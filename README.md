# 📝 Flutter Todo List App

A sleek, user-friendly Todo List application built with **Flutter**. This app helps you manage your daily tasks efficiently using local storage via **Shared Preferences** — no login or internet required!

## 🚀 Features

- ✅ Add, edit, and delete tasks
- 🗓️ Pick a due date using a date picker
- 💾 Locally save your data using **Shared Preferences**
- 📱 Smooth and responsive UI
- 👆 Swipe to delete or edit tasks with **Slidable**
- 🧼 Clear input fields with a single tap

## 📁 Project Structure

```
todo_list_app/
│
├── lib/
│   ├── models/
│   │   └── todomodel.dart        # Model class for tasks
│   ├── APIs/
│   │   └── shared_pref_api.dart  # Shared Preferences handling
│   └── main.dart                 # Entry point
│   ├── screens/
│   │   └── homepage.dart        # Main UI and logic
│
├── android/
├── ios/
├── pubspec.yaml                 # Dependencies
```

## 🛠️ Packages & APIs Used

- [`shared_preferences`](https://pub.dev/packages/shared_preferences) – Store data locally
- [`flutter_slidable`](https://pub.dev/packages/flutter_slidable) – Swipe actions for ListView
- [`intl`](https://pub.dev/packages/intl) – Format dates

## 💡 How It Works

1. Enter the task name, description, and select a date.
2. Tap **Save** to add it to the list.
3. Swipe left or right on a task to **Edit** or **Delete** it.
4. Data is stored persistently using Shared Preferences.

## 📱 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/todo_list_app.git
   cd todo_list_app
   ```

2. Run the app:
   ```bash
   flutter pub get
   flutter run
   ```

## 📦 Build APK (Optional)

To generate an APK:
```bash
flutter build apk --release
```

Output:

![Alt Text](https://github.com/Tanuja265/Todo_List_App/blob/3ae67373e84150d00bde7a2062cbef582f5d474a/Todo_List%20(2).png)


## 👤 Author

Annam Tanuja  
Flutter Developer | Passionate about App Development 
[GitHub](https://github.com/Tanuja265)
