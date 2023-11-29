import pyodbc
from datetime import datetime
import tkinter as tk
from tkinter import messagebox

class UserInterface(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("CommentC Method UI")
        self.label_login = tk.Label(self, text="Login:")
        self.entry_login = tk.Entry(self, width=30)

        self.label_text = tk.Label(self, text="Text:")
        self.entry_text = tk.Entry(self, width=30)

        self.label_thread = tk.Label(self, text="Thread ID:")
        self.entry_thread = tk.Entry(self, width=30)

        self.btn_comment = tk.Button(self, text="Add Comment", command=self.add_comment)
        self.label_login.grid(row=0, column=0, padx=10, pady=10)
        self.entry_login.grid(row=0, column=1, padx=10, pady=10)

        self.label_text.grid(row=1, column=0, padx=10, pady=10)
        self.entry_text.grid(row=1, column=1, padx=10, pady=10)

        self.label_thread.grid(row=2, column=0, padx=10, pady=10)
        self.entry_thread.grid(row=2, column=1, padx=10, pady=10)

        self.btn_comment.grid(row=3, column=0, columnspan=2, pady=10)

    def add_comment(self):
        login = self.entry_login.get()
        text = self.entry_text.get()
        thread = self.entry_thread.get()

        result = user.CommentC(login, text, thread)

        if result == 1:
            messagebox.showinfo("Коментар був успішно додан!")
        else:
            messagebox.showerror("Помилка! Коментар не був успішно додан!")
 
# З'єднання з базою даних
server = 'DESKTOP-LLJO8OJ\SQLEXPRESS'
database = 'HarmonyHub'
driver = 'ODBC Driver 17 for SQL Server'
conn_str = f'DRIVER={driver};SERVER={server};DATABASE={database};Trusted_Connection=yes'
conn = pyodbc.connect(driver = driver, host = server, database = database, trusted_connection='yes')
cursor = conn.cursor()

class User:
    def __init__(self, id, login, email, password, date_created):
        self.id = id
        self.login = login
        self.email = email
        self.password = password
        self.date_created = date_created

    def CommentC(self, login, text, thread):
        if not self._check_login(login):
            return 0
        if not self._check_text(text):
            return 0
        if not self._check_thread(thread):
            return 0
        return 1

    def _check_login(self, login):
        if len(login) <= 30 and len(login) > 0:
            if self._login_exists(login):
                return True
        return False

    def _check_text(self, text):
        return len(text) <= 2000

    def _check_thread(self, thread):
        if self._thread_exists(thread):
            return True
        return False

    def _login_exists(self, login):
        conn = pyodbc.connect(conn_str)
        cursor = conn.cursor()

        cursor.execute(f"SELECT COUNT(*) FROM usermod WHERE login = '{login}'")
        count = cursor.fetchone()[0]

        cursor.close()
        conn.close()

        return count > 0

    def _thread_exists(self, thread):
        conn = pyodbc.connect(conn_str)
        cursor = conn.cursor()

        cursor.execute(f"SELECT COUNT(*) FROM post WHERE id = {thread}")
        count = cursor.fetchone()[0]

        cursor.close()
        conn.close()

        return count > 0

class ArtPiece:
    def __init__(self, id, name, creator, price, picture, comment, date_put_on_sale):
        self.id = id
        self.name = name
        self.creator = creator
        self.price = price
        self.picture = picture
        self.comment = comment
        self.date_put_on_sale = date_put_on_sale

class Post:
    def __init__(self, id, headline, main_text, creator, picture, date_created):
        self.id = id
        self.headline = headline
        self.main_text = main_text
        self.creator = creator
        self.picture = picture
        self.date_created = date_created

class Comment:
    def __init__(self, id, thread, creator, text, date_created):
        self.id = id
        self.thread = thread
        self.creator = creator
        self.text = text
        self.date_created = date_created

cursor.close()
conn.close()

if __name__ == "__main__":
    user = User(id=1, login="example_user", email="user@example.com", password="password", date_created="2023-11-29")
    app = UserInterface()
    app.mainloop()
   