#include <ArduinoJson.h>


String message = "";
bool messageReady = false;

//SoftwareSerial s(12,13);


const int cap1 = 4;
const int cap2 = 5;
const int cap3 = 6;
const int cap4 = 7;

const int relay1 = 8;
const int relay2 = 9;
const int relay3 = 10;
const int relay4 = 11;

int socket1 = 0;
int socket2 = 0;
int socket3 = 0;
int socket4 = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  //s.begin(9600);
  pinMode(relay1, OUTPUT);
  pinMode(relay2, OUTPUT);
  pinMode(relay3, OUTPUT);
  pinMode(relay4, OUTPUT);
  pinMode(cap1, INPUT);
  pinMode(cap2, INPUT);
  pinMode(cap3, INPUT);
  pinMode(cap4, INPUT);
  
}

void loop() {
  // put your main code here, to run repeatedly:
  DynamicJsonDocument doc(1024);
  DynamicJsonDocument docF(1024);
  String message = "";
  DeserializationError error;
  
  if(Serial.available()>0) {
    message = Serial.read();
    DeserializationError error = deserializeJson(doc,message); 
  }
     
//    if(error) {
//    Serial.print(F("deserializeJson() failed: "));
//    Serial.println(error.c_str());
//    return;
//  }    
  
  
  
    if(message.length()!=0 && !error){
  
      if(doc["type"] == "request"){
        doc["type"] = "response";
        doc["socket1"] = socket1;
        doc["socket2"] = socket2;
        doc["socket3"] = socket3;
        doc["socket4"] = socket4;
        if(Serial.available()==0){
          serializeJson(doc,Serial);
        }

      } 
    
    }
  
  
  docF["type"] = "requestFirebase";
  if(Serial.available()==0){
    serializeJson(docF, Serial);
  }
  delay(1000);
  if(Serial.available() > 0) {
    message = Serial.read();
    DeserializationError error = deserializeJson(docF, message);
  }
    
//    if (error) {
//    Serial.print(F("deserializeJson() failed: "));
//    Serial.println(error.c_str());
//    return;
//  }

  if(message.length()!=0 && !error){
    if(docF["type"] == "responseFirebase"){  
      socket1 = docF["socket1"];
      socket2 = docF["socket2"];
      socket3 = docF["socket3"];
      socket4 = docF["socket4"];

    }

//    (socket1 == 1?digitalWrite(relay1, LOW):digitalWrite(relay1, HIGH));
//    (socket2 == 1?digitalWrite(relay2, LOW):digitalWrite(relay2, HIGH));
//    (socket3 == 1?digitalWrite(relay3, LOW):digitalWrite(relay3, HIGH));
//    (socket4 == 1?digitalWrite(relay4, LOW):digitalWrite(relay4, HIGH));
//
//  }
//    
    }
    
  

//  if(s.available()>0){
//    s.write(socket1);
//    s.write(socket2);
//    s.write(socket3);
//    s.write(socket4);
//    
//    }
      
      


  int cap1_status = digitalRead(cap1);
//  Serial.println("Cap1 Status");
//  Serial.println(cap1_status);
  if (cap1_status == 1){
    delay(100);
    if(cap1_status == 1){
      socket1 = !socket1;
      
      
      
    }
  }
  (socket1 == 1?digitalWrite(relay1, LOW):digitalWrite(relay1, HIGH));
//  Serial.println("Socket1 Status");
//  Serial.println(socket1);

//  Serial.println("Cap2 Status");
  int cap2_status = digitalRead(cap2);
  if (cap2_status == 1){
    delay(100);
    if(cap2_status == 1){
      socket2 = !socket2;
//      Serial.println("Socket 2");
//      Serial.println(socket2);
    }
  }
  (socket2 == 1?digitalWrite(relay2, LOW):digitalWrite(relay2, HIGH));
  
//  Serial.println("Cap3 Status");
  int cap3_status = digitalRead(cap3);
  if (cap3_status == 1){
    delay(100);
    if(cap3_status == 1){
      socket3 = !socket3;
//      Serial.print("Socket3");
//      Serial.print(socket3);
    }
  }
  (socket3 == 1?digitalWrite(relay3, LOW):digitalWrite(relay3, HIGH));
  
//  Serial.println("Cap4 Status");
  int cap4_status = digitalRead(cap4);
  if(cap4_status == 1){
    delay(100);
    if(cap4_status == 1){
      socket4 = !socket4;
//      Serial.print("Socket4");
//      Serial.println(socket4);
    }
  }
  (socket4 == 1?digitalWrite(relay4, LOW):digitalWrite(relay4, HIGH));
//  Serial.println(socket4);

  

  
  
 
} 
