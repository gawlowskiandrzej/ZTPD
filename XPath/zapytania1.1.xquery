for $k in doc('file:///C:/Users/andrz/source/repos/gawlowskiandrzej/ZTPD/XPath/swiat.xml')//KRAJ
return <KRAJ>
    {$k/NAZWA, $k/STOLICA}
</KRAJ>