# Mysql-World-layoffs-data-cleaning-project
A SQL-based data cleaning and analysis project using global layoffs data. The dataset was cleaned by removing duplicates, standardizing fields, fixing dates, and handling null values. Insights were extracted using aggregation and window functions to identify trends by company, country, industry, and time.


# 📊 World Layoffs Dataset — SQL Cleaning & EDA Project

### 👤 Author: Vedant Ratnakar  
💡 Goal: Clean raw company layoff records and uncover insights using SQL.

---

## 🚀 Project Overview

This project focuses on transforming raw layoff data into a structured, analysis-ready dataset.  
The pipeline includes:

- Duplicate removal  
- Standardization of text fields  
- Date formatting  
- Null value treatment  
- Exploratory analysis  

---

## 🧹 Data Cleaning Steps


| 1 | Backup original dataset 
| 2 | Detect & remove duplicates using `ROW_NUMBER()` 
| 3 | Trim and standardize fields (company, industry, country) 
| 4 | Convert date format to SQL `DATE` 
| 5 | Impute missing values using relational matching 
| 6 | Delete entries with no usable information 

---

## 📈 EDA Insights

Some key insights derived:

- **Top Companies by Layoffs:** Meta, Amazon, Google, Tesla  
- **Highest Layoff Year:** 2022–2023 (Post-pandemic correction)  
- **Most Affected Industries:** Tech, Retail, Transportation  
- **Several startups had 100% layoffs — shutdown cases**

---

## 📊 Visualizations (Power BI / Tableau)

Planned dashboards:

- ✔ Total layoffs over time (line chart)
- ✔ Layoffs by country (map chart)
- ✔ Layoffs by industry (bar chart)
- ✔ Top impacted companies (rank chart)
- ✔ Rolling layoffs trend (cumulative line)

---

## 🛠 Tools Used

| Category | Tool |
|----------|------|
| Data Cleaning | MySQL |
| Visualization | Power BI / Tableau (Optional) |
| Version Control | GitHub |

---


