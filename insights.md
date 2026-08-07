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

## Data Quality 07 - Produtos sem peso

**Pergunta**

Existem produtos sem informação de peso?

**Resultado**

Foram encontrados **2 produtos** sem peso cadastrado.

**Impacto no negócio**

A ausência do peso pode prejudicar análises logísticas e cálculos relacionados ao transporte e ao frete.

**Recomendação**

Como a quantidade é pequena, os registros podem ser investigados individualmente. Caso não seja possível recuperar o valor original, o peso pode ser tratado conforme a regra de negócio, sem excluir os produtos da base.

## Data Quality 08 - Produtos sem peso que participaram de pedidos

**Pergunta**

Os produtos sem informação de peso participaram de pedidos?

**Resultado**

Foram encontrados **2 produtos sem peso** com registros na tabela `order_items`.

Um produto apareceu em **17 registros de pedidos** e o outro em **1 registro**, totalizando **18 itens vendidos**.

**Impacto no negócio**

Mesmo sendo poucos registros, os produtos possuem histórico de vendas. A exclusão desses dados poderia causar perda de informações e afetar análises históricas.

Além disso, a ausência do peso pode prejudicar análises logísticas e cálculos relacionados ao transporte e ao frete.

**Recomendação**

Os produtos devem ser mantidos na base. Como são apenas dois casos, recomenda-se investigar individualmente a possibilidade de recuperar o peso correto.

## Data Quality 09 - Produtos sem comprimento

**Pergunta**

Existem produtos sem informação de comprimento?

**Resultado**

Foram encontrados **2 produtos** sem comprimento cadastrado.

**Impacto no negócio**

A ausência do comprimento pode prejudicar análises de volume, armazenamento, embalagem, transporte e logística.

**Recomendação**

Como existem poucos registros, recomenda-se investigar os produtos individualmente e tentar recuperar a informação correta. Os produtos não devem ser excluídos sem verificar se participaram de vendas.

## Data Quality 10 - Produtos sem comprimento que participaram de pedidos

**Pergunta**

Os produtos sem informação de comprimento participaram de pedidos?

**Resultado**

Foram encontrados **2 produtos sem comprimento** com registros na tabela `order_items`.

Um produto apareceu em **17 registros de pedidos** e o outro em **1 registro**, totalizando **18 itens vendidos**.

**Impacto no negócio**

Os produtos possuem histórico de vendas e não devem ser excluídos. A ausência do comprimento pode prejudicar análises de volume, embalagem, armazenamento, transporte e logística.

**Recomendação**

Os registros devem ser mantidos. Como existem apenas dois produtos, recomenda-se investigar individualmente a possibilidade de recuperar as dimensões corretas.

## Data Quality 11 - Pedidos sem cliente

**Pergunta**

Existem pedidos sem cliente associado?

**Resultado**

Não foram encontrados pedidos sem `customer_id`.

**Impacto no negócio**

Todos os pedidos podem ser relacionados aos respectivos clientes, permitindo análises de comportamento, frequência de compra, localização e perfil de consumo.

**Conclusão**

A relação entre pedidos e clientes está completa na base analisada.

## Data Quality 12 - Pagamentos com valor zero

**Pergunta**

Existem pagamentos com valor igual a zero?

**Resultado**

Foram encontrados **9 registros** com `payment_value = 0`.

**Impacto no negócio**

Esses registros podem afetar cálculos de faturamento, ticket médio e indicadores financeiros caso sejam interpretados incorretamente.

**Recomendação**

Investigar os pedidos relacionados antes de excluir ou alterar os registros. A presença de valor zero não significa automaticamente que o dado está incorreto.

## Data Quality 12 - Pagamentos com valor zero

**Pergunta**

Existem pagamentos com valor igual a zero?

**Resultado**

Foram encontrados **9 registros** com `payment_value = 0`.

A investigação mostrou:

- 3 registros com pagamento `not_defined` e pedidos cancelados;
- 4 registros com pagamento `voucher` e pedidos entregues;
- 2 registros com pagamento `voucher` e pedidos enviados.

**Impacto no negócio**

A interpretação incorreta desses registros pode afetar análises de faturamento, ticket médio e comportamento de pagamento.

**Conclusão**

Os valores zero não devem ser considerados automaticamente erros. Os registros devem ser analisados considerando o tipo de pagamento e o status do pedido.

**Recomendação**

Manter os registros na base e considerar o contexto de cada pagamento nas análises financeiras.

## Data Quality 14 - Pagamentos com valor negativo

**Pergunta**

Existem pagamentos com valor menor que zero?

**Resultado**

Não foram encontrados pagamentos com valor negativo.

**Impacto no negócio**

A ausência de valores negativos reduz o risco de distorções em cálculos de faturamento, receita e ticket médio.

**Conclusão**

Os valores financeiros analisados apresentam consistência em relação a pagamentos negativos.

## Data Quality 15 - Pagamentos sem valor

