#include <mega8.h> //1.8432MHz
#include <stdio.h>
#include <stdlib.h>
#include <delay.h>
#include <bcd.h>
#include <sleep.h>
#include <math.h>
#include <ds3231.c>
#include <sht11.c>
#include <bmp085.c>

#asm
   .equ __i2c_port=0x15 ;PORTC
   .equ __sda_bit=4
   .equ __scl_bit=5
#endasm
#include <i2c.h>

#define antena PORTD.7


//variable--------------------------------------------------

    //enumerasi dan variabel pendukung----------------------
    enum{main_menu,kirim_respon_bangun,ambil_data,mode_sleep_1,mode_sleep_2,sinkron,ambil_data_delay,ambil_data_truput,packet_data_rate,tes};
    unsigned char slot,state,i,timer_rto;
    bit flag_ambil_data;
    bit respon_bangun_ack;
    bit flag_kirim_respon;
    bit rto;
    unsigned int curah_hujan;
    //------------------------------------------------------

    //encoder dan kecepatan angin---------------------------
    unsigned int encoder,kecepatan_angin;
    bit ambil_data_kecepatan;
    //------------------------------------------------------

    //SHT11 suhu dan kelembapan-----------------------------
    float data_suhu,data_kelembapan;
    //int suhu_bmp085;
    //------------------------------------------------------

    //BMP085 TEKANAN----------------------------------------
    long int data_tekanan;
    //------------------------------------------------------

    //HMC5883L Kompas---------------------------------------
    unsigned int data_kompas;
    //------------------------------------------------------

    //RTC waktu---------------------------------------------
    unsigned char jam,menit,detik;
    unsigned char tanggal,bulan,tahun;
    unsigned char jam_sinkron,menit_sinkron,detik_sinkron,tanggal_sinkron,bulan_sinkron,tahun_sinkron;
    bit flag_sinkron;
    //------------------------------------------------------

    //Sleep mode--------------------------------------------
    unsigned char jam_alarm,menit_alarm;
    bit flag_sleep_mode;
    //------------------------------------------------------

    //parameter telekomunikasi------------------------------
    bit flag_start_delay_timer;
    bit ack;
    bit flag_start_hitung_truput;
    bit flag_hitung_pdr;
    unsigned char data_received_sukses;
    unsigned int delay;
    float delay_timer;
    float troughput;
    unsigned int data_received_kirim;
    unsigned int delay_timer_kirim;
    unsigned int troughput_kirim;
    //------------------------------------------------------


//----------------------------------------------------------

//functions-------------------------------------------------

unsigned int read_adc(unsigned char adc_input){
ADMUX=adc_input | (0x40 & 0xff);
delay_us(10);
ADCSRA|=0x40;
while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCW;
}



interrupt [USART_RXC] void usart_rx_isr(void){
unsigned char data;
data=UDR;

switch(slot){

//Header file------------------------------------------------------------------
    case 0:
    if(data==255)slot=1; //start
    break;

    case 1:
    if      (data==255) slot=1;
    else if (data=='a'){slot=0;flag_ambil_data=1;}
    else if (data=='b') slot=2; //sinkronisasi slot 2-7
    else if (data=='c'){slot=8;flag_start_delay_timer=1;} //delay slot 8
    else if (data=='d') slot=9; //mode tidur slot 9
    else if (data=='e'){flag_kirim_respon=1;respon_bangun_ack=1;} //respon ack klo tau udah bangun
    else if (data=='f'){slot=8;flag_start_hitung_truput=1;}
    else if (data=='g'){slot=8;flag_hitung_pdr=1;}
    else if (data=='h'){printf("OK\n");slot=0;} //cek status
    break;
//----------------------------------------------------------------------------


//sinkronisasi waktu slot 2-7-------------------------------------------------
    {
    case 2:
    if      (data==255)slot=1;
    else               {jam_sinkron=data;slot=3;} //sinkronisasi jam
    break;

    case 3:
    if      (data==255)slot=1;
    else               {menit_sinkron=data;slot=4;} //sinkronisasi menit
    break;

    case 4:
    if      (data==255)slot=1;
    else               {detik_sinkron=data;slot=5;} //sinkronisasi detik
    break;

    case 5:
    if      (data==255)slot=1;
    else               {tanggal_sinkron=data;slot=6;} //sinkronisasi tanggal
    break;

    case 6:
    if      (data==255)slot=1;
    else               {bulan_sinkron=data;slot=7;} //sinkronisasi bulan
    break;

    case 7:
    if      (data==255)slot=1;
    else               {tahun_sinkron=data;flag_sinkron=1;slot=0;} //sinkronisasi tahun
    break;
    }
//----------------------------------------------------------------------------

//program delay slot 8------------------------------------------------------
    {
    case 8:
    if      (data==255) slot=1;
    else if (data=='K'){
                        ack=1;
                        if(flag_hitung_pdr==1)slot=8;
                        else                  slot=0;
                        } //program utama stop timer dan kirim data delay
    break;
    }
//-----------------------------------------------------------------------------

//program mode sleep-----------------------------------------------------------
    {
    case 9:
    if      (data==255) slot=1;
    else               {jam_alarm=data;slot=10;}
    break;

    case 10:
    if      (data==255) slot=1;
    else               {menit_alarm=data;flag_sleep_mode=1;slot=0;}
    break;
    }
//-----------------------------------------------------------------------------

}
}

