<wynik>{
  for $p in collection("C:\Users\andrz\Downloads\BaseX130\basex\XQuery\db\shakespeare")/PLAY
  return <sztuka tytul="{$p/TITLE}">
    <postaci>{count($p/PERSONAE//PERSONA)}</postaci>
    <aktow>{count($p/ACT)}</aktow>
    <scen>{count($p/ACT/SCENE)}</scen>
  </sztuka>
}</wynik>