**Pergunta**

Existem registros de pagamento sem valor informado?

**Resultado**

Não foram encontrados registros com `payment_value` nulo.

**Impacto no negócio**

Todos os pagamentos possuem um valor registrado, permitindo cálculos mais confiáveis de faturamento, receita e ticket médio.

**Conclusão**

A coluna `payment_value` está completa e pode ser utilizada nas análises financeiras.

## Data Quality 16 - Avaliações fora do intervalo esperado

**Pergunta**

Existem avaliações com nota menor que 1 ou maior que 5?

**Resultado**

Não foram encontradas avaliações fora do intervalo de **1 a 5**.

**Impacto no negócio**

A consistência das notas permite análises confiáveis de satisfação dos clientes, como média das avaliações e distribuição das notas.

**Conclusão**

A coluna `review_score` está consistente em relação ao intervalo esperado.

## Data Quality 17 - Avaliações sem nota

**Pergunta**

Existem avaliações sem nota informada?

**Resultado**

Não foram encontrados registros com `review_score` nulo.

**Impacto no negócio**

Todas as avaliações possuem uma nota, permitindo o cálculo confiável da média de satisfação e a análise da distribuição das avaliações.

**Conclusão**

A coluna `review_score` está completa e pode ser utilizada nas análises de satisfação dos clientes.

## Data Quality 18 - Avaliações sem comentário

**Pergunta**

Quantas avaliações não possuem título nem mensagem?

**Resultado**

Foram encontradas **56.518 avaliações** sem título e sem mensagem de comentário.

**Impacto no negócio**

Essas avaliações ainda possuem uma nota e podem ser utilizadas em análises quantitativas de satisfação, como média das avaliações e distribuição das notas.

Entretanto, a ausência de texto limita análises qualitativas, como identificação dos principais motivos de satisfação ou insatisfação.

**Conclusão**

A ausência de comentários não deve ser tratada automaticamente como erro, pois o cliente pode ter escolhido avaliar apenas por meio da nota.

**Recomendação**

Manter os registros na base. Para análises de texto e sentimento, utilizar somente as avaliações que possuem comentário.

## Data Quality 19 - Avaliações com título, mas sem mensagem

**Pergunta**

Existem avaliações com título preenchido, mas sem mensagem?

**Resultado**

Foram encontradas **1.729 avaliações** com título preenchido e sem mensagem de comentário.

**Impacto no negócio**

Embora não exista uma mensagem detalhada, o título pode conter informações relevantes sobre a experiência do cliente.

Esses registros continuam úteis para análises quantitativas de satisfação e também podem contribuir para análises textuais.

**Conclusão**

A ausência da mensagem não deve ser tratada automaticamente como erro, pois o título pode funcionar como um comentário resumido.

**Recomendação**

Manter os registros na base. Em análises de texto, considerar o conteúdo do título como uma fonte complementar de informação.

## Data Quality 20 - Avaliações sem título, mas com mensagem

**Pergunta**

Existem avaliações sem título, mas com mensagem preenchida?

**Resultado**

Foram encontradas **31.138 avaliações** sem título e com mensagem de comentário preenchida.

**Impacto no negócio**

Mesmo sem título, essas avaliações possuem conteúdo textual que pode ajudar a identificar motivos de satisfação, reclamações, problemas de entrega e outros aspectos da experiência do cliente.

**Conclusão**

A ausência do título não deve ser tratada como erro, pois a mensagem fornece informações relevantes sobre a experiência do cliente.

**Recomendação**

Manter os registros na base e utilizar a mensagem em análises qualitativas e de sentimento.

## Data Quality 21 - Aprovação anterior à compra

**Pergunta**

Existem pedidos cuja aprovação ocorreu antes da compra?

**Resultado**

Não foram encontrados pedidos com `order_approved_at` anterior a `order_purchase_timestamp`.

**Impacto no negócio**

A consistência da sequência temporal permite calcular com mais confiança o tempo entre a realização da compra e a aprovação do pedido.

**Conclusão**

Não foram identificadas inconsistências entre as datas de compra e aprovação.

## Data Quality 22 - Envio para a transportadora anterior à aprovação

**Pergunta**

Existem pedidos cuja data de envio para a transportadora é anterior à data de aprovação?

**Resultado**

Foram encontrados **1.359 pedidos** em que `order_delivered_carrier_date` é anterior a `order_approved_at`.

**Impacto no negócio**

Essa diferença pode afetar análises de tempo de processamento, eficiência operacional e prazo entre aprovação e envio.

**Conclusão**

Foram identificadas possíveis inconsistências temporais entre a aprovação e o envio para a transportadora. A maior diferença encontrada foi de aproximadamente **171 dias**, indicando que alguns registros podem possuir problemas no preenchimento ou na atualização das datas.

Os dados não devem ser alterados ou excluídos sem uma regra de negócio definida. Essa limitação deve ser considerada nas análises de tempo de processamento e logística.

