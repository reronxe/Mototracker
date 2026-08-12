# MotoTracker

App de base: carte en direct, démarrage/arrêt d'un trajet, historique des trajets enregistrés.

## Structure

- `Sources/MotoTracker/Models` — `Trip`, `TrackedPoint`
- `Sources/MotoTracker/Services` — `LocationManager` (GPS), `TripStore` (sauvegarde JSON locale)
- `Sources/MotoTracker/Views` — `HomeView` (carte + bouton), `HistoryView` (liste), `TripDetailView`
- `project.yml` — spec XcodeGen, génère le `.xcodeproj` automatiquement en CI (pas besoin de Mac ni de committer le projet Xcode)
- `.github/workflows/build.yml` — build automatique à chaque push

## Mettre le projet sur GitHub

Depuis ce dossier, dans un terminal (PowerShell ou Git Bash) :

```bash
git init
git add .
git commit -m "Base du projet MotoTracker"
git branch -M main
git remote add origin https://github.com/TON_USER/MotoTracker.git
git push -u origin main
```

Remplace `TON_USER` par ton nom d'utilisateur GitHub, et crée le repo vide sur GitHub avant (bouton "New repository", sans README ni .gitignore).

## Voir le résultat

1. Va sur ton repo GitHub → onglet **Actions**
2. Clique sur le run le plus récent (se lance automatiquement après le push)
3. Attends que les deux jobs (`preview` et `build-ipa`) finissent (~5-10 min, macOS = plus lent)
4. En bas de la page du run, section **Artifacts** :
   - **preview-screenshots** → captures d'écran de `HomeView` et `HistoryView`, à télécharger et ouvrir directement (PNG)
   - **MotoTracker-ipa** → le fichier `.ipa` à installer sur ton iPhone via AltStore/AltServer

## Prochaines étapes possibles

- Ajouter d'autres tests dans `PreviewSnapshotTests.swift` pour prévisualiser `TripDetailView`
- Améliorer la précision GPS / gestion batterie
- Ajouter des statistiques (vitesse max, dénivelé) au modèle `Trip`
