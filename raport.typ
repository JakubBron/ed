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
Zbiór danych zawiera informacje z eksperymentu "Speed Dating", który miał na celu zbadanie, jakie czynniki wpływają na decyzje dotyczące wyboru partnera. Eksperyment polegał na organizacji serii szybkich randek, podczas których uczestnicy mieli okazję poznać się nawzajem w krótkim czasie. Zbiór danych zawiera informacje o uczestnikach, ich preferencjach badanych w różnych momentach oraz wynikach randek.
\ \
_Celem uproszczenia opisu atrybutów, niektóre z nich mają w opisie pytania. Atrybut taki odpowiada na to pytanie._
\ \ 
W raporcie używa się słów i zwrotów: 
- wydarzenie - jedno z 21 spotkań speed datingu
- runda / randka / rozmowa - spotkanie dwóch osób i rozmowa między nimi, tzw. randka
- uczestnik - osoba biorąca udział w wydarzeniu, uczestnik rozmowy; kobieta lub mężczyzna
- 6. cech - sześć cech, które były badane w eksperymencie: atrakcyjność fizyczna, szczerość, inteligencja, poczucie humoru (fun), ambicja, wspólne zainteresowania/hobby
- stanowisko / stolik - rozróżnialne między sobą miejsca, w którym znajdował się uczestnik podczas rozmowy z osobą przeciwnej płci
- Czas 1 - moment przed wydarzeniem, w którym uczestnicy wypełniali ankiety dotyczące ich preferencji i oczekiwań



= Określenie celu eksploracji i kryteriów sukcesu
Celem eksploracji danych ze zbioru "Speed Dating Experiment" jest znalezienie odpowiedzi na pytania: 
- Czy ludzie potrafią dokładnie przewidzieć swoją postrzeganą wartość na rynku randkowym?
- Sprawdzenie, jaki atrybut najmocniej wpływa na dobór partnera przeciwnej płci.
\ 
Kryteria sukcesu, które zostaną przyjęte w celu oceny skuteczności eksploracji danych, obejmują:
- wysoka korelacja (>= 0,6) między przewidywaną a rzeczywistą wartością uczestników na rynku randkowym
- zidentyfikowanie cech, które mają największy wpływ na postrzeganą wartość uczestników
- przeprowadzenie analizy istotności atrybutów ze wskazaniem najistotniejszego


= Charakterystyka zbioru danych
== Pochodzenie
https://www.kaggle.com/datasets/annavictoria/speed-dating-experiment

== Format
.csv

== Liczba przykładów
8378 rekordów

== Ilość zbiorów danych
1

#pagebreak()

