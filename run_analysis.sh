#!/bin/bash

# Script para executar a análise completa de dados
# Este script executa o arquivo data.r e gera todas as visualizações

echo "=========================================="
echo "EXECUTANDO ANÁLISE DE DADOS TIDYING"
echo "=========================================="

# Verificar se R está instalado
if ! command -v R &> /dev/null; then
    echo "ERRO: R não está instalado. Por favor, instale R primeiro."
    exit 1
fi

# Verificar se os arquivos de dados existem
if [ ! -f "small_file.txt" ]; then
    echo "ERRO: Arquivo small_file.txt não encontrado."
    exit 1
fi

if [ ! -f "student_grade.csv" ]; then
    echo "ERRO: Arquivo student_grade.csv não encontrado."
    exit 1
fi

# Executar o script R
echo "Executando análise em R..."
echo "Aguarde, as visualizações estão sendo geradas..."

Rscript data.r

# Verificar se a execução foi bem-sucedida
if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "ANÁLISE CONCLUÍDA COM SUCESSO!"
    echo "=========================================="
    echo ""
    echo "Arquivos gerados:"
    echo "- Pasta 'plots/' com todas as visualizações"
    echo ""
    echo "Visualizações criadas:"
    if [ -d "plots" ]; then
        ls -la plots/
    fi
else
    echo ""
    echo "ERRO: Falha na execução do script R."
    echo "Verifique as mensagens de erro acima."
    exit 1
fi