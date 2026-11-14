let $lata := doc("C:\Users\andrz\Downloads\BaseX130\basex\XQuery\db\bib\bib.xml")//book/@year/xs:integer(.)
return <przedział>{min($lata)} - {max($lata)}</przedział>