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
- wydarzenie - jedno z 24 spotkań speed datingu
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
== Rozkłady wartości atrybutów
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



#table(columns: (auto, auto, auto), inset: 5pt, align: center, [attr1_1], figure(image("img/box_attr1_1.png"),), [
Mediana: 24.12

Przedział wartości występujących najczęściej: \
[15.0; 30.0]

Liczba punktów oddalonych: 1265
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [sinc1_1], figure(image("img/box_sinc1_1.png"),), [
Mediana: 17.29

Przedział wartości występujących najczęściej: \
[10.0; 20.0]

Liczba punktów oddalonych: 1131
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [intel1_1], figure(image("img/box_intel1_1.png"),), [
Mediana: 21.08

Przedział wartości występujących najczęściej: \
[18.0; 25.0]

Liczba punktów oddalonych: 1514
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [fun1_1], figure(image("img/box_fun1_1.png"),), [
Mediana: 17.32

Przedział wartości występujących najczęściej: \
[12.0; 20.0]

Liczba punktów oddalonych: 1694
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [amb1_1], figure(image("img/box_amb1_1.png"),), [
Mediana: 9.6

Przedział wartości występujących najczęściej: \
[5.0; 15.0]

Liczba punktów oddalonych: 1125
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [shar1_1], figure(image("img/box_shar1_1.png"),), [
Mediana: 10.92

Przedział wartości występujących najczęściej: \
[5.0; 15.0]

Liczba punktów oddalonych: 1311
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [attr2_1], figure(image("img/box_attr2_1.png"),), [
Mediana: 32.75

Przedział wartości występujących najczęściej: \
[20.0; 40.0]

Liczba punktów oddalonych: 1464
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [sinc2_1], figure(image("img/box_sinc2_1.png"),), [
Mediana: 12.68

Przedział wartości występujących najczęściej: \
[10.0; 18.0]

Liczba punktów oddalonych: 1924
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [intel2_1], figure(image("img/box_intel2_1.png"),), [
Mediana: 14.6

Przedział wartości występujących najczęściej: \
[10.0; 20.0]

Liczba punktów oddalonych: 872
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [fun2_1], figure(image("img/box_fun2_1.png"),), [
Mediana: 18.41

Przedział wartości występujących najczęściej: \
[15.0; 20.0]

Liczba punktów oddalonych: 1766
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [amb2_1], figure(image("img/box_amb2_1.png"),), [
Mediana: 11.02

Przedział wartości występujących najczęściej: \
[5.0; 15.0]

Liczba punktów oddalonych: 1168
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [shar2_1], figure(image("img/box_shar2_1.png"),), [
Mediana: 10.61

Przedział wartości występujących najczęściej: \
[5.0; 15.0]

Liczba punktów oddalonych: 1057
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [attr3_1], figure(image("img/box_attr3_1.png"),), [
Mediana: 6.95

Przedział wartości występujących najczęściej: \
[6.0; 8.0]

Liczba punktów oddalonych: 973
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [sinc3_1], figure(image("img/box_sinc3_1.png"),), [
Mediana: 8.15

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 1021
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [intel3_1], figure(image("img/box_intel3_1.png"),), [
Mediana: 8.32

Przedział wartości występujących najczęściej: \
[8.0; 9.0]

Liczba punktów oddalonych: 1343
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [fun3_1], figure(image("img/box_fun3_1.png"),), [
Mediana: 7.57

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 1244
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [amb3_1], figure(image("img/box_amb3_1.png"),), [
Mediana: 7.41

Przedział wartości występujących najczęściej: \
[6.0; 9.0]

Liczba punktów oddalonych: 1084
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [attr1_2], figure(image("img/box_attr1_2.png"),), [
Mediana: 28.64

Przedział wartości występujących najczęściej: \
[20.0; 30.0]

Liczba punktów oddalonych: 1645
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [sinc1_2], figure(image("img/box_sinc1_2.png"),), [
Mediana: 15.57

Przedział wartości występujących najczęściej: \
[10.0; 20.0]

Liczba punktów oddalonych: 864
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [intel1_2], figure(image("img/box_intel1_2.png"),), [
Mediana: 17.67

Przedział wartości występujących najczęściej: \
[15.0; 20.0]

Liczba punktów oddalonych: 1465
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [fun1_2], figure(image("img/box_fun1_2.png"),), [
Mediana: 18.19

Przedział wartości występujących najczęściej: \
[15.0; 20.0]

Liczba punktów oddalonych: 1400
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [amb1_2], figure(image("img/box_amb1_2.png"),), [
Mediana: 8.29

Przedział wartości występujących najczęściej: \
[5.0; 10.0]

Liczba punktów oddalonych: 1366
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [shar1_2], figure(image("img/box_shar1_2.png"),), [
Mediana: 11.88

Przedział wartości występujących najczęściej: \
[10.0; 16.0]

Liczba punktów oddalonych: 1731
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [attr3_2], figure(image("img/box_attr3_2.png"),), [
Mediana: 6.97

Przedział wartości występujących najczęściej: \
[6.0; 8.0]

Liczba punktów oddalonych: 857
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [sinc3_2], figure(image("img/box_sinc3_2.png"),), [
Mediana: 7.83

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 859
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [intel3_2], figure(image("img/box_intel3_2.png"),), [
Mediana: 8.11

Przedział wartości występujących najczęściej: \
[8.0; 9.0]

Liczba punktów oddalonych: 1165
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [fun3_2], figure(image("img/box_fun3_2.png"),), [
Mediana: 7.48

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 948
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [amb3_2], figure(image("img/box_amb3_2.png"),), [
Mediana: 7.33

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 1175
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [pf_o_att], figure(image("img/box_pf_o_att.png"),), [
Mediana: 24.09

Przedział wartości występujących najczęściej: \
[15.0; 30.0]

Liczba punktów oddalonych: 1259
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [pf_o_sin], figure(image("img/box_pf_o_sin.png"),), [
Mediana: 17.29

Przedział wartości występujących najczęściej: \
[10.0; 20.0]

Liczba punktów oddalonych: 1129
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [pf_o_int], figure(image("img/box_pf_o_int.png"),), [
Mediana: 21.1

Przedział wartości występujących najczęściej: \
[18.0; 25.0]

Liczba punktów oddalonych: 1509
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [pf_o_fun], figure(image("img/box_pf_o_fun.png"),), [
Mediana: 17.32

Przedział wartości występujących najczęściej: \
[12.0; 20.0]

Liczba punktów oddalonych: 1691
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [pf_o_amb], figure(image("img/box_pf_o_amb.png"),), [
Mediana: 9.6

Przedział wartości występujących najczęściej: \
[5.0; 15.0]

Liczba punktów oddalonych: 1125
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [pf_o_sha], figure(image("img/box_pf_o_sha.png"),), [
Mediana: 10.92

Przedział wartości występujących najczęściej: \
[5.0; 15.0]

Liczba punktów oddalonych: 1309
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [attr_o], figure(image("img/box_attr_o.png"),), [
Mediana: 6.14

Przedział wartości występujących najczęściej: \
[5.0; 7.0]

Liczba punktów oddalonych: 1651
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [sinc_o], figure(image("img/box_sinc_o.png"),), [
Mediana: 7.15

Przedział wartości występujących najczęściej: \
[6.0; 8.0]

Liczba punktów oddalonych: 1404
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [intel_o], figure(image("img/box_intel_o.png"),), [
Mediana: 7.35

Przedział wartości występujących najczęściej: \
[6.0; 8.0]

Liczba punktów oddalonych: 1273
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [fun_o], figure(image("img/box_fun_o.png"),), [
Mediana: 6.34

Przedział wartości występujących najczęściej: \
[5.0; 8.0]

Liczba punktów oddalonych: 1082
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [amb_o], figure(image("img/box_amb_o.png"),), [
Mediana: 6.79

Przedział wartości występujących najczęściej: \
[6.0; 8.0]

Liczba punktów oddalonych: 1488
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [shar_o], figure(image("img/box_shar_o.png"),), [
Mediana: 5.45

Przedział wartości występujących najczęściej: \
[4.0; 7.0]

Liczba punktów oddalonych: 1253
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [round], figure(image("img/box_round.png"),), [
Mediana: 16.46

Przedział wartości występujących najczęściej: \
[11.75; 19.0]

Liczba punktów oddalonych: 1870
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [age_o], figure(image("img/box_age_o.png"),), [
Mediana: 25.86

Przedział wartości występujących najczęściej: \
[23.0; 28.0]

Liczba punktów oddalonych: 1420
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [age], figure(image("img/box_age.png"),), [
Mediana: 25.85

Przedział wartości występujących najczęściej: \
[23.0; 28.0]

Liczba punktów oddalonych: 1429
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [imprace], figure(image("img/box_imprace.png"),), [
Mediana: 3.58

Przedział wartości występujących najczęściej: \
[1.0; 6.0]

Liczba punktów oddalonych: 799
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [goal], figure(image("img/box_goal.png"),), [
Mediana: 2.23

Przedział wartości występujących najczęściej: \
[1.0; 2.0]

Liczba punktów oddalonych: 955
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [date], figure(image("img/box_date.png"),), [
Mediana: 5.05

Przedział wartości występujących najczęściej: \
[4.0; 6.0]

Liczba punktów oddalonych: 1257
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [go_out], figure(image("img/box_go_out.png"),), [
Mediana: 2.16

Przedział wartości występujących najczęściej: \
[1.0; 3.0]

Liczba punktów oddalonych: 414
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [exphappy], figure(image("img/box_exphappy.png"),), [
Mediana: 5.46

Przedział wartości występujących najczęściej: \
[5.0; 7.0]

Liczba punktów oddalonych: 1302
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [expnum], figure(image("img/box_expnum.png"),), [
Mediana: 5.57

Przedział wartości występujących najczęściej: \
[2.0; 8.0]

Liczba punktów oddalonych: 655
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [sports], figure(image("img/box_sports.png"),), [
Mediana: 6.42

Przedział wartości występujących najczęściej: \
[5.0; 9.0]

Liczba punktów oddalonych: 1441
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [tvsports], figure(image("img/box_tvsports.png"),), [
Mediana: 4.5

Przedział wartości występujących najczęściej: \
[2.0; 7.0]

Liczba punktów oddalonych: 1478
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [exercise], figure(image("img/box_exercise.png"),), [
Mediana: 6.21

Przedział wartości występujących najczęściej: \
[5.0; 8.0]

Liczba punktów oddalonych: 1545
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [dining], figure(image("img/box_dining.png"),), [
Mediana: 7.62

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 1546
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [museums], figure(image("img/box_museums.png"),), [
Mediana: 6.81

Przedział wartości występujących najczęściej: \
[6.0; 8.0]

Liczba punktów oddalonych: 1792
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [art], figure(image("img/box_art.png"),), [
Mediana: 6.49

Przedział wartości występujących najczęściej: \
[5.0; 8.0]

Liczba punktów oddalonych: 1613
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [hiking], figure(image("img/box_hiking.png"),), [
Mediana: 5.88

Przedział wartości występujących najczęściej: \
[4.0; 8.0]

Liczba punktów oddalonych: 1522
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [gaming], figure(image("img/box_gaming.png"),), [
Mediana: 3.9

Przedział wartości występujących najczęściej: \
[2.0; 6.0]

Liczba punktów oddalonych: 1582
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [clubbing], figure(image("img/box_clubbing.png"),), [
Mediana: 5.57

Przedział wartości występujących najczęściej: \
[4.0; 7.0]

Liczba punktów oddalonych: 1870
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [reading], figure(image("img/box_reading.png"),), [
Mediana: 7.69

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 1642
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [tv], figure(image("img/box_tv.png"),), [
Mediana: 5.2

Przedział wartości występujących najczęściej: \
[3.0; 7.0]

Liczba punktów oddalonych: 1488
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [theater], figure(image("img/box_theater.png"),), [
Mediana: 6.65

Przedział wartości występujących najczęściej: \
[5.0; 8.0]

Liczba punktów oddalonych: 1549
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [movies], figure(image("img/box_movies.png"),), [
Mediana: 7.96

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 1366
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [concerts], figure(image("img/box_concerts.png"),), [
Mediana: 6.76

Przedział wartości występujących najczęściej: \
[6.0; 8.0]

Liczba punktów oddalonych: 1770
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [music], figure(image("img/box_music.png"),), [
Mediana: 7.74

Przedział wartości występujących najczęściej: \
[7.0; 9.0]

Liczba punktów oddalonych: 1669
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [shopping], figure(image("img/box_shopping.png"),), [
Mediana: 5.38

Przedział wartości występujących najczęściej: \
[3.0; 7.0]

Liczba punktów oddalonych: 1709
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [yoga], figure(image("img/box_yoga.png"),), [
Mediana: 4.24

Przedział wartości występujących najczęściej: \
[2.0; 7.0]

Liczba punktów oddalonych: 1387
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [satis_2], figure(image("img/box_satis_2.png"),), [
Mediana: 5.68

Przedział wartości występujących najczęściej: \
[5.0; 7.0]

Liczba punktów oddalonych: 1335
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [length], figure(image("img/box_length.png"),), [
Mediana: 1.84

Przedział wartości występujących najczęściej: \
[1.0; 3.0]

Liczba punktów oddalonych: 0
])
#table(columns: (auto, auto, auto), inset: 5pt, align: center, [numdat_2], figure(image("img/box_numdat_2.png"),), [
Mediana: 2.31

Przedział wartości występujących najczęściej: \
[2.0; 3.0]

Liczba punktów oddalonych: 315
])


= Wnioski
== Wnioski dotyczące danych
TODO

== Korelacje między wartościami atrybutów
TODO

#figure(
  image("img/corr_activities.png"),
	caption: "Macierz korelacji."
)



= Uwagi na temat jakości danych
== Dane brakujące
W zbiorze danych występują atrybuty, dla których nie ma wartości w całej kolumnie danych (tj. dla każdego uczestnika). Istnieje całkiem dużo atrybutów, dla których pomiarów nie prowadzono w pierwszych wydarzeniach. Atrybuty, których wartości zdobywa się po długim czasie od wydarzenia, również mogą mieć brakujące wartości (np. shar2_2, brak danych dla blisko 25% wszystkich przypadków).

== Dane niespójne
Istnieje dość sporo atrybutów, dla których wartości są niespójne. Spowodowane jest to czasową zmianą skali ocen. Dla przykładu: atrybuty kończące się "1_2" są mierzone inną skalą w wydarzeniach odbywających się w okolicach 1/3 czasy trwania eksperymentu. Warto odnotować, że w tych przypadkach wartości ze skali ocen pokrywają się np. ocena w skali 1-10 i podział 100 punktów. Bez dodatkowej wiedzy nt. spotkań nie sposób odróżnić od siebie obydwie skale oceniania.

== Dane niezrozumiałe
W zbiorze występują atrybuty, których znaczenie nie jest jasne. Przykładem jest atrybut 'prob_o', który nie jest opisany w dokumentacji zbioru danych. Wartości tego atrybutu są liczbami z przedziału [1, 10], ale nie wiadomo, co one oznaczają. Kolejnym przykładem jest atrybut 'met_o', który również nie jest opisany w dokumentacji zbioru danych. 

== Punkty oddalone
TODO

= Podsumowanie
TODO