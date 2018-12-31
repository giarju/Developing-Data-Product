#User Interface Program for plotting data

#load the library
library(shiny)
library(plotly)

# Define UI for dataset 
shinyUI(pageWithSidebar(
    
    #Title
    headerPanel("Dataset Summary and Plot"),
    sidebarPanel(
        
        #selection of dataset to load
        selectInput("dataset", "Choose a dataset:", 
                    choices = c("women", "airquality", "mtcars","ChickWeight","CO2", "swiss")),
        
        #input name of variable to plot
        h4("Variable to Plot"),
        textInput("x", NULL,placeholder = "Type the x variable name"),    #input x variable
        verbatimTextOutput("xtrue"),
        textInput("y", NULL,placeholder = "Type the y variable name"),    #input y variable
        verbatimTextOutput("ytrue"),
        
        #use update button to update the panel
        submitButton("Update View")
    ),
    mainPanel(
        
        #show summary
        h4("Summary of data"),
        verbatimTextOutput("summary"),
        
        #show the data table
        h4("Table"),
        tableOutput("view"),
        
        #show the data plot for chosen x and y variable
        h4("Data Plot"),
        plotOutput("data")
    )
))