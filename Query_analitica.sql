
-- Aqui se encontra algumas consultas e resultados .(o postegres utilizdo foi todo feito pelo terminal
--por isso esta nesse estilo esse é o nome do banco que estacom duas tabelas operadoras_ativas ) 

-- Isso irá procurar por qualquer ocorrência com "EVENTOS" independentemente de maiúsculas/minúsculas

operadoras_ativas=# SELECT descricao, COUNT(*)
FROM dados_financeiros
GROUP BY descricao
HAVING descricao ILIKE '%EVENTOS%' 
LIMIT 20;
                                         descricao                                          | count 
--------------------------------------------------------------------------------------------+-------
 Apuração de Custos com Eventos por Meio Próprio                                            |  1110
 APURAÇÃO DE CUSTOS COM EVENTOS POR MEIO PRÓPRIO                                            |   740
 Depósitos Judiciais - Eventos / Sinistros                                                  |   342
 Despesas com Eventos / Sinistros                                                           | 52733
 Despesas com Eventos / Sinistros                                                           |   615
 Despesas com Eventos/Sinistros - Judicial                                                  | 15365
 Despesas com Eventos / Sinistros na modalidade de pagamento por procedimento               |  6163
 Despesas com Eventos/Sinistros não cobertos                                                |   657
 Despesas Judiciais de Eventos/Sinistros Médico-Hospitalares                                |   835
 Despesas Judiciais de Eventos/Sinistros Odontológicos                                      |   174
 EVENTOS INDENIZÁVEIS LÍQUIDOS / SINISTROS RETIDOS                                          |  1596
 Eventos/Sinistros a Liquidar para Outros Prestadores - Ação Judicial com Depósito Judicial |   656
 EVENTOS/SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA À SAÚDE                            |  1592
 EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR        |  6231
 EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS EM OUTRAS FORMAS DE PAGAMENTO                    |   256
 EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  NA MODALIDADE DE PAGAMENTO POR CAPITATION       |   317
 EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  NA MODALIDADE DE PAGAMENTO POR ORÇAMENTO GLOBAL |   217
 EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  NA MODALIDADE DE PAGAMENTO POR PACOTE           |   574
 EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS NA MODALIDADE DE PAGAMENTO POR PROCEDIMENTO      |  1579
 EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS NO SISTEMA ÚNICO DE SAÚDE - SUS                  |  1229
(20 linhas)
-----
operadoras_ativas=# SELECT DISTINCT EXTRACT(YEAR FROM data) AS ano, EXTRACT(QUARTER FROM data) AS trimestre
FROM dados_financeiros
ORDER BY ano DESC, trimestre DESC;
 ano  | trimestre 
------+-----------
 2024 |         4
 2024 |         3
(2 linhas)

--------
-- ou outra descrição que você queira testar
operadoras_ativas=# SELECT
  reg_ans AS registro_ans,
  SUM(vl_saldo_final) AS total_despesas
FROM dados_financeiros
WHERE descricao = 'Outras Despesas' 
AND EXTRACT(YEAR FROM data) = 2024
GROUP BY reg_ans
ORDER BY total_despesas DESC
LIMIT 10;
 registro_ans | total_despesas 
--------------+----------------
 005711       |  1283799838.54
 326305       |   999199645.28
 343889       |   787706209.37
 368253       |   637154231.06
 006246       |   582378671.57
 302147       |   493350977.03
 417173       |   454200770.71
 339679       |   444886345.63
 357391       |   419375136.70
 346659       |   407646280.46
(10 linhas)
-----
 "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS EM OUTRAS FORMAS DE PAGAMENTO":

operadoras_ativas=# WITH ultimo_trimestre AS (
  SELECT
    2024 AS ano,
    4 AS trimestre
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
 registro_ans | total_despesas 
--------------+----------------
 326305       |   821195810.08
 006246       |   232690215.36
 303976       |   186833139.71
 343889       |   153718898.43
 355097       |    56452295.21
 000701       |    53575159.35
 005711       |    50860934.90
 315729       |    48007042.97
 355151       |    44650527.93
 335100       |    36897219.13
(10 linhas)
