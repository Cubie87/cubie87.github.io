# Inverted Pendulum

_please note that this will be an ongoing project and updates will be posted below as they are written._

I've been wanting a larger scale project recently, and this seemed to fit the bill. A rotationally inverted pendulum (Furuta pendulum), is an inverted pendulum, but instead of having a linear track for the base to travel across, it utilises a motor's rotation to do so instead.

It would also be great to learn about sensors and actuators, specifically the different types of motors available (servo, stepper, dc), which I had been meaning to look into.


## ESP32 Microcontroller

I have some familiarity with the Arduino ecosystem, and especially when it comes to interfacing with the computer, I wanted something cheap and powerful enough for real time control. The Arduino ATMega328P is ok but very weak, so I decided to look further afield. I've previously used Teensys in Rocketry [link here], but was quite pricey.

**I eventually settled on the ESP32**, as it was cheap, and decently powerful. It also had touch pins, which could be utilised to toggle the system power state, along with wifi and bluetooth, likely unused for this project, but great to learn about.

I'm keeping the Arduino IDE as it allows me to do what I need to do for this project, and having an enormous backlog of custom libraries is useful.


## Servo

I had wanted to use a stepper motor for this, as that would provide me with a more interesting closed loop control scheme with relative position sensing, but unfortunately the driver boards did not arrive on time for me to utilise them. I hope to experiment more with these in the future.

**The servo selected was the MG995**, as it is larger than the typical blue 9g servos (SG90 or MG90s), and has a metal gear to interface with attachments. It has an approximately 270 degree physical sweep, though is reduced to around 180 degrees in the onboard controller, likely to prevent hardware damange.

It's interesting that choosing a servo essentially outsources the motor control scheme to the servo's onboard computer, resulting in the project utilising an open loop control for motor actuation. Hopefully this will still be appropriate, but I do acknowledge that it is a sub-optimal choice.


## Rotary Encoder

Due to the use of a servo in an open loop control scheme, an encoder is not required for the planar rotation of the actuator. 

However, for the pendulum, knowledge of its current position is required to control it as an inverted pendulum. This project desires precision of measurement, so I looked for encoders with the highest pulses per revolution within a reasonable price point, which turned out to be 600. Interestingly, as it was an optical quadrature encoder, the true precision is 2400 bits of information per revolution, and this can indeed be read out by the ESP32 when interfacing.

I was originally planning to run the whole system off 5V USB, but the specific physical encoder I got had issues recognising gates for around 90 degrees of each rotation around the same area at 5V, likely from dust or a manufacturing defect. However, it did work at 12V (with a shared ground to the ESP for testing), so will likely move forward with a 12V architecture.

**The exact model number is the E38S6G5-600B-G24N.**

## Calibration

#### Servo

First business item is to get 


#### Rotary Encoder



## Mount Design

#### 3D Printing


Rapid prototyping is the best!
