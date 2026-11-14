for $b in doc("C:\Users\andrz\Downloads\BaseX130\basex\XQuery\db\bib\bib.xml")/bib/book
for $t in $b/title
for $a in $b/author
return <ksiazka>{$a}{$t}</ksiazka>