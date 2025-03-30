#  Banco de Dados "operadoras_ativas"

## Sobre o Projeto
Este projeto consiste na criação e análise de um banco de dados PostgreSQL chamado `operadoras_ativas`, que contém informações sobre operadoras de planos de saúde e dados financeiros relacionados a eventos e sinistros. Todas as consultas e interações com o banco foram realizadas via terminal.

## Estrutura do Banco de Dados
O banco de dados contém duas tabelas principais:

### 1. `operadoras_ativas`
Esta tabela armazena informações sobre operadoras de planos de saúde registradas na ANS (Agência Nacional de Saúde Suplementar). Os principais campos incluem:
- `registro_ans`: Número de registro da operadora na ANS (Primary Key).
- `cnpj`: CNPJ da operadora.
- `razao_social`: Razão social da operadora.
- `nome_fantasia`: Nome fantasia da operadora.
- `modalidade`: Tipo de operadora.
- `cidade`, `uf`: Localização da operadora.
- `telefone`, `endereco_eletronico`: Contato da operadora.
- `data_registro_ans`: Data de registro na ANS.

### 2. `dados_financeiros`
Armazena informações financeiras das operadoras, incluindo despesas e eventos sinistros. Os principais campos incluem:
- `data`: Data do registro financeiro.
- `descricao`: Tipo de despesa ou evento sinistro.
- `vl_saldo_final`: Valor da despesa registrada.
- `reg_ans`: Chave estrangeira que referencia a operadora na tabela `operadoras_ativas`.

## Consultas e Resultados

### 1. Buscar registros relacionados a "EVENTOS"
Consulta que retorna a contagem de registros financeiros que contêm "EVENTOS" na descrição:
```sql
SELECT descricao, COUNT(*)
FROM dados_financeiros
GROUP BY descricao
HAVING descricao ILIKE '%EVENTOS%'
LIMIT 20;
```

### 2. Analisar períodos de dados disponíveis
Consulta que retorna os anos e trimestres presentes na tabela `dados_financeiros`:
```sql
SELECT DISTINCT EXTRACT(YEAR FROM data) AS ano, EXTRACT(QUARTER FROM data) AS trimestre
FROM dados_financeiros
ORDER BY ano DESC, trimestre DESC;
```

### 3. Maiores despesas em "Outras Despesas" no ano de 2024
Consulta que retorna as 10 operadoras com maior saldo final para a categoria "Outras Despesas":
```sql
SELECT
  reg_ans AS registro_ans,
  SUM(vl_saldo_final) AS total_despesas
FROM dados_financeiros
WHERE descricao = 'Outras Despesas'
AND EXTRACT(YEAR FROM data) = 2024
GROUP BY reg_ans
ORDER BY total_despesas DESC
LIMIT 10;
```

### 4. Analisar despesas de um tipo específico de evento
Consulta que retorna as 10 operadoras com maiores despesas no último trimestre de 2024 para "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS EM OUTRAS FORMAS DE PAGAMENTO":
```sql
WITH ultimo_trimestre AS (
  SELECT 2024 AS ano, 4 AS trimestre
)
SELECT
  reg_ans AS registro_ans,
  SUM(vl_saldo_final) AS total_despesas
FROM dados_financeiros
WHERE
  descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS EM OUTRAS FORMAS DE PAGAMENTO'
  AND EXTRACT(YEAR FROM data) = (SELECT ano FROM ultimo_trimestre)
  AND EXTRACT(QUARTER FROM data) = (SELECT trimestre FROM ultimo_trimestre)
GROUP BY reg_ans
ORDER BY total_despesas DESC
LIMIT 10;
```

## Conclusão
Este banco de dados permite a análise detalhada de eventos financeiros das operadoras de planos de saúde. As consultas SQL fornecem insights sobre despesas gerais e específicas, permitindo o monitoramento e auditoria dos dados financeiros registrados. Como melhorias futuras, pode-se considerar a criação de índices para otimizar buscas e agregar mais informações para cruzamento de dados.

