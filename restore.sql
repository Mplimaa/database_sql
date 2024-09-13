--No v�deo anterior fizemos o backup da nossa base de dados em determinados dias. Nesse v�deo, entenderemos como recuperar esses backups.

--Recuperando backups
--Voltando para o Management Studio, onde criaremos uma nova consulta conectada � base dbVendas. Nela colaremos o seguinte c�digo para recuperarmos o backup:

RESTORE HEADERONLY FROM DISK = 'F:\DATA\BACKUP\DBVENDAS_3.BAK';

USE MASTER
DROP DATABASE dbVendas
RESTORE DATABASE dbVendas FROM DISK = 'F:\DATA\BACKUP\DBVENDAS_3.BAK' WITH RECOVERY;

--Criando uma nova entrada
--Como o �ltimo backup que salvamos foi o DBVENDAS_3.BAK, onde inclu�mos as notas fiscais do dia 02/03/2022, antes de recuperarmos esse backup, incluiremos notas para o dia 03/05/2022. Ent�o, antes do c�digo acima, escreveremos EXEC IncluiNotasDia '2022-03-03' e executaremos essa linha.
--Em seguida, podemos executar o SELECT COUNT(*) FROM tb_nota para descobrir quantas notas temos agora, no caso, 3564. Aproveitamos para anotar esse valor em forma de coment�rio, como fizemos na aula anterior.

EXEC IncluiNotasDia '2022-03-03'
SELECT COUNT(*) FROM tb_nota
-- 3564

--c�digo omitido


--Digamos que nesse dia 03, tivemos um problema na pasta e o pessoal do sistema avisa para o Marcos que ele precisa recuperar o backup anterior aos dados do dia 03, ou seja, o DBVENDAS_3.BAK. Como o Marcos far� isso?

--Analisando o �ltimo backup
--Primeiramente Marcos ir� verificar o que existe nesse arquivo de backup, rodando a linha com o comando RESTORE HEADERONLY, usando o FROM DISK para passar o caminho completo do arquivo de backup:

--Ao executarmos o c�digo RESTORE HEADERONLY FROM DISK = 'F:\DATA\BACKUP\DBVENDAS_3.BAK';, temos como retorno uma tabela com apenas uma linha de dados. Nela vemos que o tipo de backup (BackupType) � 1, ou seja, backup full (backup completo). Avan�ando para direita, temos tamb�m os dados de quando o backup foi iniciado (StartDate) e quando foi finalizado (FinishDate).

--Saindo da base de dados
--Para recuperarmos esse backup, precisamos sair da base dbVendas primeiro e n�o ter nenhuma pessoa usu�ria conectada � base. No momento, eu tenho algumas abas abertas no Management Studio, al�m da consulta atual. Cada uma dessas janelas est� conectada com a base dbVendas.

--Portanto, nosso primeiro passo ser� sair da base dbVendas, rodando a linha de comando USE MASTER. Dessa forma, fomos para base Master.

--Excluindo a base de dados


--Excluindo a base de dados
--Em seguida, vamos excluir a base dbVendas. Por�m, ao inv�s de executarmos a linha de comando DROP DATABASE dbVendas manualmente, faremos a execu��o atrav�s do Management Studio.

--Isso porque, para rodarmos o comando DROP DATABASE dbVendas, primeiramente precisar�amos fechar todas as janelas que est�o conectadas ao banco de dados. Dessa forma, seria como se desconect�ssemos todas as se��es conectadas ao dbVendas.

--Antes disso, executaremos o DROP DATABASE pelo Management Studio. Isso porque, clicando com o bot�o direito do mouse sobre o banco "dbVendas" e selecionando a op��o "Excluir", na parte inferior da janela que se abre temos a op��o "Fechar conex�es existentes".

--Marcaremos a caixa de sele��o dessa op��o, todas as conex�es ser�o desligadas no momento em que apagarmos a base de dados dbVendas. Em seguida, clicamos no bot�o "OK", no canto inferior direito da janela.

