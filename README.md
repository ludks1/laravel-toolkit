# ⚙️ Laravel Artisan Toolkit for PowerShell

> Supercharge your Laravel workflow from any terminal window.

A fully interactive **PowerShell script** that gives you an intuitive menu for running common Laravel `artisan` commands — migrations, seeding, testing, server start, and more.

---

## 🎯 Features

- Run and rollback migrations interactively
- Seed your database in one command
- Start Laravel development server
- Generate models, migrations, factories
- Maintenance commands (cache clear, config cache, route list, etc.)
- Fully interactive migration name builder
- Built-in error handling and command feedback
- Optional ASCII banner (supports `ascii.txt`)

---

## 🖥️ Preview

![image](https://github.com/user-attachments/assets/d58120b8-3b05-4a8b-94bd-9a603a18c516)


---

## 📦 Installation

1. **Download or clone this repository**  
   Save the script as:


2. (Optional) Create an ASCII banner  
In the same folder, add a file called:
**ascii.txt** And paste your ASCII art there (it will be shown when the script starts).

---

## 🔧 Add Script to System PATH

To be able to run `laravel-tool.ps1` from **anywhere**, follow these steps:

### 🪟 On Windows

1. Move the script to a custom scripts folder (e.g., `C:\Users\<YourUser>\Scripts`)
2. Add that folder to your **User PATH**:
- Press `Win + R`, type `sysdm.cpl`, and hit Enter
- Go to **Advanced** > **Environment Variables**
- Under **User variables**, find `Path`, and click **Edit**
- Click **New** and add the full path:
  ```
  C:\Users\<YourUser>\Scripts
  ```
- Click **OK** and close everything

3. Now from any PowerShell window, you can run:
```laravel-tool```

🔐 License
MIT

ASCII art remains the property of its original creators.
(Current banner by Shanaka Dias.)

📌 To-Do / Personal Notes
 Add more custom commands you use often

 Add support for .env management

 Log all output to file

"You must let go of what you fear to lose. Including typing php artisan every time."
— Anakin Skywalker (probably)



