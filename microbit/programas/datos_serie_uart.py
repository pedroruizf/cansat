from microbit import *
import bmp280
#uart.init(9600,tx=pin14,rx=pin15)
uart.init(9600)
b = bmp280.BMP280()
graba=False
buffer="tiempo"+","+"temperatura"+","+"presion"+","+"altitud"+"\r\n"
uart.write(buffer)

while True:
    if button_a.is_pressed():
        graba = not graba
        sleep(200)
    if button_b.is_pressed():
        display.show(Image.SNAKE)
        break
    if graba == True:
        display.show(Image.YES)
        buffer="soto,"+str(running_time())+","+str(b.Temperature())+","+str(b.Pressure())+","+str(b.Altitude())+",fin\r\n"
        uart.write(buffer)
        sleep(500)
    else:
        display.show (Image.NO)
