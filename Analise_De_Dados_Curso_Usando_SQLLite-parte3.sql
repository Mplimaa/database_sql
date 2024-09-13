--Para saber mais: documenta��o das suas consultas e organiza��o
--PR�XIMA ATIVIDADE

--A documenta��o de c�digo � uma pr�tica fundamental no desenvolvimento de software e na an�lise de dados. Coment�rios eficazes em consultas SQL facilitam o entendimento do c�digo, a manuten��o e a colabora��o entre equipes.

--No SQLite, assim como em outros sistemas de gerenciamento de banco de dados, voc� pode adicionar coment�rios para explicar o prop�sito de uma consulta, as raz�es por tr�s de uma abordagem espec�fica ou detalhes importantes sobre os dados.

--Exemplo de Consulta SQL com Coment�rios e Organiza��o Apropriada:

--Contexto da Consulta:

--Suponha que temos um banco de dados de uma biblioteca com tabelas livros e emprestimos. Queremos descobrir os livros mais emprestados no �ltimo ano.

--Consulta SQL com Coment�rios:

---- Consulta para encontrar os livros mais emprestados no �ltimo ano
--SELECT 
--    l.titulo AS TituloLivro,               -- Seleciona o t�tulo do livro
--    COUNT(e.id_livro) AS QtdEmprestimos    -- Conta o n�mero de vezes que cada livro foi emprestado
--FROM 
--    emprestimos e
--    JOIN livros l ON e.id_livro = l.id     -- Junta a tabela de empr�stimos com a tabela de livros
--WHERE 
--    e.data_emprestimo >= '2022-01-01'      -- Filtra os empr�stimos do �ltimo ano
--GROUP BY 
--    l.titulo                               -- Agrupa os resultados pelo t�tulo do livro
--ORDER BY 



--    QtdEmprestimos DESC                    -- Ordena os livros pelo n�mero de empr�stimos, do mais ao menos emprestado
--LIMIT 10;                                  -- Limita os resultados aos 10 livros mais emprestados
--COPIAR C�DIGO
--Import�ncia dos Coment�rios:

--Clareza: Os coment�rios ajudam a explicar o prop�sito e a l�gica de cada parte da consulta, tornando-a mais acess�vel.
--Manuten��o: Documentar consultas SQL facilita futuras altera��es ou corre��es, especialmente em projetos colaborativos ou de longo prazo.
--Colabora��o: Coment�rios claros permitem que outros membros da equipe entendam rapidamente suas consultas, facilitando a colabora��o.



--08 Fa�a como eu fiz
--PR�XIMA ATIVIDADE

--Voc� est� prestes a participar de uma importante reuni�o de neg�cios onde a an�lise de dados desempenha um papel central. Neste cen�rio, suas habilidades em SQL s�o fundamentais para responder a perguntas cruciais e fornecer insights valiosos para o time de neg�cios. O desafio se divide em tr�s partes:

--Prepara��o para a Reuni�o: Aqui, voc� transformar� as pautas da reuni�o em consultas SQL.
--Participa��o Ativa na Reuni�o: Durante a reuni�o, voc� usar� suas consultas para responder questionamentos em tempo real.
--Dever de Casa: Ap�s a reuni�o, voc� concluir� uma tarefa pendente baseada nas discuss�es.


--Transforme as seguintes pautas em consultas SQL:

--Papel dos Fornecedores na Black Friday
--Consulta SQL:

---- Calcula o total de vendas de cada fornecedor na Black Friday
--SELECT SUM(Qtd_Vendas)
--FROM(
--    SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
--    FROM itens_venda iv
--    JOIN vendas v ON v.id_venda = iv.venda_id
--    JOIN produtos p ON p.id_produto = iv.produto_id
--    JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--    GROUP BY Nome_Fornecedor, "Ano/Mes"
--    ORDER BY "Ano/Mes", Qtd_Vendas
--);
--COPIAR C�DIGO
--Explica��o: Esta consulta destaca o desempenho dos fornecedores durante a Black Friday, permitindo uma an�lise detalhada das vendas por fornecedor nesse per�odo cr�tico de vendas.

--Categorias de Produtos na Black Friday
--Consulta SQL:

---- Analisa as vendas por categoria de produtos na Black Friday
--SELECT strftime("%Y", v.data_venda) AS "Ano", c.nome_categoria AS Nome_Categoria, COUNT(iv.produto_id) AS Qtd_Vendas
--FROM itens_venda iv
--JOIN vendas v ON v.id_venda = iv.venda_id
--JOIN produtos p ON p.id_produto = iv.produto_id
--JOIN categorias c ON c.id_categoria = p.categoria_id
--WHERE strftime("%m", v.data_venda) = "11"
--GROUP BY Nome_Categoria, "Ano"
--ORDER BY "Ano", Qtd_Vendas DESC;
--COPIAR C�DIGO
--Explica��o: Esta consulta fornece uma vis�o clara de quais categorias de produtos foram mais populares durante a Black Friday, organizadas por ano e quantidade de vendas.

--Durante a Reuni�o

--Valida��o das Consultas:

---- Valida��o da consist�ncia das vendas registradas
--SELECT SUM(Qtd_Vendas)
--FROM(
--    SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
--    FROM itens_venda iv
--    JOIN vendas v ON v.id_venda = iv.venda_id
--    JOIN produtos p ON p.id_produto = iv.produto_id
--    JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--    GROUP BY Nome_Fornecedor, "Ano/Mes"
--    ORDER BY "Ano/Mes", Qtd_Vendas
--);
--COPIAR C�DIGO
--Explica��o: Esta consulta serve para validar a quantidade de vendas registradas, garantindo a precis�o dos dados apresentados.

--Dever de Casa

--An�lise de Desempenho do Fornecedor:

---- An�lise da performance de vendas do fornecedor "NebulaNetworks" ao longo do tempo
--SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", COUNT(iv.produto_id) AS Qtd_Vendas
--FROM itens_venda iv
--JOIN vendas v ON v.id_venda = iv.venda_id
--JOIN produtos p ON p.id_produto = iv.produto_id
--JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--WHERE f.nome="NebulaNetworks"
--GROUP BY "Ano/Mes"
--ORDER BY "Ano/Mes", Qtd_Vendas;
--COPIAR C�DIGO
--Explica��o: Ap�s identificar o fornecedor com menor desempenho em vendas, essa consulta permite avaliar como foi a performance dele ao longo dos anos, dando insights para estrat�gias futuras.

-- DISCUTIR NO F�RUM
--PR�XIMA ATIVIDADE

