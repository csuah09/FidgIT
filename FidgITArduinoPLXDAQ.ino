#include <Wire.h>
#include <Adafruit_ADS1X15.h>
#include <PulseSensorPlayground.h>  // Pulse sensor library

Adafruit_ADS1115 ads; // Create an instance for the ADS1115

// Define sensor pins
const int hallSensorPin = 13;  // Hall effect sensor pin (D7 is GPIO 13)
const int PulseWire = A0;      // Pulse sensor connected to A0
const int joystickButtonPin = 12;  // Joystick button pin (D6 is GPIO 12)

// Timing intervals
const long intervalHall = 1000;      // Hall effect sensor interval (1 second)
const long intervalJoystick = 200;   // Joystick data interval (200 ms)
const long intervalHeartRate = 500;  // Heart rate sensor interval (500 ms)

// Variables for timing
unsigned long previousMillisHall = 0;
unsigned long previousMillisJoystick = 0;
unsigned long previousMillisHeartRate = 0;

// Hall effect sensor variables
volatile int hallPulseCount = 0;
unsigned long hallInterval = 1000;   // Time interval for calculating speed
float currentSpeed = 0;

// Joystick variables
int16_t currentJoystickX = 0, currentJoystickY = 0;
bool joystickButtonPressed = false;  // Variable to store button state
int joybuttonCount = 0;

// PulseSensor variables
PulseSensorPlayground pulseSensor;  // Creates an object
int Threshold = 550;                // Threshold to detect heartbeats
bool isRecording = false;           // Flag to indicate whether recording is active
unsigned long recordingStartTime = 0;
int bpmSum = 0;                     // Sum of BPM readings to calculate average
int bpmCount = 0;                   // Count of BPM readings
int currentBPM = 0;                 // Holds the current BPM value

// Function to handle Hall effect sensor interrupts
void IRAM_ATTR hallPulse() {
  hallPulseCount++; // Increment pulse count when the hall sensor is triggered
}

void setup() {
  // Start serial communication
  Serial.begin(115200);

  // Initialize ADS1115 (joystick)
  ads.begin();

  // Set Hall effect sensor pin as input
  pinMode(hallSensorPin, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(hallSensorPin), hallPulse, RISING);

  // Initialize PulseSensor (Heart Rate)
  pulseSensor.analogInput(PulseWire);   // Configure pulse sensor pin
  pulseSensor.setThreshold(Threshold);  // Set threshold for heartbeat detection

  // Start PulseSensor and check if it was initialized successfully
  pulseSensor.begin();

  // Set up the hall sensor
  pinMode(hallSensorPin, INPUT);

  // Set up the joystick button pin
  pinMode(joystickButtonPin, INPUT_PULLUP);  // Joystick button with internal pull-up resistor


  Serial.println("Starting sensor data logging...");
}

void loop() {
  unsigned long currentMillis = millis();

  // Handle Hall effect sensor data (calculate speed)
  if (currentMillis - previousMillisHall >= intervalHall) {
    previousMillisHall = currentMillis;

    // Calculate speed (RPM) assuming one pulse per revolution
    currentSpeed = (hallPulseCount * 60) / (hallInterval / 1000.0);
    hallPulseCount = 0; // Reset pulse count after each interval
  }

  // Handle Joystick data via ADS1115
  if (currentMillis - previousMillisJoystick >= intervalJoystick) {
    previousMillisJoystick = currentMillis;

    // Read X and Y axis from ADS1115 (Joystick)
    currentJoystickX = ads.readADC_SingleEnded(0); // Channel 0 for X-axis
    currentJoystickY = ads.readADC_SingleEnded(1); // Channel 1 for Y-axis

    // Convert to values between -32768 and 32767 if needed
    currentJoystickX = map(currentJoystickX, 0, 32767, -32768, 32767);
    currentJoystickY = map(currentJoystickY, 0, 32767, -32768, 32767);
    
    // Read the joystick button state
    joystickButtonPressed = digitalRead(joystickButtonPin) == LOW;  // Button pressed if LOW

    // If button is pressed, you can add specific functionality here
    if (joystickButtonPressed) {
      joybuttonCount++;
      Serial.println("Joystick button pressed!");
      Serial.print(joybuttonCount);
    }
  }

  // Handle Heart Rate Sensor data (BPM)
  int myBPM = pulseSensor.getBeatsPerMinute();  // Get the BPM value
  if (pulseSensor.sawStartOfBeat()) {
    Serial.println(myBPM);

    // If not already recording, start recording when a heartbeat is detected
    if (!isRecording) {
      isRecording = true;
      recordingStartTime = millis();   // Mark the start of recording
      bpmSum = 0;                      // Reset BPM sum
      bpmCount = 0;                    // Reset BPM count
    }

    // Add the current BPM to the total sum and increment the count
    bpmSum += myBPM;
    bpmCount++;
  }

  // If no heartbeats are detected for 2 seconds (finger removed), calculate average BPM
  if (isRecording && millis() - recordingStartTime > 2000 && bpmCount > 0) {
    currentBPM = bpmSum / bpmCount;   // Calculate the average BPM
    Serial.println(currentBPM);

    // Reset recording flag
    isRecording = false;
  }

  // Send all sensor data in one line to PLX-DAQ
  Serial.print("DATA,DATE,TIME,");  // PLX-DAQ header for each line
  Serial.print(currentSpeed);        // Speed (RPM)
  Serial.print(",");                 // Comma to separate values
  Serial.print(currentJoystickX);    // Joystick X-axis
  Serial.print(",");
  Serial.print(currentJoystickY);    // Joystick Y-axis
  Serial.print(",");
  Serial.print(joystickButtonPressed ? 1 : 0);  // Joystick button state (1 for pressed, 0 for not pressed)
  Serial.print(",");
  Serial.print(currentBPM);          // Current BPM or average BPM
  Serial.println();                  // Newline to end row for PLX-DAQ

  delay(20); // Small delay to avoid overload
}
