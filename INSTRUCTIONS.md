# Análise de Dados - Tidying Data

Este projeto contém a análise completa dos exercícios de tidying data conforme solicitado.

## Estrutura do Projeto

- `data.r` - Script principal com toda a análise dividida em chunks
- `small_file.txt` - Dados de exemplo com categorias e lengths
- `student_grade.csv` - Dados de notas dos estudantes
- `run_analysis.sh` - Script para executar toda a análise
- `plots/` - Pasta que será criada com todas as visualizações

## Como Executar

### Opção 1: Script Automático (Recomendado)

```bash
./run_analysis.sh
```

### Opção 2: Comando R Direto

```bash
Rscript data.r
```

### Opção 3: Executar no R Interativo

```r
source("data.r")
```

## Chunks do Código

O código está organizado nos seguintes chunks:

### Parte 1: small_file.txt

- **setup**: Carregamento de bibliotecas
- **parte1-load-data**: Carregamento do arquivo small_file.txt
- **parte1-inspect-data**: Inspeção dos dados (head, glimpse)
- **parte1-filters-analysis**: Filtros por categoria D e cálculo de médias
- **parte1-visualizations**: Criação de gráficos

### Parte 2: student_grade.csv

- **parte2-load-data**: Carregamento do arquivo student_grade.csv
- **parte2-inspect-data**: Inspeção da estrutura dos dados
- **parte2-data-questions**: Respostas às questões sobre formato tidy
- **parte2-tidying**: Transformação dos dados para formato tidy
- **parte2-statistics**: Cálculo de estatísticas das questões 1 e 2
- **parte2-additional-stats**: Estatísticas adicionais e rankings
- **parte2-visualizations**: Criação de todas as visualizações

## Visualizações Geradas

1. **length_by_category_boxplot.png** - Distribuição de Length por Categoria (small_file.txt)
2. **mean_length_by_category.png** - Média de Length por Categoria
3. **grades_by_question_boxplot.png** - Distribuição das notas por questão
4. **student_performance_top_bottom.png** - Top 10 e Bottom 10 estudantes
5. **question_difficulty.png** - Dificuldade das questões (por média)
6. **student_performance_heatmap.png** - Heatmap de performance completo
7. **q1_q2_comparison.png** - Comparação específica entre Q1 e Q2

## Respostas às Questões Específicas

### small_file.txt:

- ✅ Carregamento com `read_delim()`
- ✅ Inspeção com `head()`, `glimpse()`
- ✅ Filtro categoria D
- ✅ Categoria D ordenada por length
- ✅ Média do length para categorias D e A

### student_grade.csv:

- ✅ Identificação de anotações vs medições
- ✅ Análise do formato wide vs tidy
- ✅ Transformação para formato tidy com `pivot_longer()`
- ✅ Remoção de valores NA
- ✅ Identificação de colunas repetidas
- ✅ Cálculo de média e desvio padrão para Q1 e Q2

## Dependências R

- tidyverse
- readr
- ggplot2

Instale as dependências se necessário:

```r
install.packages(c("tidyverse", "readr", "ggplot2"))
```
