--Transcri��o
--Conseguimos participar da reuni�o e atendemos muito bem a demanda do time de neg�cios, mas ficou uma tarefa pendente. Precisamos trazer uma informa��o para eles, relacionada ao fornecedor que teve a pior performance na �ltima Black Friday.

--Eles querem a informa��o desse fornecedor ao longo de todo o tempo que temos registrado, para poderem argumentar junto ao fornecedor sobre sua performance e negociar pre�os melhores. Ent�o, queremos fornecer esse recurso de dados para os argumentos do time de neg�cios.

--Dever de casa
--De volta ao SQLite Online, podemos copiar a consulta que fizemos durante a reuni�o, onde consegu�amos calcular a performance dos fornecedores, e execut�-la.

--SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
--FROM itens_venda iv
--JOIN vendas v ON v.id_venda = iv.venda_id
--JOIN produtos p ON p.id_produto = iv.produto_id
--JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--GROUP BY Nome_Fornecedor, "Ano/Mes"
--ORDER BY "Ano/Mes", Qtd_Vendas
--;
--COPIAR C�DIGO
--Visualiza��o dos cinco primeiros registros da tabela. Para visualiz�-la na �ntegra, execute a consulta na sua m�quina.

--Ano/Mes	Nome_Fornecedor	Qtd_Vendas
--2020/01	OceanicOrigins	170
--2020/01	NebulaNetworks	193
--2020/01	PinnaclePartners	195
--2020/01	TerraTrade	204
--2020/01	InfinityImports	213
--A consulta mostra v�rios fornecedores e queremos focar apenas naquele que teve a pior performance na �ltima Black Friday, que ocorreu em 2022 no m�s de novembro. Os dados est�o ordenados do menor para o maior, ent�o procuramos pelo primeiro com a data 2022/11.

--Em 2022, no m�s 11, o fornecedor com menor n�mero de vendas durante a Black Friday foi a NebulaNetworks. Essa foi a informa��o que passamos na reuni�o e estava correta.

--Criando a nova consulta
--Vamos copiar o nome da NebulaNetwork e come�ar a criar uma consulta. Na consulta existente, que calcula, ao longo do tempo, cada fornecedor, queremos fazer um filtro.

--Ap�s o �ltimo JOIN, vamos digitar o comando WHERE seguido do nome do fornecedor (Nome_Fornecedor). Queremos que ele seja igual a "NebulaNetworks". Dessa maneira, a consulta trar� apenas os dados do fornecedor NebulaNetworks.

--SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
--FROM itens_venda iv
--JOIN vendas v ON v.id_venda = iv.venda_id
--JOIN produtos p ON p.id_produto = iv.produto_id
--JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--WHERE Nome_Fornecedor="NebulaNetworks"
--GROUP BY Nome_Fornecedor, "Ano/Mes"
--ORDER BY "Ano/Mes", Qtd_Vendas
--;
--COPIAR C�DIGO
--Ao executar a consulta, verificamos que o nome do fornecedor se repete v�rias vezes na tabela e foram trazidos menos dados, pois agora falamos apenas de um fornecedor.

--A ordena��o come�a em 2020 e vai at� 2023, mas os meses est�o um pouco embaralhados. Se observarmos 2023, come�amos no m�s 1, passamos pelos meses 2, 3, 4 e vamos at� o m�s 9, pois essa Black Friday ainda n�o aconteceu no ano de 2023.

--Na tabela, temos o ano da venda, o m�s, o nome do fornecedor e a quantidade de vendas. A quantidade de vendas � um valor importante, pois ser� usado para argumenta��o. No entanto, o nome do fornecedor � uma informa��o que se repete. Precisamos dessa informa��o no CSV? Acreditamos que n�o!

--Vamos ajustar a consulta. No local onde defin�amos o apelido Nome_Fornecedor, vamos copiar f.nome, apagar essa coluna da consulta, e no local onde fazemos o WHERE, vamos usar f.nome em vez de Nome_Fornecedor. Da mesma forma, colocaremos f.nome onde fazemos o agrupamento (GROUP BY).

--SELECT strftime("%Y/%m", v.data_venda) AS "Ano/Mes", COUNT(iv.produto_id) AS Qtd_Vendas
--FROM itens_venda iv
--JOIN vendas v ON v.id_venda = iv.venda_id
--JOIN produtos p ON p.id_produto = iv.produto_id
--JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
--WHERE f.nome="NebulaNetworks"
--GROUP BY f.nome, "Ano/Mes"
--ORDER BY "Ano/Mes", Qtd_Vendas
--;
--COPIAR C�DIGO
--Ao executar a consulta novamente, temos a seguinte visualiza��o:

--Visualiza��o dos cinco primeiros registros da tabela. Para visualiz�-la na �ntegra, execute a consulta na sua m�quina.

--Ano/Mes	Qtd_Vendas
--2020/01	193
--2020/02	90
--2020/03	96
--2020/04	106
--2020/05	165
--A ordena��o ajuda o time da �rea de neg�cios a argumentar. Eles conseguem acompanhar desde 2020, no primeiro m�s, com 193 vendas, at� a venda mais recente, em outubro de 2023, com 139 vendas. Assim, o time pode argumentar e verificar essas datas-chave.

--Embora sejam fornecidas todas essas informa��es para conversarem sobre outros meses, se o time quiser focar apenas na Black Friday, estar�o listados os meses para encontrar. Por exemplo: em novembro de 2021 (2021/11) foram 455 vendas, e em novembro de 2020 (2022/11) foram 307.

--Fornecendo a informa��o
--Acreditamos que, com essa informa��o, conseguimos atender a demanda de tarefa pendente, deixada para n�s na reuni�o. Agora, precisamos fornecer essa informa��o para eles.

--Para extrairmos uma informa��o do SQLite Online, transform�-la em uma consulta e fornecer para outra pessoa, uma das maneiras � clicando no bot�o "Export" na barra de menu superior.

--No centro da barra, encontramos esse bot�o chamado "Export" que oferece algumas op��es: "CSV", "XML", "JSON" e "SQL Schema". Estamos interessados no CSV.

--Ao clicar nessa op��o, � aberta uma janela, onde informa que o tipo do arquivo ser� CSV, que o delimitador ser� uma v�rgula, que o escape ser� aspas duplas, e o campo "Column name" est� definido como "none".

--Este � o campo que queremos que voc� preste aten��o, porque, dessa maneira, ele n�o especifica o nome das colunas. Vamos alterar de "none" para "First line". Assim, na primeira linha do CSV, ser� informado "Ano/Mes" e "Qtd_Vendas". Quem acessar esse CSV, facilmente saber� do que se trata.

--Ao confirmar, ele pergunta onde queremos salvar. Podemos criar uma pasta de "outputs" e nomear o arquivo como NebulaNetworks_vendas.csv. Salvamos essa informa��o, ela est� no nosso computador, e agora podemos encaminhar por e-mail para todos que participaram da reuni�o. Assim, eles ter�o essa informa��o e quem for negociar ter� argumentos baseados em dados.

--Conclus�o
--Estamos felizes que conseguimos responder � reuni�o e atender � demanda dela! Agora estamos prontos para come�ar a construir nosso relat�rio.

--Chegamos nesse projeto com o intuito de criar um relat�rio que vai guiar as decis�es da Black Friday. � isso que queremos fazer agora: explorar esses dados e decidir quais informa��es s�o importantes para colocar no relat�rio ou n�o.

--At� mais!