= Opis atrybutów
Opis atrybutów przedstawia poniższa tabela. Warto nadmienić, że przez zbieranie danych o preferencjach nawet do 3-4 tygodni po zakończeniu wydarzenia i opublikowaniu rezultatów szybkich randek nie dla każdego zestawu parametrów jest dostępna pełna informacja. 

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
  [condtn], [Numeryczny], [warunki przeprowadzenia eksperymentu: 1=limited choice, 2=extensive choice],
  [wave], [Numeryczny], [numer wydarzenia (które z kolei), w którym uczestnik brał udział; dookreśla inne informacje],
  [round], [Numeryczny], [ilość poznanych osób przeciwnej płci w danym wydarzeniu; tożsame z ilością rund (a.k.a. rozmów, randek), które odbyła dana osoba z osobą innej płci],
  [position], [Numeryczny], [numer stanowiska (a.k.a stolika) przy którym siedział uczestnik, gdy rozmawiał z osobą zdefiniowaną w kolumnie 'partner'],
  [positin1], [Numeryczny], [numer stanowiska (a.k.a stolika) przy którym uczestnik siedział na początku wydarzenia; tam odbył pierwszą rozmowę],
  [order], [Numeryczny], [określa, która z kolei rozmowa (a.k.a. randka) miała miejsce w danym wydarzeniu dla tej osoby; 1 - moja pierwsza rozmowa, 2 - moja druga rozmowa itd.],
  [partner], [Numeryczny], [numer uczestnika danego spotkania (kolumna id), z którym dana osoba rozmawiała w danej rundzie], 
  [pid], [Numeryczny], [unikalny numer osoby (kolumna iid), z którą rozmawiała zadana osoba],
  [match], [Nominalny], [1 - jeśli dana osoba wybrała daną osobę jako potencjalnego partnera, 0 - przypadek przeciwny],
  [int_corr], [Numeryczny], [korelacja między ocenami zainteresowań (np. bardzo lubię przejażdżki rowerem, nienawidzę grać w siatkówkę) uczestnika i partnera w Czasie 1 (tj. przed spotkaniem) \ \ wartości z przedziału [-1, 1] gdzie -1 oznacza pełną niezgodność, 1 pełną zgodność, 0 brak korelacji],    
  [samerace], [Nominalny], [1 - jeśli uczestnik i partner są tej samej rasy, 0 - jeśli nie są],
  [age_o], [Numeryczny], [wiek partnera],
  [race_o], [Nominalny], [rasa partnera (w zbiorze wartości 1-4), gdzie: \ Black/African American=1 \ European/Caucasian-American=2 \ Latino/Hispanic American=3 \ Asian/Pacific Islander/Asian-American=4 \ Native American=5 \ Other=6 ],
  [pf_o_att \ pf_o_sin \ pf_o_int \ pf_o_fun \ pf_o_amb \ pf_o_sha ], [Numeryczny], [preferencje osoby mierzone w Czasie 1 (tj. przed spotkaniem), uwzględnia każdą z mierzonych 6. cech: atrakcyjność fizyczna, szczerość, inteligencja, poczucie humoru (fun), ambicja, wspólne zainteresowania/hobby. \ Metoda oceny (domniemana po przeglądzie danych): \ podział 100 punktów, więcej = ważniejsze],
  [dec_o], [Nominalny], [1 - partner jest zainteresowany daną osobą, 0 - partner nie jest zainteresowany daną osobą],
  [attr_o \ sinc_o \ intel_o \ fun_o \ amb_o \ shar_o], [Numeryczny], [preferencje partnera mierzone w Czasie 1 (tj. przed spotkaniem), uwzględnia każdą z mierzonych 6. cech: atrakcyjność fizyczna, szczerość, inteligencja, poczucie humoru (fun), ambicja, wspólne zainteresowania/hobby \ Metoda oceny (domniemana po przeglądzie danych): \ skala 1-10, gdzie 1 - najmniej istotne, 10 - najbardziej istotne],
  [prob_o], [???], [ \ \ Niemożliwe do określenia, niewskazane w opisie zbioru. \ Prawdopodobnie atrybut oceniany w skali 1-10, gdzie 1 - najmniej istotne, 10 - najbardziej istotne \ \ ],
  [met_o], [???], [ \ \ Niemożliwe do określenia, niewskazane w opisie zbioru. \ \ ],
  [age], [Numeryczny], [Wiek uczestnika; z ankiety rejestracyjnej na wydarzenie],
  [field], [Nominalne], [Nazwa kierunku studiów uczestnika w języku angielskim; z ankiety rejestracyjnej na wydarzenie],
  [field_cd], [Nominalne], [Numeryczna reprezentacja atrybutu 'field', gdzie: \
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
  [mn_sat], [Numeryczne], [średni wynik z egzaminu SAT ze szkoły, którą ukończyła dana osoba; z ankiety rejestracyjnej na wydarzenie; proxy na określenie inteligencji],
  [tuition], [Numeryczne], [czesne za szkołę, którą ukończyła dana osoba; z ankiety rejestracyjnej na wydarzenie; tylko dla licencjatów],
  [race], [Nominalne], [Rasa uczestnika, gdzie: \ Black/African American=1
European/Caucasian-American=2 \ 
Latino/Hispanic American=3 \
Asian/Pacific Islander/Asian-American=4 \
Native American=5 \
Other=6],
  [imprace], [Numeryczne], [Jak ważne jest dla Ciebie (w skali od 1 do 10), aby osoba, z którą się umawiasz, była tego samego pochodzenia
pochodzenia rasowego/etnicznego?],
  [imprelig], [Numeryczne], [Jak ważne jest dla Ciebie (w skali od 1 do 10), aby osoba, z którą się umawiasz, była tego samego pochodzenia
religijnego?],
  [from], [Nominalne], [pochodzenie uczestnika],
  [zipcode], [Nominalne], [kod pocztowy miejsca pochodzenia uczestnika],
  [income], [Numeryczne], [średni dochód gospodarstwa domowego w miejscu pochodzenia uczestnika; z Census Bureau; brak danych = pochodzenie zagraniczne lub niepodany kod pocztowy],
  [goal], [Nominalne], [główny cel uczestnika wzięcia udziału w wydarzeniu, gdzie: \ Seemed like a fun night out=1 \
To meet new people=2 \
To get a date=3 \
Looking for a serious relationship=4 \
To say I did it=5 \
Other=6 \ 
],
  [date], [Nominalne], [Jak często chodzisz na randki? Gdzie: \ Several times a week=1 \
Twice a week=2 \
Once a week=3 \
Twice a month=4 \
Once a month=5 \
Several times a year=6 \
Almost never=7],
  [go out], [Nominalne], [Jak często wychodzisz na imprezy? Gdzie: \ Several times a week=1 \
Twice a week=2 \
Once a week=3 \
Twice a month=4 \
Once a month=5 \
Several times a year=6 \
Almost never=7],
  [career], [Nominalne], [Jaką ścieżkę kariery chciałbyś obrać?],
  [career_c], [Nominalne], [Zakodowana odpowiedź na pytanie o ścieżkę kariery, gdzie: \ 1= Lawyer \
2= Academic/Research \
3= Psychologist \
4= Doctor/Medicine \
5=Engineer \
6= Creative Arts/Entertainment \
7= Banking/Consulting/Finance/Marketing/Business/CEO/Entrepreneur/Admin \
8= Real Estate \
9= International/Humanitarian Affairs \
10= Undecided \
11=Social Work \
12=Speech Pathology \
13=Politics \
14=Pro sports/Athletics \
15=Other \
16=Journalism \
17=Architecture \
],
  [sports \ tvsports \ exercise \ dining \ museums \ art \ hiking \ gaming \ clubbing \ reading \ tv \ theater \ movies \ concerts \ music \ shopping \ yoga
  ], [Numeryczne], [Odpowiedź na pytanie: Jak bardzo jesteś zainteresowany {nazwa aktywności korespondująca z nazwą atrybutu}, w skali od 1 do 10? \ \ Mniej oczywiste atrybuty: \
  tvsports: oglądanie sportów \ yoga: joga lub medytacja ],
  [exphappy], [Numeryczne], [Ogólnie rzecz biorąc, w skali od 1 do 10, jak szczęśliwy spodziewasz się być z ludźmi poznanymi podczas speed-datingu?],
  [expnum], [Numeryczne], [Jak myślisz, ile z 20 osób, które spotkasz, będzie zainteresowanych randką z Tobą?],
  [attr1_1 \ sinc1_1 \ intel1_1 \ fun1_1 \ amb1_1 \ shar1_1 \ attr4_1 \ sinc4_1 \ intel4_1 \ fun4_1 \ amb4_1 \ shar4_1 \ attr2_1 \ sinc2_1 \ intel2_1 \ fun2_1 \ amb2_1 \ shar2_1 \ attr3_1 \ sinc3_1 \ fun3_1 \ intel3_1 \ amb3_1 \ attr5_1 \ sinc5_1 \ intel5_1 \ fun5_1 \ amb5_1], [Numeryczne], [Atrybuty opisujące każdą z mierzonych 6. cech: atrakcyjność fizyczna, szczerość, inteligencja, poczucie humoru (fun), ambicja, wspólne zainteresowania/hobby w rożnych kontekstach. Kontekst definiuje pierwsza cyfra. \ \ Dla pierwszej cyfry równej: \
  1: tego poszukuję u osoby przeciwnej płci \
  wydarzenia numer 6-9: ocena w skali 1 - 10, gdzie 1 = bardzo nieistotne, 10 = bardzo istotne, \
  pozostałewydarzenia: 100 punktów do rozdysponowania, więcej = bardziej istotne \ \ \


  2: Jak myślisz, czego płeć przeciwna szuka na randce? \ 
  wydarzenia numer 6-9: ocena w skali 1 - 10, gdzie 1 = bardzo nieistotne, 10 = bardzo istotne, \
  pozostałewydarzenia: 100 punktów do rozdysponowania, więcej = bardziej istotne \ \ \


  3: Jak myślisz, jak się mierzysz? Oceń swoją opinię na temat własnych atrybutów w skali od 1 do 10 (bądź szczery!) \
  Ocena tylko w skali 1-10 \ \ \


  4: tego poszukują inne osoby (własna opinia nt. preferencji innych) \
  wydarzenia numer 6-9: ocena w skali 1 - 10, gdzie 1 = bardzo nieistotne, 10 = bardzo istotne, \
  wydarzenia numer 10-21: 100 punktów do rozdysponowania, więcej = bardziej istotne \
  UWAGA! Nie mierzono tych parametrów dla wydarzeń numer 1-5! \ \ \
  

  5: Jak myślisz, jak postrzegają cię inni? \
  Ocena tylko w skali 1-10, gdzie 1 - okropnie, 10 - świetnie
  ],
  [dec], [Nominalne], [Ocena chęci ponownego spotkania się uczestnika badania z osobą, z którą właśnie zakończył rozmowę. Gdzie: 1 - tak, 0 - nie],
  [attr \ sinc \ intel \ fun \ amb \ shar], [Numeryczne], [Ocena każdej z 6. cech: atrakcyjność fizyczna, szczerość, inteligencja, poczucie humoru (fun), ambicja, wspólne zainteresowania/hobby w skali od 1 do 10, gdzie 1 - okropnie, 10 - świetnie. Dotyczy osoby, z którą właśnie zakończono rozmowę.],
  [like], [Numeryczne], [Ogólnie rzecz biorąc, jak bardzo lubisz tę osobę? Gdzie: 1=wcale nie lubię, 10=bardzo ją lubię],
  [prob], [Numeryczne], [Jak bardzo prawdopodobne jest, że ta osoba powie ci „tak”? Gdzie: 1=nieprawdopodobne, 10=niezwykle prawdopodobne],
  [met], [Nominalne], [Czy znałeś wcześniej tę osobę? Gdzie: 1=tak, 2=nie],
  [match_es], [Numeryczne], [Ile dopasowań szacujesz, że uzyskasz (dopasowanie ma miejsce, gdy ty i twój partner zdecydujecie „Tak”)?],
  [attr1_s \ sinc1_s \ intel1_s \ fun1_s \ amb1_s \ shar1_s], [Numeryczne], [Określ ważność każdej z 6. cech: atrakcyjność fizyczna, szczerość, inteligencja, poczucie humoru (fun), ambicja, wspólne zainteresowania/hobby w skali od 1 do 10, gdzie 1 - wcale nieważne, 10 - bardzo ważne. \ Ankieta przeprowadzona w połowie wydarzenia.],
  [attr3_s \ sinc3_s \ intel3_s \ fun3_s \ amb3_s], [Numeryczne], [Oceń swoją opinię na temat własnych atrybutów w skali od 1 do 10 (1 = okropne, 10 = świetne). Bądź szczery! \ Ankieta przeprowadzona w połowie wydarzenia.],
  [satis_2], [Numeryczne], [Ogólnie rzecz biorąc, jak bardzo jesteś zadowolony z ludzi, których spotkałeś? Gdzie 1=zupełnie niezadowolony, 10=bardzo zadowolony \ \ Odpowiedź uzyskana dzień po wydarzeniu.],
  [length], [Nominalne], [Ocena czasu trwania rundy (4 min), gdzie: \ Too little=1 \ Too much=2 \ Just Right=3 \ \ Odpowiedź uzyskana dzień po wydarzeniu.],
  [numdat_2], [Nominalne], [Oceń liczbę „szybkich randek”, które odbyłeś, gdzie: \ Too little=1 \ Too much=2 \ Just Right=3  \ \ Odpowiedź uzyskana dzień po wydarzeniu.],
  [attr7_2 \ sinc7_2 \ intel7_2 \ fun7_2 \ amb7_2 \ shar7_2], [Numeryczne], [Ponowna ocena istotności każdej z 6. cech: atrakcyjność fizyczna, szczerość, inteligencja, poczucie humoru (fun), ambicja, wspólne zainteresowania/hobby. \ Metoda oceny: podział 100 punktów, więcej = ważniejsze \ \ Odpowiedź uzyskana dzień po wydarzeniu.],
  [attr1_2 \ sinc1_2 \ intel1_2 \ fun1_2 \ amb1_2 \ shar1_2], [Numeryczne], [Ocena istotności każdej z 6. cech: atrakcyjność fizyczna, szczerość, inteligencja, poczucie humoru (fun), ambicja, wspólne zainteresowania/hobby obrazująca to, czego dany uczestnik poszukiwał u partnera przeciwnej płci. \ \  Metoda oceny: \ Wydarzenia 6-9: ocena w skali 1 - 10, gdzie 1 = bardzo nieistotne, 10 = bardzo istotne, \
  Pozostałe wydarzenia: 100 punktów do rozdysponowania, więcej = bardziej istotne \ \ \ Odpowiedź uzyskana dzień po wydarzeniu.],
  [attr4_2 \ sinc4_2 \ intel4_2 \ fun4_2 \ amb4_2 \ shar4_2], [Numeryczne], [Ocena istotności każdej z 6. cech: atrakcyjność fizyczna, szczerość, inteligencja, poczucie humoru (fun), ambicja, wspólne zainteresowania/hobby obrazująca to, co jest najbardziej pożądaną cechą u partnera przeciwnej płci (własna opinia nt. preferencji innych). \ Metoda oceny: \ 
  100 punktów do rozdysponowania, więcej = bardziej istotne \ \ \ Odpowiedź uzyskana dzień po wydarzeniu.],
  
  [attr2_2 \ sinc2_2 \ intel2_2 \ fun2_2 \ amb2_2 \ shar2_2], [Numeryczne], [Jak myślisz, czego szuka płeć przeciwna na randce? (własna opinia nt. preferencji innych osób, ocena istotności każdej z 6. cech: atrakcyjność fizyczna, szczerość, inteligencja, poczucie humoru (fun), ambicja, wspólne zainteresowania/hobby). 
  \ Metoda oceny: \
  100 punktów do rozdysponowania, więcej = bardziej istotne \ \ \  Odpowiedź uzyskana dzień po wydarzeniu.],
  [attr3_2 \ sinc3_2 \ fun3_2 \ intel3_2 \ amb3_2], [Numeryczne], [Jak myślisz, jak się oceniasz? Oceń swoją opinię na temat własnych atrybutów w skali od 1 do 10, gdzie 1 = okropny i 10 = świetny. Bądź szczery! \ \ \ Odpowiedź uzyskana dzień po wydarzeniu.],
  [attr5_2 \ sinc5_2 \ intel5_2 \ fun5_2 \ amb5_2], [Numeryczne], [Jak myślisz, jak postrzegają Cię inni? Oceń siebie tak, jak myślisz, że inni oceniliby Cię w każdym z poniższych atrybutów, w skali od 1 do 10 (1 = 
  okropny, 10 = świetny) \ \ \ Odpowiedź uzyskana dzień po wydarzeniu.],

// 3-4 tygodnie po spotkaniu 

  [you_call], [Numeryczne], [Z iloma osobami, z którymi miałeś dopasowanie, skontaktowałeś się, aby umówić się na randkę? \ \ \ Odpowiedź uzyskana 3-4 tygodnie po wydarzeniu.],
  [them_cal], [Numeryczne], [Ile osób, z którymi miałeś dopasowanie, skontaktowało się z Tobą? \ \ \ Odpowiedź uzyskana 3-4 tygodnie po wydarzeniu.],
  [date_3], [Nominalne], [Czy byłeś na randce z kimś, z kim miałeś dopasowanie? Gdzie: 1=tak, 2=nie \ \ \ Odpowiedź uzyskana 3-4 tygodnie po wydarzeniu.],
  [numdat_3], [Numeryczne], [ {JEŚLI BYŁEŚ NA CO NAJMNIEJ JEDNEJ RANDCE} \ Z iloma partnerami byłeś do tej pory na randce? \ \ \ Odpowiedź uzyskana 3-4 tygodnie po wydarzeniu.],
  [num_in_3], [Numeryczne], [ {JEŚLI BYŁEŚ NA CO NAJMNIEJ JEDNEJ RANDCE} \ Jeśli tak, to z iloma? \ \  Odpowiedź uzyskana 3-4 tygodnie po wydarzeniu.\ \ \ _Definicja atrybutu niezrozumiała (również po angielsku)_.],
  [attr1_3 \ sinc1_3 \ intel1_3 \ fun1_3 \ amb1_3 \ shar1_3], [Numeryczne], [Ocena istotności każdej z 6. cech: atrakcyjność fizyczna, szczerość, inteligencja, poczucie humoru (fun), ambicja, wspólne zainteresowania/hobby obrazująca to, czego dany uczestnik poszukiwał u partnera przeciwnej płci. \ \  Metoda oceny: \ 100 punktów do rozdysponowania, więcej = bardziej istotne \ \ \ Odpowiedź uzyskana 3-4 tygodnie po wydarzeniu.],
  [attr7_3 \ sinc7_3 \ intel7_3 \ fun7_3 \ amb7_3 \ shar7_3], [Numeryczne], [Ocena istotności każdej z 6. cech: atrakcyjność fizyczna, szczerość, inteligencja, poczucie humoru (fun), ambicja, wspólne zainteresowania/hobby obrazująca to, co ma w rzeczywistości największe znaczenie dla uczestnika. \ Metoda oceny: \ podział 100 punktów, więcej = ważniejsze \ \ \ Odpowiedź uzyskana 3-4 tygodnie po wydarzeniu.],
  [attr4_3 \ sinc4_3 \ intel4_3 \ fun4_3 \ amb4_3 \ shar4_3], [Numeryczne], [Ocena istotności każdej z 6. cech: atrakcyjność fizyczna, szczerość, inteligencja, poczucie humoru (fun), ambicja, wspólne zainteresowania/hobby obrazująca to, co jest najbardziej pożądaną cechą u partnera przeciwnej płci (własna opinia nt. preferencji innych). \ Metoda oceny: \ skala 1-10, gdzie 1 - bardzo nieistotne, 10 - bardzo istotne \ \ \ Odpowiedź uzyskana 3-4 tygodnie po wydarzeniu.],
  [attr2_3 \ sinc2_3 \ intel2_3 \ fun2_3 \ amb2_3 \ shar2_3], [Numeryczne], [Jak myślisz, czego szuka płeć przeciwna na randce? (własna opinia nt. preferencji innych osób, ocena istotności każdej z 6. cech: atrakcyjność fizyczna, szczerość, inteligencja, poczucie humoru (fun), ambicja, wspólne zainteresowania/hobby). \ Metoda oceny: \ skala 1-10, gdzie 1 - bardzo nieistotne, 10 - bardzo istotne \ \ \ Odpowiedź uzyskana 3-4 tygodnie po wydarzeniu.],
  [attr3_3 \ sinc3_3 \ intel3_3 \ fun3_3 \ amb3_3], [Numeryczne], [Jak myślisz, jak się oceniasz? Oceń swoją opinię na temat własnych atrybutów. Bądź szczery! \ Metoda oceny: \ skala 1-10, gdzie 1 = okropny, 10 = świetny \ \ \ Odpowiedź uzyskana 3-4 tygodnie po wydarzeniu.],
  [attr5_3 \ sinc5_3 \ intel5_3 \ fun5_3 \ amb5_3], [Numeryczne], [Jak myślisz, jak postrzegają Cię inni? Oceń siebie tak, jak myślisz, że inni oceniliby Cię w każdym z poniższych atrybutów. \ Metoda oceny: \ skala 1-10, gdzie 1 - okropnie, 10 - świetnie. \ \ \ Odpowiedź uzyskana 3-4 tygodnie po wydarzeniu.],
)


