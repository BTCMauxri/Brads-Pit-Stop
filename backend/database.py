import os
import mysql.connector
from dotenv import load_dotenv

# Load variables from the .env file
load_dotenv()

def get_db_connection():
    try:
        connection = mysql.connector.connect(
            host=os.getenv("DB_HOST"),
            port=os.getenv("DB_PORT"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD"),
            database=os.getenv("DB_NAME")
        )
        print("Successfully connected to the F1 Database!")
        return connection
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return None

# Quick test when you run this file directly
if __name__ == "__main__":
    get_db_connection()