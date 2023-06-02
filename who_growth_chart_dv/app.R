
library(shiny)
library(tidyverse)
library(here)
library(rio)
library(janitor)


# Define UI for application that draws a histogram
ui <- ui <- fluidPage(
    radioButtons(inputId = "plot_type" , label = "Select the plot", choices = c("scatter", "bar", "hist" )),
    plotOutput("myplot")
    
)