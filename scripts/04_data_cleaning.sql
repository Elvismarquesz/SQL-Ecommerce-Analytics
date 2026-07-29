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

