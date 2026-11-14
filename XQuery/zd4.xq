<wynik>{
  for $b in doc("C:\Users\andrz\Downloads\BaseX130\basex\XQuery\db\bib\bib.xml")/bib/book
  for $a in $b/author
  for $t in $b/title
  return <ksiazka>
    <autor>{string($a/last) || " " || string($a/first)}</autor>
    <tytul>{string($t)}</tytul>
  </ksiazka>
}</wynik>
