import pandas
import numpy as np
import matplotlib.pyplot as plt
import seaborn

from enum import IntEnum
from pathlib import Path


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
    # "career",
    # "field",
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
    *names_discrete
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
Mediana: {round(desc_n["50%"], 2)}

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

plot_corr(names_prop1_1, "1_1")

plot_corr(names_prop1_2, "1_2")

plot_corr(names_prop2_1, "2_1")

plot_corr(names_prop3_1, "3_1")

plot_corr(names_prop3_2, "2_1")

plot_corr(names_prop_o, "o")

plot_corr(names_prop_pf_o, "pf_o")

plot_corr([
    *names_prop1_1,
    *names_prop1_2,
    *names_prop2_1,
    *names_prop3_1,
    *names_prop3_2,
    *names_prop_o,
    *names_prop_pf_o,
], "scores")

Path("a.typ").write_text("\n".join(doc))