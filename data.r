# =============================================================================
# EXERCÍCIO DE ANÁLISE DE DADOS - TIDYING DATA
# =============================================================================
# Responde às questões sobre small_file.txt e student_grade.csv

# ---- setup ----
# Carregamento das bibliotecas necessárias
library(tidyverse)
library(readr)
library(ggplot2)

# Criar diretório para salvar as imagens
if (!dir.exists("plots")) {
  dir.create("plots")
}

cat("=============================================================================\n")
cat("EXERCÍCIO DE ANÁLISE DE DADOS - TIDYING DATA\n")
cat("=============================================================================\n\n")

# ---- parte1-load-data ----
# =============================================================================
# PARTE 1: ANÁLISE DO ARQUIVO small_file.txt
# =============================================================================

cat("PARTE 1: ANÁLISE DO ARQUIVO small_file.txt\n")
cat("------------------------------------------\n\n")

# Carregando o arquivo tab delimited usando read_delim
my.data <- read_delim("small_file.txt", delim = "\t")

cat("1. Dados carregados com sucesso!\n\n")

# ---- parte1-inspect-data ----
# Inspecionando os dados
cat("2. INSPEÇÃO DOS DADOS:\n\n")

cat("head():\n")
print(head(my.data))

cat("\nglimpse():\n")
glimpse(my.data)

# Nota: view() abre uma janela interativa, então comentamos para não causar problemas no script
# cat("\nview() - abre janela interativa (comentado no script)\n")
# view(my.data)

# ---- parte1-filters-analysis ----
cat("\n3. FILTROS E ANÁLISES:\n\n")

# Mostrando apenas as linhas da categoria D
cat("Linhas da categoria D:\n")
category_d <- my.data %>% 
  filter(Category == "D")
print(category_d)

cat("\nLinhas da categoria D ordenadas por Length:\n")
category_d_ordered <- my.data %>% 
  filter(Category == "D") %>% 
  arrange(Length)
print(category_d_ordered)

# Calculando a média do Length para categoria D
mean_length_d <- my.data %>% 
  filter(Category == "D") %>% 
  pull(Length) %>% 
  mean()

cat("\nMédia do Length para categoria D:", mean_length_d, "\n")

# Calculando a média do Length para categoria A
mean_length_a <- my.data %>% 
  filter(Category == "A") %>% 
  pull(Length) %>% 
  mean()

cat("Média do Length para categoria A:", mean_length_a, "\n\n")

# ---- parte1-visualizations ----
# Criar visualizações para small_file.txt
cat("4. VISUALIZAÇÕES:\n\n")

# Gráfico 1: Distribuição de Length por Categoria
p1 <- ggplot(my.data, aes(x = Category, y = Length, fill = Category)) +
  geom_boxplot(alpha = 0.7) +
  geom_jitter(width = 0.2, alpha = 0.6) +
  labs(title = "Distribuição de Length por Categoria",
       subtitle = "small_file.txt",
       x = "Categoria",
       y = "Length") +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("plots/length_by_category_boxplot.png", p1, width = 8, height = 6, dpi = 300)
cat("Gráfico salvo: plots/length_by_category_boxplot.png\n")

# Gráfico 2: Comparação das médias
means_data <- my.data %>%
  group_by(Category) %>%
  summarise(mean_length = mean(Length), .groups = "drop")

p2 <- ggplot(means_data, aes(x = Category, y = mean_length, fill = Category)) +
  geom_col(alpha = 0.8) +
  geom_text(aes(label = round(mean_length, 1)), vjust = -0.5) +
  labs(title = "Média de Length por Categoria",
       subtitle = "small_file.txt",
       x = "Categoria",
       y = "Média do Length") +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("plots/mean_length_by_category.png", p2, width = 8, height = 6, dpi = 300)
cat("Gráfico salvo: plots/mean_length_by_category.png\n\n")

# ---- parte2-load-data ----
# =============================================================================
# PARTE 2: ANÁLISE E TIDYING DO ARQUIVO student_grade.csv
# =============================================================================

cat("PARTE 2: ANÁLISE DO ARQUIVO student_grade.csv\n")
cat("---------------------------------------------\n\n")

# Carregando os dados de notas dos estudantes
student_data <- read_csv("student_grade.csv")

# ---- parte2-inspect-data ----
cat("1. DADOS ORIGINAIS (primeiras linhas):\n")
print(head(student_data))

cat("\n2. ANÁLISE DA ESTRUTURA DOS DADOS:\n\n")

cat("Dimensões dos dados:", dim(student_data), "\n")
cat("Colunas:", colnames(student_data), "\n\n")

