## Data Quality 05 - Produtos sem categoria

**Pergunta**

Existem produtos sem categoria cadastrada?

**Resultado**

Foram encontrados **610 produtos** sem categoria.

**Impacto no negócio**

Esses produtos não podem ser classificados corretamente em análises por categoria, podendo gerar indicadores incompletos ou incorretos.

**Recomendação**

Antes da construção de dashboards, esses registros devem ser tratados. Uma alternativa é classificá-los como **"Categoria não informada"** ou realizar um processo de enriquecimento dos dados.

## Data Quality 06 - Produtos sem categoria que participaram de pedidos

**Pergunta**

Os produtos sem categoria participaram de vendas?

**Resultado**

Foram encontrados **610 produtos sem categoria** que aparecem em pelo menos um pedido.

**Impacto no negócio**

A ausência da categoria pode prejudicar análises de vendas, faturamento e desempenho por categoria. Como esses produtos participaram de pedidos, excluí-los poderia causar perda de informações históricas e distorcer indicadores.

**Recomendação**

Os produtos devem ser mantidos na base. Para análises, os valores nulos podem ser classificados como **"Categoria não informada"**, sem alterar os dados originais.