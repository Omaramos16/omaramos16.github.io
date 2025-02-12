---
layout: default
title: ME218C Final Project - Super KARLio (NEDMO & 0ILUS)
---

## 🚀 **Project Overview**  
- **Project Name:** Super KARLio - *Nautical Electromechanical Device for Mobile Operation (NEDMO)*  
- **Role:** Embedded Systems & Controller Design Lead 
- **Technologies:** Embedded C/C++, FSMs, UART, SPI, XBee (Zigbee), Analog Signal Processing, PIC32, KiCad, Fusion 360, MPLAB X  
- **Class:** ME218C: Smart Product Design Applications (Graduate-Level Mechatronics Series)  
- **Team Size:** 3 members  
- **Duration:** ~3 weeks  
- **Key Contributions:** System Architecture, Embedded Software, Wireless Protocols, Electrical Design, Mechanical Integration  
- **Theme:** Inspired by *Super Mario Sunshine*  
- **Documentation:** [Project Website](https://superkarlio.weebly.com/)  
- **🎥 Demo:**  
<div class="video-container">  
  <iframe src="https://www.youtube.com/embed/dUoI39grSPE" frameborder="0" allowfullscreen></iframe>  
</div>  

---

# **Super KARLio - *Nautical Electromechanical Device for Mobile Operation (NEDMO)***  

*Super KARLio* is a Nintendo-inspired project designed to control an autonomous aquatic robot, the *0 Ingress Lightweight Uncrewed Scuttlebutt (0ILUS)*, via a custom NES-style controller (*NEDMO*). The NEDMO wirelessly communicates with the 0ILUS using XBee (Zigbee) modules for real-time control of propulsion, refueling, and water-shooting mechanisms. The system integrates embedded software, custom protoboards, analog signal processing, and retro-inspired mechanical design for an immersive, game-like experience.

---

## 🛠️ **Key Technologies & Concepts**  
- Embedded C/C++ (Modular Event-Driven Architecture)  
- Finite State Machines (FSMs) for Control & Communication  
- UART & SPI Communication (XBee Wireless, LED Matrix Display)  
- Real-Time Interrupt Handling for Low-Latency Control  
- Analog Signal Processing (Accelerometer-Based Refueling)  
- Power Distribution & Signal Integrity Optimization (Twisted Pairs, Decoupling Capacitors)  
- Hardware-Software Co-Design (PIC32, KiCad)  
- Mechanical Design (Fusion 360, 3D Printing with Bambulab)  
- System Integration Testing (UART Logs, Oscilloscopes, Debugging Tools)  

---

## 👤 **My Role & Key Contributions**  

- **System Architecture:** Led the end-to-end design of NEDMO, integrating software, hardware, and mechanical systems.  
- **Embedded Software Development:** Designed FSMs for wireless communication, joystick/button inputs, and real-time LED display management.  
- **Wireless Communication:** Engineered UART-based XBee protocols (Zigbee) for low-latency control.  
- **Motion-Based Refueling:** Developed an accelerometer-driven refueling mechanism with analog filtering to ensure signal stability.  
- **Mechanical Design:** CAD-modeled NES-inspired controller and console with magnetic latches, strain relief, and retro aesthetics.  
- **Electrical Design:** Designed custom circuits, handled power distribution, and implemented robust signal conditioning.  
- **System Integration:** Ensured seamless hardware-software communication and modular system debugging.

---

## ⚡ **Detailed Electronics Design**  

As the **Embedded Systems & Controller Design Lead**, I was responsible for the electrical architecture of NEDMO, focusing on power distribution, signal conditioning, and embedded system reliability.

### **FUELCON System - Base Unit**  
- **Purpose:** Central hub for fuel management, status display, and wireless communication.  
- **Key Components:**  
  - **MAX7219 Dot Matrix Display:** Displays communication status and active 0ILUS unit.  
  - **270° Servo Motor:** Visual fuel indicator, driven via buffered control signals.  
  - **Signal Conditioning:**  
    - **Octal Buffer (74ACT244):** Steps up PIC32’s +3.3V control signals to +5V for high-current peripherals.  
    - **Decoupling Capacitors:** Stabilize voltage near ICs to reduce noise.  
  - **Power Distribution:** Optimized with twisted power pairs to minimize EMI and ensure clean +3.3V/+5V lines from a USB battery pack.  

---

### **🔨 FUELCON - Hammer Refueling Mechanism**  
- **Design:** Motion-based refueling inspired by *Super Mario Bros.*  
- **Key Features:**  
  - **ADXL355 ±3g Analog Accelerometer:** Detects hammer swings to trigger refueling events.  
  - **Signal Processing:**  
    - Analog filtering and digital moving averages to reduce noise.  
    - Connected via JXT-XH connectors for robust signal integrity.  
  - **Microcontroller Interface:** Accelerometer outputs wired to PIC32 analog inputs (X, Y axes).

---

### 🎮 **NAVCON - NES-Inspired Controller**  
- **Purpose:** Real-time navigation control for the 0ILUS aquatic robot.  
- **Key Components:**  
  - **User Inputs:** 4 debounced buttons (160 Hz cutoff) + 2-axis joystick.  
  - **Signal Interface:**  
    - **DB9 Connector:** Secure modular connection to the FUELCON base with strain-relief mechanisms.  
    - **Hardware Debouncing:** Reduces false triggers, ensuring responsive control.  
    - **Expandability:** Reserved wiring for future button additions.

---

### 🚀 **Impact of My Electronics Design**  
- **Improved Reliability:** Crimped connectors, optimized power routing, and noise-resistant designs enhanced system stability.  
- **Power Efficiency:** Resource-sharing and effective power management reduced energy waste.  
- **Robust Data Transmission:** Buffered UART and SPI signals ensured seamless wireless control with minimal latency.  
- **Modularity:** Easy disassembly and debugging due to modular wiring and connector design.

---

## 🚩 **Key Challenges & Solutions**  

- **Wireless Reliability:** Resolved data loss with UART interrupt handling and antenna optimization.  
- **Signal Noise:** Mitigated noisy accelerometer data using analog filters and digital smoothing algorithms.  
- **Power Distribution Issues:** Improved power integrity with decoupling capacitors and optimized grounding.  
- **Mechanical Durability:** Designed for frequent gameplay with strain-relieved connectors and reinforced structures.  
- **Limited Microcontroller Resources:** Efficiently multiplexed SPI signals and optimized GPIO usage.

---

## 🌟 **Project Highlights**  
- **End-to-End System Development:** Led NEDMO’s full-stack design across software, electronics, and mechanical domains.  
- **Innovative Refueling System:** Created a motion-based refueling mechanism with analog signal processing.  
- **Wireless Control Mastery:** Designed low-latency communication protocols using XBee modules.  
- **Cross-Disciplinary Engineering:** Balanced embedded systems design with mechanical usability and aesthetics.  

---

## 💡 **Reflection & Lessons Learned**  

Working on *Super KARLio* was an immersive experience in embedded systems, real-time communication, and hardware-software co-design. Leading NEDMO’s development taught me the importance of modular architectures, robust protocols, and balancing technical performance with user-centric design.

---

## 📸 **Gallery**

- **Super KARLio in Action** 
<div class="video-container">
  <iframe src="https://drive.google.com/file/d/14LNPfPP-Z0OrEcZv3UUecbrSWsr1tCLD/preview" width="640" height="480" allow="autoplay"></iframe>
</div>

- **Design:**  
<div class="image-container">
  <img src="../assets/images/nedmo/nedmo-1.jpg" alt="NEDMO">
  <img src="../assets/images/nedmo/nedmo-2.jpg" alt="NEDMO">
  <img src="../assets/images/nedmo/nedmo-3.jpg" alt="NEDMO">
  <img src="../assets/images/nedmo/nedmo-4.jpg" alt="NEDMO">
  <img src="../assets/images/nedmo/nedmo-controller.png" alt="NEDMO">
  <img src="../assets/images/nedmo/nedmo-controller-1.png" alt="NEDMO">
  <img src="../assets/images/nedmo/nedmo-handle.png" alt="NEDMO">
  <img src="../assets/images/nedmo/nedmo-main.png" alt="NEDMO">
  <img src="../assets/images/nedmo/nedmo-oilus-home.jpg" alt="NEDMO">
</div>

- **Communication Architecture Diagram:**  
<div class="image-container">
  <img src="../assets/images/nedmo/nedmo-communicationfsm.png" alt="System Architecture">
</div>

- **Schematics:**  
<div class="image-container">
  <img src="../assets/images/nedmo/nedmo-schematics-1_orig.png" alt="Schematics">
</div>

---

## 📂 **Project Documentation**  
- 📄 <a href="../assets/docs/ME218C_S24_Project_Spec.pdf" target="_blank" rel="noopener noreferrer">Project Handout (PDF)</a>  
- 🌐 <a href="https://superkarlio.weebly.com/" target="_blank" rel="noopener noreferrer">Project Website</a>  
- 🔗 <a href="https://superkarlio.weebly.com/mechanical.html" target="_blank" rel="noopener noreferrer">Files</a>  
