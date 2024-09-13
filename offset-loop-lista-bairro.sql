--SELECT BAIRRO
--FROM [TABELA DE CLIENTES]
--WHERE CIDADE = 'Rio de Janeiro'
--ORDER BY BAIRRO
--OFFSET 3 ROWS
--FETCH NEXT 1 ROWS ONLY;

--adapte a fun��o criada neste v�deo, por�m o par�metro inicial ser� uma cidade e iremos listar 
--todos os bairros desta cidade, um a um, dentro do loop, gravando na tabela de sa�da o nome do
--bairro (Em vez do n�mero da nota e o status se � nota ou n�o, como mostrado no v�deo da aula).
--Observa��o: O contador do OFFSETcome�a no zero.

--Inicialmente, declaramos uma vari�vel para receber o bairro e a cidade:
DECLARE @BAIRRO VARCHAR(50), @CIDADE VARCHAR(50)

--Depois mais duas vari�veis: a primeira para receber o contador que vai come�ar
-- no zero e percorrer at� o n�mero total de bairros, e outra com este n�mero total de bairros:
DECLARE @CONTADOR INT, @LINHAS_BAIRRO INT

--Em seguida, a tabela que vai receber a resposta com a lista de bairros:
DECLARE @TABELA_BAIRROS TABLE ([BAIRRO] VARCHAR(50))

--Inicializamos a cidade e o contador:
SET @CIDADE = 'Rio de Janeiro'
SET @CONTADOR = 0

--Obtemos o n�mero total de bairros para a cidade:
SELECT @LINHAS_BAIRRO = COUNT(*) FROM (
SELECT DISTINCT BAIRRO FROM [TABELA DE CLIENTES]
WHERE CIDADE = @CIDADE) X

--Fazemos o Loop para percorrer todas as cidades. Lembrando que o contador come�a no zero
--e vai terminar em @LINHAS_BAIRRO - 1, como podemos verificar abaixo:
WHILE @CONTADOR < @LINHAS_BAIRRO
BEGIN
    SELECT DISTINCT @BAIRRO = BAIRRO FROM [TABELA DE CLIENTES]
    WHERE CIDADE = @CIDADE
    ORDER BY BAIRRO
    OFFSET @CONTADOR ROWS
    FETCH NEXT 1 ROWS ONLY
INSERT INTO @TABELA_BAIRROS (BAIRRO) VALUES (@BAIRRO)
SET @CONTADOR = @CONTADOR + 1
END


SELECT * FROM @TABELA_BAIRROS ORDER BY BAIRRO

