ALTER SESSION SET current_schema = CONSINCO;

SELECT COUNT (COMPRADOR), COMPRADOR FROM (

SELECT DISTINCT B.NUMERONF, B.SEQNF, TO_CHAR(B.DTARECEBIMENTO, 'DD/MM/YYYY') DATA_RECEBIMENTO, NVL(SEQCOMPRADOR, C.SEQUSUARIO) SEQCOMPRADOR, NVL(APELIDO, C.NOME) COMPRADOR
FROM MLF_AUXNFINCONSISTENCIA A LEFT JOIN MLF_NOTAFISCAL B ON A.SEQAUXNOTAFISCAL = B.SEQAUXNOTAFISCAL
                               LEFT JOIN FI_TITULO F ON F.NROTITULO = B.NUMERONF AND F.NROEMPRESA = B.NROEMPRESA AND F.SEQPESSOA = B.SEQPESSOA
                               LEFT JOIN MLF_NFITEM D ON D.SEQAUXNOTAFISCAL = A.SEQAUXNOTAFISCAL
                               LEFT JOIN GE_USUARIO C ON A.USUAUTORIZOU = C.CODUSUARIO
                               LEFT JOIN MAX_COMPRADOR MC ON MC.CODUSUARIO = A.USUAUTORIZOU

WHERE A.DESCRICAO LIKE '%Item sem nro do pedido informado' 
  AND A.AUTORIZADA = 'S'
  AND B.DTARECEBIMENTO BETWEEN SYSDATE - 10 AND SYSDATE
  )
  GROUP BY COMPRADOR
 
  