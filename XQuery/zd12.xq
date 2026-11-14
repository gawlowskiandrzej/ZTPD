let $ceny := doc("C:\Users\andrz\Downloads\BaseX130\basex\XQuery\db\bib\bib.xml")//book/price/xs:decimal(.)
return <różnica>{max($ceny) - min($ceny)}</różnica>