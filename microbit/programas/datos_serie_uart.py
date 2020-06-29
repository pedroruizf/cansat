from microbit import * #importa la librería con las órdenes propias de microbit 
import bmp280 #importa la librería con las instrucciones para el sensor bmp280
#uart.init(9600,tx=pin14,rx=pin15)
uart.init(9600) #inicializa una comunicación serie a 9600 baudios
b = bmp280.BMP280() #crea un elemento b del tipo bmp280
graba=False #variable booleana para controlar el envío de datos o no
buffer="tiempo"+","+"temperatura"+","+"presion"+","+"altitud"+"\r\n" #variable tipo string que contiene lo que se envia por puerto serie
uart.write(buffer) #envia a puerto serie la variable buffer

while True: #bucle infinito
    if button_a.is_pressed():#si el botón "a" está presionado
        graba = not graba #cambia el estado de graba por su contrario de False a True o de True a False
        sleep(200) #se espera 200 ms
    if button_b.is_pressed(): #si el botón "b" está presionado
        display.show(Image.SNAKE)#enseña dibujo de una serpiente
        break #sale del bucle (lo interrumpe)
    if graba == True:# si graba es cierto
        display.show(Image.YES)# enseña dibujo de verificado
        buffer="soto,"+str(running_time())+","+str(b.Temperature())+","+str(b.Pressure())+","+str(b.Altitude())+",fin\r\n"
        #al buffer añade texto soto,tiempo,temperatura,presion,altitud,fin seperados por coma y al final con retorno de carro
        uart.write(buffer) #envia a puerto serie la variable buffer
        sleep(500) #se espera 500 ms
    else:
        display.show (Image.NO)#enseña dibujo de cruz
