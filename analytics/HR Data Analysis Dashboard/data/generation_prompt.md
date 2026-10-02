# ChatGPT prompt used to generate the script

> Generate python script to generate a realistic dataset of 8950 records for human resources. The dataset should include the following attributes:
>
> - **Employee ID:** a unique identifier.
> - **First Name / Last Name:** randomly generated.
> - **Gender:** randomly chosen with a 46% probability for 'Female' and a 54% probability for 'Male'.
> - **State and City:** randomly assigned from a predefined list of states and their cities.
> - **Hire Date:** randomly generated with custom probabilities for each year from 2015 to 2024.
> - **Department:** randomly chosen from a list of departments with specified probabilities.
> - **Job Title:** randomly selected based on the department, with specific probabilities for each job title within the department.
> - **Education Level:** determined based on the job title, chosen from a predefined mapping of job titles to education levels.
> - **Performance Rating:** randomly selected from 'Excellent', 'Good', 'Satisfactory', 'Needs Improvement' with specified probabilities.
> - **Overtime:** randomly chosen with a 30% probability for 'Yes' and a 70% probability for 'No'.
> - **Salary:** generated based on the department and job title, within specific ranges.
> - **Birth Date:** generated based on age group distribution and job title requirements, ensuring consistency with the hire date.
> - **Termination Date:** assigned to a subset of employees (11.2% of the total) with specific probabilities for each year from 2015 to 2024, ensuring the termination date is at least 6 months after the hire date.
> - **Adjusted Salary:** calculated based on gender, education level, and age, applying specific multipliers and increments.
>
> Be sure to structure the code cleanly, using functions where appropriate, and include comments to explain each step of the process.
