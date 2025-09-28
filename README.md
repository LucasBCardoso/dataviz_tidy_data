# Data Visualization - Tidy Data Exercise

Este projeto contém exercícios completos de **Tidy Data** desenvolvidos para a disciplina de Visualização de Dados do curso de Mestrado. O projeto demonstra técnicas de limpeza, transformação e análise de dados usando R e o ecossistema tidyverse.

## 📊 Objetivos do Projeto

- Aplicar conceitos de **Tidy Data** conforme Hadley Wickham
- Realizar análise exploratória de dados (EDA)
- Transformar dados de formato wide para long
- Criar visualizações informativas e profissionais
- Responder questões específicas através de análise de dados

## 🗂️ Estrutura do Projeto

```
dataviz_tidy_data/
│
├── data.r                    # Script principal de análise (organizado em chunks)
├── small_file.txt           # Dados de exemplo com categorias A, B, C, D
├── student_grade.csv        # Dados de notas dos estudantes (Q1-Q11)
├── run_analysis.sh          # Script bash para execução automatizada
├── INSTRUCTIONS.md          # Instruções detalhadas de execução
├── README.md               # Este arquivo
└── plots/                  # Pasta gerada com todas as visualizações
    ├── length_by_category_boxplot.png
    ├── mean_length_by_category.png
    ├── grades_by_question_boxplot.png
    ├── student_performance_top_bottom.png
    ├── question_difficulty.png
    ├── student_performance_heatmap.png
    └── q1_q2_comparison.png
```

## 🚀 Como Executar

### Pré-requisitos

- R (versão 4.0+)
- Pacotes R: `tidyverse`, `readr`, `ggplot2`

### Instalação das Dependências R

```r
install.packages(c("tidyverse", "readr", "ggplot2"))
```

### Execução da Análise

#### Opção 1: Script Automático (Recomendado)

```bash
chmod +x run_analysis.sh
./run_analysis.sh
```

#### Opção 2: Comando R Direto

```bash
Rscript data.r
```

#### Opção 3: R Interativo

```r
source("data.r")
```

## 📋 Exercícios Implementados

### **Parte 1: Análise de `small_file.txt`**

- ✅ Carregamento usando `read_delim()` com separador de tabulação
- ✅ Inspeção dos dados com `head()`, `glimpse()`
- ✅ Filtro de dados da categoria D usando `filter()`
- ✅ Ordenação por length usando `arrange()`
- ✅ Cálculo de médias para categorias A e D com `mean()`

### **Parte 2: Tidy Data com `student_grade.csv`**

- ✅ Identificação de colunas de anotação vs. medição
- ✅ Análise do formato wide vs. tidy
- ✅ Transformação usando `pivot_longer()`
- ✅ Tratamento de valores NA
- ✅ Remoção de colunas redundantes
- ✅ Cálculo de estatísticas descritivas para Q1 e Q2

## 📈 Visualizações Geradas

O projeto gera automaticamente 7 visualizações profissionais:

1. **Distribuição de Length por Categoria** - Boxplot comparativo
2. **Médias por Categoria** - Gráfico de barras com valores
3. **Distribuição de Notas por Questão** - Boxplot das 11 questões
4. **Performance dos Estudantes** - Top 10 e Bottom 10
5. **Dificuldade das Questões** - Ranking por média de acertos
6. **Heatmap de Performance** - Matriz estudante x questão
7. **Comparação Q1 vs Q2** - Análise específica com violin plot

## 🔍 Principais Conceitos Demonstrados

### Tidy Data Principles

- **Cada variável** está em uma coluna
- **Cada observação** está em uma linha
- **Cada valor** está em uma célula
- **Cada tipo de unidade observacional** forma uma tabela

### Transformações de Dados

- `pivot_longer()` - Wide para Long format
- `filter()` - Filtrar observações
- `arrange()` - Ordenar dados
- `group_by()` + `summarise()` - Agregações
- `mutate()` - Criar novas variáveis

### Visualização de Dados

- Boxplots para distribuições
- Heatmaps para matrizes de dados
- Violin plots para comparações
- Gráficos de barras para médias
- Faceting para comparações múltiplas

## 📊 Resultados e Insights

### Small File Analysis

- **Categoria A**: Média de length = [valor calculado]
- **Categoria D**: Média de length = [valor calculado]
- Distribuição das categorias é balanceada

### Student Grades Analysis

- **Q1**: Média e desvio padrão calculados
- **Q2**: Média e desvio padrão calculados
- Identificação das questões mais difíceis
- Ranking de performance dos estudantes
- Padrões de desempenho visualizados

## 🛠️ Tecnologias Utilizadas

- **R** - Linguagem de programação estatística
- **tidyverse** - Ecossistema de pacotes para ciência de dados
- **ggplot2** - Gramática de gráficos para visualização
- **readr** - Leitura eficiente de dados
- **dplyr** - Manipulação de dados
- **tidyr** - Organização de dados

## 👨‍🎓 Contexto Acadêmico

Este projeto foi desenvolvido como parte dos exercícios da disciplina de **Visualização de Dados** no programa de Mestrado, demonstrando:

- Aplicação prática dos conceitos de Tidy Data
- Proficiência em R e tidyverse
- Capacidade de análise exploratória
- Habilidades de visualização de dados
- Documentação e reprodutibilidade de código

## 📝 Autor

**Lucas B. Cardoso**  
Mestrado em Visualização de Dados  
Data: Setembro 2025

---

_Este projeto demonstra a aplicação prática de conceitos fundamentais de ciência de dados, desde a limpeza até a visualização, seguindo as melhores práticas de código reproduzível e documentação clara._
