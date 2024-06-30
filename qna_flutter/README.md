# qna_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


lib/
├── main.dart
├── screens/
│   ├── home_screen.dart
│   ├── questions_screen.dart
│   ├── question_detail_screen.dart
│   ├── create_question_screen.dart
│   ├── edit_question_screen.dart
│   └── ... (další obrazovky pro odpovědi, témata atd.)
├── widgets/
│   ├── question_list_item.dart
│   ├── answer_list_item.dart
│   └── ... (další widgety pro opakovaně použitelné UI prvky)
├── models/
│   ├── question.dart
│   ├── answer.dart
│   └── topic.dart
├── services/
│   └── api_service.dart
└── utils/
└── ... (helper funkce a utility)

Vysvětlení:
main.dart: Hlavní vstupní bod aplikace, kde se inicializuje Flutter a nastavuje se domovská obrazovka.
screens/: Adresář pro obrazovky aplikace:
home_screen.dart: Úvodní obrazovka s menu.
questions_screen.dart: Obrazovka pro zobrazení seznamu otázek.
question_detail_screen.dart: Obrazovka pro detailní zobrazení otázky a odpovědí.
create_question_screen.dart: Obrazovka pro vytvoření nové otázky.
edit_question_screen.dart: Obrazovka pro úpravu existující otázky.
... (další obrazovky podle potřeby)
widgets/: Adresář pro opakovaně použitelné widgety:
question_list_item.dart: Widget pro zobrazení jedné otázky v seznamu.
answer_list_item.dart: Widget pro zobrazení jedné odpovědi.
... (další widgety podle potřeby)
models/: Adresář pro datové modely:
question.dart: Třída reprezentující otázku.
answer.dart: Třída reprezentující odpověď.
topic.dart: Třída reprezentující téma.
services/: Adresář pro služby, které komunikují s backendem:
api_service.dart: Třída pro posílání HTTP požadavků na Django endpointy.
utils/: Adresář pro helper funkce a utility.
Další tipy:
State management: Pro správu stavu aplikace zvažte použití state management knihovny jako Provider, BLoC, nebo Riverpod.
Navigace: Pro navigaci mezi obrazovkami použijte Navigator a Named Routes.
Chybové stavy: Implementujte chybové stavy a zobrazujte uživateli informativní hlášky v případě selhání požadavků na Django.
Testování: Pište unit a widget testy pro zajištění kvality kódu.
Integrace Hugging Face:
Pro integraci Hugging Face transformerů pro zodpovídání otázek budete potřebovat:
Najít vhodný model: Vyberte si model z Hugging Face Hub, který se hodí pro váš use case.
Integrace modelu do Flutteru: Použijte knihovnu jako transformers pro integraci modelu do Flutter aplikace.
Posílání požadavků na model: Implementujte funkci, která pošle otázku na model a vrátí odpověď.
Zobrazení odpovědi: Zobrazte odpověď od modelu uživateli.
Tato struktura kódu vám pomůže udržovat aplikaci přehlednou a škálovatelnou. Neváhejte se zeptat, pokud máte další otázky!