SELECT NROEMPRESA EMPRESA, NUMERONF, (SELECT NOMERAZAO FROM GE_PESSOA A WHERE A.SEQPESSOA = X.SEQPESSOA) NOMERAZAO, CODGERALOPER CGO, 
       TO_CHAR(DTAEMISSAO, 'DD/MM/YYYY') DTAEMISSAO, TO_CHAR(DTAENTRADA, 'DD/MM/YYYY') DTAENTRADA, :LT1 PERIODO_FILTRADO, 
CASE WHEN (NVL(:LS1,0)) = NROEMPRESA THEN TO_CHAR(NROEMPRESA) ELSE 'Todas Empresas' END EMP_SELEC
       
  FROM MLF_NOTAFISCAL X 
  
  WHERE 1=1 
    AND X.CODGERALOPER = 136 
    AND NROEMPRESA IN (#LS1)
    AND DTAENTRADA BETWEEN LAST_DAY(TO_DATE(:LT1, 'MM/YYYY')) - 90 AND LAST_DAY(TO_DATE(:LT1, 'MM/YYYY')) 
    AND NOT EXISTS (SELECT 1 FROM MLF_NOTAFISCAL XX WHERE XX.CODGERALOPER = 137 AND XX.NFREFERENCIANRO = X.NUMERONF AND XX.DTAEMISSAO 
                   BETWEEN LAST_DAY(TO_DATE(:LT1, 'MM/YYYY')) - 90 AND LAST_DAY(TO_DATE(:LT1, 'MM/YYYY')) )