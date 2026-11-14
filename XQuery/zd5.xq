<imiona>{
  for $a in doc("C:\Users\andrz\Downloads\BaseX130\basex\XQuery\db\bib\bib.xml")//book[title="Data on the Web"]/author
  return <imie>{string($a/first)}</imie>
}</imiona>
