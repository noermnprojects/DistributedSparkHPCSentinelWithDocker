# ⚡ Distributed Spark HPC Sentinel With Docker

![Spark](https://img.shields.io/badge/Apache_Spark-3.5.0-orange?logo=apachespark)
![Docker](https://img.shields.io/badge/Docker-Orchestrated-blue?logo=docker)
![Status](https://img.shields.io/badge/Performance-Distributed_ML-success)

**Distributed Spark HPC Sentinel With Docker** est un moteur de maintenance prédictive à haute performance conçu pour surveiller et anticiper les défaillances de nœuds au sein de clusters **HPC**. 

L'architecture s'appuie sur un déploiement orchestré via **Docker** et un pipeline de calcul distribué **Spark**, permettant de passer d'un traitement déterministe local à une analyse massivement parallèle capable de gérer des millions de métriques de télémétrie en temps réel.

---

## 🏗️ Architecture & Data Flow

### 1. Orchestration & Distributed Layer
L'infrastructure est virtualisée en trois couches distinctes pour maximiser l'isolation des ressources et la tolérance aux pannes :
* **Spark Master :** Gère le DAG (Directed Acyclic Graph) et planifie la distribution des tâches sur le cluster.
* **Worker Nodes :** Unités de calcul scalables exécutant les transformations de données en mémoire ($RAM$).
* **Jupyter Driver :** Point d'entrée pour l'ingénierie des données, agissant comme le driver du cluster Spark.

### 2. Predictive Engine (Spark MLlib)
Le pipeline transforme les données de télémétrie brutes (CPU, Température, RAM) en prédictions de pannes via un algorithme de **Random Forest** distribué :
* **Feature Engineering :** Normalisation via `StandardScaler` pour traiter des variables hétérogènes.
* **Distributed Training :** Parallélisation de l'entraînement de $N$ arbres de décision, optimisant la complexité de calcul à $\mathcal{O}(M \cdot N \log N)$ où $M$ est le nombre de nœuds.
* **Logic Gate Failure :** Identification de signatures thermiques critiques ($T > 92°C$ $\cap$ $CPU > 95\%$).

---

## 🚀 Engineering Metrics

* **Throughput :** Capacité de traitement de **1 000 000+ de relevés** en sub-seconde sur le cluster Docker.
* **Accuracy :** Précision de **99.19%** sur la détection des anomalies de nœuds HPC.
* **Scalability :** Conçu pour des datasets "Out-of-Core", permettant l'analyse de volumes de données dépassant la capacité RAM d'une machine unique grâce au partitionnement RDD.

---

## 📦 Installation & Deployment

```bash
# Clone the repository
git clone [https://github.com/noermnproject/DistributedSparkHPCSentinelWithDocker.git](https://github.com/noermnproject/DistributedSparkHPCSentinelWithDocker.git)

# Build and start the distributed cluster (Master + Workers + Jupyter)
docker-compose up -d --build

# Verify Java runtime within the container
docker exec -it jupyter-spark java -version
