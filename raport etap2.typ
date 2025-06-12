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
#align(center, text(size: 12pt, weight: "bold", smallcaps("Drugi etap: Przygotowanie danych + Modelowanie")))
#align(center, text(size: 12pt, weight: "bold", smallcaps("Speed Dating Experiment")))
#align(center, text(size: 10pt, weight: "bold", "13.06.2025 r."))
#v(5pt)


#set heading(numbering: "1.")
/*#show heading.where(level: 2): it => [
  #counter(heading).display()
  #text(weight: "medium", style: "italic", size: 13pt, it.body)
]*/
#label("Spis treści")
#outline(title: "Spis treści", indent:  n => 1em * n, depth: 3)

#pagebreak()
= Charakterystyka zbioru danych
== Pochodzenie
https://www.kaggle.com/datasets/annavictoria/speed-dating-experiment

== Format
.csv

== Liczba przykładów
8378 rekordów

== Ilość zbiorów danych
1

= Cel eksploracji i kryteria sukcesu
Celem eksploracji danych ze zbioru "Speed Dating Experiment" jest znalezienie odpowiedzi na pytania: 
- Czy ludzie potrafią dokładnie przewidzieć swoją postrzeganą wartość na rynku randkowym?
- Sprawdzenie, jaki atrybut najmocniej wpływa na dobór partnera przeciwnej płci.
\ 
Kryteria sukcesu, które zostaną przyjęte w celu oceny skuteczności eksploracji danych, obejmują:
- wysoka korelacja (>= 0,6) między przewidywaną a rzeczywistą wartością uczestników na rynku randkowym
- zidentyfikowanie cech, które mają największy wpływ na postrzeganą wartość uczestników
- przeprowadzenie analizy istotności atrybutów ze wskazaniem najistotniejszego


= Dyskusja kroków dalszego postępowania
== Założenia wstępne
< opisać, jeśli są lub brak >

== Testowanie wyników
< cośtam >


= Przygotowanie danych
== Dane brakujące i dane do ujednolicenia
< usunąć, jeśli nie występują>

== Zamiana na nominalne/numeryczne
< usunąć, jeśli nie występuje>

== Podzbiór danych
< krótki opis podziboru danych, który analizowaliśmy >

= Wyniki i model
== Krótki opis modelu
< do opisania, uwzględnić parametry modelu >

== Wyniki osiągnięte przez model
< wyniki, może być w formie tabeli > \
< jeśli drzewo, wstawić obrazek drzewa >

= Optymalizacja modelu 
< opis zmian i optymalizacji: co, dlaczego, na ile ustawiono, inny podzbiór danych > \
< dodatkowe podpunkty w miarę potrzeb >

= Wnioski
< wnioski końcowe, osiągnięte wyniki, komentarz, jakie parametry były najlepsze >