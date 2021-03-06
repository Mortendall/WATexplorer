


#' correlation_visualizer
#'
#' @param id id for app
#' @param clinical clinical data
#'
#' @return
#' @export

   correlation_visualizer_ui <- function(id, clinical){
    ns <- shiny::NS(id)
    clincal_data <- clinical
    headers <- clinical %>%
      dplyr::select(-c(Sample.ID, Gender))

    sidebarLayout(
      sidebarPanel(
        textInput(ns("gene"),
                    label = "Enter a gene symbol",
                    value = "NAMPT"),
        selectInput(ns("category"),
                    label = "Choose a correlation factor",
                    choices = colnames(headers))),
      mainPanel(
        plotOutput(outputId = ns("correlation"))
      ))
  }



#' Title
#'
#' @param id session ID
#' @param cpm_values cpm_table with symbols
#' @param clinical matrix with clinical data
#'
#' @return
#' @export
#'

correlation_visualizer <- function(id, cpm_values, clinical){
  moduleServer(
    id,
    function(input, output, session){

      output$correlation <- renderPlot({
        clincal_data <- clinical
                cpm_long <- cpm_values
                clinical_data <- clinical
                cpm_long <- cpm_long %>%
                  dplyr::select(-rn)
                cpm_long <- cpm_long %>%
                  tidyr::pivot_longer(cols = -SYMBOL,
                                      names_to = "sample",
                                      values_to = "CPM")



                correlation_table <- left_join(cpm_long, clinical_data, by = c("sample"="Sample.ID"))

                ggplot(subset(correlation_table, SYMBOL == input$gene), aes_string(x = input$category, y = "CPM"))+
                  geom_point()+
                  geom_smooth(method = lm, se = F)


      })
    }
    )}
