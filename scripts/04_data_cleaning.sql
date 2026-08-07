/*
=========================================================
PROJETO: SQL E-commerce Analytics

Arquivo:
04_data_cleaning.sql

Objetivo:

Realizar verificações de qualidade dos dados antes das análises.

Autor:
Elvis Marques

=========================================================
*/

-- =====================================================
-- 01 - Verificar customer_id duplicados
-- Objetivo:
-- Garantir que a chave primária da tabela customers
-- realmente não possui registros repetidos.
-- =====================================================

SELECT
    customer_id,
    COUNT(*) AS quantidade
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Resultado:
-- Nenhum customer_id duplicado encontrado.

-- Conclusão:
-- A chave primária da tabela customers está consistente.

-- =====================================================
-- 02 - Verificar order_id duplicados
-- Objetivo:
-- Garantir que a chave primária da tabela orders
-- realmente não possui registros repetidos.
-- =====================================================

SELECT
    order_id,
    COUNT(*) AS quantidade
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Resultado:
-- Nenhum order_id duplicado encontrado.

-- Conclusão:
-- A chave primária da tabela orders está consistente.

-- =====================================================
-- 03 - Verificar clientes sem cidade
-- Objetivo:
-- Identificar registros de clientes sem informação de cidade.
-- =====================================================

SELECT *
FROM customers
WHERE customer_city IS NULL;

-- Resultado:
-- Nenhum cliente sem cidade foi encontrado.

-- Conclusão:
-- A coluna customer_city está completa e pode ser utilizada
-- com segurança em análises por localização.

-- =====================================================
-- 04 - Verificar clientes sem estado
-- Objetivo:
-- Identificar registros de clientes sem informação do estado.
-- =====================================================

SELECT *
FROM customers
WHERE customer_state IS NULL;

-- Resultado:
-- Nenhum cliente sem estado foi encontrado.

-- Conclusão:
-- A coluna customer_state está completa e pode ser utilizada
-- com segurança em análises por estado.

-- =====================================================
-- 05 - Verificar produtos sem categoria
-- Objetivo:
-- Identificar produtos que não possuem categoria cadastrada.
-- =====================================================

SELECT *
FROM products
WHERE product_category_name IS NULL;

-- Resultado:
-- Foram encontrados 610 produtos sem categoria.

-- Conclusão:
-- A ausência da categoria pode comprometer análises de vendas
-- por categoria e a construção de dashboards.
-- Esses registros devem ser tratados antes das análises.

-- =====================================================
-- 06 - Produtos sem categoria que já foram vendidos
-- Objetivo:
-- Verificar se existem produtos sem categoria que participaram de pedidos.
-- =====================================================

SELECT
    p.product_id,
    p.product_category_name,
    COUNT(oi.order_id) AS total_vendas
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE p.product_category_name IS NULL
GROUP BY p.product_id, p.product_category_name
ORDER BY total_vendas DESC;

-- Resultado:
-- Foram encontrados 610 produtos sem categoria que participaram
-- de pelo menos um pedido.

-- Conclusão:
-- Todos os produtos sem categoria possuem registros de vendas.
-- Portanto, esses produtos não devem ser excluídos, pois a exclusão
-- poderia causar perda de informações e comprometer análises históricas.

-- =====================================================
-- 07 - Verificar produtos sem peso
-- Objetivo:
-- Identificar produtos sem informação de peso.
-- =====================================================

SELECT *
FROM products
WHERE product_weight_g IS NULL;

-- Resultado:
-- Foram encontrados 2 produtos sem informação de peso.

-- Conclusão:
-- A quantidade de registros com peso ausente é baixa.
-- Porém, esses produtos podem prejudicar análises logísticas
-- e cálculos relacionados ao transporte.

-- =====================================================
-- 08 - Produtos sem peso que participaram de pedidos
-- Objetivo:
-- Verificar se os produtos sem peso possuem registros
-- na tabela order_items.
-- =====================================================

SELECT
    p.product_id,
    p.product_weight_g,
    COUNT(oi.order_id) AS total_vendas
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE p.product_weight_g IS NULL
GROUP BY
    p.product_id,
    p.product_weight_g
ORDER BY total_vendas DESC;

