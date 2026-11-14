let $ksiazki := doc("C:\Users\andrz\Downloads\BaseX130\basex\XQuery\db\bib\bib.xml")//book
for $l in distinct-values($ksiazki/author/last)
return <autor>
  <last>{$l}</last>
  {$ksiazki[author/last = $l]/title}
</autor>