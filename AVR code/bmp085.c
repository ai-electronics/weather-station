#include <i2c.h>

int ac1,ac2,ac3,b1,b2,mb,mc,md;
unsigned int ac4,ac5,ac6;
long int x1,x2,b5,b3,x3,b6,b7;
unsigned long int b4;
long int up;
long int ut;

long pressure;

int ac1_hi,ac1_lo;
int ac2_hi,ac2_lo;
int ac3_hi,ac3_lo;
int ac4_hi,ac4_lo;
int ac5_hi,ac5_lo;
int ac6_hi,ac6_lo;
int b1_hi,b1_lo;
int b2_hi,b2_lo;
int mb_hi,mb_lo;
int mc_hi,mc_lo;
int md_hi,md_lo;


void read_calibration_bmp085(){
i2c_start();
i2c_write(0xee);
i2c_write(0xaa);
i2c_start();
i2c_write(0xef);

ac1_hi=i2c_read(1);
ac1_lo=i2c_read(1);

ac2_hi=i2c_read(1);
ac2_lo=i2c_read(1);

ac3_hi=i2c_read(1);
ac3_lo=i2c_read(1);

ac4_hi=i2c_read(1);
ac4_lo=i2c_read(1);

ac5_hi=i2c_read(1);
ac5_lo=i2c_read(1);

ac6_hi=i2c_read(1);
ac6_lo=i2c_read(1);

b1_hi=i2c_read(1);
b1_lo=i2c_read(1);

b2_hi=i2c_read(1);
b2_lo=i2c_read(1);

mb_hi=i2c_read(1);
mb_lo=i2c_read(1);

mc_hi=i2c_read(1);
mc_lo=i2c_read(1);

md_hi=i2c_read(1);
md_lo=i2c_read(0);

i2c_stop();

ac1=ac1_hi<<8 | ac1_lo;
ac2=ac2_hi<<8 | ac2_lo;
ac3=ac3_hi<<8 | ac3_lo;
ac4=ac4_hi<<8 | ac4_lo;
ac5=ac5_hi<<8 | ac5_lo;
ac6=ac6_hi<<8 | ac6_lo;

b1=b1_hi<<8 | b1_lo;
b2=b2_hi<<8 | b2_lo;

mb=mb_hi<<8 | mb_lo;
mc=mc_hi<<8 | mc_lo;
md=md_hi<<8 | md_lo;
//printf("ac1= %d ac2= %d ac3= %d ac4= %u ac5= %u ac6= %u b1= %d b2= %d mb= %d mc= %d md= %d\r\n",ac1,ac2,ac3,ac4,ac5,ac6,b1,b2,mb,mc,md);
}

void read_uncompensated_temp(){
char temp_value_hi,temp_value_lo;
i2c_start();
i2c_write(0xee);
i2c_write(0xf4);
i2c_write(0x2e);
i2c_stop();

delay_ms(5);

i2c_start();
i2c_write(0xee);
i2c_write(0xf6);
i2c_start();
i2c_write(0xef);
temp_value_hi=i2c_read(1);
temp_value_lo=i2c_read(0);
i2c_stop();

ut =(long int) temp_value_hi <<8 | (long)temp_value_lo;

x1 = ((long)ut - ac6) * ac5 >> 15;
x2 = ((long)mc << 11) / (x1 + md);
b5 = x1 + x2;
}

void read_uncompensated_pressure(){
char pres_value_hi,pres_value_lo;
long p;

i2c_start();
i2c_write(0xee);
i2c_write(0xf4);
i2c_write(0x34);
i2c_stop();

delay_ms(5);

i2c_start();
i2c_write(0xee);
i2c_write(0xf6);
i2c_start();
i2c_write(0xef);
pres_value_hi=i2c_read(1); //f6
pres_value_lo=i2c_read(0); //f7
i2c_stop();

up= (long)pres_value_hi <<8 | (long)pres_value_lo; // | (long)pres_value_x)>>8;
	b6 = b5 - 4000;
	x1 = (b2* (b6 * b6) >> 12) >> 11;
	x2 = (ac2 * b6) >> 11;
	x3 = x1 + x2;
	b3 = (((((long)ac1) * 4 + x3) << 0) + 2) >> 2;
	x1 = (ac3 * b6) >> 13;
	x2 = (b1 * ((b6 * b6) >> 12)) >> 16;
	x3 = ((x1 + x2) + 2) >> 2;
	b4 = (ac4 * (unsigned long)(x3 + 32768)) >> 15;
	b7 = ((unsigned long)up - b3) * (50000 >> 0);
	p = b7 < 0x80000000 ? (b7 << 1) / b4 : (b7 / b4) << 1;
	x1 = (p >> 8) * (p >> 8);
	x1 = (x1 * 3038) >> 16;
	x2 = (-7357 * p) >> 16;
	pressure = p + ((x1 + x2 + 3791) >> 4);
}

//float suhubmp() {
//	float temperature;
//    read_uncompensated_temp();
//	temperature = ((b5 + 8)>>4);
//	//temperature = temperature *10;
//	return temperature;
//}

long int tekananbmp(){
    read_uncompensated_pressure();
    return pressure;
}