# Git Bash: жаңа GitHub репозиторийіне жүктеу

**Ескерту:** Бұл басқа адамға арналған бөлек репозиторий. Бұрынғы `smart-home-management` жобасына қоспаңыз.

## 1. GitHub-та репозиторий құру
- https://github.com/new
- Repository name: `smart-parking-system`
- Description: `Smart parking information system for booking spaces and controlling access.`
- Public таңдаңыз.
- README, .gitignore, license автоматты қосылмасын.
- Topics: `smart-parking`, `parking-management`, `uml`, `iot`, `automation`.

## 2. Архивті ашып, жоба папкасының ішінде Git Bash іске қосу

`README.md` көрініп тұрған папкада:

```bash
git init -b main
git remote add origin https://github.com/USERNAME/smart-parking-system.git
```

`USERNAME` орнына репозиторий иесінің GitHub логинін енгізіңіз. Қажет болса, алдымен `git config --global user.name` және `git config --global user.email` баптаңыз.

## 3. Төрт мағыналы commit

```bash
git add README.md .gitignore GITHUB_STEPS.md
git commit -m "Add smart parking README and repository guide"

git switch -c behavior-diagrams

git add docs/analysis/activity-enter-parking.drawio docs/analysis/activity-enter-parking.png
git commit -m "Add activity diagram for parking entry"

git add docs/analysis/sequence-enter-parking.drawio docs/analysis/sequence-enter-parking.png
git commit -m "Add sequence diagram for parking entry"

git add docs/analysis/SCENARIO.md
git commit -m "Document smart parking entry scenario"

git log --oneline
```

## 4. GitHub-қа жіберу

```bash
git push -u origin behavior-diagrams
git push -u origin main
```

## 5. Pull Request
- GitHub-та Pull requests → New pull request.
- **base: main**, **compare: behavior-diagrams**.
- Create pull request → Merge pull request → Confirm merge.
- `behavior-diagrams` тармағын өшірмеңіз.
- `main` ішіндегі README сурет сілтемелерін тексеріңіз.

## 6. Тапсыру
- GitHub-тағы Public репозиторийдің сілтемесін жетекшіге жіберіңіз.
