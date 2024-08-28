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
- The data was scraped of indeed on 09-08-2024 using the search term "data analyst" and with geographical filter the Netherlands. The Apify Indeed scraper was used for this. The raw dataset is included as X, but the _description_ column was not included to protect any included personal data.
### Techstack
- Apify (Indeed scraper) --> Data collection
- ChatGPT --> Data labeling
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

### Analysis & Visualization (Dashboard)
After these preparation steps were the final clean file X was imported into Tableau. This tool allowed me to perform analysis, as well as visualize the findings into a coherent dashboard. The dashboard can be found under X and a screenshot is included below

![image](https://github.com/user-attachments/assets/1a194e1b-cf6d-41e6-8b2e-33bb6f311a1f)


## Conclusion

### Findings
- Excel and SQL were found to be the top-demanded skills, which suggests a strong demand for basic data manipulation and querying abilities. Python and Git, also highly mentioned, indicate a growing need for coding and version control skills, reflecting the increasing complexity and collaboration in data analysis tasks.
- Almost all job listings requested for a degree. 47.3% requested at least a HBO degree, whereas a small majority of the job listings requested for at least a WO degree with 52.3%
- Most data analysis jobs are located in larger cities. In terms of area a vast majority is located in the randstad (Amsterdam, Rotterdam, Utrecht area)
- Average salary for the different experience levels. Internship: Intern: 26k, Junior: 43k, Medior: 59k, Senior 70k
- Luxoft leads with a 4.5 rating, followed by Salesforce, Microsoft, and Johnson & Johnson at 4.2, showing high employee satisfaction across various industries. It makes sense that larger coorporation came out on top of this list as only companies that had at least 100 employee reviews were included. 

### Limitations
- Relatively small (888 posts) and non-diverse sample (only one platform and search term)
- Seniority was collected by a LLM analyzing description content, could be prone to error.
- Review results only account for larger companies

### Further recommendations
- Look into the role of remote working
- Larger, more diverse dataset to have more robust results.  
- Add more adaptability/insightfulness to dashboard by adding filters