# ---- parte2-data-questions ----
# Respondendo às questões sobre o formato dos dados:
cat("3. QUESTÕES SOBRE O FORMATO DOS DADOS:\n\n")

cat("• Quais colunas são anotações e quais são medições?\n")
cat("  - Anotações: Year, Class, Student (identificadores)\n")
cat("  - Medições: Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11 (notas das questões)\n\n")

cat("• Quantos tipos diferentes de medição existem?\n")
cat("  - 1 tipo: Notas/pontuações das questões (todas são do mesmo tipo)\n\n")

cat("• Todas as medições do mesmo tipo estão em uma única coluna?\n")
cat("  - NÃO. As notas estão espalhadas em 11 colunas (Q1 a Q11)\n\n")

cat("• Qual é o nome da variável sendo medida?\n")
cat("  - 'Grade' ou 'Nota' (pontuação obtida pelo estudante)\n\n")

cat("• O nome da variável está em uma coluna?\n")
cat("  - NÃO. Os nomes estão nos cabeçalhos das colunas (Q1, Q2, etc.)\n\n")

# ---- parte2-tidying ----
# Transformando os dados para formato tidy
cat("4. TRANSFORMANDO PARA FORMATO TIDY:\n\n")

student_tidy <- student_data %>%
  # Transformar de wide para long format
  pivot_longer(cols = Q1:Q11, 
               names_to = "Question", 
               values_to = "Grade") %>%
  # Remover linhas com valores NA
  filter(!is.na(Grade)) %>%
  # Remover colunas com informação repetida (se houver)
  # Year e Class são constantes, mas vamos mantê-las para contexto
  select(Year, Class, Student, Question, Grade)

cat("Dados em formato tidy (primeiras linhas):\n")
print(head(student_tidy, 10))

cat("\n5. VERIFICAÇÃO DE VALORES NA:\n\n")

# Contando NAs nos dados originais
na_count_original <- student_data %>%
  select(Q1:Q11) %>%
  summarise(across(everything(), ~sum(is.na(.)))) %>%
  rowwise() %>%
  summarise(total_nas = sum(c_across(everything())))

cat("Total de NAs nos dados originais:", na_count_original$total_nas, "\n")

# Verificando se há NAs nos dados tidy (após remoção)
na_count_tidy <- sum(is.na(student_tidy$Grade))
cat("Total de NAs nos dados tidy (após remoção):", na_count_tidy, "\n\n")

cat("6. COLUNAS COM INFORMAÇÃO REPETIDA:\n\n")
cat("- Year: Todos os registros são de 2022 (informação repetida)\n")
cat("- Class: Todos são 'Student' (informação repetida)\n")
cat("- Estas colunas poderiam ser removidas para análise, mas mantidas para contexto\n\n")

# ---- parte2-statistics ----
# Calculando média e desvio padrão das questões 1 e 2
cat("7. ESTATÍSTICAS DAS QUESTÕES 1 E 2:\n\n")

q1_q2_stats <- student_tidy %>%
  filter(Question %in% c("Q1", "Q2")) %>%
  group_by(Question) %>%
  summarise(
    mean_grade = mean(Grade, na.rm = TRUE),
    sd_grade = sd(Grade, na.rm = TRUE),
    n_students = n(),
    .groups = "drop"
  )

print(q1_q2_stats)

cat("\nRESUMO DAS ESTATÍSTICAS:\n")
cat("Q1 - Média:", round(q1_q2_stats$mean_grade[1], 2), 
    ", Desvio Padrão:", round(q1_q2_stats$sd_grade[1], 2), "\n")
cat("Q2 - Média:", round(q1_q2_stats$mean_grade[2], 2), 
    ", Desvio Padrão:", round(q1_q2_stats$sd_grade[2], 2), "\n\n")

# ---- parte2-additional-stats ----
# Estatísticas adicionais úteis
cat("8. ESTATÍSTICAS ADICIONAIS:\n\n")

# Performance geral por estudante
student_performance <- student_tidy %>%
  group_by(Student) %>%
  summarise(
    mean_grade = mean(Grade),
    n_questions = n(),
    .groups = "drop"
  ) %>%
  arrange(desc(mean_grade))

cat("Top 5 estudantes por média geral:\n")
print(head(student_performance, 5))

cat("\nBottom 5 estudantes por média geral:\n")
print(tail(student_performance, 5))

# Performance por questão
question_difficulty <- student_tidy %>%
  group_by(Question) %>%
  summarise(
    mean_grade = mean(Grade),
    sd_grade = sd(Grade),
    n_students = n(),
    .groups = "drop"
  ) %>%
  arrange(mean_grade)

