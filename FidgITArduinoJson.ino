#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <Wire.h>
#include <Adafruit_ADS1X15.h>
#include <PulseSensorPlayground.h>

Adafruit_ADS1115 ads;
PulseSensorPlayground pulseSensor;

// Define Wi-Fi credentials
const char* ssid = "FidgetTool_AP";

ESP8266WebServer server(80); // Set up HTTP server on port 80

// Sensor Pins
const int hallSensorPin = 13;
const int PulseWire = A0;
const int joystickButtonPin = 12;

// Timing Intervals
const long intervalHall = 1000;
const long intervalJoystick = 200;
const long intervalHeartRate = 1000;

// Variables for timing and data
unsigned long previousMillisHall = 0, previousMillisJoystick = 0, previousMillisHeartRate = 0;
volatile int hallPulseCount = 0;
float currentSpeed = 0;
int16_t currentJoystickX = 0, currentJoystickY = 0;
bool joystickButtonPressed = false;
int joybuttonCount = 0;
int Threshold = 550;
bool isRecording = false;
unsigned long recordingStartTime = 0;
int bpmSum = 0, bpmCount = 0, currentBPM = 0;

// Function to handle Hall effect sensor interrupts
void IRAM_ATTR hallPulse() {
  hallPulseCount++;
}

void setup() {
  Serial.begin(115200);

  // Configure static IP for Access Point mode
  IPAddress local_IP(192, 168, 4, 1);
  IPAddress gateway(192, 168, 4, 1);
  IPAddress subnet(255, 255, 255, 0);

  WiFi.softAPConfig(local_IP, gateway, subnet); // Set the static IP configuration
  WiFi.softAP(ssid); // Start Access Point with SSID and password
  Serial.print("Access Point \"");
  Serial.print(ssid);
  Serial.println("\" started");
  
  Serial.print("IP address: ");
  Serial.println(WiFi.softAPIP());

  // HTTP Request Handlers
  server.on("/", HTTP_GET, []() {
    server.send(200, "text/plain", "ESP8266 Server is working"); // Root URL for testing connection
  });
  server.on("/data", HTTP_GET, handleDataRequest); // Main data route
  server.begin();
  Serial.println("HTTP server started");

  // Initialize sensors
  ads.begin();
  pinMode(hallSensorPin, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(hallSensorPin), hallPulse, RISING);
  pulseSensor.analogInput(PulseWire);
  pulseSensor.setThreshold(Threshold);
  pulseSensor.begin();
  pinMode(joystickButtonPin, INPUT_PULLUP);

  Serial.println("Starting sensor data logging...");
}

void loop() {
  unsigned long currentMillis = millis();

  // Handle client requests
  server.handleClient();

  // Process Hall sensor data
  if (currentMillis - previousMillisHall >= intervalHall) {
    previousMillisHall = currentMillis;
    currentSpeed = (hallPulseCount * 60) / (intervalHall / 1000.0); // RPM calculation
    hallPulseCount = 0;
  }

  // Process Joystick data
  if (currentMillis - previousMillisJoystick >= intervalJoystick) {
    previousMillisJoystick = currentMillis;
    currentJoystickX = ads.readADC_SingleEnded(0);
    currentJoystickY = ads.readADC_SingleEnded(1);
    currentJoystickX = map(currentJoystickX, 0, 32767, -32768, 32767);
    currentJoystickY = map(currentJoystickY, 0, 32767, -32768, 32767);
    joystickButtonPressed = digitalRead(joystickButtonPin) == LOW;

    if (joystickButtonPressed) {
      joybuttonCount++;
      Serial.println("Joystick button pressed!");
      Serial.print(joybuttonCount);
    }
  }

  // Process Heart Rate data
  int myBPM = pulseSensor.getBeatsPerMinute();
  if (pulseSensor.sawStartOfBeat()) {
    if (!isRecording) {
      isRecording = true;
      recordingStartTime = millis();
      bpmSum = 0;
      bpmCount = 0;
    }
    bpmSum += myBPM;
    bpmCount++;
  }
  
  if (isRecording && millis() - recordingStartTime > 2000 && bpmCount > 0) {
    currentBPM = bpmSum / bpmCount;
    isRecording = false;
  }
}

void handleDataRequest() {
  // Ensure all sensor data is fresh
  server.handleClient();

  // Construct JSON response with sensor data
  String jsonResponse = "{";
  jsonResponse += "\"speed\":" + String(currentSpeed) + ",";
  jsonResponse += "\"joystick_x\":" + String(currentJoystickX) + ",";
  jsonResponse += "\"joystick_y\":" + String(currentJoystickY) + ",";
  jsonResponse += "\"joystick_button\":" + String(joystickButtonPressed ? 1 : 0) + ",";
  jsonResponse += "\"bpm\":" + String(currentBPM);
  jsonResponse += "}";

  // Send JSON response
  server.send(200, "application/json", jsonResponse);
}

