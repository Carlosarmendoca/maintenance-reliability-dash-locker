WITH base_limpa AS (
  SELECT 
    NomePlanta,
    EquipamentoID,
    DataSolicitacao,
    DataConclusao,
    Ano,
    Mes
  FROM Maintenance.vw_manutencao_base
  WHERE TipoServico = 'Corretiva' AND DataConclusao IS NOT NULL
),
calculo_intervalos AS (
  SELECT 
    *,
    -- Intervalo entre o fim da falha anterior e o início da atual (Uptime)
    DATETIME_DIFF(DataSolicitacao, LAG(DataConclusao) OVER(PARTITION BY EquipamentoID ORDER BY DataSolicitacao), HOUR) AS intervalo_horas
  FROM base_limpa
)
SELECT 
  NomePlanta,
  EquipamentoID,
  Ano,
  Mes,
  -- Soma das horas que o equipamento ficou rodando (Uptime)
  SUM(intervalo_horas) AS soma_uptime_horas,
  -- Contagem real de quantas ordens de serviço corretivas ocorreram
  COUNT(*) AS total_falhas 
FROM calculo_intervalos
GROUP BY 1, 2, 3, 4