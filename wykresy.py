import pandas
import numpy as np
import matplotlib.pyplot as plt
import seaborn

from enum import IntEnum
from pathlib import Path

class Gender(IntEnum):
    FEMALE = 0
    MALE = 1

class Condition(IntEnum):
    LIMITED_CHOICE = 1
    EXTENSIVE_CHOICE = 2

class FieldCd(IntEnum):
    LAW = 1
    MATH = 2
    SOCIAL_SCIENCE_PSYCH = 3
    MEDICAL_SCIENCE = 4
    ENGINEERING = 5
    ENGLISH_JOURNALISM = 6
    HISTORY_PHILOSOPHY = 7
    BUSINESS_ECON = 8
    EDUCATION = 9
    BIOLOGICAL_SCIENCES = 10
    SOCIAL_WORK = 11
    UNDERGRAD_UNDECIDED = 12
    POLITICAL_SCIENCE = 13
    FILM = 14
    FINE_ARTS = 15
    LANGUAGES = 16
    ARCHITECTURE = 17
    OTHER = 18

class Race(IntEnum):
    BLACK = 1
    CAUCASIAN = 2
    LATINO = 3
    ASIAN = 4
    NATIVE_AMERICAN = 5
    OTHER = 6

class Goal(IntEnum):
    FUN_NIGHT_OUT = 1
    MEET_NEW_PEOPLE = 2
    GET_DATE = 3
    SERIOUS_RELATIONSHIP = 4
    TO_SAY_I_DID_IT = 5
    OTHER = 6

class Frequency(IntEnum):
    SEVERAL_TIMES_WEEK = 1
    TWICE_WEEK = 2
    ONCE_WEEK = 3
    TWICE_MONTH = 4
    ONCE_MONTH = 5
    SEVERAL_TIMES_YEAR = 6
    ALMOST_NEVER = 7

class CareerC(IntEnum):
    LAWYER = 1
    ACADEMIC_RESEARCH = 2
    PSYCHOLOGIST = 3
    DOCTOR_MEDICINE = 4
    ENGINEER = 5
    CREATIVE_ARTS = 6
    BUSINESS_FINANCE = 7
    REAL_ESTATE = 8
    INTERNATIONAL_AFFAIRS = 9
    UNDECIDED = 10
    SOCIAL_WORK = 11
    SPEECH_PATHOLOGY = 12
    POLITICS = 13
    PRO_SPORTS = 14
    OTHER = 15
    JOURNALISM = 16
    ARCHITECTURE = 17

class Length(IntEnum):
    TOO_LITTLE = 1
    TOO_MUCH = 2
    JUST_RIGHT = 3

class NumDat(IntEnum):
    TOO_FEW = 1
    TOO_MANY = 2
    JUST_RIGHT = 3



data = pandas.read_csv("dating.csv", sep=";")

waves = [1, 2, 3, 4, 5, 10, 11, 15, 16, 17]

data = data[data.wave.isin(waves)]

names_prop = ["attr", "sinc", "intel", "fun", "amb", "shar"]

names_prop1_1 = [f"{p}1_1" for p in names_prop]
names_prop2_1 = [f"{p}2_1" for p in names_prop]
names_prop3_1 = [f"{p}3_1" for p in names_prop if "shar" != p]

names_prop1_2 = [f"{p}1_2" for p in names_prop]
names_prop3_2 = [f"{p}3_2" for p in names_prop if "shar" != p]

names_prop_pf_o = [f"pf_o_{p[:3]}" for p in names_prop]
names_prop_o = [f"{p}_o" for p in names_prop]

names_prop_generic = [
    "round",
    "age_o",
    "age",
    "imprace",
    "goal",
    "date",
    "go_out",
    "exphappy",
    "expnum",
]

names_prop_generic2 = [
    "satis_2",
    "length",
    "numdat_2",
]


names_prop_activities = [
    "sports",
    "tvsports",
    "exercise",
    "dining",
    "museums",
    "art",
    "hiking",
    "gaming",
    "clubbing",
    "reading",
    "tv",
    "theater",
    "movies",
    "concerts",
    "music",
    "shopping",
    "yoga",
]

names_discrete = [
    "match",
    "samerace",
    "race_o",
    "race",
    "career",
    "field",
]

names_all = [
    *names_prop1_1,
    *names_prop2_1,
    *names_prop3_1,
    *names_prop1_2,
    *names_prop3_2,
    *names_prop_pf_o,
    *names_prop_o,
    *names_prop_generic,
    *names_prop_activities,
    *names_prop_generic2,
]


img_dir = Path("img")
img_dir.mkdir(exist_ok=True)

doc = []

for name in names_all:
    print("hist", name)
    path = img_dir / f"hist_{name}.png"
    plt.clf()
    data[name].plot.hist(title=f"Histogram atrybutu {name}", xlabel=name, ylabel="Liczba próbek", ec='white')
    plt.savefig(path)

    doc.append(f"#table(columns: (auto, auto), inset: 5pt, align: center, [{name}], figure(image(\"{str(path)}\"),))")

for name in names_all:
    print("box", name)
    path = img_dir / f"box_{name}.png"
    plt.clf()
    data[name].plot.box(title=f"Wykres pudełkowy atrybutu {name}", ylabel="Wartości atrybutu")
    plt.savefig(path)

    attr = data[name]
    desc_n = attr.describe()

    outliers = attr[(attr < desc_n["25%"]) | (attr > desc_n["75%"])]

    desc = f"""
Mediana: {round(desc_n["mean"], 2)}

Przedział wartości występujących najczęściej:
[{desc_n["25%"]}; {desc_n["75%"]}]

Liczba punktów oddalonych: {int(outliers.count())}
"""
    doc.append(f"#table(columns: (auto, auto, auto), inset: 5pt, align: center, [{name}], figure(image(\"{str(path)}\"),), [{desc}])")

def plot_corr(names, name):
    print("corr", name)
    plt.clf()

    seaborn.heatmap(data[names].corr(method="spearman"))

    path = img_dir / f"corr_{name}.png"

    plt.savefig(path)

    doc.append(f"#figure(image(\"{str(path)}\"))")

plot_corr(names_prop_activities, "activities")

Path("a.typ").write_text("\n".join(doc))