WITH base_paradas AS (
  SELECT 
    NomePlanta,
    EquipamentoID,
    Ano,
    Mes,
    SUM(DATETIME_DIFF(DataConclusao, DataSolicitacao, MINUTE) / 60.0) AS total_horas_downtime
  FROM Maintenance.vw_manutencao_base
  WHERE TipoServico = 'Corretiva'
    AND DataConclusao IS NOT NULL
  GROUP BY 1, 2, 3, 4
)
SELECT 
  *,
  -- Calcula o total de horas do mês (Dias do Mês * 24h) para servir de base (100%) para a Disponibilidade Operacional
  (EXTRACT(DAY FROM LAST_DAY(DATE(Ano, Mes, 1))) * 24) AS horas_calendario_equipamento
FROM base_paradas