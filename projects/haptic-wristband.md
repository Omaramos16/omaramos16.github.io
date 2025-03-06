---
layout: default
title: Wrist-Worn Haptic Device
---

## 🚀 **Project Overview**  
- **Project Name:** Wrist-Worn Haptic Feedback Device  
- **Role:** Embedded Systems Engineer  
- **Technologies:** Embedded C++, PCB Design (KiCad), Bluetooth (Classic & BLE), I2C, PWM Motor Control, IMU-based Feedback, Power Management  
- **Lab:** Stanford CHARM Lab (Collaborative Haptics and Robotics in Medicine)  
- **Mentors:** Dr. Ryo Eguchi, Dr. Allison Okamura  
- **Duration:** Summer Quarter 2022, SURI (Stanford Undergraduate Research Institute)
- **Key Contributions:** Circuit Design, Bluetooth Communication, IMU Integration, Power Management, Custom PCB  
- **Documentation:** [Research Poster (PDF)](../assets/docs/SURI_Poster.pdf){:target="_blank"}

<div class="image-container">
  <img src="../assets/images/haptic_device/charm_main.jpeg" alt="Haptic Device Prototype">
  <img src="../assets/images/haptic_device/hd_pcb2.jpeg" alt="PCB Design Render">
</div>

---

# **Wrist-Worn Haptic Device for Motion Guidance**  

This project focused on developing a wrist-worn haptic device capable of providing real-time motion guidance through vibrotactile feedback, enabling intuitive, non-visual communication of movement cues. Designed for assistive technology and rehabilitation, the system integrates IMU-driven feedback, wireless control, and miniaturized electronics into a compact wearable device.

---

## 🛠️ **Engineering Contributions & Key Technologies**  

- **Embedded Systems & Firmware Development**  
  - Implemented **Bluetooth Classic** on an **Arduino Nano 33 IoT**, replacing default BLE to reduce latency and improve real-time responsiveness.  
  - Developed **IMU-driven feedback algorithms**, enabling dynamic vibrotactile responses based on motion.  
  - Addressed PWM limitations on the Arduino by implementing an **I2C-based PCA9685 PWM driver**, later optimizing it to a **ULN2803 Darlington array** after testing revealed fewer motors were needed.

- **Circuit & Power Management**  
  - Designed a **single LiPo battery power system**, integrating a **DC-DC step-up converter** to provide stable voltage to the microcontroller while isolating motor power.  
  - Added **decoupling capacitors** to suppress voltage drops caused by rapid motor actuation, preventing unintended microcontroller resets.  
  - Designed a **custom two-layer PCB in KiCad**, reducing circuit size by *40%* while improving durability and power efficiency.   

- **Component Selection & Hardware Optimization**  
  - Selected an **Arduino-compatible microcontroller** with Bluetooth capabilities and adequate processing power.  
  - Sourced **high-efficiency vibration motors** to deliver optimal haptic feedback.  
  - Transitioned from **I2C PWM driver (PCA9685) to a ULN2803 Darlington array**, eliminating I2C overhead and reducing power consumption.  
  - Integrated **I2C communication** for IMU data processing, ensuring efficient sensor fusion while minimizing microcontroller pin usage.  

- **Wearable Integration & Mechanical Design**  
  - Designed a **3D-printed enclosure** for electronics, ensuring compactness and durability.  
  - Developed a **modular velcro-mounted system**, allowing motors to be repositioned for different user studies.  

---

## 🚩 **Key Challenges & Solutions**  

- **Bluetooth Latency & Communication Stability**  
  - *Issue:* BLE on the Arduino Nano 33 IoT introduced excessive latency for real-time haptic feedback.  
  - *Solution:* Flashed **ESP32 firmware to enable Classic Bluetooth**, significantly improving data transmission speed and responsiveness.  

- **Power Fluctuations Resetting MCU**  
  - *Issue:* High-frequency motor actuation caused voltage drops, intermittently resetting the microcontroller.  
  - *Solution:* Added **decoupling capacitors** and a **DC-DC step-up converter**, stabilizing voltage and preventing power-related disruptions.  

- **PWM Output Limitations**  
  - *Issue:* The Arduino lacked enough PWM outputs to drive multiple vibration motors.  
  - *Solution:* Implemented an **I2C-based PCA9685 PWM driver**, later switching to a **ULN2803 Darlington array** after testing showed fewer motors were needed, reducing complexity and I2C overhead.  

- **I2C Communication Efficiency**  
  - *Issue:* The system required multiple peripherals while minimizing microcontroller pin usage.  
  - *Solution:* Optimized **I2C communication** for both the PWM driver (initially) and IMU, ensuring reliable data transfer with minimal resource overhead.  

- **Wearable Size & Weight Reduction**  
  - *Issue:* The initial prototype was too large and heavy due to multiple breakout boards.  
  - *Solution:* Designed a **custom two-layer PCB**, consolidating components into a **40% smaller** footprint while improving durability.  

---

## 🧰 **Technical Stack & Validation**  

- **Microcontroller Development:** Arduino Nano 33 IoT (ESP32-based)  
- **Firmware Development:** C++ (Arduino)  
- **Communication Protocols:** Bluetooth Classic, I2C, PWM  
- **Hardware Design Tools:** KiCad (PCB), Oscilloscope for signal analysis  
- **Mechanical Design:** Fusion 360 (3D-printed enclosure)

**Testing & Validation:**  
- Verified Bluetooth connectivity & data transmission speeds.  
- Stress-tested power system under dynamic motor actuation.  
- Calibrated IMU-based feedback algorithms for motion responsiveness.  

---

## 💡 **Reflection & Highlights**  

This project provided hands-on experience in embedded systems, wearable technology, and circuit design. Some of my highlights were:  
- Designing a custom PCB that significantly reduced device size and power complexity.
- Improving haptic response time with Classic Bluetooth & optimized PWM control.
- Developing a wearable, adaptable design for potential future CHARM Lab research.

This experience has further strengthened my skills in embedded system architecture, PCB design, and wearable device development, preparing me for future work in haptic interfaces and assistive technology.

---

## 📸 **Gallery**  

- **Early Testing & Circuit Prototyping:**  
<div class="image-container">
  <img src="../assets/images/haptic_device/hd_prototype_1.jpeg" alt="Prototype Testing">
  <img src="../assets/images/haptic_device/hd_prototype_2.jpeg" alt="Prototype Testing">
  <img src="../assets/images/haptic_device/charm_main.jpeg" alt="Prototype Testing">
</div>

- **Custom PCB Layout in KiCad for planned next iteration:**  
<div class="image-container">
  <img src="../assets/images/haptic_device/hd_schematic.jpeg" alt="PCB Design Schematic">
  <img src="../assets/images/haptic_device/hd_pcb1.jpeg" alt="PCB Design">
  <img src="../assets/images/haptic_device/hd_pcb2.jpeg" alt="PCB Design Render">
</div>

- **SURI Poster Presentation:**  
<div class="image-container">
  <img src="../assets/images/haptic_device/presentation.JPG" alt="Presentation">
</div>


---

## 📂 **Project Documentation**  

- 📄 [Research Poster (PDF)](../assets/docs/SURI_Poster.pdf){:target="_blank"}
