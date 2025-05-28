#import "@preview/note-me:0.3.0": *
#import "@preview/tablex:0.0.9": tablex, rowspanx, colspanx
#let insa-short(
  author : none,
  date : none,
  doc
) = {
  set text(lang: "pl")
  set page(
    "a4",
    margin: (top: 3cm, bottom: 2cm, left: 2em, right: 2em),
    header: [
      #place(left, [#image("img/logo.png", height: 3cm) #text(smallcaps("   Eksploracja Danych, informatyka 2024/2025"), baseline: -4em)], dy: 2cm)
      #place(right + bottom)[
        #author\
        #if type(date) == datetime [
          #date.display("[day]/[month]/[year]")
        ] else [
          #date
        ]
      ]
    ],
    
  )
  doc
}
#show: doc => insa-short(
  author: [
		Jakub Bronowski, 193208
		#linebreak()
    Mikołaj Klikowicz, 193264
		#linebreak()
    Maciej Raciniewski, 189774
  ],
  doc)

#v(15pt)
#align(center, text(size: 21pt, weight: "bold", smallcaps("Projekt z przedmiotu Eksploracja Danych")))
#align(center, text(size: 12pt, weight: "bold", smallcaps("Pierwszy etap: Zrozumienie problemu + Zrozumienie danych")))
#align(center, text(size: 12pt, weight: "bold", smallcaps("Speed Dating Experiment")))
#align(center, text(size: 10pt, weight: "bold", "30.05.2025 r."))
#v(5pt)


#set heading(numbering: "1.")
/*#show heading.where(level: 2): it => [
  #counter(heading).display()
  #text(weight: "medium", style: "italic", size: 13pt, it.body)
]*/
#label("Spis treści")
#outline(title: "Spis treści", indent:  n => 1em * n, depth: 3)

#pagebreak()

= Ogólny opis zbioru
Zbiór danych zawiera informacje z eksperymentu "Speed Dating", który miał na celu zbadanie, jakie czynniki wpływają na decyzje dotyczące wyboru partnera. Eksperyment polegał na organizacji serii szybkich randek, podczas których uczestnicy mieli okazję poznać się nawzajem w krótkim czasie. Zbiór danych zawiera informacje o uczestnikach, ich preferencjach oraz wynikach randek.

???

= Określenie celu eksploracji i kryteriów sukcesu
????


= Charakterystyka zbioru danych
== Pochodzenie
https://www.kaggle.com/datasets/annavictoria/speed-dating-experiment

== Format
.csv

== Liczba przykładów
8378 rekordów

== Ilość zbiorów danych
1


= Opis atrybutów
abcd

