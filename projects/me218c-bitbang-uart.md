---
layout: default
title: Bit-Banged UART in Assembly
---

## 🚀 **Project Overview**  
- **Project Name:** Bit-Banged UART using Assembly
- **Technologies:** Assembly, Software UART, Interrupt-Driven Communication, PIC10F322, MPLAB X  
- **Key Focus:** Software-based serial communication without a hardware UART  
- **Class:** ME218C: Smart Product Design Applications  

---

## 📖 **Project Description**  

This project implements a **software-based UART (bit-banged)** entirely in assembly on a **PIC10F322**, a microcontroller **without built-in UART hardware**. Using **precise instruction timing and interrupt-driven reception**, the system reliably transmits and receives **ASCII characters at 2400 baud**.  
 
✔ **Bit-banged TX:** Manually generates start, data, and stop bits via software.  
✔ **Interrupt-driven RX:** Detects incoming data via edge interrupts and samples at **1.5 bit-time intervals**.  
✔ **Uses a Numerically Controlled Oscillator (NCO) for baud rate timing.**  
✔ **Receives serial data, converts it to uppercase, and retransmits it.**  

---

## 🛠️ **Key Technologies & Implementation Details**  

- **Microcontroller:** **PIC10F322 (8-bit, 256 bytes RAM, 512 words Flash)**  
- **Programming Language:** **Microchip PIC Assembly (MPASM, Mid-Range 8-bit Architecture)**  
- **Baud Rate:** **2400 baud, 8-N-1 (8 data bits, no parity, 1 stop bit)**  
- **Transmission Method:**  
  - Uses **an NCO (Numerically Controlled Oscillator) to generate the baud clock**.  
  - Each bit is manually written to the TX pin at the correct timing.  
- **Reception Method:**  
  - **Interrupt-on-Change (IOC) detects start bit.**  
  - **Timer2 interrupt samples** the middle of each bit period.  
  - Assembles received bits into a byte and **echoes it back** in uppercase.  

---

## 🚩 **Key Challenges & Solutions**  

- **🔄 Implementing Precise Timing for Bit-Banged Transmission**  
  - *Challenge:* Timing must be **exact** to match the 2400 baud rate.  
  - *Solution:* Used a **Numerically Controlled Oscillator (NCO)** to generate **precise interrupts** for each bit.  

- **⚡ Ensuring Reliable Reception Without a Hardware UART Buffer**  
  - *Challenge:* Reading bits at the **wrong moment** could result in corrupted data.  
  - *Solution:* Used a **1.5 bit-time sampling strategy** via **Timer2 interrupts** to read bits at the correct moment.  

- **🛠️ Debugging Without Traditional Serial Print Statements**  
  - *Challenge:* No hardware UART means no printf debugging.  
  - *Solution:* Used a **logic analyzer** to validate TX waveform & verify timing accuracy.  

---

## 🧰 **Technical Stack & Validation**  

- **Microcontroller:** **PIC10F322 (No Hardware UART, 8-bit RISC)**  
- **Programming:** **Assembly (MPASM, MPLAB X IDE)**  
- **Communication Method:** **Bit-Banged TX & Interrupt-Driven RX**  
- **Baud Rate Control:** **Numerically Controlled Oscillator (NCO) for precise timing**  
- **Testing Tools:** **Logic Analyzer for waveform validation**  
- **Performance:** Successfully transmitted, received, & echoed ASCII characters over **2400 baud serial**  

---

## 🌟 **Project Highlights**  

✔ **Implemented Full Software-Based UART** on a microcontroller without hardware UART.  
✔ **Low-Level Embedded Programming in Assembly** with precise bit-timing control.  
✔ **Interrupt-Driven Reception Handling** for accurate serial data decoding.  
✔ **Successfully Transmitted & Received ASCII Data** at 2400 baud.  

---
