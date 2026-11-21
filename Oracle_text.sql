-- CYTATY

1.
CREATE TABLE CYTATY AS SELECT * FROM ZTPD.CYTATY;

2.
SELECT autor, tekst
FROM   cytaty
WHERE  LOWER(tekst) LIKE '%optymista%' AND LOWER(tekst) LIKE '%pesymista%';

3. 
CREATE INDEX cytaty_tekst_idx ON cytaty(tekst)
INDEXTYPE IS CTXSYS.CONTEXT;

4. 
SELECT autor, tekst
FROM   cytaty
WHERE  CONTAINS(tekst, 'optymista AND pesymista') > 0;

5.
SELECT autor, tekst
FROM   cytaty
WHERE  CONTAINS(tekst, 'pesymista NOT optymista') > 0;

6.
SELECT autor, tekst
FROM   cytaty
WHERE  CONTAINS(tekst, 'NEAR((pesymista, optymista), 3)') > 0;

7.
SELECT autor, tekst
FROM   cytaty
WHERE  CONTAINS(tekst, 'NEAR((pesymista, optymista), 10)') > 0;

8. 
SELECT autor, tekst
FROM   cytaty
WHERE  CONTAINS(tekst, 'życi%') > 0;

9.
SELECT autor, tekst, SCORE(1) AS dopasowanie
FROM   cytaty
WHERE  CONTAINS(tekst, 'życi%', 1) > 0;

10. 
SELECT autor, tekst, dopasowanie
FROM  (SELECT autor, tekst, SCORE(1) AS dopasowanie
       FROM   cytaty
       WHERE  CONTAINS(tekst, 'życi%', 1) > 0
       ORDER BY SCORE(1) DESC)
WHERE ROWNUM <= 1;

11.
SELECT autor, tekst
FROM   cytaty
WHERE  CONTAINS(tekst, 'fuzzy(probelm)') > 0;

12. 
INSERT INTO cytaty (id, autor, tekst)
SELECT NVL(MAX(id), 0) + 1,
       'Bertrand Russell',
       'To smutne, że głupcy są tacy pewni siebie, a ludzie rozsądni tacy pełni wątpliwości.'
FROM   cytaty;
COMMIT;

13.
indeks nie jest aktualizowany na bieżąco, przez co nie ma w nim nowego cytatu, więc zapytanie nie zwróci wiersza.
SELECT autor, tekst
FROM   cytaty
WHERE  CONTAINS(tekst, 'głupcy') > 0;

14. 
SELECT table_name FROM user_tables WHERE table_name LIKE 'DR$%';

SELECT * FROM DR$CYTATY_TEKST_IDX$I WHERE token_text = 'GŁUPCY';

15. 
DROP INDEX cytaty_tekst_idx;
CREATE INDEX cytaty_tekst_idx ON cytaty(tekst)
INDEXTYPE IS CTXSYS.CONTEXT;

16. 
SELECT * FROM DR$CYTATY_TEKST_IDX$I WHERE token_text = 'GŁUPCY';

SELECT autor, tekst
FROM   cytaty
WHERE  CONTAINS(tekst, 'głupcy') > 0;

17.
DROP INDEX cytaty_tekst_idx;
DROP TABLE cytaty;

-- QUOTES

1.
CREATE TABLE QUOTES AS SELECT * FROM ZTPD.QUOTES;

2.
CREATE INDEX quotes_text_idx ON quotes(text)
INDEXTYPE IS CTXSYS.CONTEXT;

3.
SELECT * FROM quotes WHERE CONTAINS(text, 'work')     > 0;
SELECT * FROM quotes WHERE CONTAINS(text, '$work')    > 0;
SELECT * FROM quotes WHERE CONTAINS(text, 'working')  > 0;
SELECT * FROM quotes WHERE CONTAINS(text, '$working') > 0;

4.
Nie zwrócił wyników bo prawdopodobnie słowo 'it' jest w domyślnej stop liście i nie jest indeksowane.
SELECT * FROM quotes WHERE CONTAINS(text, 'it') > 0;

5.
SELECT * FROM CTX_STOPLISTS;
Wykorzystywał domyślną stop listę

6.
SELECT * FROM CTX_STOPWORDS WHERE spw_stoplist = 'DEFAULT_STOPLIST';

7. 
DROP INDEX quotes_text_idx;

CREATE INDEX quotes_text_idx ON quotes(text)
INDEXTYPE IS CTXSYS.CONTEXT
PARAMETERS ('STOPLIST CTXSYS.EMPTY_STOPLIST');

8.
SELECT * FROM quotes WHERE CONTAINS(text, 'it') > 0;

Tak wyniki zostały zwrócone ponieważ została użyta pusta stop lista

9.
SELECT * FROM quotes WHERE CONTAINS(text, 'fool AND humans') > 0;

10.
SELECT * FROM quotes WHERE CONTAINS(text, 'fool AND computer') > 0;

11.
indeks nie ma zdefiniowanej sekcji SENTENCE (domyślna grupa sekcji jej nie obsługuje).
SELECT * FROM quotes WHERE CONTAINS(text, '(fool AND humans) WITHIN SENTENCE') > 0;

12.
DROP INDEX quotes_text_idx;

13.
BEGIN
  CTX_DDL.CREATE_SECTION_GROUP('nullgroup', 'NULL_SECTION_GROUP');
  CTX_DDL.ADD_SPECIAL_SECTION('nullgroup', 'SENTENCE');
  CTX_DDL.ADD_SPECIAL_SECTION('nullgroup', 'PARAGRAPH');
END;

14.
CREATE INDEX quotes_text_idx ON quotes(text)
INDEXTYPE IS CTXSYS.CONTEXT
PARAMETERS ('SECTION GROUP nullgroup');

15.
SELECT * FROM quotes WHERE CONTAINS(text, '(fool AND humans) WITHIN SENTENCE') > 0;
SELECT * FROM quotes WHERE CONTAINS(text, '(fool AND computer) WITHIN SENTENCE') > 0;

16.
Tak: domyślnie myślnik jest traktowany jako separator tokenów,
SELECT * FROM quotes WHERE CONTAINS(text, 'humans') > 0;

17.
DROP INDEX quotes_text_idx;

BEGIN
  CTX_DDL.CREATE_PREFERENCE('lex_z_m', 'BASIC_LEXER');
  CTX_DDL.SET_ATTRIBUTE('lex_z_m', 'PRINTJOINS', '-');
END;
/

CREATE INDEX quotes_text_idx ON quotes(text)
INDEXTYPE IS CTXSYS.CONTEXT
PARAMETERS ('LEXER lex_z_m');

18.
SELECT * FROM quotes WHERE CONTAINS(text, 'humans') > 0;
nie, zwrócił tylko humans

19.
SELECT * FROM quotes WHERE CONTAINS(text, 'non\-humans') > 0;

20.
DROP INDEX quotes_text_idx;
DROP TABLE quotes;

BEGIN
  CTX_DDL.DROP_PREFERENCE('lex_z_m');
  CTX_DDL.DROP_SECTION_GROUP('nullgroup');
END;
/