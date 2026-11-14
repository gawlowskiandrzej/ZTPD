let $ksiazki := doc("C:\Users\andrz\Downloads\BaseX130\basex\XQuery\db\bib\bib.xml")//book
let $min := min($ksiazki/price/xs:double(.))
return <najtańsze>{
  for $b in $ksiazki[xs:double(price) = $min]
  return <najtańsza>{$b/title}{$b/author}</najtańsza>
}</najtańsze>