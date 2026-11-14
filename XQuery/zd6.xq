(: <DataOnTheWeb>{
  doc("C:\Users\andrz\Downloads\BaseX130\basex\XQuery\db\bib\bib.xml")//book[title="Data on the Web"]
}</DataOnTheWeb> :)

<DataOnTheWeb>{
  for $b in doc("C:\Users\andrz\Downloads\BaseX130\basex\XQuery\db\bib\bib.xml")//book
  where $b/title = "Data on the Web"
  return $b
}</DataOnTheWeb>
