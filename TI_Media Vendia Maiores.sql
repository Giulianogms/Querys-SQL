SELECT * FROM 

(select d.apelido comprador,
       --a.nroempresa loja,
       b.seqfamilia familia, 
       a.seqproduto PLU,
       b.desccompleta descricao,
       SUM(a.medvdiageral) media_venda
/*from consinco.mrl_produtoempresa a,consinco.map_produto b,consinco.map_famdivisao c,consinco.max_comprador d, 
consinco.ge_pessoa f, consinco.map_familia h*/

FROM CONSINCO.MRL_PRODUTOEMPRESA A LEFT JOIN CONSINCO.MAP_PRODUTO B       ON A.SEQPRODUTO = B.SEQPRODUTO
                                   LEFT JOIN CONSINCO.MAP_FAMILIA H       ON B.SEQFAMILIA = H.SEQFAMILIA
                                   LEFT JOIN CONSINCO.MAP_FAMDIVISAO C    ON B.SEQFAMILIA = C.SEQFAMILIA
                                   LEFT JOIN CONSINCO.MAX_COMPRADOR D     ON D.SEQCOMPRADOR = C.SEQCOMPRADOR
                                   --LEFT JOIN CONSINCO.GE_PESSOA F ON F.SEQPESSOA = A.NROEMPRESA
/*where a.seqproduto=b.seqproduto
and b.seqfamilia=h.seqfamilia
AND a.nroempresa=f.seqpessoa 
and b.seqfamilia=c.seqfamilia
and c.seqcomprador=d.seqcomprador*/
WHERE B.DESCCOMPLETA NOT LIKE '%USO%'
AND B.DESCCOMPLETA NOT LIKE '%SACOLA%'
AND COMPRADOR NOT LIKE '%FLV%'
AND H.PESAVEL != 'S'
and a.statuscompra='A'
and a.nroempresa<300 
and a.medvdiageral<>0

GROUP BY D.APELIDO, --A.NROEMPRESA, 
         B.SEQFAMILIA, A.SEQPRODUTO, B.DESCCOMPLETA
         
         ORDER BY 5 DESC, 2)
         
         WHERE FAMILIA IN (SELECT SEQFAMILIA FROM MAP_PRODUTO WHERE SEQPRODUTO IN (620093,788274,159623,330527,444644,293303,121385,270175,797672,216900,290418,290562,243520,139151,210021,386654,124669,109154,248890,220150,181471,234661,209575,209574,100069,212131,223378,280761,217110,175005,243643,532402,769709,474849,242482,312738,733793,445085,104401,839600,243511,229688,106740,195249,153119,578523,240229,240140,243251,413930,510790,2134,166027,812092,218668,5500,104548,2189,106818,509091,213062,248191,740876,243810,805810,509107,480710,248885,813150,544085,508520,225836,813105,246188,508711,712088,785389,226984,273800,534673,241871,374941,248241,214273,226875,449571,402194,270151,368520,210782,113090,282307,234151,243552,120050,152426,299343,803441,335218,403238,195218,732840,202862,239802,269940,150057,445092,335225,276665,414609,194549,797429,382403,2752,374927,481281,242907,213059,247057,248197,136235,594462,248487,517720,813174,187398,850384,243612,387354,474979,676434,374989,248541,893435,284486,293334,243257,241873,218335,895705,206028,113410,813129,152419,231674,217096,335195,246827,510608,299336,359504,750783,241600,571944,618670,782074,240324,282376,291767,245125,149303,133678,223882,313551,268196,354196,563420,207147,232203,246269,752121,187749,217691,284684,222588,223191,906975,573856,246466,508605,857246,241565,227530,590044,284592,210805,889377,244423,231655,425445,243568,242779,247142,582056,386401,213533,378215,186971,679862,241346,437813,210552,322492,206154,110778,248192,598736,158657,206025,511261,340892,177269,676397,538893,243317,732741,313957,243555,243957,335201,206087,138352,387422,242216,112833,138628,412735,248214,103787,836227,220527,518260,249362,248215,192972,870511,127950,511421,743143,860611,223193,676519,828291,676465,220503,290579,206003,798945,210163,229059,773140,463805,248816,178013,374996,243371,236918,216529,180986,222935,143271,241872,248213,359467,118170,248836,13819,220032,223649,526258,290470,585378,114981,102155,187923,487726,189392,536820,89838,580687,122238,180696,854795,273251,784702,770347,449557,290449,244509,243896,144537,847322,221909,313575,243582,819008,241562,289511,359498,829724,679657,261258,210926,583718,209977,14120,805186,247940,220251,5517,242679,243690,206235,873161,309950,249327,439480,160094,222587,563529,405836,243636,722551,147873,328692,821452,231658,215290,137027,336925,2769,528511,869126,424677,242164,230308,231678,246436,836241,543804,225440,207278,194396,245126,226154,709958,303248,331463,148405,228679,242176,282390,869652,220151,774598,735636,537186,608206,248821,241791,353892,282659,786089,242678,276658,259729,7573,223414,217632,226860,248446,245597,719612,471619,248414,226882,405799,621496,540599,222669,241115,133111,207733,207734,180757,528382,249246,100010,277105,110501,220516,340977,228621,594523,275934,248138,274050,453820,207277,858809,231314,243321,349024,449106,207273,206084,218323,847278,278348,207274,511414,508667,433969,517690,209454,220961,218091,880220,292818,242254,220135,222400,13888,242257,578004,210538,796408,676427,142892,222671,46268,187916,52849,247978,220885,385848,508551,226868,510455,231783,214926,243872,714174,217420,827430,243389,218333,528450,129015,847223,207279,453646,143738,837033,227260,528559,798587,242796,207737,684545,148399,290586,209074,407519,817226,213253,242719,412636,225245,735490,509145,850117,197274,363532,207707,248817,368506,245969,248819,603201,620154,427111,230707,240362,291811,680059,242693,528481,210651,284431,246264,144568,402200,840590,231362,242908,187930,803496,532426,220057,208579,552882,178945,849982,282826,246871,240369,5142,248830,149556,217211,860628,339599,498272,776325,468572,247430,216293,238289,841580,227259,236635,508889,243616,291323,257275,248205,232290,833097,231683,237769,241331,480918,214902,539739,274067,241265,223153,243553,282628,246870,456913,102575,797719,223306,579247,210607,218369,243366,212252,242938,487597,238285,206891,217416,387613,1984,243154,836609,290425,803502,196536,517843,241497,216372,223415,739276,817875,906210,769884,540919,243398,212656,214851,603485,208746,243396,177054,247914,572828,716819,136518,121378,221587,523219,395175,471626,176262,244096,813808,538947,239945,887502,246820,214087,596619,241558,847230,188432,279901,149846,739658,225243,245408,786287,617321,245972,118392,193481,207275,277181,205307,246369,6811,579117,235113,825351,240356,209881,140119,524124,420105,189491,899406,751544,155366,372404,225251,212643,282314,236997,489355,212449,102377,769372,238346,733625,236637,382663,189477,400442,750370,381703,175067,248540,144575,206207,228093,483124,518352,242774,835978,482790,249212,238914,213844,343329,466769,404990,243394,216889,506373,188050,230832,489348,237190,835923,248824,244044,558648,753135,273282,219831,217428,188449,224730,218570,216530,396356,354370,589963,100847,395366,217690,143295,214070,819404,438049,866651,223413,359481,532457,881357,245799,239066,52863,249647,248829,232877,678643,101097,581738,414012,205265,679664,243561,429689,551199,244512,114899,631921,835985,359474,283830,487733,417853,217419,508957,241548,856317,226221,228743,845120,249731,489393,156882,127615,560801,857765,377324,153287,121248,130806,296953,246726,341035,218324,229642,117715,242799,241543,508964,218473,127103,351003,817905,244097,744775,226555,240004,794619,487740,584715,287180,873154,126960,528443,167628,444651,860369,240426,247486,739634,873123,539555,224745,247896,487542,292245,241863,234856,186858,581776,249648,458689,739641,197137,175739,221739,238286,221929,206749,219531,53754,341349,404655,241237,224574,470643,27212,122245,550031,261265,301602,226529,873130,313896,525244,870740,244262,906746,835992,829144,242872,214576,163996,249774,399227,508698,737944,184731,218569,221985,185516,214889,164191,243995,280754,187893,210606,862721,221257,186780,389655,786140,717182,399159,511155,833271,712699,224474,214180,176842,208232,248125,889414,390972,222934,243392,746199,216012,691314,217574,360760,284660,238388,534635,127967,315890,241371,592246,887588,220492,29162,237212,217963,441056,217649,247873,618472,770118,863179,221777,873147,835916,110334,378574,247166,508971,847391,168168,551182,524100,573320,7702,800600,213783,57721,810388,217633,234079,32797,220133,237332,216872,247421,866262,722339,240543,206770,127390,177276,242909,239942,222598,433952,132206,229967,189378,210108,241549,163941,296960,221915,769891,248250,225750,242264,328791,174534,291422,115131,218571,460767,232191,289535,232873,282321,247150,242221,44868,215093,225625,282413,184816,217421,742832,216892,115590,192729,247977,735858,241379,248895,596671,155557,231680,767040,216350,802772,143288,178051,740883,573887,306669,528290,614511,310246,222401,493321,770637,245423,218769,241601,405140,618922,245971,510660,208967,592734,236155,232715,225248,216895,490115,222857,216553,183109,138857,248894,442992,214173,557719,109772,181044,245154,132350,211072,203863,222492,852760,680073,295024,220454,180764,455190,552530,244259,205407,262910,509268,171311,425360,248888,261494,836135,874571,784603,218390,687553
))