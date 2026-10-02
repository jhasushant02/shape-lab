# Analysis

The analysis is the Tableau workbook. There are two dashboards:

| Dashboard | What it covers |
|---|---|
| **HR Summary: Overview** | Total hired, active and terminated; hiring and termination trends by year; headcount by department and job title; headquarters versus branches |
| **HR Summary: Demographics** | Gender ratio, age distribution, education levels, and education versus performance rating |
| **HR Summary: Income analysis** | Salary by education level and gender; age versus salary within each department |
| **Employee list** | Every employee record with filters on every column, for finding one person and seeing everything about them |

Published on Tableau Public: https://public.tableau.com/views/HRDashboard_Dummy/HRSummary

## To add the workbook here

Download the packaged workbook (`.twbx`) from Tableau Public (Download, then Tableau Workbook) and save it in this folder, for example `HRDashboard.twbx`.

## To rebuild from scratch

1. Generate `HumanResources.csv` with `../data/generate_hr_data.py`.
2. In Tableau, connect to the CSV as a text file.
3. Build the sheets for each view above and combine them into the HR Summary and Employee list dashboards.
