for $k in doc('file:///C:/Users/andrz/source/repos/gawlowskiandrzej/ZTPD/XPath/zesp_prac.xml')
return data($k/ZESPOLY/ROW[NAZWA='SYSTEMY EKSPERCKIE']/PRACOWNICY/ROW/NAZWISKO)