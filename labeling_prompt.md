### The following was inserted into ChatGPT,alongside portions of the description data. This was done in batches of 50 due to computational limitations.

I want you to analyze job descriptions and label them with a seniority level: "junior," "medior," "senior," or "not specified." The output should be a single column containing only the seniority label without any explanation or row numbers.

Label based on:

- Literal mentions of terms like "junior," "medior," or "senior" in the job description.
- Years of experience required: use "junior" for 0-2 years, "medior" for 3-5 years, and "senior" for 6+ years.
- If multiple seniorities are mentioned, use the lowest level (e.g., if both "junior" and "senior" are mentioned, output "junior").
- If no terms or years of experience are mentioned, label as "not specified."
The input will be provided as a list of job descriptions.
