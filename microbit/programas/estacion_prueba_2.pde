import processing.serial.*;

Serial puerto;//establece variable puerto tipo Serial
PrintWriter fichero;//establece variable fichero tipo PrintWriter (fichero)
int contador=0;//variable para contar el nº de grabaciones realizadas

void setup() {
  println(Serial.list());
  size (400, 335);
  background(0);
  puerto = new Serial(this, Serial.list()[0], 9600);//establece la variable puerto asignando el receptor APC200 y una velocidad de 9600 baudios
  fichero=createWriter("datos.csv");//crea el fichero datos.csv
  datosPantalla("Sin datos", "Sin datos", "Sin datos", "Sin datos");
}

void draw() {

  //datosPantalla("Sin datos", "Sin datos", "Sin datos", "Sin datos", "Sin datos", "Sin datos", "Sin datos", "Sin datos");

  while (puerto.available()>0) {//mientras haya datos en el puerto serie
    String buffer=puerto.readStringUntil(10);//leemos los datos del puerto serie hasta el salto de línea (10 en ascii), y los asignamos a buffer

    if (buffer!=null) {//si buffer no está vacío
      String[] listaBuffer = split(buffer, ',');//extrae en un array los elementos separados por coma del buffer
      int longitudBuffer=buffer.length();//leemos el nº de caracteres del buffer
      int numeroCampos=listaBuffer.length;//leemos el nº de campos que están en el array, deben ser 10
      //println (buffer);
      println ("el nº de campos es:" + numeroCampos + " el nº de caracteres es:" + longitudBuffer);//imprimimos en consola el nº de campos y nº de caracteres recibidos

      if (numeroCampos==6 && listaBuffer[0].equals("soto")==true && listaBuffer[5].equals("fin\r\n")==true) {//grabamos si hay 6 campos y los campos de control de inicio y fin son correctos
        contador++;
        fichero.print(buffer);//colocamos en el fichero el buffer
        fichero.flush();//hacemos la grabación efectiva y se cierra el fichero
        println(buffer);//imprimimos por consola lo grabado
        datosPantalla(listaBuffer[1], listaBuffer[2], listaBuffer[3], listaBuffer[4]);//llamamos a la función que nos pone en pantalla los datos recogidos
      } else {
        datosPantalla("Sin datos", "Sin datos", "Sin datos", "Sin datos");
      }
    }
  }
}

void datosPantalla(String tiempo, String temperatura, String presion, String altitud) {
  background(0);
  textSize (24);
  text ("Datos SotoSat", 120, 35);
  textSize(16);
  text ("Tiempo(ms):"+ tiempo, 50, 75);
  text ("Temperatura (ºC):"+temperatura, 50, 100);
  text ("Presión (Pa):"+presion, 50, 125);
  text ("Altitud (m):"+altitud, 50, 150);
  
}
