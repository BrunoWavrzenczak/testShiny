library(shiny)

ui <- fluidPage(
  titlePanel('gerador de numeros aleatorios'),
  sidebarLayout(
    sidebarPanel(
      selectInput('dist','selecione a distribuiçao',
                  choices = c('normal','uniforme','exponencial')),
      numericInput('amostra','defina o n',min = 10,max = 10000,value = 1000),
      textInput('title','defina o titulo do histograma'),
      sliderInput('num','quantos numeros para exibir?',
                  min = 10,max = 1000,value = 100)
      
    ),
    mainPanel(
      plotOutput('hist'),
      verbatimTextOutput('tim')
    )
  )
  
)

server <- function(input,output){
  x <- reactive(switch(input$dist,
                       'normal' = rnorm(input$amostra),
                       'uniforme' = runif(input$amostra),
                       'exponencial' = rexp(input$amostra)))
  output$hist <- renderPlot(hist(x(), main = input$title))
  output$tim <- renderPrint(head(x(),input$num))
}

shinyApp(ui,server)
