#Server logic program fro plotting data

#load library
library(shiny)
library(datasets)
library(plotly)

# Define server logic function
shinyServer(function(input, output){
    
    # select the chosen data set to load
    datasetInput <- reactive({
        switch(input$dataset,
               "women" = women, 
               "airquality" = airquality, 
               "mtcars" = mtcars,
               "ChickWeight" = ChickWeight,
               "CO2" = CO2,
               "swiss" = swiss)
    })
    
    #Show summary of the dataset
    output$summary <- renderPrint({
        used <- datasetInput()
        summary(used)
    })
    
    #Show the first 6 row of the dataset
    output$view <- renderTable({
        head(datasetInput())
    })
    
    #create a reactive table of the dataset
    dataset <- renderDataTable({
        datasetInput()
    })
    
    #check the validity of the selected x variable 
    output$xtrue <- renderText({
        if(!sum(input$x == names(datasetInput()))){
            "Variable don't exist!"
        }
    })
    
    #check the validity of the selected y variable
    output$ytrue <- renderText({
        if(!sum(input$y == names(datasetInput()))){
            "Variable don't exist!"
        }
    })
    
    #Create the plot
    output$data <- renderPlot({   
        plot(x = subset(datasetInput(), select = input$x, drop = T),
             y = subset(datasetInput(), select = input$y, drop = T),
             xlab = input$x, ylab = input$y)
    })
    
})