= Wyniki eksploracyjnej analizy danych
== Rozkłady wartości atrybutów (histogramy)
#table(columns: (auto, auto), inset: 5pt, align: center, [attr1_1], figure(image("img/hist_attr1_1.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [sinc1_1], figure(image("img/hist_sinc1_1.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [intel1_1], figure(image("img/hist_intel1_1.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [fun1_1], figure(image("img/hist_fun1_1.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [amb1_1], figure(image("img/hist_amb1_1.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [shar1_1], figure(image("img/hist_shar1_1.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [attr2_1], figure(image("img/hist_attr2_1.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [sinc2_1], figure(image("img/hist_sinc2_1.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [intel2_1], figure(image("img/hist_intel2_1.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [fun2_1], figure(image("img/hist_fun2_1.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [amb2_1], figure(image("img/hist_amb2_1.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [shar2_1], figure(image("img/hist_shar2_1.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [attr3_1], figure(image("img/hist_attr3_1.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [sinc3_1], figure(image("img/hist_sinc3_1.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [intel3_1], figure(image("img/hist_intel3_1.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [fun3_1], figure(image("img/hist_fun3_1.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [amb3_1], figure(image("img/hist_amb3_1.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [attr1_2], figure(image("img/hist_attr1_2.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [sinc1_2], figure(image("img/hist_sinc1_2.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [intel1_2], figure(image("img/hist_intel1_2.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [fun1_2], figure(image("img/hist_fun1_2.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [amb1_2], figure(image("img/hist_amb1_2.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [shar1_2], figure(image("img/hist_shar1_2.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [attr3_2], figure(image("img/hist_attr3_2.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [sinc3_2], figure(image("img/hist_sinc3_2.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [intel3_2], figure(image("img/hist_intel3_2.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [fun3_2], figure(image("img/hist_fun3_2.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [amb3_2], figure(image("img/hist_amb3_2.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [pf_o_att], figure(image("img/hist_pf_o_att.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [pf_o_sin], figure(image("img/hist_pf_o_sin.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [pf_o_int], figure(image("img/hist_pf_o_int.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [pf_o_fun], figure(image("img/hist_pf_o_fun.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [pf_o_amb], figure(image("img/hist_pf_o_amb.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [pf_o_sha], figure(image("img/hist_pf_o_sha.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [attr_o], figure(image("img/hist_attr_o.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [sinc_o], figure(image("img/hist_sinc_o.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [intel_o], figure(image("img/hist_intel_o.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [fun_o], figure(image("img/hist_fun_o.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [amb_o], figure(image("img/hist_amb_o.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [shar_o], figure(image("img/hist_shar_o.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [round], figure(image("img/hist_round.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [age_o], figure(image("img/hist_age_o.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [age], figure(image("img/hist_age.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [imprace], figure(image("img/hist_imprace.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [goal], figure(image("img/hist_goal.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [date], figure(image("img/hist_date.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [go_out], figure(image("img/hist_go_out.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [exphappy], figure(image("img/hist_exphappy.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [expnum], figure(image("img/hist_expnum.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [sports], figure(image("img/hist_sports.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [tvsports], figure(image("img/hist_tvsports.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [exercise], figure(image("img/hist_exercise.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [dining], figure(image("img/hist_dining.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [museums], figure(image("img/hist_museums.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [art], figure(image("img/hist_art.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [hiking], figure(image("img/hist_hiking.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [gaming], figure(image("img/hist_gaming.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [clubbing], figure(image("img/hist_clubbing.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [reading], figure(image("img/hist_reading.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [tv], figure(image("img/hist_tv.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [theater], figure(image("img/hist_theater.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [movies], figure(image("img/hist_movies.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [concerts], figure(image("img/hist_concerts.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [music], figure(image("img/hist_music.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [shopping], figure(image("img/hist_shopping.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [yoga], figure(image("img/hist_yoga.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [satis_2], figure(image("img/hist_satis_2.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [length], figure(image("img/hist_length.png", height: 40%),))
#table(columns: (auto, auto), inset: 5pt, align: center, [numdat_2], figure(image("img/hist_numdat_2.png", height: 40%),))

