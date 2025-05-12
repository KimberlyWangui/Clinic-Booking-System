## Clinic-Booking-System 🏥

### Project Overview
The Clinic Booking System is a comprehensive MySQL database solution designed to streamline healthcare management, providing a robust platform for medical clinics to manage patients, doctors, appointments, medical records, and billing processes.

### Features
🩺 Doctor Management: Track doctor details, specializations, and departments

👥 Patient Profiles: Comprehensive patient information management

📅 Appointment Scheduling: Efficient booking and tracking of medical appointments

📋 Medical Records: Secure storage and retrieval of patient medical histories

💰 Billing System: Advanced billing and payment tracking

🏥 Department Organization: Categorize medical departments and specialties

💳 Insurance Integration: Manage patient insurance information

### Entity Relationship Diagram (ERD)
![ERD Diagram](Images/ERD1.png)
![ERD Diagram](Images/ERD2.png)
![ERD Diagram](Images/ERD3.png)

### Database Entities
1. Departments: Medical department information
2. Doctors: Healthcare professional details
3. Patients: Patient personal and contact information
4. Insurance Providers: Insurance company details
5. Appointment Slots: Available time slots for appointments
6. Appointments: Booking details
7. Medical Records: Patient treatment and diagnosis history
8. Billing: Financial transaction records

### Prerequisites
MySQL Server (8.0 or later recommended)

MySQL Workbench or similar SQL management tool (optional but recommended)

### Installation & Setup
1. Database Creation
   1. Clone the repository or download the SQL files
   2. Open MySQL Workbench or your preferred SQL client
   3. Create a new connection to your local MySQL server
2. Import Database
Method 1: Using MySQL Workbench
 1. Open MySQL Workbench
 2. Connect to your MySQL server
 3. Go to Server > Data Import
 4. Choose "Import from Self-Contained File"
 5. Select the `clinic.sql` file
 6. Create a new schema or select an existing one
 7. Start the import

Method 2: Using Command Line
 Connect to MySQl
 `mysql -u [username] -p`
 
 Create the database
 CREATE DATABASE clinic_booking_system;

 Use the database
 USE clinic_booking_system;

 Import the SQL file
 source /path/to/clinic_booking_system.sql;

3. Insert Sample Data
  Run the `clinic.sql` script to populate the database with sample records.

### Technologies Used
MySQL

SQL

Database Design

Entity-Relationship Modeling
 
