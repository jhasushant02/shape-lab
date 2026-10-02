# Data

There is no real HR data in this project. No company hands over employee records for a side project, so the dataset is synthetic: a ChatGPT-written Python script using `pandas`, `numpy` and `Faker` generates 8,950 employee records that look like an HR system export.

| File | What it is |
|---|---|
| `generate_hr_data.py` | The generator script. Run it to create `HumanResources.csv`. |
| `generation_prompt.md` | The ChatGPT prompt that produced the script. |
| `HumanResources.csv` | Not committed. Created by running the script (see below). |

## To reproduce

```bash
pip install pandas numpy faker
python generate_hr_data.py      # writes HumanResources.csv next to the script
```

The script is seeded (`Faker.seed(42)`, `np.random.seed(42)`, `random.seed(42)`), but salaries use today's date to work out age, so the exact salary values can differ slightly depending on the day and library versions you run it.

## Columns

| Column | Notes |
|---|---|
| `employee_id` | Random 8-digit ID with a `00-` prefix |
| `first_name`, `last_name` | From Faker |
| `gender` | Female 46%, Male 54% |
| `state`, `city` | 8 states, 3 cities each; New York is 70% of employees |
| `hiredate` | Weighted by year, 2015 to 2024 |
| `department`, `job_title` | 7 departments, 4 job titles each, with set probabilities |
| `education_level` | Chosen from the levels allowed for each job title |
| `salary` | Base salary for the job title, then adjusted for gender, education and age (the adjusted value overwrites the base) |
| `performance_rating` | Excellent 12%, Good 50%, Satisfactory 30%, Needs Improvement 8% |
| `overtime` | Yes 30%, No 70% |
| `birthdate` | Generated from an age-group distribution |
| `termdate` | Blank for active employees; set for about 11.2% of employees (1,000 after rounding) |

## Because it is synthetic

Every pattern in the dashboard comes from a setting in this script. In particular:

- Performance rating is drawn independently of everything else, so it cannot correlate with education.
- The pay adjustment is written into the script: men get +3% (High School) and +11.5% (Bachelor), women get +7% (Master) and +17% (PhD), plus 0.1% to 0.3% per year of age. Any gender pay gap in the income view is planted, and its direction flips by education level.
- Department mix (Operations 30%, Sales 21%, Customer Service 19%, IT 15%, Marketing 8%, Finance 5%, HR 2%) and the New York concentration are inputs, not findings.

## Known issues in the script

These do not stop the dashboard working, but they are worth knowing before treating the data as realistic.

- **Manager age rule never applies.** `any('Manager' in title for title in row['job_title'])` loops over the letters of the job title, so it is always false. Managers get the same age logic as everyone else.
- **Birthdate is not tied to hire date.** Age is worked out against today, so an employee hired in 2015 can have been under 18 at the time.
- **Termination year is drawn independently of hire date.** Dates earlier than hire date plus 180 days are moved to exactly hire date plus 180 days, so terminations bunch up and the intended year distribution is distorted.
- **`employee_id` is not guaranteed unique.** IDs are random 8-digit numbers with no duplicate check; across 8,950 draws a collision is possible.
- **The base salary is overwritten** by the adjusted salary, so only one salary column exists.
- **Leftovers:** `assigned_states` and `assigned_cities`, the `educations` list, the unused month and day in `generate_custom_date`, and the `Customer Success Manager` entry in `education_mapping` are never used, and the comments beside the hire-year weights do not match the weights.
