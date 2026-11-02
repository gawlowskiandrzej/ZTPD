for $k in doc('file:///C:/Users/andrz/source/repos/gawlowskiandrzej/ZTPD/XPath/swiat.xml')//KRAJ[substring(NAZWA,1,1)=substring(STOLICA,1,1)]
return <KRAJ>
    {$k/NAZWA, $k/STOLICA}
</KRAJ>