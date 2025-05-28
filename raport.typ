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


= Opis atrybutów
abcd

#tablex(
  columns: 3,
  align: (center, center, center),
  widths: (2, 1, 4),
  header: true,
  [Nazwa], [Typ], [Znaczenie], 
  [iid], [Numeryczny], [unikalny numer uczestnika],
  [id], [Numeryczny], [numer uczestnika w ramach fali],
  [gender], [Numeryczny], [płeć uczestnika (1 - mężczyzna, 0 - kobieta)],
  [idg], [Numeryczny], [numer badanego w obrębie płci, grupy],
  [condtn], [Numeryczny], [1=limited choice, 2=extensive choice],
  [wave], [Numeryczny], [numer fali, w której uczestnik brał udział; dookreśla inne informacje],
  [round], [Numeryczny], [numer rundy, w której uczestnik brał udział],
  [position], [Numeryczny], [numer stacji, na której partnerzy poznali się],
  [positin1], [Numeryczny], [numer stacji, na której zachęto zabawę],
  [order], [Numeryczny], [ilość randek zadaniej nocy]

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