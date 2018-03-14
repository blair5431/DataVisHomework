
Oberservations:
1. The cities with the highest temperatures are closest to the equator.
2. The cities with the lowest percent humidity were around 20 degress latitude.
3. Levels of cloudiness raged across all latitudes.


```python
# Dependencies
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import requests
import time
import json
import openweathermapy.core as owm
from citipy import citipy
from random import uniform

# Weather mapy Places API Key from config
from config import key
```


```python
#collect 500+ cities across the world of varying distance from the equator
#Perform a weather check on each of the cities using a series of successive API calls.
#Include a print log of each city as it's being processed with the city number, city name, and requested URL.
#Get Temp Latitude, humidity,cloudiness, wind speed (mph) from api
#Create scatter plots
```


```python
#create random list of lat and long
#use citipy to find the nearest city to lat and long
city = citipy.nearest_city(0.00, 0.00)
city
city.city_name
```




    'takoradi'




```python
lat=[]
long=[]
city_names=[]
city_counter = 0
temp = []
latitude =[]
humidity =[]
cloudiness = []
wind_speed = []


#creatins a random lat and lon
x, y = uniform(-180,180), uniform(-90, 90)
y

#collect 500+ cities across the world of varying distance from the equator
data_range = np.arange(1,10000,1)
data_range

# Create settings dictionary with information we're interested in
settings = {"units": "Imperial", "appid": key}



for data in data_range:
    
    
    #creating random list of lat
    x = uniform(-180,180)
    
    #creaing random list of long
    y = uniform(-90, 90)
    
    #finding nearest city to the random corrdinate
    city = citipy.nearest_city(x, y)
    
    #finding the city name from nearest city from above 
    city_name=city.city_name
    if city_name in city_names:
        #print("repeated")
        continue
    
    #counting the number of selected cities
    city_counter = city_counter + 1
    
    lat.append(x)
    long.append(y)
    city_names.append(city_name)
    
    
    
    try:
        current_weather = owm.get_current(city_name, **settings) 
    except:
        print("not city data")
        
    #print(current_weather)
    print(str(city_counter) +" " +str(city_name))
    #print(city_counter)
    
    #getting temp,latitute,humdity,cloudiness, wind spped
    temp.append(current_weather["main"]["temp"])
    humidity.append(current_weather["main"]["humidity"])
    cloudiness.append(current_weather["clouds"]["all"])
    wind_speed.append(current_weather["wind"]["speed"])
    latitude.append(current_weather["coord"]["lat"])
    
    #once city count gets to 500 then break the loop
    if city_counter == 500:
        break
    
                                            
```

    1 cape town
    2 longyearbyen
    3 ushuaia
    4 narsaq
    5 jamalpur
    6 berlevag
    7 ilulissat
    8 inhambane
    9 zinder
    10 san cristobal
    not city data
    11 taolanaro
    12 lichtenburg
    13 port elizabeth
    14 mazara del vallo
    not city data
    15 malwan
    16 pozo colorado
    17 mar del plata
    18 dikson
    19 sosnytsya
    20 busselton
    21 qaanaaq
    22 bathsheba
    23 mahebourg
    24 jamestown
    not city data
    25 barentsburg
    26 nova borova
    27 codrington
    28 saint george
    not city data
    29 tubruq
    30 la palma
    not city data
    31 illoqqortoormiut
    32 ponta do sol
    33 bredasdorp
    34 chuy
    35 hithadhoo
    not city data
    36 amderma
    37 melilla
    38 port alfred
    39 hualmay
    40 punta arenas
    41 kruisfontein
    42 georgetown
    43 lebu
    44 nadym
    45 boca do acre
    46 torbay
    not city data
    47 bargal
    48 saldanha
    49 puertollano
    50 narimanov
    51 bree
    not city data
    52 olafsvik
    53 guadalajara
    not city data
    54 belushya guba
    55 sorland
    56 hamilton
    57 arraial do cabo
    58 victoria
    59 adre
    60 agadez
    61 korampallam
    62 marathon
    63 clyde river
    64 strezhevoy
    65 albany
    66 abnub
    67 upernavik
    68 hermanus
    69 plettenberg bay
    not city data
    70 umbauba
    71 istanbul
    72 thompson
    73 saint-augustin
    74 east london
    75 puerto carreno
    76 lusambo
    not city data
    77 marcona
    78 huarmey
    79 ribeira brava
    80 marawi
    81 rundu
    82 puerto del rosario
    83 birmingham
    84 boende
    85 kitui
    86 saint-philippe
    87 olinda
    88 atar
    89 stephenville
    90 kulhudhuffushi
    not city data
    91 korla
    not city data
    92 acarau
    93 bambous virieux
    94 makat
    95 springbok
    96 necochea
    97 skjervoy
    98 el cobre
    99 ispas
    100 grand-lahou
    101 jalu
    102 iqaluit
    103 geraldton
    104 the valley
    105 ubinskoye
    not city data
    106 santa eulalia del rio
    107 bereda
    108 jacareacanga
    109 rio grande
    110 tasiilaq
    111 alta floresta
    112 le port
    113 marsh harbour
    114 keti bandar
    115 sao filipe
    116 kangaatsiaq
    not city data
    117 galgani
    118 coihaique
    119 amos
    120 pachino
    121 dudinka
    122 beruwala
    not city data
    123 bengkulu
    124 klaksvik
    125 touros
    126 iacu
    127 tiznit
    128 salalah
    129 saint-joseph
    130 leh
    131 qaqortoq
    132 la macarena
    133 barra do garcas
    134 dingle
    not city data
    135 tsihombe
    136 sorochinsk
    137 monrovia
    138 shelburne
    139 fredericton
    not city data
    140 felidhoo
    141 margate
    142 bangui
    143 vardo
    144 talagang
    not city data
    145 blonduos
    146 aguimes
    147 vila franca do campo
    148 dezful
    149 breytovo
    150 tocopilla
    151 nanortalik
    152 raciborz
    153 kathmandu
    154 hendek
    155 brazzaville
    not city data
    156 khormuj
    157 ancud
    158 burgeo
    159 maragogi
    160 kabare
    161 rocha
    162 buritis
    163 opuwo
    164 pisco
    165 cidreira
    166 kyshtovka
    167 los algarrobos
    168 karachi
    not city data
    169 hurghada
    170 havoysund
    171 hobyo
    172 mogosesti-siret
    173 grand-santi
    174 chapais
    175 chirawa
    176 ouesso
    177 trofors
    178 faya
    179 caravelas
    180 matara
    181 castro
    182 taltal
    183 bongandanga
    184 umm lajj
    185 kumbo
    186 benguela
    187 turukhansk
    188 boa viagem
    189 salinopolis
    190 ostersund
    191 oxford
    192 marrakesh
    193 ribeira grande
    194 bartica
    195 goderich
    196 riviere-au-renard
    197 chatellerault
    198 vila velha
    199 davlekanovo
    200 ler
    not city data
    201 stornoway
    not city data
    202 alto baudo
    203 veraval
    204 obidos
    205 tarrafal
    not city data
    206 andenes
    207 abu dhabi
    208 roald
    not city data
    209 tambopata
    210 manbij
    211 chernyanka
    212 jaguaribe
    213 ostrovnoy
    214 tessalit
    215 doha
    not city data
    216 doctor pedro p. pena
    217 pangnirtung
    not city data
    218 azimur
    219 axim
    220 namibe
    221 ambilobe
    222 paranga
    223 muzhi
    not city data
    224 gulshat
    not city data
    225 grand river south east
    226 talcahuano
    227 kasimov
    228 siverek
    229 lasa
    230 mecca
    231 deneysville
    232 gat
    233 tsumeb
    234 quatre cocos
    235 saint anthony
    236 darab
    237 grand gaube
    not city data
    238 lar gerd
    239 quelimane
    240 shahr-e babak
    241 praia da vitoria
    242 ginir
    243 talnakh
    244 quixeramobim
    not city data
    245 kapoeta
    246 carbondale
    247 odienne
    248 staritsa
    249 horki
    250 sambava
    251 yabrud
    252 piacabucu
    253 sao joao da barra
    254 yar-sale
    255 adrar
    256 granja
    257 ust-ishim
    258 puerto colombia
    259 eyrarbakki
    260 mehamn
    261 chulym
    262 divnomorskoye
    263 aksehir
    264 usinsk
    265 sinnamary
    266 bubaque
    267 kaman
    not city data
    268 krasnoselkup
    269 urbana
    270 kalavad
    271 rostock
    272 damietta
    273 kongolo
    274 coquimbo
    275 hambantota
    276 recanati
    277 kabalo
    278 monte carmelo
    279 bara
    280 mezhdurechensk
    281 ishim
    282 arlit
    283 sumbe
    284 mkokotoni
    285 key west
    286 taoudenni
    287 bandiagara
    288 edissiya
    289 souillac
    290 oranjemund
    291 marzuq
    292 sarakhs
    not city data
    293 rawah
    294 melnikovo
    295 le vauclin
    296 rio gallegos
    297 pinega
    298 paita
    299 loralai
    300 iralaya
    not city data
    301 aktash
    302 toledo
    303 nokaneng
    304 kolokani
    305 oka
    306 xudat
    307 luderitz
    308 nacala
    309 guarapari
    310 prudnik
    311 comodoro rivadavia
    312 ereymentau
    313 toma
    314 rurrenabaque
    315 lagoa
    316 el carmen
    317 grindavik
    318 boa vista
    319 sao jose da coroa grande
    320 camopi
    not city data
    321 vicuna
    322 valverde del camino
    not city data
    323 sorvag
    324 ginda
    325 saint-francois
    326 buraydah
    327 nebug
    328 nuuk
    not city data
    329 tumannyy
    330 van
    331 hofn
    332 port blair
    333 konigs wusterhausen
    334 pathankot
    335 clarence town
    not city data
    336 hunza
    337 malhargarh
    338 gunjur
    339 fomboni
    340 camacha
    341 laguna
    342 saint-pierre
    343 sokolka
    344 kavaratti
    345 honningsvag
    346 mandali
    347 natividade
    not city data
    348 debre zeyit
    349 gonda
    350 lavumisa
    351 inta
    352 moreira sales
    353 anisoc
    354 mamallapuram
    not city data
    355 mullaitivu
    356 diffa
    357 paamiut
    358 sumy
    359 cayenne
    360 sala
    361 zvishavane
    362 barahona
    363 iracoubo
    364 nouakchott
    not city data
    365 lephepe
    366 otjimbingwe
    not city data
    367 burica
    368 siniscola
    369 chimbote
    not city data
    370 attawapiskat
    371 iona
    372 bomet
    373 westport
    374 astana
    375 iranshahr
    376 nivala
    377 maceio
    378 baracoa
    379 lebyazhye
    380 gualaceo
    381 aksu
    not city data
    382 crab hill
    383 bogacs
    not city data
    384 kazalinsk
    385 codajas
    386 san rafael del sur
    387 christiana
    388 otukpo
    389 east angus
    390 camapua
    391 medina
    392 bulungu
    393 leshukonskoye
    394 sawai madhopur
    395 henties bay
    396 san ramon
    not city data
    397 mrirt
    not city data
    398 bolungarvik
    399 rybinsk
    400 ilheus
    401 pangody
    402 los llanos de aridane
    403 urubicha
    404 el jicaro
    405 yahotyn
    406 manono
    407 estreito
    408 ajra
    409 kang
    410 diego de almagro
    411 exu
    412 wamba
    413 peniche
    414 barra do corda
    415 san andres
    416 porto novo
    417 zlobin
    418 nantucket
    419 pombas
    420 shihezi
    421 khash
    422 bakau
    423 dawlatabad
    424 newberry
    425 rafai
    426 ngorongoro
    not city data
    427 sakakah
    428 sao miguel do araguaia
    429 tabou
    430 sardarshahr
    431 alampur
    432 chicama
    433 puerto leguizamo
    434 port-cartier
    435 houma
    436 moss point
    437 gurlan
    438 porto nacional
    439 mushie
    440 araouane
    441 cobourg
    442 santa isabel do rio negro
    443 kungsbacka
    444 rio cuarto
    445 hojslev
    446 sangueya
    447 sokoni
    448 tazovskiy
    449 baijiantan
    450 omboue
    451 barra da estiva
    452 ust-tsilma
    453 durban
    454 bonavista
    455 hisor
    456 katiola
    457 kollam
    458 carutapera
    459 astrea
    460 narbonne
    461 conde
    462 abu samrah
    463 huicungo
    464 muisne
    465 bilma
    466 mosetse
    467 hagere hiywet
    468 segou
    469 moerdijk
    470 tornio
    471 jumla
    472 antofagasta
    473 alpena
    474 roche-la-moliere
    475 makokou
    476 meulaboh
    477 bonthe
    not city data
    478 maarianhamina
    479 carnarvon
    480 colomi
    481 knysna
    482 muros
    483 ondjiva
    484 chinhoyi
    485 capim grosso
    486 moose factory
    487 tashara
    488 polunochnoye
    489 padang
    not city data
    490 bardiyah
    491 manaus
    492 kudahuvadhoo
    493 maniitsoq
    494 zafra
    495 nieuwpoort
    496 barsovo
    497 sechura
    498 maraa
    499 digby
    500 basoko



