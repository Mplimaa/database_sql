
USE DB_VENDAS
ALTER DATABASE DB_VENDAS SET RECOVERY SIMPLE
DBCC SHRINKDATABASE ('DB_VENDAS', NOTRUNCATE)
DBCC SHRINKDATABASE ('DB_VENDAS', TRUNCATEONLY)
ALTER DATABASE DB_VENDAS SET RECOVERY FULL


/*arquivo Reduzinho-base.sql

Um ponto de aten��o para o DBA � a verifica��o constante do espa�o em disco dispon�vel no servidor onde a base de dados est� armazenada. 
Isso porque a base de dados do SQL Server tende a crescer muito, principalmente os arquivos de log e transa��es, � medida que o banco 
vai sendo utilizado.
A diminui��o do espa�o livre em disco pode afetar a performance do sistema. Por isso, o DBA tamb�m deve verificar o crescimento da base.

Na se��o de atividade abaixo deste v�deo, h� um link para download do script Reduzindo Base.sql. Vamos copi�-lo para o nosso diret�rio
de trabalho. Voltando ao Management Studio, vamos carregar esse novo script clicando em "Arquivo > Abrir > Arquivo > Reduzindo Base.sql
> Abrir". O script que se abre � o seguinte:

USE DB_VENDAS
ALTER DATABASE DB_VENDAS SET RECOVERY SIMPLE
DBCC SHRINKDATABASE ('DB_VENDAS', NOTRUNCATE)
DBCC SHRINKDATABASE ('DB_VENDAS', TRUNCATEONLY)
ALTER DATABASE DB_VENDAS SET RECOVERY FULLCOPIAR C�DIGO

Note que ele est� executando quatro comandos � o comando USE no in�cio est� apenas reposicionando o script para ser executado na base 
DB VENDAS. Esses quatro comandos ir�o reduzir o tamanho da base de dados do banco de dados porque, � medida que o banco vai sendo 
utilizado, muita coisa desnecess�ria ser� gravada nele.

Basicamente, o primeiro comando, ALTER DATABASE com o SET RECOVERY SIMPLE, � usado para modificar as configura��es do banco de dados.
Quando usamos a fun��o de recupera��o definindo a op��o SIMPLE, o SQL Server n�o mant�m nenhum log de transa��o completo.

Isso significa que, ao recuperar os dados da base de dados, eliminar� os dados de transa��es de log. Isso pode ser perigoso se voc�
tem a necessidade de um rollback dos dados. Por isso, ao rodar os comandos de redu��o da base de dados, � importante ter certeza de
que voc� realizou um backup do banco e que seus usu�rios n�o est�o utilizando esse banco.

O segundo comando se chama DBCC SHRINKDATABASE. Com ele, reduzimos o tamanho do banco de dados removendo todo o espa�o n�o utilizado.
O par�metro NOTRUNCATE significa que o arquivo do banco de dados n�o ser� encurtado al�m do tamanho atual, mesmo que haja espa�o 
inutilizado.

O terceiro comando tamb�m � o DBCC SHRINKDATABASE, mas com o par�metro TRUNCATEONLY. Ele remover� apenas o espa�o n�o utilizado no 
final do arquivo do banco de dados. Isso significa que o tamanho do arquivo ser� reduzido sem mover dados.

O �ltimo comando � o ALTER DATABASE novamente, dessa vez com o par�metro SET RECOVERY FULL. Com essa op��o definida, o SQL Server
mant�m o log de transa��o completo � ent�o, permite que voc� volte a gravar as transa��es do banco. Ou seja, se voc� n�o passar o
seu banco novamente para RECOVERY FULL, estar� limitando a capacidade de salvar os logs de transa��o.

No entanto, para reduzir o tamanho, voc� precisa passar o banco para RECOVERY SIMPLE, ou seja, eliminar a necessidade de salvar o
log de transa��o, para ent�o reduzir a base e, finalmente, voltar ao status original.

Ent�o, vamos verificar o tamanho da base nesse momento. Para isso, clicamos no nome da base "DB_VENDAS" no menu lateral esquerdo 
com o bot�o direito do mouse e, em seguida, clicamos em "Propriedades". Na janela de propriedades, clicamos em "Arquivos" no menu
lateral esquerdo. Nessa tela, veremos todas as propriedades do nosso banco de dados. Na tabela, temos um campo chamado "Tamanho (MB)"
em que podemos ver o tamanho do banco:

3105 MB do banco de dados "DB_VENDAS"
4104 MB de log de transa��o
Podemos clicar em "Cancelar" para fechar essa janela de propriedades do banco de dados.

Agora, vamos executar os comandos do script Reduzindo Base.sql. Ele roda rapidamente e, se acessarmos novamente a janela de 
Propriedades do Banco, veremos que seu tamanho foi reduzido:

3068 MB do banco de dados "DB_VENDAS"
8 MB de log de transa��o
O tamanho do banco diminuiu pouco, mas o do log de transa��o reduziu bastante. Economizamos 4GB de espa�o! Claro que, se quisermos
dar um rollback numa transa��o que estava parada no meio, n�o conseguiremos porque apagamos todo o log de transa��o. Mas, houve uma 
economia muito grande de espa�o.

� importante que n�s, como DBAs, tenhamos este script em m�os para reduzir periodicamente o tamanho da base de dados, economizando
espa�o em disco e evitando que ele se esgote. Isso pode acontecer com a m�quina onde o banco de dados SQL Server est� salvo. 
Portanto, � fundamental manter um controle constante do espa�o livre em disco dispon�vel.

Um abra�o e at� o pr�ximo v�deo!

*/


/*

A falta de espa�o em disco em um servidor de banco de dados SQL Server pode afetar negativamente o desempenho e a integridade 
dos dados armazenados. O DBA deve monitorar o crescimento da base de dados ao longo do tempo, lembrando que esse crescimento
n�o � diretamente proporcional � quantidade de dados, pois o arquivo de LOG, que armazena as transa��es para posteriores 
COMMITs e ROLLBACKs, � o principal respons�vel pelo consumo de espa�o em disco.

Das op��es abaixo, quais s�o as alternativas verdadeiras?

A falta de espa�o em disco pode levar � perda de desempenho do servidor.


A falta de espa�o em disco pode levar � perda de desempenho do servidor, porque o SQL Server precisa alocar espa�o em disco de
maneira fragmentada, o que pode levar a uma diminui��o do desempenho de leitura e grava��o.

Alternativa correta
A falta de espa�o em disco pode levar � fragmenta��o do espa�o em disco e diminuir o desempenho de leitura e grava��o.


A falta de espa�o em disco pode levar � fragmenta��o do espa�o em disco, o que pode levar a uma diminui��o do desempenho
de leitura e grava��o.

Alternativa correta
A falta de espa�o em disco pode levar � falha do servidor de banco de dados SQL Server.


A falta de espa�o em disco pode levar � falha total do servidor de banco de dados SQL Server, se o espa�o em disco for 
completamente esgotado.
*/