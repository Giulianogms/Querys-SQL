
SELECT DISTINCT EMP, PLU, QP.PRODUTO DESCRICAO, QT ENTRADA, 
       TO_CHAR(SM, 'FM999G999G999D90', 'NLS_NUMERIC_CHARACTERS='',.''') VALOR_ENT,
       TO_CHAR((SM / QT), 'FM999G999G990D90', 'NLS_NUMERIC_CHARACTERS='',.''') VALOR_UNI,
       TO_CHAR(Y.DTAENTRADA, 'DD/MM/YYYY'), NULL CONSUMO, NULL ESTOQUE
       
FROM (
SELECT X.SEQPRODUTO PLU, X.NROEMPRESA EMP, X.CODGERALOPER CGO, X.QTDLANCTO, 
       (VALORLANCTOBRT * QTDLANCTO) VLR_BRUTO
        FROM fato_perda x INNER JOIN dim_codgeraloper y ON (x.codgeraloper = y.codgeraloper)
        WHERE SEQPRODUTO IN (246931,234167,208615,208614,771887,239512,231117,228213,228225,
                             228223,228219,228215,234173,233427,225289,231567,188579,188425,213382,188531)
        AND DTAOPERACAO BETWEEN :DT1 AND :DT2
        AND Y.CODGERALOPER IN (269,270,271,272,273,274)
       
) X LEFT JOIN QLV_PRODUTO QP ON X.PLU = QP.SEQPRODUTO
    LEFT JOIN (SELECT C.NROEMPRESA, C.SEQPRODUTO, SUM(C.QTDITEM) QT, SUM(C.VLRITEM) SM, C.DTAENTRADA FROM FATO_COMPRA C 
                   WHERE C.SEQPRODUTO IN (246931,234167,208615,208614,771887,239512,231117,228213,228225,
                                          228223,228219,228215,234173,233427,225289,231567,188579,188425,213382,188531)
                         AND   C.DTAENTRADA BETWEEN :DT1 AND :DT2
                   GROUP BY NROEMPRESA, SEQPRODUTO, DTAENTRADA) Y ON X.PLU = Y.SEQPRODUTO AND X.EMP = Y.NROEMPRESA

GROUP BY PLU, EMP, QP.PRODUTO, QT, SM, DTAENTRADA

UNION ALL

SELECT EMP, PLU, QP.PRODUTO DESCRICAO,
       NULL, NULL, NULL, NULL,
       SUM(QTDLANCTO) CONSUMO,
       E.QTDESTOQUE ESTOQUE FROM (SELECT X.SEQPRODUTO PLU, X.NROEMPRESA EMP, X.CODGERALOPER CGO, X.QTDLANCTO, 
       (VALORLANCTOBRT * QTDLANCTO) VLR_BRUTO
    FROM fato_perda x INNER JOIN dim_codgeraloper y ON (x.codgeraloper = y.codgeraloper)
        WHERE SEQPRODUTO IN (246931,234167,208615,208614,771887,239512,231117,228213,228225,228223,
                             228219,228215,234173,233427,225289,231567,188579,188425,213382,188531)
        AND DTAOPERACAO BETWEEN :DT1 AND :DT2
        AND Y.CODGERALOPER IN (269,270,271,272,273,274)) X
    LEFT JOIN FATO_ESTOQUE E ON E.SEQPRODUTO = X.PLU AND E.NROEMPRESA = X.EMP AND E.DTAESTOQUE = TRUNC(SYSDATE-1)
    LEFT JOIN QLV_PRODUTO QP ON X.PLU = QP.SEQPRODUTO
    
GROUP BY PLU, EMP, E.QTDESTOQUE, QP.PRODUTO

ORDER BY 2,3,1,9 DESC