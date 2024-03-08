library(tidyverse)
library(MASS)
library(ggplot2)
library(gridExtra)
library(knitr)
library(GGally)

#Load the dataset#
imdb_data <- read.csv("dataset06.csv")
glimpse(imdb_data)

mean(imdb_data$rating) # 5.294166
median(imdb_data$rating) # 4.6

imdb_data$genre <- as.factor(imdb_data$genre)

#new binary column#
imdb_data$high_rating <- ifelse(imdb_data$rating >= 7, 1, 0)

# Check for missing values
missing_values <- sum(is.na(imdb_data$length))
missing_values

# Impute missing values with the median
median_length <- median(imdb_data$length, na.rm = TRUE)
imdb_data$length[is.na(imdb_data$length)] <- median_length

summary(imdb_data[2:7])

#Visualisations#

########Scattermatrix######
imdb_data_numeric <- imdb_data %>%
  select_if(is.numeric)
imdb_data_numeric

scatterplot_matrix <- ggpairs(imdb_data_numeric[2:6], title="Scatterplot matrix")
scatterplot_matrix

s1 <- ggplot(data=imdb_data, aes(x = year, y = rating))+
  geom_point()+
  geom_smooth(method="lm")
s1

s2 <- ggplot(data=imdb_data, aes(x = length, y = rating))+
  geom_point()+
  geom_smooth(method="lm")
s2

s3 <- ggplot(data=imdb_data, aes(x = budget, y = rating))+
  geom_point()+
  geom_smooth(method="lm")
s3

s4 <- ggplot(data=imdb_data, aes(x = votes , y = rating))+
  geom_point()+
  geom_smooth(method="lm")
s4

s5 <- ggplot(data=imdb_data, aes(x = log(votes) , y = rating))+
  geom_point()+
  geom_smooth(method="lm")
s5

#########BOXPLOT###########
# Set up the layout
par(mfrow = c(2, 3))

b1 <- boxplot(imdb_data$year)
b2 <- boxplot(imdb_data$length)
b3 <- boxplot(imdb_data$budget)
b4 <- boxplot(imdb_data$votes)
b5 <- boxplot(imdb_data$rating)

# Reset the layout to default
par(mfrow = c(1, 1))

#######DATA STRUCTURES############

#Histograms for statistical distribution#
year_plot <- ggplot(data=imdb_data, mapping=aes(x=year))+
  geom_histogram(color="red")
show(year_plot)

log_year_plot <- ggplot(data=imdb_data, mapping=aes(x=log(year)))+
  geom_histogram(color="red")
show(log_year_plot)

length_plot <- ggplot(data=imdb_data, mapping=aes(x=length))+
  geom_histogram(color="blue")
show(length_plot)

log_length_plot <- ggplot(data=imdb_data, mapping=aes(x=log(length)))+
  geom_histogram(color="blue")
show(log_length_plot)

budget_plot <- ggplot(data=imdb_data, mapping=aes(x=budget))+
  geom_histogram(color="green")
show(budget_plot)

log_budget_plot <- ggplot(data=imdb_data, mapping=aes(x=log(budget)))+
  geom_histogram(color="green")
show(log_budget_plot)

votes_plot <- ggplot(data=imdb_data, mapping=aes(x=votes))+
  geom_histogram(color="yellow")
show(votes_plot)

log_votes_plot <- ggplot(data=imdb_data, mapping=aes(x=log(votes)))+
  geom_histogram(color="yellow")
show(log_votes_plot)

rating_plot <- ggplot(data=imdb_data, mapping=aes(x=rating))+
  geom_histogram(color="skyblue")
show(rating_plot)

b6 <- ggplot(data=imdb_data, aes(x=factor(genre), , y = rating, color = genre))+
  geom_boxplot()
  
grid.arrange(year_plot, log_year_plot, length_plot, log_length_plot,
             budget_plot, log_budget_plot, votes_plot, 
             log_votes_plot,rating_plot, b6)

#OUTLIERS#
year_outliers <- imdb_data %>%
  mutate(is_outlier = year > quantile(year, 0.75) + 1.5 * IQR(year) |
           year < quantile(year, 0.25) - 1.5 * IQR(year)) %>%
  filter(is_outlier) %>%
  ungroup()

