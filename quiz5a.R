#install packages needed
install.packages('tidyverse')
install.packages('ggplot2')
library(tidyverse)
library(ggplot2)

# Generate independent data for all five people
matt_pages <- sample(2:15, 100, replace = TRUE)
ash_pages <- sample(10:60, 100, replace = TRUE)
jacki_pages <- sample(1:20, 100, replace = TRUE)
rol_pages <- sample(2:50, 100, replace = TRUE)
mike_pages <- sample(10:100, 100, replace = TRUE)

#Construct a data frame with all the data generated.
readpage <- data.frame(
  Matt = matt_pages,
  Ash = ash_pages,
  Jacki = jacki_pages,
  Rol = rol_pages,
  Mike = mike_pages
)

#Test if there are five variables (5 people)
readpage |> length() == 5
#It is impossible to have a negative page read, test if all actual height are greater than 0.
readpage |> min() >= 0
#Test if all data are integer for Matt
readpage$Matt |> class() == "integer"
#There should not be a extreme large value, since a book cannot contain that much pages.
readpage |> max() < 10000
#Test if data for Matt and Ash are correlated or not
result <- cor.test(readpage$Matt, readpage$Ash)
result$p.value < 0.05

#Construct the line graph
ggplot() +
  geom_line(data = readpage, aes(x = seq_along(Matt), y = Matt, color = "Matt")) +
  geom_line(data = readpage, aes(x = seq_along(Ash), y = Ash, color = "Ash")) +
  geom_line(data = readpage, aes(x = seq_along(Jacki), y = Jacki, color = "Jacki")) +
  geom_line(data = readpage, aes(x = seq_along(Rol), y = Rol, color = "Rol")) +
  geom_line(data = readpage, aes(x = seq_along(Mike), y = Mike, color = "Mike")) +
  labs(title = "Number of Pages Read by Each Student Over 100 Days",
       x = "Day",
       y = "Pages Read") +
  scale_color_manual(values = c("red", "blue", "green", "purple", "orange")) +
  theme_minimal()