// wykresy pudełkowe
== Punkty oddalone i rozkłady wartości atrybutów (wykresy pudełkowe)
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [attr1_1], figure(image("img/box_attr1_1.png"),), [
Mediana: 20.0

Przedział wartości występujących najczęściej: \
[15.0; 30.0]

Liczba punktów oddalonych: 1265
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [sinc1_1], figure(image("img/box_sinc1_1.png"),), [
Mediana: 19.0

Przedział wartości występujących najczęściej: \
[10.0; 20.0]

Liczba punktów oddalonych: 1131
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [intel1_1], figure(image("img/box_intel1_1.png"),), [
Mediana: 20.0

Przedział wartości występujących najczęściej: \
[18.0; 25.0]

Liczba punktów oddalonych: 1514
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [fun1_1], figure(image("img/box_fun1_1.png"),), [
Mediana: 18.0

Przedział wartości występujących najczęściej: \
[12.0; 20.0]

Liczba punktów oddalonych: 1694
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [amb1_1], figure(image("img/box_amb1_1.png"),), [
Mediana: 10.0

Przedział wartości występujących najczęściej: \
[5.0; 15.0]

Liczba punktów oddalonych: 1125
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [shar1_1], figure(image("img/box_shar1_1.png"),), [
Mediana: 10.0

Przedział wartości występujących najczęściej: \
[5.0; 15.0]

Liczba punktów oddalonych: 1311
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [attr2_1], figure(image("img/box_attr2_1.png"),), [
Mediana: 30.0

Przedział wartości występujących najczęściej: \
[20.0; 40.0]

Liczba punktów oddalonych: 1464
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [sinc2_1], figure(image("img/box_sinc2_1.png"),), [
Mediana: 10.0

Przedział wartości występujących najczęściej: \
[10.0; 18.0]

Liczba punktów oddalonych: 1924
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [intel2_1], figure(image("img/box_intel2_1.png"),), [
Mediana: 15.0

Przedział wartości występujących najczęściej: \
[10.0; 20.0]

Liczba punktów oddalonych: 872
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [fun2_1], figure(image("img/box_fun2_1.png"),), [
Mediana: 20.0

Przedział wartości występujących najczęściej: \
[15.0; 20.0]

Liczba punktów oddalonych: 1766
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [amb2_1], figure(image("img/box_amb2_1.png"),), [
Mediana: 10.0

Przedział wartości występujących najczęściej: \
[5.0; 15.0]

Liczba punktów oddalonych: 1168
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [shar2_1], figure(image("img/box_shar2_1.png"),), [
Mediana: 10.0

Przedział wartości występujących najczęściej: \
[5.0; 15.0]

Liczba punktów oddalonych: 1057
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [attr3_1], figure(image("img/box_attr3_1.png"),), [
Mediana: 7.0

Przedział wartości występujących najczęściej: \
[6.0; 8.0]

Liczba punktów oddalonych: 973
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [sinc3_1], figure(image("img/box_sinc3_1.png"),), [
Mediana: 8.0

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 1021
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [intel3_1], figure(image("img/box_intel3_1.png"),), [
Mediana: 8.0

Przedział wartości występujących najczęściej: \
[8.0; 9.0]

Liczba punktów oddalonych: 1343
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [fun3_1], figure(image("img/box_fun3_1.png"),), [
Mediana: 8.0

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 1244
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [amb3_1], figure(image("img/box_amb3_1.png"),), [
Mediana: 8.0

Przedział wartości występujących najczęściej: \
[6.0; 9.0]

Liczba punktów oddalonych: 1084
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [attr1_2], figure(image("img/box_attr1_2.png"),), [
Mediana: 25.0

Przedział wartości występujących najczęściej: \
[20.0; 30.0]

Liczba punktów oddalonych: 1645
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [sinc1_2], figure(image("img/box_sinc1_2.png"),), [
Mediana: 15.0

Przedział wartości występujących najczęściej: \
[10.0; 20.0]

Liczba punktów oddalonych: 864
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [intel1_2], figure(image("img/box_intel1_2.png"),), [
Mediana: 20.0

Przedział wartości występujących najczęściej: \
[15.0; 20.0]

Liczba punktów oddalonych: 1465
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [fun1_2], figure(image("img/box_fun1_2.png"),), [
Mediana: 20.0

Przedział wartości występujących najczęściej: \
[15.0; 20.0]

Liczba punktów oddalonych: 1400
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [amb1_2], figure(image("img/box_amb1_2.png"),), [
Mediana: 10.0

Przedział wartości występujących najczęściej: \
[5.0; 10.0]

Liczba punktów oddalonych: 1366
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [shar1_2], figure(image("img/box_shar1_2.png"),), [
Mediana: 10.0

Przedział wartości występujących najczęściej: \
[10.0; 16.0]

Liczba punktów oddalonych: 1731
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [attr3_2], figure(image("img/box_attr3_2.png"),), [
Mediana: 7.0

Przedział wartości występujących najczęściej: \
[6.0; 8.0]

Liczba punktów oddalonych: 857
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [sinc3_2], figure(image("img/box_sinc3_2.png"),), [
Mediana: 8.0

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 859
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [intel3_2], figure(image("img/box_intel3_2.png"),), [
Mediana: 8.0

Przedział wartości występujących najczęściej: \
[8.0; 9.0]

Liczba punktów oddalonych: 1165
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [fun3_2], figure(image("img/box_fun3_2.png"),), [
Mediana: 8.0

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 948
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [amb3_2], figure(image("img/box_amb3_2.png"),), [
Mediana: 8.0

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 1175
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [pf_o_att], figure(image("img/box_pf_o_att.png"),), [
Mediana: 20.0

Przedział wartości występujących najczęściej: \
[15.0; 30.0]

Liczba punktów oddalonych: 1259
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [pf_o_sin], figure(image("img/box_pf_o_sin.png"),), [
Mediana: 19.5

Przedział wartości występujących najczęściej: \
[10.0; 20.0]

Liczba punktów oddalonych: 1129
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [pf_o_int], figure(image("img/box_pf_o_int.png"),), [
Mediana: 20.0

Przedział wartości występujących najczęściej: \
[18.0; 25.0]

Liczba punktów oddalonych: 1509
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [pf_o_fun], figure(image("img/box_pf_o_fun.png"),), [
Mediana: 18.0

Przedział wartości występujących najczęściej: \
[12.0; 20.0]

Liczba punktów oddalonych: 1691
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [pf_o_amb], figure(image("img/box_pf_o_amb.png"),), [
Mediana: 10.0

Przedział wartości występujących najczęściej: \
[5.0; 15.0]

Liczba punktów oddalonych: 1125
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [pf_o_sha], figure(image("img/box_pf_o_sha.png"),), [
Mediana: 10.0

Przedział wartości występujących najczęściej: \
[5.0; 15.0]

Liczba punktów oddalonych: 1309
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [attr_o], figure(image("img/box_attr_o.png"),), [
Mediana: 6.0

Przedział wartości występujących najczęściej: \
[5.0; 7.0]

Liczba punktów oddalonych: 1651
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [sinc_o], figure(image("img/box_sinc_o.png"),), [
Mediana: 7.0

Przedział wartości występujących najczęściej: \
[6.0; 8.0]

Liczba punktów oddalonych: 1404
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [intel_o], figure(image("img/box_intel_o.png"),), [
Mediana: 7.0

Przedział wartości występujących najczęściej: \
[6.0; 8.0]

Liczba punktów oddalonych: 1273
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [fun_o], figure(image("img/box_fun_o.png"),), [
Mediana: 6.0

Przedział wartości występujących najczęściej: \
[5.0; 8.0]

Liczba punktów oddalonych: 1082
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [amb_o], figure(image("img/box_amb_o.png"),), [
Mediana: 7.0

Przedział wartości występujących najczęściej: \
[6.0; 8.0]

Liczba punktów oddalonych: 1488
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [shar_o], figure(image("img/box_shar_o.png"),), [
Mediana: 5.0

Przedział wartości występujących najczęściej: \
[4.0; 7.0]

Liczba punktów oddalonych: 1253
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [round], figure(image("img/box_round.png"),), [
Mediana: 18.0

Przedział wartości występujących najczęściej: \
[11.75; 19.0]

Liczba punktów oddalonych: 1870
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [age_o], figure(image("img/box_age_o.png"),), [
Mediana: 26.0

Przedział wartości występujących najczęściej: \
[23.0; 28.0]

Liczba punktów oddalonych: 1420
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [age], figure(image("img/box_age.png"),), [
Mediana: 26.0

Przedział wartości występujących najczęściej: \
[23.0; 28.0]

Liczba punktów oddalonych: 1429
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [imprace], figure(image("img/box_imprace.png"),), [
Mediana: 3.0

Przedział wartości występujących najczęściej: \
[1.0; 6.0]

Liczba punktów oddalonych: 799
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [goal], figure(image("img/box_goal.png"),), [
Mediana: 2.0

Przedział wartości występujących najczęściej: \
[1.0; 2.0]

Liczba punktów oddalonych: 955
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [date], figure(image("img/box_date.png"),), [
Mediana: 5.0

Przedział wartości występujących najczęściej: \
[4.0; 6.0]

Liczba punktów oddalonych: 1257
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [go_out], figure(image("img/box_go_out.png"),), [
Mediana: 2.0

Przedział wartości występujących najczęściej: \
[1.0; 3.0]

Liczba punktów oddalonych: 414
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [exphappy], figure(image("img/box_exphappy.png"),), [
Mediana: 6.0

Przedział wartości występujących najczęściej: \
[5.0; 7.0]

Liczba punktów oddalonych: 1302
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [expnum], figure(image("img/box_expnum.png"),), [
Mediana: 4.0

Przedział wartości występujących najczęściej: \
[2.0; 8.0]

Liczba punktów oddalonych: 655
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [sports], figure(image("img/box_sports.png"),), [
Mediana: 7.0

Przedział wartości występujących najczęściej: \
[5.0; 9.0]

Liczba punktów oddalonych: 1441
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [tvsports], figure(image("img/box_tvsports.png"),), [
Mediana: 4.0

Przedział wartości występujących najczęściej: \
[2.0; 7.0]

Liczba punktów oddalonych: 1478
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [exercise], figure(image("img/box_exercise.png"),), [
Mediana: 6.0

Przedział wartości występujących najczęściej: \
[5.0; 8.0]

Liczba punktów oddalonych: 1545
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [dining], figure(image("img/box_dining.png"),), [
Mediana: 8.0

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 1546
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [museums], figure(image("img/box_museums.png"),), [
Mediana: 7.0

Przedział wartości występujących najczęściej: \
[6.0; 8.0]

Liczba punktów oddalonych: 1792
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [art], figure(image("img/box_art.png"),), [
Mediana: 7.0

Przedział wartości występujących najczęściej: \
[5.0; 8.0]

Liczba punktów oddalonych: 1613
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [hiking], figure(image("img/box_hiking.png"),), [
Mediana: 6.0

Przedział wartości występujących najczęściej: \
[4.0; 8.0]

Liczba punktów oddalonych: 1522
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [gaming], figure(image("img/box_gaming.png"),), [
Mediana: 4.0

Przedział wartości występujących najczęściej: \
[2.0; 6.0]

Liczba punktów oddalonych: 1582
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [clubbing], figure(image("img/box_clubbing.png"),), [
Mediana: 6.0

Przedział wartości występujących najczęściej: \
[4.0; 7.0]

Liczba punktów oddalonych: 1870
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [reading], figure(image("img/box_reading.png"),), [
Mediana: 8.0

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 1642
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [tv], figure(image("img/box_tv.png"),), [
Mediana: 6.0

Przedział wartości występujących najczęściej: \
[3.0; 7.0]

Liczba punktów oddalonych: 1488
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [theater], figure(image("img/box_theater.png"),), [
Mediana: 7.0

Przedział wartości występujących najczęściej: \
[5.0; 8.0]

Liczba punktów oddalonych: 1549
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [movies], figure(image("img/box_movies.png"),), [
Mediana: 8.0

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 1366
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [concerts], figure(image("img/box_concerts.png"),), [
Mediana: 7.0

Przedział wartości występujących najczęściej: \
[6.0; 8.0]

Liczba punktów oddalonych: 1770
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [music], figure(image("img/box_music.png"),), [
Mediana: 8.0

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 1669
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [shopping], figure(image("img/box_shopping.png"),), [
Mediana: 5.0

Przedział wartości występujących najczęściej: \
[3.0; 7.0]

Liczba punktów oddalonych: 1709
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [yoga], figure(image("img/box_yoga.png"),), [
Mediana: 4.0

Przedział wartości występujących najczęściej: \
[2.0; 7.0]

Liczba punktów oddalonych: 1387
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [satis_2], figure(image("img/box_satis_2.png"),), [
Mediana: 6.0

Przedział wartości występujących najczęściej: \
[5.0; 7.0]

Liczba punktów oddalonych: 1335
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [length], figure(image("img/box_length.png"),), [
Mediana: 1.0

Przedział wartości występujących najczęściej: \
[1.0; 3.0]

Liczba punktów oddalonych: 0
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [numdat_2], figure(image("img/box_numdat_2.png"),), [
Mediana: 2.0

Przedział wartości występujących najczęściej: \
[2.0; 3.0]

Liczba punktów oddalonych: 315
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [match], figure(image("img/box_match.png"),), [
Mediana: 0.0

Przedział wartości występujących najczęściej: \
[0.0; 0.0]

Liczba punktów oddalonych: 690 
\ \ \ Atrybut binarny, wykres pudełkowy analizować ostrożnie.
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [samerace], figure(image("img/box_samerace.png"),), [
Mediana: 0.0

Przedział wartości występujących najczęściej: \
[0.0; 1.0]

Liczba punktów oddalonych: 0
\ \ \ Atrybut binarny, wykres pudełkowy analizować ostrożnie.
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [race_o], figure(image("img/box_race_o.png"),), [
Mediana: 2.0

Przedział wartości występujących najczęściej: \
[2.0; 4.0]

Liczba punktów oddalonych: 456
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [race], figure(image("img/box_race.png"),), [
Mediana: 2.0

Przedział wartości występujących najczęściej: \
[2.0; 4.0]

Liczba punktów oddalonych: 457
])

= Wnioski
== Wnioski dotyczące danych
*1. Wiek uczestników* 
- Większość uczestników mieściła się w przedziale wiekowym 20-30 lat, co jest charakterystyczne dla studentów MBA. Ten przedział wiekowy może wpływać na preferencje i priorytety romantyczne, a także na ogólną dynamikę eksperymentu.


*2. Ambicja jako atrybut*
- Przed wydarzeniem histogram oceny ambicji wskazywał, że około 2/3 uczestników oceniło ambicję partnerów na mniej niż 10 punktów w skali 0-100. Był to rozkład lewoskośny, z pozostałą częścią ocen rozłożoną między 10 a 20 punktów.
- Dzień po wydarzeniu znaczenie ambicji u partnerów wzrosło — ponad połowa uczestników uznała ją za istotną, a wykres zmienił charakter na wycentrowany, z dwoma wyraźnymi szczytami w końcowych przedziałach 0-20 punktów (większość ocen powyżej 10).
- Ocena własnej ambicji uczestników pozostała stabilna, z prawoskośnym rozkładem wskazującym na wysoką samoocenę w tej kategorii.

*3. Zainteresowania i aktywności*
- Rozkład zainteresowań uczestników w większości był prawostronnie skierowany (więcej ocen na niższym poziomie).
- Wyjątkami były kategorie filmów (wysokie zainteresowanie, centralny rozkład) oraz gier komputerowych (gaming), które cechowały się niskim poziomem zainteresowania wśród uczestników.

*4. Atrakcyjność jako atrybut*
- Przed randkami uczestnicy oceniali atrakcyjność partnerów w skali 1–10. Rozkład był nieco prawoskośny, z ocenami najczęściej wynoszącymi 5, 6, 7 lub 8, a średnia wynosiła 6,x14 punktów.
- W skali 0–100 rozkład punktów był lewoskośny, z większością ocen koncentrujących się w przedziale 15-30 punktów. Atrybut atrakcyjności często otrzymywał najwięcej punktów w ramach dostępnej puli. Średnia wynosiła 24,12 punktów, a w skrajnych przypadkach osiągała nawet 100 punktów.
- Po wydarzeniu rozkład znaczenia atrakcyjności uległ zmianie. Skrajne przypadki wzrosły do około 80 punktów, a minimalne znaczenie podniosło się z 0 do 10 punktów. Średnia wzrosła do 28,64 punktów.

*5. Szczerość i clubbing*
- Histogramy cech takich jak szczerość oraz zainteresowanie clubbingiem zawierały najbardziej odległe punkty w rozkładzie. - Większość uczestników była zainteresowana clubbingiem, co pokazał wyraźny szczyt rozkładu w wysokich przedziałach. Tylko niewielki odsetek uczestników ocenił swoje zainteresowanie tą aktywnością na minimalnym poziomie (1 w skali 0–10).

*6. Częstotliwość randek*
- Najczęstsze odpowiedzi uczestników na pytanie o częstotliwość randek mieściły się w przedziale od „dwa razy w miesiącu” do „kilka razy w roku”. Średnia oscylowała wokół wartości „raz w miesiącu”.


*7. Szczerość jako wartość w relacjach*
- Dzień po spotkaniach szczerość była niżej oceniana jako istotna cecha u potencjalnego partnera przeciwnej płci. Średnia ocena spadła z 17,29 punktów do 15,57 punktów w skali 0–100.
-  Może to sugerować, że w krótkich interakcjach, takich jak 4-minutowe randki, inne cechy (np. atrakcyjność lub wspólne zainteresowania) zyskują na znaczeniu, przesuwając uwagę uczestników z wartości takich jak szczerość.

#pagebreak()

*8. Czas trwania spotkań*
- Większość uczestników uważała, że czas trwania 4-minutowych randek był zbyt krótki, co potwierdza analiza odpowiedzi. Mediana odpowiedzi wskazywała na potrzebę dłuższych interakcji.
- Drugą najczęściej wybieraną opcją była odpowiedź, że czas randki był „idealny”, co sugeruje pewną grupę uczestników zadowoloną z formatu wydarzenia.
- Jedynie niewielki odsetek uczestników (około 7%) uznał, że spotkania były zbyt długie. Może to wskazywać na różne potrzeby i oczekiwania uczestników wobec formatu randek.


== Korelacje między wartościami atrybutów
Z uwagi na olbrzymią ilość atrubów, wygenerowano korelację tylko dla kilku z nich. Mimo to, udało się wyciągnąć z nich kilka ciekawych wniosków (macierze poniżej, opis tylko do ciekawszych wyników). 
\ \ 
Macierz korelacji w danych Speed Dating wskazuje na interesujące zależności między preferencjami uczestników. Najczęściej wspólnie cenionymi atrybutami były sztuka i muzea, które wykazują wysoką korelację, podobnie jak koncerty i muzyka, co sugeruje, że osoby zainteresowane jedną z tych dziedzin mają tendencję do doceniania również innych związanych z kulturą i rozrywką.
Z kolei sport był najmniej skorelowanym atrybutem, wykazując jedynie słabą korelację z takimi czynnikami jak TV sportowa, ćwiczenia czy gaming. Wskazuje to na stosunkowo izolowane preferencje w tej kategorii, co może odzwierciedlać bardziej wyspecjalizowane zainteresowania.
Najwięcej wspólnych korelacji odnotowano wśród kategorii takich jak jedzenie, muzea, sztuka oraz zakupy, co sugeruje, że te aktywności są postrzegane jako uniwersalne elementy stylu życia, które łatwo znajdują wspólny grunt między różnymi uczestnikami. Tego typu dane mogą być szczególnie użyteczne w analizie dopasowania uczestników na podstawie wspólnych zainteresowań, co jest kluczowe w kontekście wydarzeń typu speed dating.

#figure(
  image("img/corr_activities.png", height: 40%),
	caption: "Macierz korelacji atrybutów związaych z zainteresowaniami."
)

#pagebreak()

Macierz korelacji pokazuje, że nie występują silne zależności pomiędzy analizowanymi cechami – wszystkie współczynniki korelacji poza przekątną są poniżej 0,6. Najwyższe korelacje zaobserwowano między poczuciem humoru a atrakcyjnością fizyczną, ambicją a inteligencją, oraz między poczuciem humoru a ambicją. Z kolei najniższą korelację widać między atrakcyjnością a szczerością, co sugeruje, że osoby uważające się za atrakcyjne niekoniecznie postrzegają siebie jako szczere. Ogólnie cechy te mają względnie niezależny charakter, co oznacza, że uczestnicy różnicowali swoje samooceny w zależności od konkretnego atrybutu.
#figure(
  image("img/corr_1_1.png"),
	caption: "Macierz korelacji atrybutów istotności każdej z 6. cech, której dana osoba poszukuje u partnera."
)

#pagebreak()
Macierz korelacji wskazuje, że zależności między ocenianymi cechami są słabe lub umiarkowane. Najwyższą korelację można zaobserwować między ambicją a wspólnymi zainteresowaniami, co sugeruje, że osoby przykładające wagę do ambicji partnera często zwracają również uwagę na podobieństwo hobby. Zauważalna jest także umiarkowana dodatnia korelacja między szczerością a większością pozostałych cech. Natomiast atrakcyjność fizyczna oraz wspólne zainteresowania cechują się niską lub nawet ujemną korelacją z pozostałymi cechami, co może świadczyć o ich odmiennym charakterze w ocenie partnera. Warto również zwrócić uwagę, że niektóre korelacje są ujemne, choć niezbyt silne, co wskazuje na zróżnicowane podejście uczestników do wartościowania poszczególnych cech.
#figure(
  image("img/corr_1_2.png"),
	caption: "Macierz korelacji istotności cech w kontekście: czego uczestnik poszukiwał u partnera płci przeciwnej."
)


#figure(
  image("img/corr_2_1.png"),
	caption: "Macierz korelacji istotności poszukiwania na randce danej cechy przez płeć przeciwną (własna opinia o preferencjach innych)."
)


#figure(
  image("img/corr_o.png", height: 40%),
	caption: "Macierz korelacji istotności danej cechy pod względem preferencji partnera."
)


#figure(
  image("img/corr_pf_o.png", height: 40%),
	caption: "Macierz korelacji istotności danej cechy pod względem preferencji uczestnika (przed randkowaniem)."
)


#figure(
  image("img/corr_scores.png", height: 40%),
	caption: "Macierz korelacji istotności cech - ocena przed wydarzeniem, 1 dzień po wydarzeniu dla partnera jak i uczestnika."
)



Warto wspomnieć, że niemożliwe jest wyznaczenie korelacji wszystkich atrybutów przez fakt występowania danych tekstowych (zbiór fraz) lub ich mapowania na liczby. W takim przypadku korelacja nie niesie żadnych sensowych informacji.  


= Uwagi na temat jakości danych
== Dane brakujące
W zbiorze danych występują atrybuty, dla których nie ma wartości w całej kolumnie danych (tj. dla każdego uczestnika). Istnieje całkiem dużo atrybutów, dla których pomiarów nie prowadzono w pierwszych wydarzeniach. Atrybuty, których wartości zdobywa się po długim czasie od wydarzenia, również mogą mieć brakujące wartości (np. shar2_2, brak danych dla blisko 25% wszystkich przypadków).

== Dane niespójne
Istnieje dość sporo atrybutów, dla których wartości są niespójne. Spowodowane jest to czasową zmianą skali ocen. Dla przykładu: atrybuty kończące się "1_2" są mierzone inną skalą w wydarzeniach odbywających się w okolicach 1/3 czasu trwania eksperymentu. Warto odnotować, że w tych przypadkach wartości ze skali ocen pokrywają się np. ocena w skali 1-10 i podział 100 punktów. Bez dodatkowej wiedzy nt. spotkań nie sposób odróżnić od siebie obydwie skale oceniania. \ \
Inny problem, utrudniający "przyzywyczajenie się" do danych to niespójność mapowania wartości binarnych na wartości liczbowe. Dla części parametrów obowiązuje podział _0 lub 1_ a dla innych _1 lub 2_. Dla przykładu: atrybut 'samerace' typu Tak/Nie mapowany do _0 lub 1_ oraz "met" typu Tak/Nie mapowany do _1 lub 2_.

== Dane niezrozumiałe
W zbiorze występują atrybuty, których znaczenie nie jest jasne. Przykładem jest atrybut 'prob_o', który nie jest opisany w dokumentacji zbioru danych. Wartości tego atrybutu są liczbami z przedziału [1, 10], ale nie wiadomo, co one oznaczają. Kolejnym przykładem jest atrybut 'met_o', który również nie jest opisany w dokumentacji zbioru danych. 

== Punkty oddalone
Prezentowane na wykresach pudełkowych powyżej, w sekcji 5.2.

= Podsumowanie i wnioski ogólne:
Analiza danych wskazuje, że krótkie interakcje podczas wydarzenia wyraźnie wpływają na ewolucję ocen atrybutów, takich jak atrakcyjność czy ambicja, które zyskują na znaczeniu po bezpośrednim kontakcie. Szczerość była oceniana niżej dzień po spotkaniach, co może wynikać z ograniczonego czasu na głębsze poznanie. Różnorodność preferencji uczestników w zakresie czasu trwania spotkań oraz zainteresowań sugeruje potrzebę lepszego dostosowania formatu wydarzenia, aby uwzględnić oczekiwania różnych grup.