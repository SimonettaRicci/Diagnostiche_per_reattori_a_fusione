# Diagnostiche_per_reattori_a_fusione
# Modes Tracking Algorithms using Internal Discrete Coils (IDC)

**Sviluppato da:** Crescenzi Andrea, Ricci Simonetta, Vinci Alessio  
**Data:** 13 Luglio 2025
---

## Panoramica del progetto

Questo progetto analizza lo sviluppo e il confronto di algoritmi avanzati per il monitoraggio dei modi magnetici all’interno di un **Tokamak**.

I modi magnetici rappresentano segnali precursori di instabilità del plasma e possibili *disruption*. Il loro rilevamento tempestivo è fondamentale per la sicurezza e l’efficienza dei reattori a fusione nucleare.

L’obiettivo del lavoro è superare le limitazioni delle tradizionali **saddle coil**, introducendo l’utilizzo di **Internal Discrete Coils (IDC)**, caratterizzate da maggiore sensibilità e risposta più rapida.

---

## Metodi di rilevamento implementati

Il progetto confronta tre approcci principali per la stima dell’ampiezza e della fase dei modi magnetici:

### Metodo matriciale (geometrico)
Basato sulla risoluzione di un sistema sovradeterminato tramite **minimi quadrati** o **pseudo-inversa**, sfruttando la geometria toroidale delle bobine.

---

### Metodo delle differenze
Approccio classico basato sulla differenza tra segnali di bobine opposte per estrarre le componenti sinusoidali e cosinusoidali del modo.

---

### Rete neurale (Deep Learning) sviluppata in Python
Rete fully-connected a 5 livelli addestrata su dati rumorosi per la previsione dei primi tre modi principali:

- B₁  
- B₂  
- B₃  

---

## Caratteristiche del software

### Modellazione del rumore
Il sistema include una simulazione realistica del rumore di misura:

- Rumore bianco gaussiano (~5%)
- Rumore integrale (fino al 20%) per drift e instabilità lente

---

### Architettura modulare
Il codice è organizzato in moduli funzionali:

- `Gen_dataset` → generazione dati
- `Gen_plasma` → simulazione dinamica del plasma
- `Stime_Matriciale_IDC` → stima geometrica
- `Stime_NN_IDC` → inferenza tramite rete neurale

- ![schemaCodice](images/schemaCodice.png)


---

## Risultati principali

### Sensibilità
Le **IDC (Internal Discrete Coils)** mostrano una sensibilità superiore rispetto alle saddle coil tradizionali, anticipando il rilevamento delle instabilità fino a ~2 secondi (shot 94214).

---

### Accuratezza
Il metodo matriciale risulta il più robusto rispetto al rumore e il più preciso nella ricostruzione del modo fondamentale (modo 1).

---

### Rilevamento disruption
Nei test sullo shot distruttivo **94214**, il sistema IDC rileva instabilità già a:

- t ≈ 49.90 s  

mentre i sistemi tradizionali mostrano segnali evidenti solo dopo i 50 s.

---

## Sviluppi futuri

- Implementazione di **Physics-Informed Neural Networks (PINNs)** per incorporare la dinamica temporale dei modi
- Sviluppo di approcci ibridi tra modello fisico e machine learning
- Miglioramento della robustezza in scenari ad alto rumore

---

## Contesto scientifico

Progetto sviluppato nell’ambito dello studio delle **instabilità MHD (Magneto-Hydro-Dynamics)** e del controllo del plasma nei Tokamak.

---

## Autori

- Crescenzi Andrea  
- Ricci Simonetta  
- Vinci Alessio  
