# TEST SHINY APP

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Palmer Penguins Scatterplot"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            # checkbox to determine whether different species should be colored
            checkboxInput(inputId = "color",
                          label = "Color Species",
                          value = FALSE),
            
            p("Should different species be colored?")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("scatterPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$scatterPlot <- renderPlot({
        # import necessary packages
        library(tidyverse)
        library(palmerpenguins)
        
        # Generate a scatterplot of bill length vs bill depth
        p1 <- penguins %>% 
          ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
          theme_bw(base_size = 16) +
          ggtitle("Bill Lengths vs Depts (in mm)")
        
        if(input$color){
          p1 + geom_point(aes(col = species))
        } else {
          p1 + geom_point()
        }
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
