# AI Context: Python Environment Architecture (Level 0-3)

## 🎯 Zweck dieses Dokuments
Dieses Dokument dient als Master-Instruktion für die Arbeit in diesem Repository. Jede Code-Änderung, jedes neue Skript und jede Environment-Manipulation muss die folgende 4-Schichten-Architektur respektieren.

---

## 🏗 Die 4 Ebenen (The Levels)

### Level 0: OS-Fundament / Build Primitives
- **Verantwortung:** System-Pakete, Compiler, Basistools.
- **Tools:** `apt`, `build-essential`, `git`, `docker`, `openjdk`.
- **Regel:** Hier wird kein Python-Code ausgeführt. Hier werden nur die Voraussetzungen für die Tools geschaffen.

### Level 1: User-Space Orchestratoren (Die Werkzeuge)
- **Verantwortung:** Management-Tools, die Environments erzeugen oder steuern.
- **Kern-Tools:** - `uv` (Globaler Standard für Python-Management)
  - `micromamba` (Nur das Binary, für Heavy-Runtimes)
  - `bashrc` / `.bash_lib` (Die Logik-Zentrale)
- **Regel:** Tools leben im PATH, aber niemals innerhalb einer aktivierten Umgebung. Sie sind "Stateless".

### Level 2: Heavy / Shared Runtimes (Data Science Stack)
- **Verantwortung:** Große, langlebige Umgebungen mit komplexen Abhängigkeiten (CUDA, PyTorch).
- **Management:** Via `micromamba`.
- **Regel:** Werden global registriert (z.B. als Jupyter Kernel), um von Level 3 aus genutzt zu werden.

### Level 3: Projekt-Environments (Workspaces)
- **Verantwortung:** Projekt-spezifische, isolierte Umgebungen.
- **Management:** Via `uv` (`.venv`, `pyproject.toml`).
- **Regel:** Wegwerfbar, reproduzierbar, repo-lokal.

---

## 🛠 Spezifische Arbeitsanweisungen für die KI (Kilocode/MCP)

1. **Bash-Logik (`.bash_lib` & `.bashrc`):**
   - Funktionen müssen "Level-Aware" sein.
   - Nutze die existierende `exportadd`-Logik für Pfad-Manipulationen.
   - Priorisiere bei der Aktivierung: Level 3 (`.venv`) > Level 2 (`~/.startenv`).

2. **Python-Workflows:**
   - Installiere niemals Libraries global.
   - Nutze `uv tool install` für CLI-Apps (Level 1).
   - Nutze `uv add` für Projekt-Abhängigkeiten (Level 3).

3. **Integration & Aliase:**
   - Neue Aliase gehören in `.bash_aliases`.
   - Komplexe Logik gehört in `.bash_lib`.
   - Der Prompt (PS1) muss den Status der Levels (Farben!) widerspiegeln.

---

## 🚩 Aktueller Arbeitsauftrag für die Session
1. **Status Quo:** Analyse der vorhandenen `.bash_lib` im Repo.
2. **Ziel:** Optimierung der `pyinit`-Funktion und der Jupyter-Kernel-Integration gemäß der Level-Trennung.
3. **Task:** Erstelle robuste Bootstrap-Logik für das `devenv`-Notebook (L0/L1) und das `pythoncoding`-Notebook (L2/L3).

---
**Hinweis für die KI:** Arbeite konservativ. Ändere keine Pfade, ohne die Auswirkungen auf die anderen Level zu prüfen. Nutze vorhandene Variablen aus der `.bash_lib`.