```python
# create dataframe with data from all the cities
weather_dict = {
    "City Name":city_names,
    "Temperature": temp,
    "humidity": humidity,
    "latitude": latitude,
    "cloudiness":cloudiness,
    "wind speed":wind_speed
} 
weather_dict
weather_df = pd.DataFrame(weather_dict)
len(weather_df)
```




    500




```python
# Build a scatter plot for Temperature vs Latitude 
plt.scatter(weather_df["latitude"], weather_df["Temperature"], marker="o")

# Incorporate the other graph properties
plt.title("City Latitude vs Temperature (F) (3.12.18)")
plt.xlabel("Latitude")
plt.ylabel("Temperature (F)")
plt.grid(True)

# Save the figure
plt.savefig("City Latitude vs Temperature (F) (3.12.18).png")

# Show plot
plt.show() 
```


![png](output_6_0.png)



```python
# Build a scatter plot for Humidity vs Latitude 
plt.scatter(weather_dict["latitude"], weather_dict["humidity"], marker="o")

# Incorporate the other graph properties
plt.title("City Latitude vs Humidity (3.12.18)")
plt.xlabel("Latitude")
plt.ylabel("Humidity")
plt.grid(True)

# Save the figure
plt.savefig("City Latitude vs Humidity (3.12.18).png")

# Show plot
plt.show()
```


![png](output_7_0.png)



```python
# Build a scatter plot for Cloudiness vs Latitude 
plt.scatter(weather_dict["latitude"], weather_dict["cloudiness"], marker="o")

# Incorporate the other graph properties
plt.title("City Latitude vs Cloudiness (3.12.18)")
plt.xlabel("Latitude")
plt.ylabel("Cloudiness")
plt.grid(True)

# Save the figure
plt.savefig("City Latitude vs Cloudiness (3.12.18).png")

# Show plot
plt.show() 
```


![png](output_8_0.png)



```python
# Build a scatter plot for Cloudiness vs Latitude 
plt.scatter(weather_dict["latitude"], weather_dict["wind speed"], marker="o")

# Incorporate the other graph properties
plt.title("City Latitude vs Wind Speed (mph) (3.12.18)")
plt.xlabel("Latitude")
plt.ylabel("Wind Speed")
plt.grid(True)

# Save the figure
plt.savefig("City Latitude vs Wind Speed (mph) (3.12.18).png")

# Show plot
plt.show() 
```


![png](output_9_0.png)

