--Criaremos uma nova consulta e come�aremos declarando duas vari�veis: @NOME, do tipo VARCHAR de 200, e @ENDERECO, 
--do tipo VARCHAR de valor interno m�ximo permitido.
--Em seguida, declaramos nosso CURSOR, que chamaremos de CURSOR1, e fazemos a sele��o de NOME, que ser� uma concatena��o
--dos dados ENDERECO 1, BAIRRO, CIDADE, o texto , CEP e a informa��o CEP. Esses campos todos chamaremos de ENDCOMPLETO.

--Executando somente a consulta SELECT NOME, ([ENDERECO 1], + ' ' + BAIRRO + ' ' + CIDADE + ' ' + ESTADO + ', CEP: ' + CEP) 
--ENDCOMPLETO FROM [TABELA DE CLIENTES] teremos como retorno duas colunas: a de nome e a de endere�o completo:
--Desta forma, o conte�do do campo NOME ir� para @NOME, e o conte�do de ENDCOMPLETO, para @ENDERECO.

--Agora, inclu�mos o mesmo la�o de repeti��o que fizemos no exemplo anterior. A diferen�a estar� apenas no que deve ser
--impresso, pois optaremos por imprimir a vari�vel @NOME, seguida do texto , Endere�o: e da vari�vel @ENDERECO:
--Por fim, usaremos CLOSE e DEALLOCATE:
--Executando o c�digo, receberemos os dados organizados da seguinte forma: nome, seguido do texto "Endere�o:" e do endere�o completo.
DECLARE @NOME VARCHAR(200)
DECLARE @ENDERECO VARCHAR(MAX)

DECLARE CURSOR1 CURSOR FOR
SELECT
NOME, 
([ENDERECO 1] + ' ' + BAIRRO + ' ' + CIDADE + ' ' + ESTADO + ', CEP: ' + CEP) as ENDCOMPLETO
FROM [TABELA DE CLIENTES] --select * from [TABELA DE CLIENTES]
OPEN CURSOR1
FETCH NEXT FROM CURSOR1 INTO @NOME, @ENDERECO
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @NOME + ', Endere�o: ' + @ENDERECO
    FETCH NEXT FROM CURSOR1 INTO @NOME, @ENDERECO
END
CLOSE CURSOR1
DEALLOCATE CURSOR1