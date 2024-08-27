# The "Data Analyst" job market in the Netherlands 
## Project Overview

As a recent graduate in Business Analytics and an aspiring Data Analyst, I am eager to understand the dynamics of the data analysis job market in the Netherlands. Gaining insights into what employers are seeking and what they offer will allow me to tailor my job applications effectively and be better prepared for interviews. This project aims to analyze and answer key questions related to the data analysis job market, which will ultimately help me and others in similar situations navigate the job search process more strategically.

To achieve these goals, I have outlined the following research questions:
- What skills are employers looking for?
- What experience and education levels are employers seeking?
- Where are most data analysis jobs located in the Netherlands?
- What is the average salary for different experience levels?
- Which companies are the best-rated by employees?

## Approach 

### Collection
- The data was scraped of indeed on XX-XX-XX using the search term "data analyst" and with geographical filter the Netherlands. The Apify Indeed scraper was used for this. The

### Techstack
- R (dplyr, tidygeocoder) --> Data cleaning & engineering
- Tableau --> Analysis & Visualization

### Cleaning & Engineering
The following key steps were taken. **CODE**
1. Unecessary/Redundant columns were deleted.
2. _location_ column was cleaned and coordinates of the cities were added using the tidygeocoder package, to allow for the creation of maps.
3. _jobType_ column was standardized and brought down to Full-time/Part-time/Other/Unknown.
4. _salary_ column was cleaned and standardized to show the annual wage for all of the job postings, resulting in the new column _numeric_salary_.
5. _description_ column was searched through for the mentioning of X's top 10 data analyst skills and for each skill a binary column was created.
6. ChatGPT was used to label the required experience level, based on job descriptions. The prompt can be found under XXX and the output file XXX

### Analysis & Visualization 
After these preparation steps were the final clean file X was imported into Tableau. This tool allowed me to perform analysis, as well as visualize the findings into a coherent dashboard. The dashboard can be found under X and a screenshot is included below

![image](https://github.com/user-attachments/assets/cadf0f7d-02aa-434a-bcb3-b0d9d7093e0b)

## Conclusion

### Findings
### Limitations
### Further recommendations