-- Resultado:
-- Foram encontrados 2 produtos sem informação de peso
-- que participaram de pedidos.
-- Um produto apareceu em 17 registros de pedidos
-- e o outro apareceu em 1 registro.

-- Conclusão:
-- Os dois produtos sem peso possuem histórico de vendas.
-- Portanto, eles não devem ser excluídos da base.
-- A ausência do peso pode afetar análises logísticas,
-- cálculos de frete e estudos relacionados ao transporte.

-- =====================================================
-- 09 - Verificar produtos sem comprimento
-- Objetivo:
-- Identificar produtos sem informação de comprimento.
-- =====================================================

SELECT *
FROM products
WHERE product_length_cm IS NULL;

-- Resultado:
-- Foram encontrados 2 produtos sem informação de comprimento.

-- Conclusão:
-- A quantidade de registros com comprimento ausente é baixa.
-- Porém, a ausência dessa informação pode prejudicar análises
-- logísticas e cálculos relacionados ao volume e ao transporte.

-- =====================================================
-- 10 - Produtos sem comprimento que participaram de pedidos
-- Objetivo:
-- Verificar se os produtos sem comprimento possuem
-- registros na tabela order_items.
-- =====================================================

SELECT
    p.product_id,
    p.product_length_cm,
    COUNT(oi.order_id) AS total_itens_vendidos
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE p.product_length_cm IS NULL
GROUP BY
    p.product_id,
    p.product_length_cm
ORDER BY total_itens_vendidos DESC;

-- Resultado:
-- Foram encontrados 2 produtos sem informação de comprimento
-- que participaram de pedidos.
-- Um produto apareceu em 17 registros de pedidos
-- e o outro apareceu em 1 registro.
-- Total: 18 itens vendidos.

-- Conclusão:
-- Os produtos sem comprimento possuem histórico de vendas
-- e não devem ser excluídos da base.
-- A ausência dessa informação pode afetar análises de volume,
-- embalagem, armazenamento e logística.

-- =====================================================
-- 11 - Verificar pedidos sem cliente
-- Objetivo:
-- Identificar pedidos que não possuem customer_id.
-- =====================================================

SELECT *
FROM orders
WHERE customer_id IS NULL;

-- Resultado:
-- Nenhum pedido sem customer_id foi encontrado.

-- Conclusão:
-- Todos os pedidos possuem um cliente associado.
-- O relacionamento entre orders e customers está completo
-- para as análises realizadas.

-- =====================================================
-- 12 - Verificar pagamentos com valor igual a zero
-- Objetivo:
-- Identificar pagamentos que possuem valor igual a zero.
-- =====================================================

SELECT *
FROM payments
WHERE payment_value = 0;

-- Resultado:
-- Foram encontrados 9 registros de pagamento
-- com payment_value igual a zero.

-- Conclusão:
-- Os registros devem ser investigados antes de serem
-- classificados como erro, pois podem representar regras
-- específicas de pagamento ou inconsistências nos dados.

-- =====================================================
-- 13 - Investigar pedidos com pagamento igual a zero
-- Objetivo:
-- Verificar o status dos pedidos relacionados aos
-- pagamentos com valor igual a zero.
-- =====================================================

SELECT
    p.order_id,
    p.payment_type,
    p.payment_value,
    o.order_status
FROM payments p
INNER JOIN orders o
    ON p.order_id = o.order_id
WHERE p.payment_value = 0
ORDER BY o.order_status;

-- Resultado:
-- Foram encontrados 9 registros de pagamento com valor igual a zero.
--
-- Distribuição identificada:
-- - 3 registros: pagamento not_defined e pedido cancelado.
-- - 4 registros: pagamento voucher e pedido entregue.
-- - 2 registros: pagamento voucher e pedido enviado.
--
-- Conclusão:
-- Os pagamentos com valor zero não devem ser classificados
-- automaticamente como erros.
-- Parte dos registros está associada a pedidos cancelados,
-- enquanto outros estão relacionados ao uso de voucher.
-- Recomenda-se manter os registros e considerar o contexto
-- do pagamento nas análises financeiras.

-- =====================================================
-- 14 - Verificar pagamentos com valor negativo
-- Objetivo:
-- Identificar registros de pagamento com valor menor que zero.
-- =====================================================

