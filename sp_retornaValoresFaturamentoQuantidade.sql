--DECLARE @CPF AS VARCHAR (12) = '19290992743'
--DECLARE @ANO AS INT = 2017
--DECLARE @NUM_NOTAS AS INT 
--DECLARE @FATURAMENTO AS FLOAT

--SELECT @NUM_NOTAS = COUNT(*) FROM [NOTAS FISCAIS]
--WHERE CPF = @CPF AND YEAR([DATA]) = @ANO

--SELECT @FATURAMENTO = SUM(INF.QUANTIDADE * INF.[PRE�O])
--FROM [ITENS NOTAS FISCAIS] INF
--	JOIN [NOTAS FISCAIS] NF
--		ON NF.NUMERO=INF.NUMERO
--WHERE NF.CPF = @CPF AND YEAR(NF.[DATA]) = @ANO

--SELECT @NUM_NOTAS AS NOTAS, @FATURAMENTO AS FATURAMENTO
ALTER  PROCEDURE retornaValoresFaturamentoQuantidade	
@CPF AS VARCHAR	(12), @ANO AS INT, @NUM_NOTAS AS INT OUTPUT, @FATURAMENTO AS FLOAT OUTPUT
AS
BEGIN

SELECT @NUM_NOTAS = COUNT(*) FROM [NOTAS FISCAIS]
WHERE CPF = @CPF AND YEAR([DATA]) = @ANO

SELECT @FATURAMENTO = SUM(INF.QUANTIDADE * INF.[PRE�O])
FROM [ITENS NOTAS FISCAIS] INF
	JOIN [NOTAS FISCAIS] NF
		ON NF.NUMERO=INF.NUMERO
WHERE NF.CPF = @CPF AND YEAR(NF.[DATA]) = @ANO
END

DECLARE @NUM_NOTAS INT
DECLARE @FATURAMENTO FLOAT

set @NUM_NOTAS = 0
SET @FATURAMENTO = 0

SELECT @NUM_NOTAS AS NOTAS, @FATURAMENTO AS FATURAMENTO

EXEC retornaValoresFaturamentoQuantidade @CPF='19290992743',@ANO=2017,
@NUM_NOTAS=@NUM_NOTAS OUTPUT,  @FATURAMENTO=@FATURAMENTO OUTPUT
--AS VARI�VEIS CPF E ANO S�O PASSADAS COMO VALOR
--OUTPUT PASSA AS VARI�VEIS COMO REFERENCIA
SELECT @NUM_NOTAS, @FATURAMENTO


SP_CONFIGURE