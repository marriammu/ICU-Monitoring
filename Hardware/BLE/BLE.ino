#include "SoftwareSerial.h"

SoftwareSerial mySerial(2, 3); // TX, RX
#define LED 13
char i ;
#include "DHT.h"
float Data[4];
#define DHTPIN 7     // Digital pin connected to the DHT sensor

#define DHTTYPE DHT11   // DHT 11
DHT dht(DHTPIN, DHTTYPE);
void initBluetooth() {
  Serial.begin(9600);
  
  Serial.println("---------------Master------------------");
  dht.begin();
  mySerial.begin(38400);
 
}
char result[6]; // Buffer big enough for 7-character float
char result2[6]; // Buffer big enough for 7-character float
void updateSerial() {
//  Serial.println(Serial.read()); 
 delay(2000);

  // Reading temperature or humidity takes about 250 milliseconds!
  // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)
  float h = dht.readHumidity();
  dtostrf(h, 2, 2, result);
  // Read temperature as Celsius (the default)
  float t = dht.readTemperature();
  dtostrf(t, 2, 2, result2);


  i = mySerial.read();
    Serial.print(i);


  if (i=='0'){

   digitalWrite(LED, HIGH);}

   else{
    digitalWrite(LED, LOW);
    }
  mySerial.print(result);
    mySerial.print(',');
      mySerial.print(result2);


}
void setup() {
  pinMode(LED, OUTPUT);
  initBluetooth();
}

void loop() {

  updateSerial();
  delay(500);
}
