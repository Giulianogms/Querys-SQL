SELECT B.NROEMPRESA,
       NVL(B.NROCTRC, NUMERO) NRO_MDFE,
       B.SERIECTRC SERIE,
       TO_CHAR(B.DTAHORAEMISSAO, 'DD/MM/YYYY HH24:MI') EMISSAO,
       B.DESCSTATUSCTE STATUS,
       B.M000_VL_TOT_PREST VALOR,
       CASE WHEN NROEMPRESA IS NULL THEN 'Sequencial Quebrado!' ELSE B.SEQPESSOA||' - '||
      (SELECT NOMERAZAO FROM CONSINCO.GE_PESSOA WHERE SEQPESSOA = B.SEQPESSOA) END RAZAO,
       TO_CHAR(B.CTEDTAENV, 'DD/MM/YYYY HH24:MI')  AUTORIZACAO
       
FROM (
   SELECT LEVEL  AS numero
   FROM dual
   CONNECT BY LEVEL <= 10000
) AA LEFT JOIN CONSINCO.MFTV_PAINELCTEMDFE B ON AA.NUMERO = B.NROCTRC AND 1=1 
                                                                      AND B.NROEMPRESA IN (#LS1)
                                                                      AND TRUNC(B.DTAHORAEMISSAO) BETWEEN :DT1 AND :DT2

WHERE numero BETWEEN (SELECT MIN(NROCTRC) FROM CONSINCO.MFTV_PAINELCTEMDFE A
                       WHERE 1=1 
                         AND A.NROEMPRESA IN (#LS1)
                         AND TRUNC(A.DTAHORAEMISSAO) BETWEEN :DT1 AND :DT2) 
                         
   AND (SELECT MAX(NROCTRC) FROM CONSINCO.MFTV_PAINELCTEMDFE A
         WHERE 1=1 
           AND A.NROEMPRESA IN (#LS1)
           AND TRUNC(A.DTAHORAEMISSAO) BETWEEN :DT1 AND :DT2)
   
 ORDER BY NUMERO