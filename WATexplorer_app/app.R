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

clinical_data <- openxlsx::read.xlsx(here("data/collected_clinical_data_trimmed.xlsx"))

#####Shiny App calls#####

ui <- fluidPage(titlePanel("WAT Explorer"),
                tabsetPanel(type = "tabs",
                            tabPanel("TimeB_Comp_reactome", reactome_page_ui("reactome_1", reactomedata[[1]], edgeR_data[[1]])),
                            tabPanel("PR_comp_reactome", reactome_page_ui("reactome_2", reactomedata[[2]], edgeR_data[[2]])),
                            tabPanel("CR_Comp_reactome", reactome_page_ui("reactome_3", reactomedata[[3]], edgeR_data[[3]])),
                            tabPanel("PR_A_vs_CR_A_reactome", reactome_page_ui("reactome_4", reactomedata[[4]], edgeR_data[[4]])),
                            tabPanel("Interaction_reactome", reactome_page_ui("reactome_5", reactomedata[[5]], edgeR_data[[5]])),
                            tabPanel("TImeB_Comp_GO", GO_page_ui("GO_1", GO_data[[1]], edgeR_data[[1]])),
                            tabPanel("PR_Comp_GO", GO_page_ui("GO_2", GO_data[[2]], edgeR_data[[2]])),
                            tabPanel("CR_Comp_GO", GO_page_ui("GO_3", GO_data[[3]], edgeR_data[[3]])),
                            tabPanel("PR_A_vs_CR_A_GO", GO_page_ui("GO_4", GO_data[[4]], edgeR_data[[4]])),
                            tabPanel("Interaction_GO", GO_page_ui("GO_5", GO_data[[5]], edgeR_data[[5]])),
                            tabPanel("Gene Correlator", correlation_visualizer_ui("correlator", clinical_data)))
)
server <- function(input, output, session){
  reactome_page("reactome_1", reactomedata[[1]],  sample_info, cpm_data, edgeR_data[[1]])
  reactome_page("reactome_2", reactomedata[[2]],  sample_info, cpm_data, edgeR_data[[2]])
  reactome_page("reactome_3", reactomedata[[3]],  sample_info, cpm_data, edgeR_data[[3]])
  reactome_page("reactome_4", reactomedata[[4]], sample_info, cpm_data, edgeR_data[[4]])
  reactome_page("reactome_5", reactomedata[[5]], sample_info, cpm_data, edgeR_data[[5]])
  GO_page("GO_1", GO_data[[1]], sample_info, cpm_data, edgeR_data[[1]])
  GO_page("GO_2", GO_data[[2]], sample_info, cpm_data, edgeR_data[[2]])
  GO_page("GO_3", GO_data[[3]], sample_info, cpm_data, edgeR_data[[3]])
  GO_page("GO_4", GO_data[[4]], sample_info, cpm_data, edgeR_data[[4]])
  GO_page("GO_5", GO_data[[5]], sample_info, cpm_data, edgeR_data[[5]])
  correlation_visualizer("correlator", cpm_data, clinical_data)

  }

shinyApp(ui, server)