SELECT *
FROM payments
WHERE payment_value < 0;

-- Resultado:
-- Nenhum pagamento com valor negativo foi encontrado.

-- Conclusão:
-- Os valores de pagamento não apresentam registros negativos,
-- reduzindo o risco de distorções nos cálculos de faturamento
-- e indicadores financeiros.

-- =====================================================
-- 15 - Verificar pagamentos sem valor
-- Objetivo:
-- Identificar registros com payment_value nulo.
-- =====================================================

SELECT *
FROM payments
WHERE payment_value IS NULL;

-- Resultado:
-- Nenhum pagamento com payment_value nulo foi encontrado.

-- Conclusão:
-- Todos os registros de pagamento possuem um valor informado.
-- A coluna payment_value está completa para as análises financeiras.

-- =====================================================
-- 16 - Verificar avaliações fora do intervalo permitido
-- Objetivo:
-- Identificar avaliações menores que 1 ou maiores que 5.
-- =====================================================

SELECT *
FROM reviews
WHERE review_score < 1
   OR review_score > 5;

-- Resultado:
-- Nenhuma avaliação fora do intervalo de 1 a 5 foi encontrada.

-- Conclusão:
-- Os valores da coluna review_score estão dentro da escala
-- esperada e podem ser utilizados nas análises de satisfação.

-- =====================================================
-- 17 - Verificar avaliações sem nota
-- Objetivo:
-- Identificar registros com review_score nulo.
-- =====================================================

SELECT *
FROM reviews
WHERE review_score IS NULL;

-- Resultado:
-- Nenhuma avaliação com review_score nulo foi encontrada.

-- Conclusão:
-- Todas as avaliações possuem uma nota informada.
-- A coluna review_score está completa para análises
-- de satisfação dos clientes.

-- =====================================================
-- 18 - Verificar avaliações sem comentário
-- Objetivo:
-- Identificar avaliações sem título e sem mensagem.
-- =====================================================

SELECT *
FROM reviews
WHERE review_comment_title IS NULL
  AND review_comment_message IS NULL;

  -- Resultado:
-- Foram encontradas 56.518 avaliações sem título
-- e sem mensagem de comentário.

-- Conclusão:
-- A ausência de texto não significa necessariamente
-- que a avaliação é inválida, pois o cliente pode ter
-- informado apenas a nota.
-- Esses registros podem ser utilizados em análises
-- quantitativas de satisfação, mas não em análises
-- de sentimento baseadas em texto.

-- =====================================================
-- 19 - Verificar avaliações com título, mas sem mensagem
-- Objetivo:
-- Identificar avaliações que possuem título, mas não
-- possuem texto no comentário.
-- =====================================================

SELECT *
FROM reviews
WHERE review_comment_title IS NOT NULL
  AND review_comment_message IS NULL;

-- Resultado:
-- Foram encontradas 1.729 avaliações com título preenchido,
-- mas sem mensagem de comentário.

-- Conclusão:
-- A ausência da mensagem não torna a avaliação inválida,
-- pois o título pode conter informações relevantes sobre
-- a experiência do cliente.
-- Esses registros podem ser utilizados em análises de
-- satisfação e análises textuais baseadas no título.

-- =====================================================
-- 20 - Verificar avaliações sem título, mas com mensagem
-- Objetivo:
-- Identificar avaliações que possuem mensagem,
-- mas não possuem título.
-- =====================================================

SELECT *
FROM reviews
WHERE review_comment_title IS NULL
  AND review_comment_message IS NOT NULL;

-- Resultado:
-- Foram encontradas 31.138 avaliações sem título,
-- mas com mensagem de comentário preenchida.

-- Conclusão:
-- A ausência do título não torna a avaliação inválida,
-- pois a mensagem contém informações sobre a experiência
-- do cliente.
-- Esses registros podem ser utilizados em análises de
-- satisfação e análises textuais.

-- =====================================================
-- 21 - Verificar pedidos aprovados antes da compra
-- Objetivo:
-- Identificar possíveis inconsistências na sequência
-- temporal dos pedidos.
-- =====================================================

SELECT
    order_id,
    order_purchase_timestamp,
    order_approved_at
FROM orders
WHERE order_approved_at < order_purchase_timestamp;

