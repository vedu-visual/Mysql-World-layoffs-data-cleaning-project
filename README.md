# Global Layoffs Analytics
**MySQL · Tableau · End-to-End Analytics Project**
*Author: Vedant Ratnakar*

---

## Overview

This project transforms a messy, raw dataset of global company layoffs into a clean, analysis-ready asset — then surfaces executive-level insights through SQL and an interactive Tableau dashboard.

The workflow mirrors a real-world analytics engagement: raw data in, decision-ready dashboards out.

---

## Data Cleaning & Preparation

All cleaning was done in MySQL using advanced SQL techniques to ensure the dataset was accurate, consistent, and ready for analysis.

**Steps taken:**

1. Backed up the original raw dataset before any modifications
2. Identified and removed duplicate records using `ROW_NUMBER()` window functions
3. Standardized text fields — company names, industry labels, and country values
4. Converted date strings into proper SQL `DATE` format
5. Filled missing values using relational matching logic across related records
6. Dropped records with insufficient or unresolvable data

> **Outcome:** A clean, reliable dataset suitable for aggregation, ranking, and visualization.

---

## Exploratory Data Analysis

Key insights were extracted using CTEs, window functions, and ranking queries.

| Dimension | Finding |
|---|---|
| Top companies | Meta, Amazon, Google, Tesla, Microsoft |
| Peak period | 2022–2023 (post-pandemic correction) |
| Most impacted industries | Consumer, Retail, Transportation |
| Startup shutdowns | 141 companies with 100% workforce reduction |
| Geographic concentration | US accounts for ~67% of all tracked layoffs |

These findings directly shaped the metrics and narrative of the Tableau dashboard.

---

## Tableau Dashboard

An interactive dashboard was built to present findings in a clear, executive-friendly format — enabling stakeholders to explore the data without writing a single query.

### Visuals included

- **Trend line** — total layoffs over time (monthly resolution)
- **Geographic map** — layoff volume by country
- **Industry bar chart** — ranked breakdown by sector impact
- **Company ranking chart** — dynamic Top-N by total layoffs
- **Stage analysis** — breakdown by funding stage (Post-IPO, Series B–D, Seed, etc.)
- **Rolling/cumulative trend** — built using window function logic

### Dashboard capabilities

- Year, country, and industry filters (interactive)
- Dynamic Top-N company ranking
- KPI summary cards for at-a-glance metrics
- Business-ready design suitable for presentations and board reports

---

## Tools & Technologies

| Category | Tool |
|---|---|
| Data cleaning & analysis | MySQL |
| Data visualization | Tableau |
| Version control | GitHub |

---

## Skills Demonstrated

- Advanced SQL — CTEs, window functions, data cleaning pipelines
- Exploratory data analysis at scale
- Business-focused insight generation from raw data
- Tableau dashboard design and storytelling
- End-to-end analytics project execution

---

## Business Value

This project demonstrates the ability to:

- Convert unreliable raw data into trusted analytics assets
- Surface macro-level workforce trends across industries and geographies
- Enable strategic workforce and investment decisions through dashboards
- Communicate complex findings clearly to non-technical stakeholders

The insights are relevant to HR leaders, investors, finance teams, and executives monitoring sector-level risk exposure in a volatile macro environment.

---

*Data period: 2020–2023 · 2,361 layoff events · 50+ countries tracked*