#tablex(
  columns: 3,
  align: (center, center, center),
  widths: (2, 1, 4),
  header: true,
  [Nazwa], [Typ], [Znaczenie], 
  [iid], [Numeryczny], [numer uczestnika, unikalny w całym zbiorze],
  [id], [Numeryczny], [numer uczestnika, unikalny tylko w obrębie danego spotkania],
  [gender], [Nominalny], [płeć uczestnika (1 - mężczyzna, 0 - kobieta)],
  [idg], [Numeryczny], [numer identyfikuje, którą z kolei osobą danej płci jest zadany uczestnik np. 1 - pierwsza kobieta, 2 - druga kobieta, 1 - pierwszy mężczyzna, 2 - drugi mężczyzna],
  [condtn], [Numeryczny], [warunki przeprowadzenia eksperymentu: 1=limited choice, 2=extensive choice \ \   *cokolwiek by to znaczyło*],
  [wave], [Numeryczny], [numer wydarzenia, w której uczestnik brał udział; dookreśla inne informacje],
  [round], [Numeryczny], [ilość poznanych osób przeciwnej płci w danym wydarzeniu; tożsame z ilością rund (a.k.a. rozmów, randek), które odbyła dana osoba z osobą innej płci],
  [position], [Numeryczny], [numer stanowiska (a.k.a stolika) przy którym siedział uczestnik, gdy rozmawiał z osobą zdefiniowaną w kolumnie 'partner'],
  [positin1], [Numeryczny], [numer stanowiska (a.k.a stolika) przy którym uczestnik siedział na początku wydarzenia; tam odbył pierwszą rozmowę],
  [order], [Numeryczny], [określa, która z kolei rozmowa (a.k.a. randka) miała miejsce w danym wydarzeniu dla tej osoby; 1 - moja pierwsza rozmowa, 2 - moja druga rozmowa itd.],
  [partner], [Numeryczny], [numer uczestnika danego spotkania (kolumna id), z którym dana osoba rozmawiała w danej rundzie], 
  [pid], [Numeryczny], [unikalny numer osoby (kolumna iid), z którą rozmawiała zadana osoba],
  [match], [Nominalny], [1 - jeśli dana osoba wybrała daną osobę jako potencjalnego partnera, 0 - przypadek przeciwny],
  [int_corr], [Numeryczny], [korelacja między ocenami zainteresowań (np. bardzo lubię przejażdzki rowerem, nienawidzę grać w siatkówkę) uczestnika i partnera w Czasie 1 (tj. przed spotkaniem) \ \ wartości z przedziału [-1, 1] gdzie -1 oznacza pełną niezgodność, 1 pełną zgodność, 0 brak korelacji],    
  [samerace], [Nominalny], [1 - jeśli uczestnik i partner są tej samej rasy, 0 - jeśli nie są],
  [age_o], [Numeryczny], [wiek partnera],
  [race_o], [Nominalny], [rasa partnera (w zbiorze wartości 1-4)\ Black/African American=1 \ European/Caucasian-American=2 \ Latino/Hispanic American=3 \ Asian/Pacific Islander/Asian-American=4 \ Native American=5 \ Other=6 ],
  [pf_o_att \ pf_o_sin \ pf_o_int \ pf_o_fun \ pf_o_amb \ pf_o_sha ], [Numeryczny], [preferencje osoby mierzone w Czasie 1 (tj. przed spotkaniem), uwzględnia każdą z mierzonych 6. cech: atrakcyjność fizyczna, szczerość, inteligencja, poczucie humoru (fun), ambicja, wspólne zainresowania/hobby],
  [dec_o], [Nominalny], [1 - partner jest zainteresowany daną osobą, 0 - partner nie jest zainteresowany daną osobą],
  [attr_o \ sinc_o \ intel_o \ fun_o \ amb_o \ shar_o], [Numeryczny], [preferencje partnera mierzone w Czasie 1 (tj. przed spotkaniem), uwzględnia każdą z mierzonych 6. cech: atrakcyjność fizyczna, szczerość, inteligencja, poczucie humoru (fun), ambicja, wspólne zainresowania/hobby],
  [prob_o], [???], [ \ \ Co to jest?????? \ \ ],
  [met_o], [???], [ \ \ Co to jest?????? \ \ ],
  [age], [Numeryczny], [Wiek uczestnika; z ankiety rejestracyjnej na wydarzenie],
  [field], [Nominalne], [Nazwa kierunku studiów uczestnika w języku angielskim; z ankiety rejestracyjnej na wydarzenie],
  [field_cd], [Numeryczne], [Numeryczna reprezentacja atrybutu 'field', gdzie: \
1= Law \
2= Math \
3= Social Science, Psychologist \
4= Medical Science, Pharmaceuticals, and Bio Tech \
5= Engineering \
6= English/Creative Writing/ Journalism \
7= History/Religion/Philosophy \
8= Business/Econ/Finance \ 
9= Education, Academia \
10= Biological Sciences/Chemistry/Physics \
11= Social Work \
12= Undergrad/undecided \ 
13=Political Science/International Affairs \ 
14=Film \
15=Fine Arts/Arts Administration \
16=Languages \
17=Architecture \
18=Other],
  [undergrd], [Nominalne], [szkoła, w której uzyskano tytuł licencjata; z ankiety rejestracyjnej na wydarzenie],
  [mn_sat], [Numeryczne], [Średni wynik z egzaminu SAT ze szkoły, którą ukończyła dana osoba; z ankiety rejestracyjnej na wydarzenie ],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],
  [], [], [],

)


= Wyniki eksploracyjnej analizy danych
== Rozkłady wartości atrybutów
#figure(
	image("img/test.png", width: 90%),
	caption: "Historgram dla atrybutu <ATRYBUT>."
)


= Wnioski

== Wnioski dotyczące danych
abcd

== Korelacje między wartościami atrybutów
abcd

#figure(
	image("img/test.png", width: 90%),
	caption: "Macierz korelacji."
)

= Uwagi na temat jakości danych
abcd

== Dane brakujące
xdxdxd

== Dane niespójne
abcdabcd

== Dane niezrozumiałe
abcd abcd

== Punkty oddalone
abcd

= Podsumowanie
xdxdxd