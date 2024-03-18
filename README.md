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
- Binary variable were introduced (taking values 1 and 0) and  categorical variable 'Rating greater than 7' and 'Rating less than 7'
- Both were converted to factor type

### EDA
	
- Summary statistics of all the variables were formulated
- Correlation between the variables was found to be weak
- Histograms show belong to a family of exponential distributions. GLM model is appropriate.The also suggest logarithmic transformation of votes.
- Scatterplots justified the weak correlation
- Boxplots and summary stats for explantory variables are explored with respect to catrgorical binary variable. Many outliers are observed.
- Outliers-threshold values for extreme outliers to facilitate robust analysis

### Formal analysis

- Logistic regression model is fitted since binary variable is the response variable
  
- Main model
1. high_rating ~ length + budget + genre
2. From the table - p-values are significant, Confidence intervals do not contain 0
3. Anova table (in m0_model) suggested that log_votes and year show the smallest reduction in residual deviance, log_votes was insignificant in the  saturated model
4. Goodness of fit methods-explain briefly (Deviance & Hosmer-Lemeshow goodness of fit test)
5. Assumptions were valid for all the models
6. log-odds- coefficients, confidence intervals, graph
7. odds - coefficients,  Confidence intervals
8. probabilities 
	
### Model Selection
- Likelihood Ratio Chi-Squared Statistic Test 
- Residuals
- ROC and AUC
- AIC & BIC

### Conclusion and further work 
- In summary, we find that the GLM model high_rating ~ length + budget + genre is the most appropriate since the Saturated
model has insignificant log_votes and ‘year’ has smallest reduction in residual deviance.
- In conclusion, it can be observed that ‘length’, ‘budget’ and ‘genre’ are the properties of film that influence the IMDB ratings
to be greater than 7 on not.

This QMD file is contributed by DAS-Group-Project-2 Group 06.
