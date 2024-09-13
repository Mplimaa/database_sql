--11
--M�o na massa: hora da pr�tica
--PR�XIMA ATIVIDADE

--Chegou a hora de se desafiar a desenvolver ainda mais todo o conhecimento aprendido durante nossa jornada!

--Aqui est�o algumas atividades que v�o te ajudar a praticar e fixar ainda mais cada conte�do e caso voc� precise de ajuda, op��es de solu��o das atividades est�o dispon�veis na se��o �Opini�o da pessoa instrutora�.

--Considerando a mesma base de dados utilizada no curso.

--01 - Qual � o n�mero de Clientes que existem na base de dados ?

--02 - Quantos produtos foram vendidos no ano de 2022 ?

--03 - Qual a categoria que mais vendeu em 2022 ?

--04 - Qual o primeiro ano dispon�vel na base ?

--05 - Qual o nome do fornecedor que mais vendeu no primeiro ano dispon�vel na base ?

--06 - Quanto ele vendeu no primeiro ano dispon�vel na base de dados ?

--07 - Quais as duas categorias que mais venderam no total de todos os anos ?

--08 - Crie uma tabela comparando as vendas ao longo do tempo das duas categorias que mais venderam no total de todos os anos.

--09 - Calcule a porcentagem de vendas por categorias no ano de 2022.

--10 - Crie uma m�trica mostrando a porcentagem de vendas a mais que a melhor categoria tem em rela��o a pior no ano de 2022.

-- DISCUTIR NO 

--Opini�o do instrutor

--Podem existir diversas formas de solucionar os problemas propostos e algumas delas s�o apresentadas a seguir:

--01 -
SELECT COUNT(*) AS Qtd_Clientes FROM CLIENTES;

--02-
SELECT COUNT(*) AS Qtd_Produtos, strftime('%Y', data_venda) AS Ano FROM VENDAS WHERE Ano = '2022';

--03-
SELECT COUNT(*) AS Qtd_Vendas, c.nome_categoria AS Categoria
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN PRODUTOS p ON p.id_produto = iv.produto_id
JOIN CATEGORIAS c ON c.id_categoria = p.categoria_id
WHERE strftime('%Y', v.data_venda) = '2022'
GROUP BY categoria 
ORDER BY COUNT(*) DESC
LIMIT 1;

--04-
SELECT MIN(strftime('%Y', data_venda)) AS Ano FROM VENDAS;

--05-
SELECT COUNT(*) AS Qtd_Vendas, f.nome AS Fornecedor
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN PRODUTOS p ON p.id_produto = iv.produto_id
JOIN FORNECEDORES f ON f.id_fornecedor = p.fornecedor_id
WHERE strftime('%Y', v.data_venda) = '2020'
GROUP BY Fornecedor
ORDER BY COUNT(*) DESC
LIMIT 1;

--06
SELECT COUNT(*) AS Qtd_Vendas, strftime('%Y', v.data_venda) AS Ano, f.nome AS Fornecedor
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN PRODUTOS p ON p.id_produto = iv.produto_id
JOIN FORNECEDORES f ON f.id_fornecedor = p.fornecedor_id
WHERE Ano = '2020'
GROUP BY Fornecedor
ORDER BY COUNT(*) DESC
LIMIT 1
;


--07-
SELECT COUNT(*) AS Qtd_Vendas, c.nome_categoria AS Categoria
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN PRODUTOS p ON p.id_produto = iv.produto_id
JOIN CATEGORIAS c ON c.id_categoria = p.categoria_id
GROUP BY Categoria
ORDER BY COUNT(*) DESC
LIMIT 2;


--08
SELECT "Ano/M�s",
SUM(CASE WHEN Categoria=='Eletr�nicos' THEN Qtd_Vendas ELSE 0 END) AS Eletr�nicos,
SUM(CASE WHEN Categoria=='Vestu�rio' THEN Qtd_Vendas ELSE 0 END) AS Vestu�rio
FROM(
    SELECT COUNT(*) AS Qtd_Vendas, strftime('%Y/%m', v.data_venda) AS "Ano/M�s", c.nome_categoria AS Categoria
    FROM itens_venda iv
    JOIN vendas v ON v.id_venda = iv.venda_id
    JOIN PRODUTOS p ON p.id_produto = iv.produto_id
    JOIN CATEGORIAS c ON c.id_categoria = p.categoria_id
    WHERE Categoria IN ('Eletr�nicos', 'Vestu�rio')
    GROUP BY "Ano/M�s", Categoria
    ORDER BY "Ano/M�s", Categoria
)
GROUP BY "Ano/M�s"
;


--09
WITH Total_Vendas AS (
SELECT COUNT(*) as Total_Vendas_2022
From itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
WHERE strftime('%Y', v.data_venda) = '2022'
)
SELECT Nome_Categoria, Qtd_Vendas, ROUND(100.0*Qtd_Vendas/tv.Total_Vendas_2022, 2) || '%' AS Porcentagem
FROM(
  SELECT c.nome_categoria AS Nome_Categoria, COUNT(iv.produto_id) AS Qtd_Vendas
  from itens_venda iv
  JOIN vendas v ON v.id_venda = iv.venda_id
  JOIN produtos p ON p.id_produto = iv.produto_id
  JOIN categorias c ON c.id_categoria = p.categoria_id
  WHERE strftime('%Y', v.data_venda) = '2022'
  GROUP BY Nome_Categoria
  ORDER BY Qtd_Vendas DESC
  ), Total_Vendas tv
;



--12
--Desafio: crie outras m�tricas e elabore mais o seu relat�rio
--PR�XIMA ATIVIDADE

--Para dar suporte ao time de neg�cios, n�s criamos uma m�trica que calcula a porcentagem de vendas e ela j� ser� bem �til para eles.
--E no nosso relat�rio inclu�mos compara��o de vendas entre os principais fornecedores, a porcentagem de vendas das categorias e
--identificamos uma sazonalidade nas vendas comparando os �ltimos anos de dados.

--Aqui proponho para voc� um desafio, voc� j� � um especialista nesse projeto e pode criar mais an�lises e m�tricas, atacando partes
--n�o exploradas como marcas, categorias e o que mais voc� entender que faz sentido para o nosso relat�rio e para a �rea de neg�cios.

--Opini�o do instrutor

--Depois que fizer isso, n�o esque�a de compartilhar seus resultados l� na comunidade no Discord ou no LinkedIn marcando a Alura.