for $k in doc('file:///C:/Users/andrz/source/repos/gawlowskiandrzej/ZTPD/XPath/swiat.xml')//KRAJ[starts-with(NAZWA,'A')]
return <KRAJ>
    {$k/NAZWA, $k/STOLICA}
</KRAJ>