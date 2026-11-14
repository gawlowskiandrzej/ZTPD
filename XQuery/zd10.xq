for $b in doc("C:\Users\andrz\Downloads\BaseX130\basex\XQuery\db\bib\bib.xml")//book
return <ksiazka>
  {$b/title}
  <autorow>{count($b/author)}</autorow>
</ksiazka>