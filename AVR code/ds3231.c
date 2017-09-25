#include <i2c.h>

void alarm_mati(){
i2c_start();
i2c_write(0xd0);
i2c_write(15);
i2c_write(0b00000000);
i2c_stop();
}

void set_rtc(){
i2c_start();
i2c_write(0xd0);
i2c_write(14); //control 0x0E
i2c_write(0b00000110); //bit7=disable osc, bit2=alarm enable bit1=alarm2 enable
i2c_stop();
}

void set_alarm(unsigned char jam,unsigned char menit){
i2c_start();
i2c_write(0xd0);
i2c_write(11);
i2c_write(bin2bcd(menit)&0b01111111);
i2c_write(bin2bcd(jam)&0b01111111);
i2c_write(0b10000000);
i2c_stop();
}

void set_waktu(unsigned char jam,unsigned char menit,unsigned char detik){
i2c_start();
i2c_write(0xd0);
i2c_write(0);            
i2c_write(bin2bcd(detik));
i2c_write(bin2bcd(menit));
i2c_write(bin2bcd(jam));
i2c_stop();
}

void jam_brp(unsigned char *jam,unsigned char *menit,unsigned char *detik){
i2c_start();
i2c_write(0xd0);
i2c_write(0);
i2c_start();
i2c_write(0xd1);
*detik=bcd2bin(i2c_read(1));
*menit=bcd2bin(i2c_read(1));
*jam=bcd2bin(i2c_read(0));
i2c_stop();
}

void tgl_brp(unsigned char *tanggal,unsigned char *bulan,unsigned char *tahun){
i2c_start();
i2c_write(0xd0);
i2c_write(4);
i2c_start();
i2c_write(0xd1);
*tanggal=bcd2bin(i2c_read(1));
*bulan=bcd2bin(i2c_read(1));
*tahun=bcd2bin(i2c_read(0));
i2c_stop();
}

void set_tgl(unsigned char tanggal,unsigned char bulan,unsigned char tahun){
i2c_start();
i2c_write(0xd0);
i2c_write(4);
i2c_write(bin2bcd(tanggal));
i2c_write(bin2bcd(bulan));
i2c_write(bin2bcd(tahun));
i2c_stop();
} 