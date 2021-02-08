#####Load in required data####
#load in reactomedata
reactomedata <- list(TimeBComp = NA,
                     PR_effect = NA,
                     CR_effect = NA,
                     PR_A_vs_CR_A = NA,
                     Interaction = NA)
for (i in 1:5){
  reactomedata[[i]] <- openxlsx::read.xlsx(here("data/210201Reactome_data_annotated.xlsx"), sheet = i)
}


#load in cpm data
cpm_data <- openxlsx::read.xlsx(here("data/CPM_matrix.xlsx"))

#load in GO-data

GO_data <- list(TimeBComp = NA,
                PR_effect = NA,
                CR_effect = NA,
                PR_A_vs_CR_A = NA,
                Interaction = NA)

for (i in 1:5){
  GO_data[[i]] <- openxlsx::read.xlsx(here("data/210201GO_data_annotated.xlsx"), sheet = i)
}

#load in sample info
sample_info <- openxlsx::read.xlsx(here("data/sample_info.xlsx"))
#load in
edgeR_data <- list(TimeBComp = NA,
                     PR_effect = NA,
                     CR_effect = NA,
                     PR_A_vs_CR_A = NA,
                     Interaction = NA)
for (i in 1:5){
  edgeR_data[[i]] <- openxlsx::read.xlsx(here("data/edgeR_PR_CR_201812_sort.xlsx"), sheet = i)
}

#####Shiny App calls#####

ui <- fluidPage(titlePanel("WAT Explorer"),
                tabsetPanel(type = "tabs",
                            tabPanel("TimeB_Comp", reactome_page_ui("reactome", reactomedata, edgeR_data)),
                                     tabPanel("PR_comp")))

server <- function(input, output, session){
  reactome_page("reactome", reactomedata, sample_info, cpm_data, edgeR_data)
}

shinyApp(ui, server)