-- Resultado:
-- Nenhum pedido foi aprovado antes da data de compra.

-- Conclusão:
-- A sequência temporal entre a compra e a aprovação
-- está consistente nos dados analisados.

-- =====================================================
-- 22 - Verificar pedidos enviados antes da aprovação
-- Objetivo:
-- Identificar possíveis inconsistências entre a data
-- de aprovação e o envio para a transportadora.
-- =====================================================

SELECT
    order_id,
    order_approved_at,
    order_delivered_carrier_date
FROM orders
WHERE order_delivered_carrier_date < order_approved_at;

-- Resultado:
-- Foram encontrados 1.359 pedidos cuja data de envio
-- para a transportadora é anterior à data de aprovação.

-- Conclusão:
-- Foi identificada uma possível inconsistência na sequência
-- temporal entre a aprovação do pedido e o envio para a
-- transportadora.
-- Os registros devem ser investigados antes de serem
-- classificados como erros ou alterados.


-- =====================================================
-- 23 - Medir a diferença entre envio e aprovação
-- Objetivo:
-- Calcular a diferença de tempo nos pedidos em que o
-- envio para a transportadora ocorreu antes da aprovação.
-- =====================================================

SELECT
    order_id,
    order_approved_at,
    order_delivered_carrier_date,
    order_approved_at - order_delivered_carrier_date
        AS diferenca_tempo
FROM orders
WHERE order_delivered_carrier_date < order_approved_at
ORDER BY diferenca_tempo DESC;

-- Resultado:
-- Foram encontrados 1.359 pedidos com data de envio para
-- a transportadora anterior à data de aprovação.
--
-- A maior diferença identificada foi de aproximadamente
-- 171 dias.

-- Conclusão:
-- A diferença máxima encontrada é significativa e pode
-- indicar inconsistências no registro das datas ou atrasos
-- na atualização dos eventos do pedido.
-- Os dados devem ser mantidos em seu estado original,
-- mas essa particularidade deve ser considerada em análises
-- de tempo de processamento e logística.


-- =====================================================
-- 24 - Verificar entregas anteriores ao envio
-- Objetivo:
-- Identificar pedidos cuja entrega ao cliente ocorreu
-- antes do envio para a transportadora.
-- =====================================================

SELECT
    order_id,
    order_delivered_carrier_date,
    order_delivered_customer_date
FROM orders
WHERE order_delivered_customer_date
      < order_delivered_carrier_date;

-- Resultado:
-- Foram encontrados 23 pedidos cuja data de entrega ao cliente
-- é anterior à data de envio para a transportadora.

-- Conclusão:
-- Foi identificada uma possível inconsistência na sequência
-- temporal entre o envio e a entrega.
-- Como a quantidade de registros é baixa, recomenda-se
-- investigar os casos individualmente.
-- Os dados devem ser mantidos em seu estado original.

-- =====================================================
-- 25 - Medir a diferença entre entrega e envio
-- Objetivo:
-- Calcular a diferença de tempo nos pedidos em que a
-- entrega foi registrada antes do envio.
-- =====================================================

SELECT
    order_id,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_delivered_carrier_date
        - order_delivered_customer_date
        AS diferenca_tempo
FROM orders
WHERE order_delivered_customer_date
      < order_delivered_carrier_date
ORDER BY diferenca_tempo DESC;

-- Resultado:
-- Foram encontrados 23 pedidos cuja data de entrega ao cliente
-- é anterior à data de envio para a transportadora.
--
-- A maior diferença encontrada foi de aproximadamente
-- 16 dias, 2 horas e 18 minutos.

-- Conclusão:
-- A diferença máxima é significativa e indica possíveis
-- inconsistências no registro ou na atualização das datas.
-- Os registros devem ser mantidos em seu estado original,
-- mas essa limitação deve ser considerada nas análises
-- de prazo de entrega e desempenho logístico.

-- =====================================================
-- 26 - Verificar previsão de entrega anterior à compra
-- Objetivo:
-- Identificar pedidos cuja data estimada de entrega
-- é anterior à data de compra.
-- =====================================================

SELECT
    order_id,
    order_purchase_timestamp,
    order_estimated_delivery_date
FROM orders
WHERE order_estimated_delivery_date
      < order_purchase_timestamp;

