//ASSIGMNET OF PINS

#include <ESP8266WiFi.h>
#include "FirebaseESP8266.h"
#include <ArduinoJson.h>


FirebaseData firebaseData;
DynamicJsonDocument doc(1024);
String message = "";
DeserializationError error;


#define FIREBASE_HOST "smart-power-extender-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "70UUBADmHRABdQhO3mtVjfCS31sYm6ThQOwT6HG8"
const char *ssid =  "AkshayaIllam";
const char *pass =  "AkshayaIllam@WiFi";
//SoftwareSerial s(5, 6);

int socket1 = 0;
int socket2 = 0;
int socket3 = 0;
int socket4 = 0;

int timer1 = 0;
int timer2 = 0;
int timer3 = 0;
int timer4 = 0;

int socket1R = 0;
int socket2R = 0;
int socket3R = 0;
int socket4R = 0;

int socket1P = 0;
int socket2P = 0;
int socket3P = 0;
int socket4P = 0;

void setup() {
  // put your setup code here, to run once:

  Serial.begin(9600);
  //s.begin(9600);
  WiFi.begin(ssid, pass);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    //Serial.println(".");
  }
  //Serial.println("");
  //Serial.println("WiFi connected");
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
}

void loop() {
  // put your main code here, to run repeatedly:
  socket1P = socket1;
  socket2P = socket2;
  socket3P = socket3;
  socket4P = socket4;
    
  //  // Sending the request
    doc["type"] = "request";
    if(Serial.available()==0){
      serializeJson(doc, Serial);
    }

  // Reading the response
  delay(100);
  
  if(Serial.available() > 0) {
    message = Serial.read();
    DeserializationError error = deserializeJson(doc, message);
//    if (error) {    Serial.print(F("deserializeJson() failed: "));
//    Serial.println(error.c_str());
//    return;
//  }

  }

  if(message.length()!=0 && !error){
    if(doc["type"] == "response"){  
    socket1 = doc["socket1"];
    socket2 = doc["socket2"];
    socket3 = doc["socket3"];
    socket4 = doc["socket4"];

    }

  }

   if(Serial.available() > 0) {
    message = Serial.read();
    DeserializationError error = deserializeJson(doc, message);
//    if (error) {    Serial.print(F("deserializeJson() failed: "));
//    Serial.println(error.c_str());
//    return;
//  }

  }

  

 if(doc["type"] == "requestFirebase"){
   socket1R = Firebase.getInt(firebaseData,"socket1");
   socket2R = Firebase.getInt(firebaseData,"socket2");
   socket3R = Firebase.getInt(firebaseData,"socket3");
   socket4R = Firebase.getInt(firebaseData,"socket4");
   doc["type"] = "responseFirebase";
   doc["socket1"] = socket1R;
   doc["socket2"] = socket2R;
   doc["socket3"] = socket3R;
   doc["socket4"] = socket4R;
   doc["timer1"] = timer1;
   doc["timer2"] = timer2;
   doc["timer3"] = timer3;
   doc["timer4"] = timer4;
   if(Serial.available()==0){
   serializeJson(doc,Serial);
   }
   
   }
  
  
  
  //(Firebase.setJSON(firebaseData,"/",doc))

  if(socket1!=socket1P){
    if (Firebase.setInt(firebaseData, "/socket1", socket1)) {

   //Serial.println("Success in updating socket1");
 }

  }
    
    
 if(socket2!=socket2P){
  if (Firebase.setInt(firebaseData, "/socket2", socket2)) {
   //Serial.println("Success in updating socket2");
 }

 }
 
 if(socket3!=socket3P){
  if (Firebase.setInt(firebaseData, "/socket3", socket3)) {
   //Serial.println("Success in updating socket3");
 }

 }

 if(socket4!=socket4P){
  if (Firebase.setInt(firebaseData, "/socket4", socket4)) {
   //Serial.println("Success in updating socket4");
 }

 }

 

 

}