interrupt [EXT_INT0] void ext_int0_isr(void){ //interrupt buat bangun
GICR=0x00;
GIFR=0x00;
sleep_disable();
antena=1; //antena nyala
alarm_mati();
state=kirim_respon_bangun;

}

interrupt [EXT_INT1] void ext_int1_isr(void){
encoder++;
}

interrupt [TIM1_COMPA] void timer1_compa_isr(void){
kecepatan_angin=encoder;
encoder=0;
ambil_data_kecepatan=1;

}

interrupt [TIM1_OVF] void timer1_ovf_isr(void){
timer_rto++;
}


void main(void){
unsigned char minus=0;

// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: On
// USART Transmitter: On
// USART Mode: Asynchronous
// USART Baud Rate: 9600
UCSRA=0x00;
UCSRB=0x98;
UCSRC=0x86;
UBRRH=0x00;
UBRRL=0x0b;

ACSR=0x80;

DDRC.3=1;

//power antena
DDRD.7=1;
antena=1;

i2c_init();
delay_ms(10);
read_calibration_bmp085();

set_rtc();

PORTD.2=1;
PORTD.3=1;
alarm_mati();

TCCR1B=0x07;

#asm("sei")
state=main_menu;
while (1){
switch(state){

    case main_menu:{
    if(flag_ambil_data==1)          state=ambil_data;
    if(flag_sleep_mode==1)          state=mode_sleep_1;
    if(flag_sinkron==1)             state=sinkron;
    if(flag_start_delay_timer==1)   state=ambil_data_delay;
    if(flag_start_hitung_truput==1) state=ambil_data_truput;
    if(flag_kirim_respon==1)        state=kirim_respon_bangun;
    if(flag_start_hitung_truput==1) state=ambil_data_truput;
    if(flag_hitung_pdr==1)          state=packet_data_rate;
    }break;

    case ambil_data:{
    curah_hujan=TCNT1;                                    //ambil data curah hujan
    TCCR1B=0x0D;
    OCR1AH=0x07;
    OCR1AL=0x07;
    TIMSK=0x10;
    GICR=0x80;
    MCUCR=0x08;
    GIFR=0x80;
    encoder=0;
    TCNT1=0;
    ambil_data_kecepatan=0;while(!ambil_data_kecepatan);  //ambil data kecepatan angin
    //printf("data_kecepatan\r\n");
    jam_brp(&jam,&menit,&detik);                          //ambil data waktu
    //printf("data_jam\r\n");
    tgl_brp(&tanggal,&bulan,&tahun);
    //printf("data_tanggal\r\n");
    baca_sht11(&data_kelembapan,&data_suhu);              //ambil data suhu dan kelembapan
    //printf("data sht\r\n");

    read_uncompensated_temp();
    read_uncompensated_pressure();
    //suhu_bmp085=temperature_bmp085();
    //printf("data_suhubmp085\r\n");
    data_tekanan=tekananbmp();                                  //ambil data tekanan
    //printf("data_pressurebmp085\r\n");

    delay_ms(1);
    ADMUX=0x40 & 0xff;
    ADCSRA=0x85;
    data_kompas=read_adc(0);                                   //ambil data arah mata angin
    ADMUX=0x00;
    ADCSRA=0x00;
    //printf("data_kompas\r\n");
    flag_ambil_data=0;
    TCCR1B=0x07;
    TCNT1=0;
    OCR1AH=0x00;
    OCR1AL=0x00;
    TIMSK=0x00;
    GICR=0x00;
    MCUCR=0x00;
    GIFR=0x00;
    printf("A%dB%dC%dD%dE%dF%dG%ldH%dI%dJ%dK%dZ\n",jam,menit,kecepatan_angin,(int)data_kelembapan,(int)data_suhu,data_kompas,data_tekanan,tanggal,bulan,tahun,curah_hujan);
    curah_hujan=0;
    state=main_menu;
    minus++;
    }break;

    case sinkron:{
    set_waktu(jam_sinkron,menit_sinkron,detik_sinkron);
    set_tgl(tanggal_sinkron,bulan_sinkron,tahun_sinkron);
    printf("OK\n");
    flag_sinkron=0;
    state=main_menu;
    }break;

    case ambil_data_delay:{
    delay=0;
    TCCR1B=0x01;
    TIMSK=0x04;
    timer_rto=0;
    TCNT1=0;
    ack=0;
    printf("D123456789012345678901234567890\n");
    while(!ack && timer_rto<122);
    delay_timer=(float)TCNT1*0.00025;
    delay_timer_kirim=(int)delay_timer;
    if(delay_timer_kirim<1)delay_timer_kirim=1;
    printf("L%dZ\n",delay_timer_kirim);
    TCCR1B=0x0B;
    ack=0;
    flag_start_delay_timer=0;
    state=main_menu;
    }break;

    case ambil_data_truput:{
    delay=0;
    TCCR1B=0x01;
    TIMSK=0x04;
    timer_rto=0;
    TCNT1=0;
    printf("D123456789012345678901234567890\n");
    while(!ack && timer_rto<122);
    delay_timer=(float)TCNT1*0.00025;
    troughput=32/(delay_timer/1000);
    troughput_kirim=(int)troughput;
    printf("T%dZ\n",troughput_kirim);
    TCCR1B=0x0B;
    TIMSK=0x10;
    ack=0;
    flag_start_hitung_truput=0;
    state=main_menu;
    }break;

    case packet_data_rate:{
    delay=0;
    TCCR1B=0x01;
    TIMSK=0x04;
    timer_rto=0;
    TCNT1=0;
    data_received_sukses=0;
    for(i=0;i<11;i++){
        printf("D123456789012345678901234567890\n");
        while(!ack){
            if(timer_rto>121){rto=1;break;}
        }
    if(rto==1)rto=0;
    else      data_received_sukses++;
    ack=0;
    timer_rto=0;
    }
    data_received_kirim=data_received_sukses*10;
    printf("P%dZ\n",data_received_kirim);
    TCCR1B=0x0B;
    TIMSK=0x10;
    ack=0;
    flag_hitung_pdr=0;
    slot=0;
    state=main_menu;
    }break;

    case kirim_respon_bangun:{
    printf("W\n");
    delay_ms(100);
    if(respon_bangun_ack){flag_kirim_respon=0;respon_bangun_ack=0;state=main_menu;}
    }break;

    case mode_sleep_1:{
    set_alarm(jam_alarm,menit_alarm);
    printf("S\n");
    antena=0;
    flag_sleep_mode=0;
    GICR=0x00;
    GIFR=0x00;
    MCUCR=0x00;
    state=mode_sleep_2;
    }break;

    case mode_sleep_2:{
    GICR=0x40;
    GIFR=0x40;
    sleep_enable();
    idle();
    //printf("hoho haha\r\n");
    }break;

    case tes:{
//    suhubmp();
//    printf("Tekanan=%luPa ",tekananbmp());
//    baca_sht11(&data_kelembapan,&data_suhu);              //ambil data suhu dan kelembapan
//    printf("Kelembapan=%d%c Suhu=%dC \r\n",(int)data_kelembapan,37,(int)(data_suhu*10));
    printf("01234567890abcdefghijklmnopqrstuvwxyz\r\n");
//    curah_hujan=TCNT1;                                    //ambil data curah hujan
    //data_kompas=read_adc(0);
    //ambil_data_kecepatan=0;while(!ambil_data_kecepatan);  //ambil data kecepatan angin
    //printf("kecepatan = %d arah angin= %d\r\n",kecepatan_angin,data_kompas);
    delay_ms(500);
    }break;
    }
}
}