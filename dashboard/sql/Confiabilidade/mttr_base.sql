WITH  base AS (
SELECT
NomePlanta,
Ano,
SUM(TempoExecucaoHoras) AS soma_tempo_reparo,
COUNT(*) AS total_reparos
FROM Maintenance.vw_manutencao_base
WHERE TipoServico = 'Corretiva'
AND DataConclusao IS NOT NULL
GROUP BY NomePlanta, Ano
)

SELECT
*,
DATE(Ano, 1,1) AS DataAno,
LAG(soma_tempo_reparo) OVER (PARTITION BY NomePlanta ORDER BY Ano) AS soma_tempo_reparo_ant,
LAG(total_reparos) OVER (PARTITION BY NomePlanta ORDER BY Ano) AS total_reparos_ant
FROM base