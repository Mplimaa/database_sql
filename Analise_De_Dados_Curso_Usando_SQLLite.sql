--anscri��o
--J� nos preparamos para a reuni�o trimestral da Zoop Megastore. Pegamos as pautas da reuni�o, as poss�veis d�vidas que surgiriam, e preparamos as consultas (queries) para responder com agilidade qualquer questionamento. Agora que estamos preparados, vamos para a reuni�o?

--Respondendo d�vidas
--Igor: Ol�, Mirla. Tudo bem? Sou o Igor, do time de an�lise de dados. Recebemos uma demanda do comercial sobre algumas d�vidas para a Black Friday deste ano. � isso mesmo?

--Mirla: Perfeito, Igor. Exatamente. Estamos come�ando a tomar decis�es estrat�gicas para a nossa Black Friday, e para tomar essas decis�es, vamos precisar de algumas respostas suas quanto aos dados que temos referentes � �ltima Black Friday que aconteceu no ano passado.

--Vamos come�ar trazendo algumas perguntas em rela��o aos fornecedores. Gostar�amos de saber, para ter uma prioridade, quais foram os fornecedores que mais venderam, que mais trouxeram renda para n�s na �ltima Black Friday. Voc� consegue nos informar?

--Igor: Claro, preparamos algumas consultas j� focadas nos fornecedores. Vou fazer uma pequena modifica��o para aplicar um filtro devido � quest�o da Black Friday.

--Vamos acessar a consulta e digitar o comando WHERE na linha 8 para aplicar o filtro. Como estamos falando de m�s, precisaremos usar o strftime(), recebendo a especifica��o do m�s (%m") entre aspas duplas. Em seguida, vamos acessar a data da venda entre par�nteses (v.data_venda).

--Acessando o m�s, j� conseguimos aplicar o filtro na Black Friday do �ltimo ano, que ser� o m�s de novembro. Ent�o, podemos adicionar ao final = "11".

--banco_de_dados.db:

--SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
--FROM itens_venda iv
--JOIN vendas v ON v.id_venda = iv.venda_id
--JOIN produtos p ON p.id_produto = iv.produto_id
--JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--WHERE strftime("%m", v.data_venda) = "11"
--GROUP BY Nome_Fornecedor, "Ano/Mes"
--ORDER BY "Ano/Mes", Qtd_Vendas
--;
--COPIAR C�DIGO
--Ap�s selecionar e executar essa consulta, j� conseguimos responder.

--Na �ltima Black Friday, voc� quer saber quem vendeu mais, certo? Os dois fornecedores que se destacaram na Black Friday de 2022 foram a AstroSupply, com 1.830 vendas, e a HorizonDistributors, com 1.735 vendas. Estes foram os destaques da �ltima Black Friday.

--Mirla: Nas conversas que tivemos no setor, surgiu a informa��o de que provavelmente o NebulaNetworks teve um desempenho inferior na �ltima Black Friday. Gostar�amos de confirmar se realmente foi o NebulaNetworks que menos vendeu na �ltima Black Friday.

--Igor: Podemos confirmar. Nessa mesma tabela, como a ordena��o vai do menor para o maior, conseguimos ir no primeiro registro de 2022, no m�s 11, e confirmar que foram eles. O NebulaNetworks teve 529 vendas. Portanto, foi uma performance bem abaixo, se compararmos com as melhores.

--Mirla: Tamb�m estamos planejando algumas categorias que queremos colocar na p�gina inicial para torn�-la mais atraente. Voc� consegue nos informar quais delas venderam mais na �ltima Black Friday para tomarmos essa prioridade?

--Igor: Podemos fazer isso. Temos uma consulta que retorna as mesmas informa��es, mas do ponto de vista das categorias. Consigo aplicar um filtro semelhante para focar na Black Friday.

--Ap�s o �ltimo JOIN, vamos adicionar o mesmo WHERE strftime() utilizado anteriormente.

--SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", c.nome_categoria AS Nome_Categoria, COUNT(iv.produto_id) AS Qtd_Vendas
--FROM itens_venda iv
--JOIN vendas v ON v.id_venda = iv.venda_id
--JOIN produtos p ON p.id_produto = iv.produto_id
--JOIN categorias c ON c.id_categoria = p.categoria_id
--WHERE strftime("%m", v.data_venda) = "11"
--GROUP BY Nome_Categoria, "Ano/Mes"
--ORDER BY "Ano/Mes", Qtd_Vendas
--;
--COPIAR C�DIGO
--Ap�s executar a consulta em "Run", ele traz o mesmo formato, mas agora com menos linhas, porque temos cinco categorias contra os dez fornecedores que t�nhamos.

--Olhando para 2022, temos cinco resultados para novembro. Vendemos mais nas categorias de eletr�nicos e vestu�rio, sendo "Eletr�nicos" com 2.808 vendas e "Vestu�rio" com 2.609 vendas. Esses foram os dois destaques de categoria na �ltima Black Friday.

--Mirla: �timo! Para fechar o planejamento, voc� consegue me informar quais dessas categorias menos venderam?

--Igor: Consigo. A categoria que teve menos venda foi a de "Livros", com 1.407 vendas. Por�m, para deix�-la bem informada, existiu uma proximidade no n�mero de vendas tanto em "Alimentos" quanto em "Esportes", respectivamente, 1.425 e 1.454. Ent�o, por mais que "Livros" tenha sido a que menos vendeu, ela est� bem pr�xima a essas outras duas categorias.

--Mirla: Isso vai me ajudar muito! Ainda h� um ponto antes de encerrar. Voc� falou da NebulaNetworks e me veio a ideia de conversar com esse fornecedor, mas gostar�amos de levar dados para mostrar o desempenho de vendas deles, at� para negociar novos valores.

--Voc� consegue trazer esse conjunto de dados para levarmos a eles?

--Igor: Sim, temos acesso a essa informa��o, mas n�o preparamos uma consulta para isso. Precisar�amos pensar com calma, montar essa consulta. Podemos fornecer esses dados posteriormente por e-mail?

--Mirla: Esses dados est�o realmente atualizados, certo?

--Igor: � uma boa pergunta, Mirla. Vou confirmar junto com voc�. A partir das nossas an�lises, sabemos que o total de vendas nesses �ltimos anos deu 150 mil itens. Ent�o, conseguimos usar essa consulta para fazer uma valida��o.

--Na parte dos dados dos fornecedores, vamos remover o filtro para novembro para considerar todo o ano, e vamos transformar essa consulta em uma sub consulta. Para isso, selecionamos a consulta e apertamos "Tab" para indent�-la � direita.

--Em seguida, vamos digitar o comando FROM na primeira linha, abrir par�nteses e colocar a sub consulta.

--FROM (
--  SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id)   AS Qtd_Vendas
--  FROM itens_venda iv
--  JOIN vendas v ON v.id_venda = iv.venda_id
--  JOIN produtos p ON p.id_produto = iv.produto_id
--  JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--  GROUP BY Nome_Fornecedor, "Ano/Mes"
--  ORDER BY "Ano/Mes", Qtd_Vendas
--)
--;
--COPIAR C�DIGO
--Agora podemos executar essa consulta e somar a quantidade de itens vendidos, j� que temos todos os itens. Assim, vamos obter os 150 mil itens vendidos. Para isso, vamos adicionar o comando SELECT ao in�cio da consulta e fazer um SUM() da quantidade de vendas (Qtd_Vendas).

