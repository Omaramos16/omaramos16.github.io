---
layout: default
title: High-Performance Image Processing with Hardware Acceleration
---

## 🚀 **Project Overview**  
- **Project Name:** High-Performance Image Processing with Hardware Acceleration  
- **Role:** Digital Systems Engineer  
- **Technologies:** **Verilog, MIPS, FPGA, NEON SIMD, Pthreads, Hardware Acceleration**  
- **Class:** EE180: Computer Architecture  
- **Duration:** 4 Labs (Progressive System Development)  
- **Key Contributions:** Custom processor implementation, multi-threaded image processing, FPGA-accelerated Sobel filter  

---

## 📖 **Project Summary**  
This project focused on **building a high-performance computing system** from the ground up:  

1️⃣ **Custom 5-Stage Pipelined MIPS Processor**  
   - Designed a **fully pipelined CPU** with **data forwarding & instruction stalling** to resolve hazards.  
   - Implemented **over 30 MIPS instructions**, including branching, memory access, and arithmetic operations.  
   - Synthesized and ran the processor on an **FPGA**, executing assembly programs.  

2️⃣ **Optimized Sobel Filter with SIMD & Multi-Threading**  
   - Implemented **vectorized image processing** using **NEON SIMD instructions** to accelerate pixel operations.  
   - Developed **multi-threaded Sobel filtering** using **Pthreads**, improving FPS from **5 → 72 FPS.**  
   - Optimized **data locality, loop unrolling, and parallel execution** for peak efficiency.  

3️⃣ **FPGA-Based Hardware Accelerator**  
   - Designed and implemented a **hardware Sobel filter accelerator** to process images in parallel.  
   - Implemented a **custom state machine (FSM)** for managing **data flow & control logic**.  
   - Achieved massive speedup compared to CPU execution.  

---

## 🛠️ **Key Technologies & Concepts**  
- **5-Stage Pipelined Processor Design** – Implemented **data forwarding, instruction stalling, and hazard detection.**  
- **NEON SIMD Vectorization** – Used **single-instruction, multiple-data (SIMD) instructions** to accelerate image filtering.  
- **Multi-Threaded Programming (Pthreads)** – Optimized **parallel execution across CPU cores** for real-time performance.  
- **FPGA-Based Hardware Acceleration** – Developed a **custom hardware accelerator** for **real-time image processing.**  
- **Verilog & MIPS ISA** – Designed a **fully functional RISC processor** from scratch.  

---

## 🛠️ **Key Technologies & Concepts**  
- **5-Stage Pipelined Processor Design** – Extended and optimized a **MIPS processor**, implementing **data forwarding, instruction stalling, and hazard detection** for correct execution.  
- **NEON SIMD Vectorization** – Used **single-instruction, multiple-data (SIMD) instructions** to accelerate image filtering, improving efficiency.  
- **Multi-Threaded Programming (Pthreads)** – Optimized **parallel execution across CPU cores**, increasing performance from **5 FPS → 72 FPS**.  
- **FPGA-Based Hardware Acceleration** – Developed a **custom Sobel filter accelerator** to process images in real time on an **FPGA**.  
- **Verilog & MIPS ISA** – Implemented additional **MIPS instructions** and control logic, enhancing the functionality of a pipelined RISC processor.    

---

## 🚩 **Challenges & Solutions**  
- **Data Hazards in Pipeline Execution**  
  - Implemented **data forwarding & instruction stalling** to ensure correct execution.  

- **Synchronization in Multi-Threaded Image Processing**  
  - Used **barriers & mutex locks** to coordinate multi-core execution efficiently.  

- **FPGA Timing Constraints & Signal Delays**  
  - Debugged using **waveform analysis & FSM state tracking** to optimize performance.  
