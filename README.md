# Das-Group-06

## Introduction 
The study aims to investigate the relationship between various film attributes and IMDB ratings, drawing
data from the IMDB film database allocated. The data set comprises of the factors such as film ID, release
year, duration, budget, votes, genre, and IMDB rating. The research question focuses on examining the
factors that impact IMDB ratings, particularly whether specific film properties contribute to ratings
greater than seven. A Generalized Linear Model (GLM) analysis is conducted to derive the relationships
between these properties and IMDB ratings.

## Summary for the whole QMD file  

### Data Wrangling

- The data was checked for missing values, length had 103 values missing, missing values were replaced by the median (after grouping length by genre)
- Binary variable was introduced (explain 1 and 0), categorical variable 'rating greater than 7' and 'rating less than 7'
- Both were converted to factor

### EDA
	
- Summary statistics were formulated
- Correlation was found to be weak
- Histograms suggested logarithmic transformation of votes 
- Scatterplots justified the weak correlation
- Boxplots and summary stats for variables-comment on main point and if outliers are present or not
- Outliers-threshold values for extreme outliers to facilitate robust analysis

### Formal analysis

- Logistic regression model is fitted since binary variable is the response variable
  
- Main model
1. explain main equation
2. From the table - p-values significant, Confidence intervals do not contain 0
3. nova table (in m0_model) suggested that log_votes and year show the smallest reduction in residual deviance, log_votes was insignificant in the  saturated model
4. Goodness of fit methods-explain briefly (names and result)
5. Assumptions were valid-include graphs of 4 and 5
6. log-odds- basic equation, use the plot to comment on the coefficients
7. odds- basic equation, values,  Confidence intervals
8. probabilities - basic formula, explain the graph (what it shows)
	
### Model Selection
- Explain why m2_model was chosen 
- Name the methods used

### Conclusion and further work 
- Answer the research question (which properties impact rating greater than 7), 1 suggestion for further work

This QMD file is contributed by DAS-Group-Project-2 Group 06.