--SELECT SUM(Qtd_Vendas)
--FROM (
--  SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id)   AS Qtd_Vendas
--  FROM itens_venda iv
--  JOIN vendas v ON v.id_venda = iv.venda_id
--  JOIN produtos p ON p.id_produto = iv.produto_id
--  JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--  GROUP BY Nome_Fornecedor, "Ano/Mes"
--  ORDER BY "Ano/Mes", Qtd_Vendas
--)
--;
--COPIAR C�DIGO
--Ap�s selecionar a consulta e apertar "Run", � retornado o valor de 150.034 vendas. Sendo assim, os dados est�o atualizados, Mirla, pode ficar tranquila!

--Mirla: Perfeito, Igor. Agora que temos essa confian�a de que os dados realmente est�o atuais, vamos ficar no aguardo de voc� mandar esse conjunto de dados, certo?

--At� a pr�xima. Muito obrigada pelo seu tempo!

--Igor: Obrigado, Mirla. Tchau!

--Conclus�o
--Conseguimos fazer a reuni�o com a Mirla da �rea de neg�cios e foi uma reuni�o muito produtiva. Respondemos os principais questionamentos dela usando as consultas que preparamos. Foi uma conversa bem �gil, onde conseguimos trazer dados e informa��es para ela tomar decis�es para a Black Friday.

--Um ponto importante � que uma das demandas exigia uma consulta mais elaborada que precis�vamos construir para falar do fornecedor da NebulaNetwork e como foi a performance dela ao longo desses anos.

--Isso ficou como tarefa para n�s e vamos resolv�-la daqui a pouco!