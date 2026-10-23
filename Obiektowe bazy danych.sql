1. CREATE TYPE samochod AS OBJECT (
  marka VARCHAR2(20),
  model VARCHAR2(20),
  kilometry NUMBER,
  data_produkcji DATE,
  cena NUMBER(10,2)
);
/
CREATE TABLE samochody OF samochod;

INSERT INTO samochody VALUES (samochod('FIAT','BRAVA',60000,TO_DATE('30/11/1999', 'DD/MM/YYYY'),25000));
INSERT INTO samochody VALUES (samochod('FORD','MONDEO',80000,TO_DATE('10/05/1997', 'DD/MM/YYYY'),45000));
INSERT INTO samochody VALUES (samochod('MAZDA','323',12000,TO_DATE('22/09/2000', 'DD/MM/YYYY'),52000));

2. 
ALTER TYPE samochod ADD MEMBER FUNCTION wartosc RETURN NUMBER CASCADE;
/
CREATE OR REPLACE TYPE BODY samochod AS
  MEMBER FUNCTION wartosc RETURN NUMBER IS
  BEGIN
    RETURN cena * POWER(0.9, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM data_produkcji));
  END wartosc;
END;
/

3. 
ALTER TYPE samochod ADD MAP MEMBER FUNCTION odwzoruj RETURN NUMBER CASCADE;
/
CREATE OR REPLACE TYPE BODY samochod AS
  MEMBER FUNCTION wartosc RETURN NUMBER IS
  BEGIN
    RETURN cena * POWER(0.9, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM data_produkcji));
  END wartosc;

  MAP MEMBER FUNCTION odwzoruj RETURN NUMBER IS
  BEGIN
    RETURN (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM data_produkcji)) + kilometry/10000;
  END odwzoruj;
END;
/
SELECT * FROM samochody s ORDER BY VALUE(s);
4.
CREATE TABLE wlasciciele (
  imie VARCHAR2(100),
  nazwisko VARCHAR2(100),
  auto SAMOCHOD
);

INSERT INTO wlasciciele VALUES ('JAN','KOWALSKI', samochod('FIAT','SEICENTO',30000,DATE '2010-12-02',19500));
INSERT INTO wlasciciele VALUES ('ADAM','NOWAK', samochod('OPEL','ASTRA',34000,DATE '2009-06-01',33700));

5.
Drop table wlasciciele;

6.
CREATE TYPE wlasciciel AS OBJECT (
  imie VARCHAR2(100),
  nazwisko VARCHAR2(100)
);
/
CREATE TABLE wlasciciele OF wlasciciel;

INSERT INTO wlasciciele VALUES (wlasciciel('JAN','KOWALSKI'));
INSERT INTO wlasciciele VALUES (wlasciciel('ADAM','NOWAK'));
INSERT INTO wlasciciele VALUES (wlasciciel('ANNA','WISNIEWSKA'));

7.
ALTER TYPE samochod ADD ATTRIBUTE (wlasciciel_ref REF wlasciciel) CASCADE;

8.
DELETE FROM samochody;

9.
ALTER TABLE samochody ADD SCOPE FOR (wlasciciel_ref) IS wlasciciele;

10.
INSERT INTO samochody VALUES (samochod('FIAT','BRAVA',60000,DATE '1999-11-30',25000,
  (SELECT REF(w) FROM wlasciciele w WHERE w.nazwisko='KOWALSKI')));
INSERT INTO samochody VALUES (samochod('FORD','MONDEO',80000,DATE '1997-05-10',45000,
  (SELECT REF(w) FROM wlasciciele w WHERE w.nazwisko='NOWAK')));
INSERT INTO samochody VALUES (samochod('MAZDA','323',12000,DATE '2000-09-22',52000,
  (SELECT REF(w) FROM wlasciciele w WHERE w.nazwisko='WISNIEWSKA')));

11.
- w instrukcji

12.
DECLARE
  TYPE t_ksiazki IS VARRAY(10) OF VARCHAR2(40);
  moje_ksiazki t_ksiazki := t_ksiazki('');
BEGIN
  moje_ksiazki(1) := 'Pan Tadeusz';
  moje_ksiazki.EXTEND(3);
  moje_ksiazki(2) := 'Lalka';
  moje_ksiazki(3) := 'Zbrodnia i kara';
  moje_ksiazki(4) := 'Krzyżacy';

  FOR i IN moje_ksiazki.FIRST()..moje_ksiazki.LAST() LOOP
    DBMS_OUTPUT.PUT_LINE(moje_ksiazki(i));
  END LOOP;

  moje_ksiazki.TRIM(1);        
  moje_ksiazki.EXTEND();               
  moje_ksiazki(moje_ksiazki.LAST()) := 'W pustyni i w puszczy';

  DBMS_OUTPUT.PUT_LINE('Po zmianach:');
  FOR i IN moje_ksiazki.FIRST()..moje_ksiazki.LAST() LOOP
    DBMS_OUTPUT.PUT_LINE(moje_ksiazki(i));
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Liczba elementow: ' || moje_ksiazki.COUNT());
END;

13.
- w instrukcji

14.
DECLARE
  TYPE t_miesiace IS TABLE OF VARCHAR2(20);
  miesiace t_miesiace := t_miesiace();
BEGIN
  miesiace.EXTEND(12);
  miesiace(1) := 'STYCZEN';   miesiace(2) := 'LUTY';
  miesiace(3) := 'MARZEC';    miesiace(4) := 'KWIECIEN';
  miesiace(5) := 'MAJ';       miesiace(6) := 'CZERWIEC';
  miesiace(7) := 'LIPIEC';    miesiace(8) := 'SIERPIEN';
  miesiace(9) := 'WRZESIEN';  miesiace(10) := 'PAZDZIERNIK';
  miesiace(11) := 'LISTOPAD'; miesiace(12) := 'GRUDZIEN';

  miesiace.DELETE(2,4);   
  miesiace.DELETE(11);   

  DBMS_OUTPUT.PUT_LINE('Liczba elementow: ' || miesiace.COUNT());
  FOR i IN miesiace.FIRST()..miesiace.LAST() LOOP
    IF miesiace.EXISTS(i) THEN
      DBMS_OUTPUT.PUT_LINE(miesiace(i));
    END IF;
  END LOOP;
END;

15.
- w instrukcji
16.
CREATE TYPE koszyk_produktow AS TABLE OF VARCHAR2(30);
/
CREATE TABLE zakupy (
  id NUMBER PRIMARY KEY,
  koszyk KOSZYK_PRODUKTOW
) NESTED TABLE koszyk STORE AS tab_koszyk;

INSERT INTO zakupy VALUES (1, koszyk_produktow('MLEKO','CHLEB','MASLO'));
INSERT INTO zakupy VALUES (2, koszyk_produktow('SER','CHLEB'));
INSERT INTO zakupy VALUES (3, koszyk_produktow('JABLKA','GRUSZKI'));

SELECT z.id, k.* FROM zakupy z, TABLE(z.koszyk) k;

DELETE FROM zakupy
WHERE id IN (SELECT z.id FROM zakupy z, TABLE(z.koszyk) k
             WHERE k.column_value = 'CHLEB');

SELECT z.id, k.* FROM zakupy z, TABLE(z.koszyk) k;

17,18,19,20 w instrukcji
