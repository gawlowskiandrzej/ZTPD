for $k in doc('file:///C:/Users/andrz/source/repos/gawlowskiandrzej/ZTPD/XPath/zesp_prac.xml')
return sum($k/ZESPOLY/ROW[PRACOWNICY/ROW/NAZWISKO='BRZEZINSKI']/PRACOWNICY/ROW/PLACA_POD)