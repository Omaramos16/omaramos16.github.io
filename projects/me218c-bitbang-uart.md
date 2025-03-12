---
layout: default
title: Bit-Banged UART in Assembly
---

## 🚀 **Project Overview**  
- **Project Name:** Bit-Banged UART using Assembly
- **Technologies:** Assembly, Software UART, Interrupt-Driven Communication, PIC10F322, MPLAB X  
- **Key Focus:** Developing a fully software-implemented UART on a microcontroller without built-in UART hardware, requiring precise bit-banging transmission and interrupt-driven reception.
- **Class:** ME218C: Smart Product Design Applications  
- **📜 Full Source Code:** You can view the complete source code [here](../assets/docs/bit_banged_uart.asm).

---

## 📖 **Project Description**  

Developed a software UART on a PIC10F322 (a microcontroller without hardware UART) using precise bit-banging for transmission and interrupt-driven reception. The system reliably transmits and receives ASCII characters at 2400 baud, using a Numerically Controlled Oscillator (NCO) for timing and Timer interrupts for accurate sampling. Received characters are echoed back in uppercase.

---

## 🛠️ **Key Technologies & Implementation Details**  

- **Microcontroller:** PIC10F322 (8-bit, No Hardware UART)
- **Programming Language:** Microchip PIC Assembly (MPASM, Mid-Range 8-bit Architecture)  
- **Baud Rate:** 2400 baud, 8-N-1 (8 data bits, no parity, 1 stop bit) 
- **Transmission**: Bit-banged output using NCO-driven (Numerically Controlled Oscillator) timing. Each bit is manually written to the TX pin at the correct timing.  
- **Reception:**  
  - Interrupt-on-Change (IOC) detects start bit.  
  - Timer2 interrupt samples at 1.5 bit-times to assemble data.
  - Characters are echoed back in uppercase.

---

### 🚩 Key Challenges & Solutions  
- **Precise Timing for Bit-Banged Transmission** → Used **NCO** to generate stable baud timing.  
- **Reliable Reception Without a Hardware UART** → Implemented **interrupt-based sampling** for accurate data capture.  
- **Debugging Without a UART Buffer** → Used a **logic analyzer** to verify waveform accuracy.  

---

### 🧰 Technical Stack & Validation  
✔ **Bit-banged TX & Interrupt-driven RX** for full software UART.  
✔ **Validated UART timing & synchronization** using a **logic analyzer**.  
✔ **Successfully transmitted & received ASCII data** at 2400 baud.  

---

### 🌟 Project Highlights  
✔ **Implemented Full Software UART on Hardware-Limited MCU**  
✔ **Low-Level Embedded Programming in Assembly**  
✔ **Precise Timing Control with NCO & Timer Interrupts**  

---