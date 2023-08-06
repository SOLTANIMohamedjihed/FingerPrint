library(shiny)
library(fingerprint)

# Définition de l'interface utilisateur
ui <- fluidPage(
  titlePanel("Comparateur d'empreintes digitales"),
  sidebarLayout(
    sidebarPanel(
      fileInput("fingerprint_file1", "Choisir la première empreinte digitale", accept = c(".png")),
      fileInput("fingerprint_file2", "Choisir la deuxième empreinte digitale", accept = c(".png")),
      actionButton("submit", "Comparer")
    ),
    mainPanel(
      textOutput("comparison_result")
    )
  )
)

# Définition du serveur
server <- function(input, output) {

  # Comparaison des deux empreintes digitales
  output$comparison_result <- renderText({
    req(input$fingerprint_file1, input$fingerprint_file2)

    fingerprint1 <- read.image(input$fingerprint_file1$datapath)
    fingerprint2 <- read.image(input$fingerprint_file2$datapath)

    score <- fingerprint.compare(fingerprint1, fingerprint2)

    if (score >= 0.6) {
      "Les empreintes digitales sont similaires."
    } else {
      "Les empreintes digitales sont différentes."
    }
  })
}

# Exécution de l'application Shiny
shinyApp(ui = ui, server = server)