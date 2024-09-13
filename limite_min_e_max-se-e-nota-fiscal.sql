--Construiremos um programa em T-SQL para pegar uma sequ�ncia de n�meros inteiros desde um limite m�nimo a um limite m�ximo. 
--Em seguida, ele ir� e percorrer esses n�meros e verificar se eles correspondem a uma nota fiscal na base de dados SUCOS_VENDAS. 
--Portanto � importante estarmos conectados e conectadas � base SUCOS_VENDAS.

DECLARE @LIMITE_MINIMO INT, @LIMITE_MAXIMO INT

--gravar o resultado da declara��o @LIMITE_MINIMO e @LIMITE_MAXIMO na vari�vel tabela.
DECLARE @TABELA_NUMEROS TABLE ([NUMERO] INT, [STATUS] VARCHAR(200))
DECLARE @CONTADOR_NOTAS INT

--inicializar limite minimo e maximo
SET @LIMITE_MINIMO = 1
SET @LIMITE_MAXIMO = 1000000

--nao aparecer inclusoes e resultados
SET NOCOUNT ON

WHILE @LIMITE_MINIMO <= @LIMITE_MAXIMO
BEGIN
	SELECT @CONTADOR_NOTAS = COUNT(*) FROM [dbo].[NOTAS FISCAIS] WHERE NUMERO = @LIMITE_MINIMO
	IF @CONTADOR_NOTAS > 0 
		BEGIN
			INSERT INTO @TABELA_NUMEROS (NUMERO, STATUS) VALUES (@LIMITE_MINIMO, '� NOTA FISCAL')
		END
	ELSE
		BEGIN 
			INSERT INTO @TABELA_NUMEROS (NUMERO, STATUS) VALUES (@LIMITE_MINIMO, 'N�O � NOTA FISCAL')
		END
	
	SET @LIMITE_MINIMO = @LIMITE_MINIMO + 1
END
SELECT * FROM @TABELA_NUMEROS ORDER BY NUMERO

--SELECT MIN(NUMERO), MAX(NUMERO) FROM [dbo].[NOTAS FISCAIS]
