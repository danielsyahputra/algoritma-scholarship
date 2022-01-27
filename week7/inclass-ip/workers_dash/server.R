function(input, output) { 
  
  output$plot1 <- renderPlotly({
    # Data untuk case 1
    year_data <- input$year_data
    case1 <- workers_clean %>% 
      mutate(gap_earning = total_earnings_male - total_earnings_female) %>% 
      filter(year == year_data) %>% 
      group_by(major_category) %>% 
      summarise(mean_gap_earning = mean(gap_earning)) %>% 
      ungroup()
    
    # Visualisasi plot 1
    plot_case1 <- case1 %>% 
      ggplot(aes(x = mean_gap_earning, 
                 y = reorder(major_category, mean_gap_earning),
                 text = glue("Mean Gap Earning {year_data}: {round(mean_gap_earning, 2)}")))+
      geom_col(aes(fill = mean_gap_earning), show.legend = F) + 
      scale_fill_gradient(low="#fff2cd", high="firebrick") + 
      labs(title = glue("Mean Gap Earning: {year_data}"), 
           subtitle = "Pegawai Laki-laki dan Perempuan Tahun 2016",
           x = "Mean Gap Earning", 
           y = "Divisi") +
      theme_clean()
    
    # Visualisasi interaktif
    ggplotly(plot_case1, tooltip = "text")
  })
  
  output$plot2 <- renderPlotly({
    case2 <- workers_clean %>% 
      filter(workers_female > workers_male) %>% 
      group_by(major_category) %>% 
      summarise(n_position = n()) %>% 
      arrange(desc(n_position))
    
    plot_case2 <- case2 %>% 
      ggplot(aes(x = n_position,
                 y = reorder(major_category, n_position),
                 text = glue("Jumlah Posisi Divisi: {n_position}"))) +
      geom_segment(aes(x = 0, xend=n_position, yend= major_category), color="grey") +
      geom_point(color="firebrick", size=2.5, alpha=0.6) +
      theme(
        panel.grid.major.y = element_blank(),
        panel.border = element_blank(),
        axis.ticks.y = element_blank()
      ) + 
      labs(title = "Jumlah Divisi", 
           subtitle = "Pegawai Perempuan",
           x = "Jumlah Posisi Divisi", 
           y = "Divisi") +
      theme_clean()
    
    ggplotly(plot_case2, tooltip = "text")
  })
  
  output$plot3 <- renderPlotly({
    
    year_data <- input$year_btn
    
    case3 <- workers_clean %>% 
      filter(year == year_data) %>% 
      pivot_longer(cols = c("total_earnings_male", "total_earnings_female"), 
                   names_to = "gender", 
                   values_to = "total_earnings_male_female",
                   names_prefix = "total_earnings_") %>% 
      select(gender, total_earnings_male_female)
    
    options(scipen = 99)
    plot_case3 <- case3 %>% 
      ggplot(aes(x = total_earnings_male_female)) + 
      geom_density(aes(fill=gender, position = "identity", alpha = 0.8)) + 
      theme_clean() +
      labs(
        title = glue("Sebaran Pendapatan Berdasarkan Gender ({year_data})"), x = NULL, y = NULL
      ) + 
      scale_fill_brewer(palette = "Set2")
    
    ggplotly(plot_case3, tooltip = "x")
  })
  
  output$table <- renderDataTable({
    datatable(workers_clean, options = list(scrollX=T, scrollY = 400))
  })
}