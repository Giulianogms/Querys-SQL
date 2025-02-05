SELECT X.DTAESTOQUE, X.NROEMPRESA, X.SEQPRODUTO PLU, DESCCOMPLETA PRODUTO, TO_NUMBER(X.QTDESTQLOJA) ESTOQUE,  
       DECODE(STATUSCOMPRA, 'A','Ativo','I','Inativo','S','Suspenso') STATUS_COMPRA, CATEGORIAN3
  FROM FATO_ESTOQUE X INNER JOIN MAP_PRODUTO P ON P.SEQPRODUTO = X.SEQPRODUTO
                      INNER JOIN MRL_PRODUTOEMPRESA E ON E.SEQPRODUTO = X.SEQPRODUTO AND X.NROEMPRESA = E.NROEMPRESA
                      INNER JOIN DIM_CATEGORIA@CONSINCODW C ON C.SEQFAMILIA = P.SEQFAMILIA

WHERE 1=1
  AND DTAESTOQUE BETWEEN :DT1 AND :DT2
  AND CATEGORIAN3  IN (#LS2)
  AND X.NROEMPRESA IN (#LS1)
