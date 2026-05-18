# Dashboard de Confiabilidade e Custos de Manutenção Industrial

Projeto desenvolvido com foco em análise de confiabilidade, desempenho operacional e custos de manutenção industrial utilizando SQL, BigQuery e Looker Studio.

O dashboard foi construído com base em indicadores amplamente utilizados na engenharia de manutenção, permitindo análise temporal, identificação de ativos críticos e acompanhamento da evolução dos custos operacionais.

---

# 🚀 Tecnologias Utilizadas

- SQL
- Google BigQuery
- Looker Studio
- Modelagem de Dados
- Funções Analíticas SQL
- Window Functions

---

# 📊 Indicadores Desenvolvidos

## Confiabilidade

- MTBF (Mean Time Between Failures)
- MTTR (Mean Time To Repair)
- Disponibilidade Operacional
- Volume de Manutenções Corretivas
- Ranking de ativos críticos

---

## Custos

- Custo Total de Manutenção
- Custos de Peças
- Custos de Mão de Obra
- Crescimento MoM (Month over Month)
- Crescimento YoY (Year over Year)
- Custos por Planta

---

# 🧠 Técnicas Aplicadas

- Window Functions (`LAG`, `OVER`, `PARTITION BY`)
- Comparações temporais MoM e YoY
- Tratamento de granularidade por Ordem de Serviço
- Agregações temporais
- KPIs industriais
- Modelagem analítica para dashboards executivos

---

# 📂 Estrutura do Projeto

```text
maintenance-reliability-dashboard/
│
├── README.md
│
├── sql/
│   ├── confiabilidade/
│   │   ├── disponibilidade_consolidada.sql
│   │   ├── mtbf_base.sql
│   │   ├── mttr_base.sql
│   │
│   ├── custos/
│   │   ├── custos_pecas_temporal.sql
│   │   ├── custo_planta_mom_yoy.sql
│
├── images/
│   ├── dashboard_confiabilidade.png
│   ├── dashboard_custos.png


