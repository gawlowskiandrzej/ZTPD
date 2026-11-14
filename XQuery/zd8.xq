<Data>{
  for $b in doc("C:\Users\andrz\Downloads\BaseX130\basex\XQuery\db\bib\bib.xml")//book
  where contains($b/title, "Data")
  return (
    $b/title,
    for $l in $b/author/last
    return <nazwisko>{string($l)}</nazwisko>
  )
}</Data>