cat("\nDificuldade das questões (ordenado da mais difícil para a mais fácil):\n")
print(question_difficulty)

# ---- parte2-visualizations ----
# Criar visualizações para student_grade.csv
cat("\n9. VISUALIZAÇÕES:\n\n")

# Gráfico 3: Distribuição das notas por questão
p3 <- ggplot(student_tidy, aes(x = Question, y = Grade, fill = Question)) +
  geom_boxplot(alpha = 0.7) +
  labs(title = "Distribuição das Notas por Questão",
       subtitle = "student_grade.csv - Dados Tidy",
       x = "Questão",
       y = "Nota") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none") +
  scale_y_continuous(limits = c(0, 10))

ggsave("plots/grades_by_question_boxplot.png", p3, width = 10, height = 6, dpi = 300)
cat("Gráfico salvo: plots/grades_by_question_boxplot.png\n")

# Gráfico 4: Performance média por estudante (top 10 e bottom 10)
top_bottom_students <- rbind(
  head(student_performance, 10) %>% mutate(group = "Top 10"),
  tail(student_performance, 10) %>% mutate(group = "Bottom 10")
)

p4 <- ggplot(top_bottom_students, aes(x = reorder(Student, mean_grade), y = mean_grade, fill = group)) +
  geom_col(alpha = 0.8) +
  coord_flip() +
  facet_wrap(~group, scales = "free_y") +
  labs(title = "Performance dos Estudantes",
       subtitle = "Top 10 e Bottom 10 estudantes por média geral",
       x = "Estudante",
       y = "Média Geral") +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("plots/student_performance_top_bottom.png", p4, width = 12, height = 8, dpi = 300)
cat("Gráfico salvo: plots/student_performance_top_bottom.png\n")

# Gráfico 5: Dificuldade das questões
p5 <- ggplot(question_difficulty, aes(x = reorder(Question, mean_grade), y = mean_grade)) +
  geom_col(fill = "steelblue", alpha = 0.8) +
  geom_text(aes(label = round(mean_grade, 2)), hjust = -0.1) +
  coord_flip() +
  labs(title = "Dificuldade das Questões",
       subtitle = "Média das notas por questão (ordenado da mais difícil para a mais fácil)",
       x = "Questão",
       y = "Média das Notas") +
  theme_minimal()

ggsave("plots/question_difficulty.png", p5, width = 10, height = 6, dpi = 300)
cat("Gráfico salvo: plots/question_difficulty.png\n")

# Gráfico 6: Heatmap de performance
# Criar matriz de notas por estudante e questão
grade_matrix <- student_tidy %>%
  select(Student, Question, Grade) %>%
  pivot_wider(names_from = Question, values_from = Grade) %>%
  column_to_rownames("Student") %>%
  as.matrix()

# Converter para formato long para ggplot
grade_heatmap_data <- student_tidy %>%
  arrange(Student, Question)

p6 <- ggplot(grade_heatmap_data, aes(x = Question, y = Student, fill = Grade)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "red", mid = "yellow", high = "green", 
                       midpoint = 5, name = "Nota") +
  labs(title = "Heatmap de Performance dos Estudantes",
       subtitle = "Notas por estudante e questão",
       x = "Questão",
       y = "Estudante") +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 6),
        axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("plots/student_performance_heatmap.png", p6, width = 12, height = 16, dpi = 300)
cat("Gráfico salvo: plots/student_performance_heatmap.png\n")

# Gráfico 7: Comparação Q1 vs Q2
q1_q2_data <- student_tidy %>%
  filter(Question %in% c("Q1", "Q2"))

p7 <- ggplot(q1_q2_data, aes(x = Question, y = Grade, fill = Question)) +
  geom_violin(alpha = 0.7) +
  geom_boxplot(width = 0.2, alpha = 0.9) +
  stat_summary(fun = mean, geom = "point", shape = 23, size = 3, fill = "white") +
  labs(title = "Comparação entre Q1 e Q2",
       subtitle = "Distribuição das notas com médias destacadas",
       x = "Questão",
       y = "Nota") +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("plots/q1_q2_comparison.png", p7, width = 8, height = 6, dpi = 300)
cat("Gráfico salvo: plots/q1_q2_comparison.png\n")

cat("\n=============================================================================\n")
cat("ANÁLISE COMPLETA FINALIZADA!\n")
cat("Todas as visualizações foram salvas na pasta 'plots/'\n")
cat("=============================================================================\n")