--Feito isso, nossa base de dados desaparece, tanto da barra lateral esquerda no Management Studio, quanto das pastas "LOG_TRANSACOES" e "ARQUIVO_DADOS", no nosso computador.

--Restaurando o backup
--Nosso pr�ximo passo ser� restaura o backup, executando:

RESTORE DATABASE dbVendas FROM DISK = 'F:\DATA\BACKUP\DBVENDAS_3.BAK' WITH RECOVERY;


--Nessa linha temos o comando RESTORE DATABASE, seguido do nome do banco de dados. Tamb�m temos o FROM DISK com o caminho completo do backup. Por fim, temos a cl�usula WITH RECOVERY, que � muito importante.

--Vamos supor que nossa base de dados est� sendo usada e tiramos um backup. Pode ser que no momento em que o backup esteja acontecendo, tamb�m tenhamos transa��es sendo executadas, portanto essas transa��es n�o ser�o salvas no backup.

--Ao recuperarmos o backup, precisamos adicionar a cl�usula WITH RECOVERY para sabermos se essas transa��es que estavam sendo conclu�das s�o levadas ou n�o em considera��o no momento de recupera��o desse backup. No caso, ao escrevermos essa cl�usula, garantimos que tudo o que foi salvo por esse backup completo ser� recuperado.

--Executando esse c�digo, ele recupera o backup, ent�o dentro das pastas "LOG_TRANSACOES" e "ARQUIVO_DADOS" o arquivo dbVendas.MDF voltou. Com isso, na parte superior do Management Studio, podemos voltar a nos conectar com o base de dados dbVendas.

--Em seguida, depois da �ltima linha de c�digo, pressionaremos "Enter" duas vezes e codaremos SELECT COUNT(*) FROM tb_nota. Ao executarmos esse c�digo, percebemos que temos 3469 notas, que � o mesmo valor que t�nhamos quando fizemos o backup do dia 02/03/2022, como podemos conferir na consulta passada.

--Vamos recuperar o segundo backup. Para isso, vamos copiar o bloco de c�digo de recupera��o de backup e o colar ao final do c�digo, lembrando de mudar o nome do arquivo para DBVENDAS_2.BAK.

--c�digo omitido

USE MASTER
DROP DATABASE dbVendas
RESTORE DATABASE dbVendas FROM DISK = 'F:\DATA\BACKUP\DBVENDAS_2.BAK' WITH RECOVERY;

--Em seguida, na coluna da esquerda, clicaremos na pasta "Banco de Dados" com o bot�o direito do mouse e selecionaremos a op��o "Atualizar". Ao fazermos isso, a op��o "dbVendas" volta a aparecer na lista.

--Clicaremos com o bot�o direito do mouse sobre dbVendas e selecionaremos a op��o "Excluir". Na janela que � aberta, marcaremos novamente a op��o "Fechar conex�es existentes" e clicaremos no bot�o "OK". Por fim, executamos a linha de c�digo de recupera��o do backup.

--Em seguida, podemos selecionar novamente a base de dados "dbVendas" na parte superior da janela. Ap�s o bloco de c�digo, vamos colar o comando SELECT COUNT(*) FROM tb_nota e o executar. Dessa vez o retorno foi de 3322 notas, que � o n�mero salvo no backup 2.

--Conclus�o
--� dessa forma que recuperamos backups:

--Sa�mos da base;
--Deletamos a base, com c�digo DROP DATABASE ou atrav�s do Management Studio;
--Recuperamos o backup com o RESTORE DATABASE;
--Voltamos para base de dados, deixando-a dispon�vel.
--Precisamos considerar que se fizermos o backup completo, todas as caracter�sticas da base, incluindo a localiza��o dos arquivos de dados e de log, s�o recuperados nos diret�rios onde estavam quando o backup foi feito.


-- DISCUTIR NO F�RUM
--PR�XIMA ATIVIDADE
--�cone Microsoft SQL Server 2022: administrando o banco de dados Microsoft SQL Server 2022: administrando o banco de dados
--42% 
--AULA
--03
-- Criando e restaurando Backups
-- AULA ATUAL