**Recomendação**

Manter os dados originais e considerar essa particularidade ao calcular indicadores operacionais.

A investigação da diferença entre as datas mostrou que a maior diferença encontrada foi de aproximadamente **171 dias**.

Isso indica que parte dos registros pode apresentar inconsistências relevantes na sequência temporal dos eventos.

## Data Quality 24 - Entrega anterior ao envio

**Pergunta**

Existem pedidos cuja entrega ao cliente ocorreu antes do envio para a transportadora?

**Resultado**

Foram encontrados **23 pedidos** em que `order_delivered_customer_date` é anterior a `order_delivered_carrier_date`.

**Impacto no negócio**

Essa inconsistência pode afetar cálculos de tempo de transporte, prazo de entrega e desempenho logístico.

**Conclusão**

Foram identificados poucos casos com possível inconsistência na sequência temporal entre envio e entrega. Como existem apenas 23 registros, recomenda-se investigar esses pedidos individualmente.

**Recomendação**

Manter os dados originais e considerar essa limitação ao calcular indicadores logísticos.

A investigação mostrou que a maior diferença encontrada foi de aproximadamente **16 dias, 2 horas e 18 minutos**.

Essa diferença é significativa e pode indicar inconsistências no registro ou na atualização das datas logísticas.

## Data Quality 26 - Previsão de entrega anterior à compra

**Pergunta**

Existem pedidos cuja data estimada de entrega é anterior à data da compra?

**Resultado**

Não foram encontrados pedidos com `order_estimated_delivery_date` anterior a `order_purchase_timestamp`.

**Impacto no negócio**

A consistência dessas datas permite utilizar a previsão de entrega em análises de prazo, desempenho logístico e comparação entre entrega estimada e entrega real.

**Conclusão**

Não foram identificadas inconsistências entre a data da compra e a data estimada de entrega.

## Data Quality 27 - Entrega anterior à compra

**Pergunta**

Existem pedidos cuja entrega ao cliente ocorreu antes da data da compra?

**Resultado**

Não foram encontrados pedidos com `order_delivered_customer_date` anterior a `order_purchase_timestamp`.

**Impacto no negócio**

A consistência entre a data de compra e a data de entrega permite calcular com mais segurança o tempo total de entrega e outros indicadores logísticos.

**Conclusão**

Não foram identificadas inconsistências entre a data da compra e a data de entrega ao cliente.

## Data Quality 28 - Pedidos entregues após o prazo estimado

**Pergunta**

Quantos pedidos foram entregues após a data estimada?

**Resultado**

Foram encontrados **7.827 pedidos** cuja data real de entrega foi posterior à data estimada.

**Impacto no negócio**

Entregas após o prazo previsto podem reduzir a satisfação dos clientes, aumentar reclamações e afetar a percepção sobre a qualidade do serviço logístico.

**Conclusão**

Foi identificada uma quantidade relevante de pedidos entregues com atraso em relação ao prazo estimado.

**Recomendação**

Investigar os fatores associados aos atrasos, como estado de destino, transportadora, categoria do produto e período da compra.

A análise do tempo de atraso mostrou que o maior atraso individual foi de aproximadamente **188 dias**.

É importante observar que esse valor representa o maior caso encontrado e não o atraso médio dos pedidos.

**Conclusão**

Foram encontrados **7.827 pedidos** entregues após o prazo estimado. O maior atraso individual foi de aproximadamente **188 dias**, indicando a existência de casos extremos que podem estar relacionados a problemas logísticos, exceções operacionais ou inconsistências nas datas.

Os dados devem ser mantidos em seu estado original, mas os casos extremos devem ser considerados ao analisar o desempenho das entregas.

## Data Quality 30 - Pedidos entregues antes do prazo estimado

**Pergunta**

Quantos pedidos foram entregues antes da data estimada?

**Resultado**

Foram encontrados **88.649 pedidos** cuja data real de entrega foi anterior à data estimada.

**Impacto no negócio**

Entregas antecipadas podem contribuir para uma melhor experiência do cliente e indicar bom desempenho logístico.

**Conclusão**

A quantidade de pedidos entregues antes do prazo é muito superior à quantidade de pedidos entregues após o prazo. Isso pode indicar eficiência na operação logística ou que os prazos estimados foram definidos com uma margem de segurança.

**Recomendação**

Comparar os resultados por estado, período e categoria de produto para identificar onde o desempenho logístico é mais eficiente.

## Data Quality 31 - Pedidos entregues exatamente no prazo

**Pergunta**

Quantos pedidos foram entregues exatamente na data estimada?

**Resultado**

Foram encontrados **1.292 pedidos** entregues exatamente na data prevista.

**Impacto no negócio**

Embora existam entregas realizadas exatamente no prazo, a maioria dos pedidos foi entregue antes da data estimada.

**Conclusão**

A operação logística apresenta predominância de entregas antecipadas, indicando bom desempenho ou estimativas de entrega conservadoras.