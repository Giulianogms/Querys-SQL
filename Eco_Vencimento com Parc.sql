ALTER SESSION SET current_schema = CONSINCO;

/* Versão Giuliano - Vencimento com Parcelados - Chamado 30133 */

SELECT PED.NROEMPRESA AS LJ, TIT.NROTITULO AS NRO_TITULO, TIT.CODESPECIE AS ESPECIE, PE.NOMERAZAO, NF.DTAHOREMISSAO AS DT_EMISSAO,
       CASE WHEN NF.DTAVENCIMENTO IS NULL THEN TIT.DTAVENCIMENTO ELSE NF.DTAVENCIMENTO END AS DT_VENCIMENTO,
       TIT.VLRORIGINAL AS VALOR_TITULO, ROUND(SUM(IT.VLRACRESCIMO) + SUM(IT.VLRITEM),2) AS Valor_Total_NF,
       TIT.SEQTITULO AS NUMERO_TITULO, PED.NROPEDCLIENTE AS NUMERO_PEDIDO, PED.PEDIDOID AS PLATAFORMA

FROM CONSINCO.EDI_PEDVENDA EDI
     LEFT JOIN CONSINCO.MAD_PEDVENDA PED ON (EDI.NROPEDVENDA = PED.NROPEDVENDA AND PED.NROEMPRESA = EDI.NROEMPRESA)
     LEFT JOIN CONSINCO.MFL_DOCTOFISCAL NF ON (PED.NROPEDVENDA = NF.NROPEDIDOVENDA)
     LEFT JOIN CONSINCO.FI_TITULO TIT on (NF.NUMERODF = TIT.NROTITULO AND NF.SERIEDF = TIT.SERIETITULO AND NF.NROEMPRESA = TIT.NROEMPRESA AND NF.SEQPESSOA = TIT.SEQPESSOANOTA AND NF.DTAMOVIMENTO = TIT.DTAEMISSAO)
     LEFT JOIN CONSINCO.MFL_DFITEM IT ON (IT.SEQNF = NF.SEQNF) /* AND IT.STATUSITEM = 'V')*/
     LEFT JOIN CONSINCO.GE_PESSOA PE ON (PE.SEQPESSOA = NF.SEQPESSOA) 
     
WHERE PED.PEDIDOID IN ('IFOOD','SM','MMC')
     AND PED.NROEMPRESA = 26
     AND PED.dtapedidoafv >= sysdate -7
     AND PED.ORIGEMPEDIDO = 'E'
     AND PED.INDENTREGARETIRA IN ('E','R')

GROUP BY PED.NROEMPRESA , TIT.NROTITULO , TIT.CODESPECIE , PE.NOMERAZAO, NF.DTAHOREMISSAO , 
         NF.DTAVENCIMENTO , (CASE WHEN NF.DTAVENCIMENTO IS NULL THEN TIT.DTAVENCIMENTO ELSE NF.DTAVENCIMENTO END), 
         TIT.VLRORIGINAL,TIT.SEQTITULO,PED.NROPEDCLIENTE,PED.PEDIDOID
ORDER BY DT_EMISSAO DESC;