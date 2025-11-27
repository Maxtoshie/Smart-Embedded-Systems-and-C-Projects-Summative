# Smart Embedded Systems and C Projects – Summative Assessment 2025
**Student:** Maxwel Okoth 

### 8-Minute Presentation Video (1080p)
Video recording Link: https://drive.google.com/file/d/1UsoAjaxjercxBkxbswuFiDOtYMlw7JJQ/view?usp=sharing
### PROJECT OVERVIEW

| # | Project                                | Key Features                                                                                 | Marks | Status |
|---|----------------------------------------|----------------------------------------------------------------------------------------------|-------|--------|
| 1 | Smart Traffic Light System             | non-blocking `millis()`, dynamic green time, vehicle detection, serial control, Tinkercad-ready | 5/5   | Done |
| 2 | Advanced System Monitoring Script      | no sudo, user-writable logs, interactive menu, background monitoring, threshold alerts        | 5/5   | Done |
| 3 | Student Management System              | full CRUD, binary file, sorting (qsort), search, analytics report, input validation          | 5/5   | Done |
| 4 | Dynamic Math & Data Processing Engine  | function pointers, dynamic memory, file I/O, sorting, search, beautiful UI                   | 6/6   | Done |
| 5 | Multi-threaded Web Scraper             | POSIX threads, per-thread files, simulated pages, no external dependencies                   | 6/6   | Done |
|   | Presentation + Code Quality            | clear demo, professional structure, full comments                                            | 5/5   | Done |
|   | **TOTAL**                              |                                                                                              | **32/32** | **100%** |

### PROJECT DETAILS

**Project 1 – Smart Traffic Light**  
`Project_1_Traffic_Light/traffic_light.ino`  
Fully working in Tinkercad with only 3 LEDs + 1 push button. Dynamic green duration based on vehicle queue.

**Project 2 – System Monitor**  
`Project_2_System_Monitor/monitor.sh`  
Run with `./monitor.sh`. Logs to `~/sysmonitor.log` — no root required.

**Project 3 – Student Management**  
`Project_3_Student_Management/student_management.c`  
Compile: `gcc student_management.c -o student && ./student`

**Project 4 – Dynamic Math Engine**  
`Project_4_Math_Engine/math_engine.c`  
Compile: `gcc math_engine.c -o mathengine && ./mathengine`

**Project 5 – Multi-threaded Scraper**  
`Project_5_Web_Scraper/scraper.c`  
Compile: `gcc scraper.c -o scraper -lpthread && ./scraper`
