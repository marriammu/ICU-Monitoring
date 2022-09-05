#include "SoftwareSerial.h"
#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266HTTPClient.h>
#include <ArduinoJson.h>
const char *server_url = "*******/SensorsData";
StaticJsonBuffer<20000> jsonBuffer;

WiFiClient client;
HTTPClient http;

String t1 ;
String t2;
char toggle1;
char toggle2; 
int arr;
String readStr;
int command;
SoftwareSerial mySerial(D2, D3); // TX, RX

void setup() {
  Serial.begin(9600);
  mySerial.begin(38400);

      WiFi.begin("STUDBME2","BME2Stud");

  
     while (WiFi.status() != WL_CONNECTED) {
      delay(500);
     
      Serial.print(".");
     }
     Serial.println("WiFi connected");
}

void loop() { 
    JsonObject& values = jsonBuffer.createObject();
  //Hold the values
  values["Temperature"] = t2;
  values["Humidity"] = t1;
   http.begin(client, server_url);
      http.setTimeout(6000);
     //Assign the datatype to be transered 
  http.addHeader("Content-Type", "application/json");

  //Create The JSON file
  char arr[500];
  values.prettyPrintTo(arr, sizeof(arr));
  //Post method to send the data 
  int httpCode = http.POST(arr);
    if(httpCode > 0)
    {
      if (httpCode == HTTP_CODE_OK || httpCode == HTTP_CODE_MOVED_PERMANENTLY) 
      {
          String payload = http.getString();
          toggle1 = payload[4];
          toggle2=payload[10];
          Serial.print("Response: ");Serial.println(toggle1);
       
       }
    }
    
    else
    {
      
         Serial.printf("[HTTP] GET... failed, error: %s", http.errorToString(httpCode).c_str());
         Serial.println();
    }
    http.end();
    if (mySerial.available())  
    {
       readStr =mySerial.readString();
       mySerial.write(toggle1);
    }
//      Serial.print(t1);
      t1=readStr.substring(0, 5);
            Serial.println(t1);
      t2=readStr.substring(6, 11);
            Serial.println(t2);
delay(1000);

}
 
