ALTER SESSION SET CURRENT_SCHEMA = CONSINCO;

SELECT TO_CHAR(A.DTAENTRADASAIDA, 'YYYY') ANO, TO_CHAR(A.DTAENTRADASAIDA, 'MM') MES, A.CODGERALOPER CGO, 
       CASE WHEN A.CODGERALOPER IN (37,48,123,610,615,613,810,916,910,911) THEN 'VENDA' ELSE 'QUEBRA' END TIPO_CGO,
       A.NROEMPRESA COD_EMPRESA, M.NOMEREDUZIDO EMPRESA, A.SEQPRODUTO COD_PRODUTO, P.DESCCOMPLETA PRODUTO, Q.CATEGORIA_NIVEL_1, CATEGORIA_NIVEL_2, CATEGORIA_NIVEL_3, 
       CASE WHEN F.PESAVEL = 'S' THEN 'KG' ELSE 'UNI' END EMB,
       SUM(A.QTDSAIDATRANSF + QTDSAIDAOUTRAS + QTDSAIDAVENDA) QTD, ROUND(AVG(A.VLRCTOBRUTOUNIT),2) CUSTO_UNITARIO,
       
       ROUND(SUM((QTDSAIDAOUTRAS + QTDSAIDAVENDA) * VLRCTOBRUTOUNIT),2) VLR_TOTAL
          
  FROM MAXV_ABCMOVTOBASE_PROD A INNER JOIN MAP_FAMDIVISAO D     ON D.SEQFAMILIA    = A.SEQFAMILIA
                                INNER JOIN MAP_PRODUTO P        ON P.SEQPRODUTO    = A.SEQPRODUTO
                                INNER JOIN MRL_PRODUTOEMPRESA C ON C.SEQPRODUTO    = A.SEQPRODUTO   AND C.NROEMPRESA = A.NROEMPRESA
                                INNER JOIN MAX_EMPRESA M        ON M.NROEMPRESA    = A.NROEMPRESA
                                LEFT JOIN QLV_CATEGORIA@CONSINCODW Q ON Q.SEQFAMILIA = P.SEQFAMILIA
                                INNER JOIN MAP_FAMILIA F        ON F.SEQFAMILIA = P.SEQFAMILIA
 WHERE 1=1
 
   AND D.NRODIVISAO IN (1) 
   AND A.DTAENTRADASAIDA BETWEEN :DT1 AND :DT2
   AND A.NRODIVISAO = D.NRODIVISAO
   AND A.NROEMPRESA IN (#LS1)
   AND A.CODGERALOPER IN (37,48,123,610,615,613,810,916,910,911,20,34,30,35,46,47,62,63,33,63,73,258,263,549)
   AND Q.CATEGORIA_NIVEL_1 IN (#LS2)

 HAVING SUM(A.QTDSAIDATRANSF + QTDSAIDAOUTRAS + QTDSAIDAVENDA) > 0
   
  GROUP BY TO_CHAR(A.DTAENTRADASAIDA, 'MM'),  TO_CHAR(A.DTAENTRADASAIDA, 'YYYY'), A.NROEMPRESA, A.CODGERALOPER, NOMEREDUZIDO, A.SEQPRODUTO, DESCCOMPLETA,CATEGORIA_NIVEL_1,
           CATEGORIA_NIVEL_2, CATEGORIA_NIVEL_3, PESAVEL

ORDER BY 5,7