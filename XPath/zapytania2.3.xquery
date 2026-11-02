for $k in doc('file:///C:/Users/andrz/source/repos/gawlowskiandrzej/ZTPD/XPath/zesp_prac.xml')
return count($k/ZESPOLY/ROW[ID_ZESP=10]/PRACOWNICY/ROW/NAZWISKO)