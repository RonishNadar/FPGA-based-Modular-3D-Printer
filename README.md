# FPGA based Modular 3D Printer

## Introduction

Modern day manufacturing processes make use of various CNC machines. These
machines use similar technology and hardware but are sold individually for different
operations. By amalgamating several functions into a single system the efficiency
can be increased and cost highly reduced. Contemporary 3D printers make use of
micro-controllers, these devices run sequentially and to improve the performance,
the processing speed needs to be increased. Alternatively, the processes can be
shared and run by parallel blocks to increase the performance. FPGAs can be used
to parallelize the task s and improve efficiency.

---

## Contents:

1. Mechanical Design
2. Electronics
3. Demonstration Video

---

## Mechanical Design
![123](https://github.com/RonishNadar/FPGA-based-Modular-3D-Printer/assets/137984084/25b6ed28-0f47-4415-b739-8b2f9e472351)

The frame is constructed using aluminium. The Z-axis motion of the hot bed is done through two lead screw based actuator and the X-axis and Y-axis are taken care using slider based actuator. 

---

## Electronics
#### Electronic Components used:
- 1 x Xilinx Nexys 2 FPGA Board
- 1 x Raspberry Pi 4B
- 1 x FTDI FT232 USB to Serial
- 5 x NEMA 17 Stepper Motors
- 4 x TB6600 Stepper Motor Driver
- 1 x 12V Hot Bed
- 1 x 12V Hot Extruder
- 1 x 12V DC Motor
- 6 x Feedback Limit Switches
- 2 x 10K NTC Thermistor

The code for the robot automation is provided above.

---

## Demonstration Video

1. 3D Printing Demo

- https://drive.google.com/file/d/1t4UAHGC81zde_A08YZPD3bV_dZkhscCF/view?usp=sharing
- https://drive.google.com/file/d/1-L4NQ1OALyOLEQjKM2Tkkpd9sBdeq1kx/view?usp=sharing

2. Modulrity Demo (Milling)

- https://drive.google.com/file/d/1TUlYnzkdqgqkpXYkdak7sU4ZTnVcv832/view?usp=sharing
- https://drive.google.com/file/d/1XJeEiQJuOYYUQABSML6X-HdxjGy-oZ8y/view?usp=sharing
