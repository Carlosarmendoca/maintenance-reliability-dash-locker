WITH pecas_por_os AS (
  SELECT
    MovimentoID,
    SUM(CustoTotalPecas) AS custo_pecas
  FROM Maintenance.vw_ospecas
  GROUP BY MovimentoID
),

custo_os AS (
  SELECT
    b.MovimentoID,
    b.AnoMes,
    b.CustoMaoObra,
    IFNULL(p.custo_pecas, 0) AS custo_pecas
  FROM Maintenance.vw_manutencao_base b
  LEFT JOIN pecas_por_os p
    ON p.MovimentoID = b.MovimentoID
),

custo_mensal AS (
  SELECT
    AnoMes,
    SUM(CustoMaoObra) AS CustoMaoObra,      -- agrega por mês
    SUM(custo_pecas)  AS custo_pecas,         -- agrega por mês
    SUM(CustoMaoObra + custo_pecas) AS custo_total
  FROM custo_os
  GROUP BY AnoMes                             -- só AnoMes no GROUP BY
)


SELECT
  AnoMes,
  PARSE_DATE('%Y-%m', AnoMes) AS data_referencia,
  CustoMaoObra,
  custo_pecas,
  custo_total,

  LAG(custo_total) OVER (ORDER BY AnoMes) AS custo_mes_anterior,

  SAFE_DIVIDE(
    custo_total - LAG(custo_total) OVER (ORDER BY AnoMes),
    LAG(custo_total) OVER (ORDER BY AnoMes)
  ) AS mom_crescimento,

  LAG(custo_total, 12) OVER (ORDER BY AnoMes) AS custo_ano_anterior,

  SAFE_DIVIDE(
    custo_total - LAG(custo_total,12) OVER (ORDER BY AnoMes),
    LAG(custo_total,12) OVER (ORDER BY AnoMes)
  ) AS yoy_crescimento

FROM custo_mensal