# Global Layoffs Data Cleaning & Analysis (SQL Project)

This project explores a global layoffs dataset to uncover workforce trends across industries, companies, and funding stages. 
It demonstrates SQL skills in **data cleaning, transformation, and exploratory data analysis (EDA)** using MySQL.

---

## 🎯 Objectives
- Perform **data cleaning**: remove duplicates, standardize text fields, handle null values, and reformat dates.  
- Conduct **exploratory data analysis (EDA)**: identify layoff trends by industry, company, country, and year.  
- Apply **SQL window functions and aggregate queries** to generate actionable insights.  

---

## 📊 Dataset
- Source: `layoffs.csv`  
- Contains company-level layoff data with fields such as:
  - Company, Location, Industry, Date, Country, Stage, Funds Raised, Total Laid Off, % Laid Off
- Size: ~X rows, X columns (fill in after checking the CSV).  

---

## 🔄 Project Workflow
1. **Data Cleaning (`Data_cleaning_MySQL_Project.sql`):**
   - Created staging tables for transformations.
   - Removed duplicates using `ROW_NUMBER()`.
   - Standardized company, industry, and country fields.
   - Reformatted date fields and handled missing values.

2. **Exploratory Data Analysis (`Exploratory_Data_Analysis_Mysqlproject.sql`):**
   - Aggregated layoffs by company, industry, year, and stage.
   - Identified companies with the highest layoffs.
   - Calculated rolling monthly totals of layoffs.
   - Ranked top 5 companies per year using `DENSE_RANK()`.

---

## 🔍 Key Insights
- Industries like **Tech** and **Crypto** experienced the largest layoffs.  
- The year **2022–2023** saw the highest recorded layoffs.  
- Certain companies consistently appeared in the **top 5 by layoffs** each year.  
- Startups at **Late-Stage funding** were among the most impacted.  

---

## 🛠️ Tech Stack
- **MySQL** (Data Cleaning + EDA)  
- SQL Functions: `ROW_NUMBER()`, `DENSE_RANK()`, `GROUP BY`, `JOIN`, `WINDOW FUNCTIONS`  