-- Resultado:
-- Nenhum pedido possui data estimada de entrega
-- anterior à data de compra.

-- Conclusão:
-- A sequência temporal entre a compra e a previsão
-- de entrega está consistente nos dados analisados.

-- =====================================================
-- 27 - Verificar entrega anterior à compra
-- Objetivo:
-- Identificar pedidos cuja entrega ao cliente ocorreu
-- antes da data de compra.
-- =====================================================

SELECT
    order_id,
    order_purchase_timestamp,
    order_delivered_customer_date
FROM orders
WHERE order_delivered_customer_date
      < order_purchase_timestamp;

-- Resultado:
-- Nenhum pedido possui data de entrega ao cliente
-- anterior à data de compra.

-- Conclusão:
-- A sequência temporal entre a compra e a entrega
-- está consistente nos dados analisados.

-- =====================================================
-- 28 - Verificar pedidos entregues após o prazo estimado
-- Objetivo:
-- Identificar pedidos cuja entrega ao cliente ocorreu
-- depois da data estimada de entrega.
-- =====================================================

SELECT
    order_id,
    order_estimated_delivery_date,
    order_delivered_customer_date
FROM orders
WHERE order_delivered_customer_date
      > order_estimated_delivery_date;

-- Resultado:
-- Foram encontrados 7.827 pedidos entregues após
-- a data estimada de entrega.

-- Conclusão:
-- Foi identificada uma quantidade relevante de pedidos
-- entregues após o prazo previsto.
-- Esses atrasos podem afetar a satisfação dos clientes
-- e os indicadores de desempenho logístico.

-- =====================================================
-- 29 - Calcular o tempo de atraso das entregas
-- Objetivo:
-- Medir quantos dias cada pedido foi entregue após
-- a data estimada.
-- =====================================================

SELECT
    order_id,
    order_estimated_delivery_date,
    order_delivered_customer_date,
    order_delivered_customer_date
        - order_estimated_delivery_date
        AS tempo_atraso
FROM orders
WHERE order_delivered_customer_date
      > order_estimated_delivery_date
ORDER BY tempo_atraso DESC;

-- Resultado:
-- Foram encontrados 7.827 pedidos entregues após
-- a data estimada de entrega.
--
-- O maior atraso identificado foi de aproximadamente
-- 188 dias.

-- Conclusão:
-- A quantidade de entregas após o prazo estimado é relevante.
-- O maior atraso encontrado é extremamente elevado e pode
-- indicar problemas logísticos, exceções operacionais ou
-- inconsistências no registro das datas.
--
-- Os dados devem ser mantidos em seu estado original,
-- mas essa limitação deve ser considerada nas análises
-- de desempenho logístico e satisfação dos clientes.

-- =====================================================
-- 30 - Verificar pedidos entregues antes do prazo estimado
-- Objetivo:
-- Identificar pedidos cuja entrega ao cliente ocorreu
-- antes da data estimada de entrega.
-- =====================================================

SELECT
    order_id,
    order_estimated_delivery_date,
    order_delivered_customer_date
FROM orders
WHERE order_delivered_customer_date
      < order_estimated_delivery_date;

-- Resultado:
-- Foram encontrados 88.649 pedidos entregues antes
-- da data estimada de entrega.

-- Conclusão:
-- A maior parte dos pedidos entregues foi concluída
-- antes do prazo previsto.
-- Esse resultado pode indicar eficiência logística
-- ou prazos estimados mais conservadores.

-- =====================================================
-- 31 - Verificar pedidos entregues no dia estimado
-- Objetivo:
-- Identificar pedidos entregues no mesmo dia previsto,
-- desconsiderando a diferença de horário.
-- =====================================================

SELECT
    order_id,
    order_estimated_delivery_date,
    order_delivered_customer_date
FROM orders
WHERE DATE(order_delivered_customer_date)
      = DATE(order_estimated_delivery_date);

-- Resultado:
-- Foram encontrados 1.292 pedidos entregues
-- exatamente na data estimada de entrega.

-- Conclusão:
-- A quantidade de entregas realizadas exatamente
-- na data prevista é pequena quando comparada às
-- entregas antecipadas.
--
-- A maior parte dos pedidos foi entregue antes
-- do prazo estimado.

