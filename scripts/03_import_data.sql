/*
=========================================================
IMPORTAÇÃO DOS DADOS
Projeto: SQL E-commerce Analytics
Autor: Elvis Marques
=========================================================

As tabelas foram importadas utilizando o recurso
Import/Export Data do pgAdmin.

Ordem de importação:

1. customers
2. products
3. sellers
4. category_translation
5. orders
6. payments
7. reviews
8. order_items

Observações encontradas durante a carga:

- customer_unique_id NÃO é único.
  A restrição UNIQUE foi removida.

- review_id possui registros repetidos.
  A PRIMARY KEY foi removida da tabela reviews
  para permitir a importação do dataset.

=========================================================
*/