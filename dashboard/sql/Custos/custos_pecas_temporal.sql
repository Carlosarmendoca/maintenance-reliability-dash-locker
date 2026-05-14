WITH base AS (
  SELECT
    MovimentoID,
    NomePlanta,
    AnoMes,
    Mes,
    TipoServico,
    SUM(QuantidadeConsumida) AS total_pecas,
    SUM(CustoTotalPecas) AS custo_total_pecas
  FROM Maintenance.vw_ospecas
  GROUP BY MovimentoID, NomePlanta, AnoMes, Mes, TipoServico
)

SELECT
  NomePlanta,
  AnoMes,
  Mes,
  PARSE_DATE('%Y-%m', AnoMes) AS data_referencia,
  TipoServico,
  SUM(total_pecas) AS total_pecas,
  SUM(custo_total_pecas) AS custo_total_pecas,
  COUNT(MovimentoID) AS total_mov
FROM base
GROUP BY NomePlanta, AnoMes, Mes, TipoServico