length_outliers <- imdb_data %>%
  mutate(is_outlier = length > quantile(length, 0.75) + 1.5 * IQR(length) |
           length < quantile(length, 0.25) - 1.5 * IQR(length)) %>%
  filter(is_outlier) %>%
  ungroup()

budget_outliers <- imdb_data %>%
  mutate(is_outlier = budget > quantile(budget, 0.75) + 1.5 * IQR(budget) |
           budget < quantile(budget, 0.25) - 1.5 * IQR(budget)) %>%
  filter(is_outlier) %>%
  ungroup()

votes_outliers <- imdb_data %>%
  mutate(is_outlier = votes > quantile(votes, 0.75) + 1.5 * IQR(votes) |
           votes < quantile(votes, 0.25) - 1.5 * IQR(votes)) %>%
  filter(is_outlier) %>%
  ungroup()

rating_outliers <- imdb_data %>%
  mutate(is_outlier = rating > quantile(rating, 0.75) + 1.5 * IQR(rating) |
           rating < quantile(rating, 0.25) - 1.5 * IQR(rating)) %>%
  filter(is_outlier) %>%
  ungroup() #NO OUTLIER

#Fit the GLM#
glm_model <- glm(high_rating ~ year + length + budget + votes + genre, 
                 data = imdb_data, family = binomial(link="logit"))
summary(glm_model)

# Likelihhod Ratio Test (LRT) #

glm_model_lrt <- step(glm_model, test="LRT")
summary(glm_model_lrt)
# high_rating ~ year + length + budget + genre

glm_model_lrt$deviance # 1028.692
AIC(glm_model_lrt)     # 1048.692
BIC(glm_model_lrt)     # 1104.381

#Backwards selection#
glm_model_back <- step(glm_model)
summary(glm_model_back)
# high_rating ~ year + length + budget + genre

glm_model_back$deviance # 1028.692
AIC(glm_model_back)     # 1048.692
BIC(glm_model_back)     # 1104.381

#Forward Selection#
glm_model_forward <- step(glm_model, direction = "forward")
summary(glm_model_forward)
# high_rating ~ year + length + budget + votes + genre

glm_model_forward$deviance # 1027.335
AIC(glm_model_forward)     # 1049.335
BIC(glm_model_forward)     # 1110.593

#Stepwise Selection#
glm_model_stepwise <- step(glm_model, direction = "both")
summary(glm_model_stepwise) 
# high_rating ~ year + length + budget + genre

glm_model_stepwise$deviance # 1028.692
AIC(glm_model_stepwise)     # 1048.692
BIC(glm_model_stepwise)     # 1104.381




genre_dist <- imdb_data %>%
  group_by(genre) %>%
  summarise(genre_count=n())

genre_dist

ggplot(data = imdb_data, aes(x = factor(genre), y=year, color=genre)) +
  geom_boxplot()

ggplot(data = imdb_data, aes(x = factor(genre), y=budget, color=genre)) +
  geom_boxplot()

ggplot(data = imdb_data, aes(x = factor(genre), y=log(votes), color=genre)) +
  geom_boxplot()

#Interaction models#

int_model <- glm(high_rating ~ year*genre + length + budget, 
                 data = imdb_data, family = binomial(link="logit"))
summary(int_model)


#Scale the data#

library(dplyr)

# Scale numerical variables
imdb_data_scaled <- imdb_data %>%
  mutate_at(vars(year, length, budget, votes), scale)

# Check the scaled dataset
head(imdb_data_scaled)

glm2 <- glm(high_rating ~ year + length + budget + votes + genre, 
            data = imdb_data_scaled, family = binomial(link="logit"))
summary(glm2)

step(glm2, test="LRT") # high_rating ~ year + length + budget + genre

glm3 <- glm(high_rating ~ length + budget + votes + genre, 
            data = imdb_data_scaled, family = binomial(link="logit"))
summary(glm3)

step(glm3, test="LRT") #high_rating ~ length + budget + genre

glm4 <- glm(high_rating ~ length*genre + budget, 
            data = imdb_data_scaled, family = binomial(link="logit"))
summary(glm4)

step(glm4, test="LRT")
