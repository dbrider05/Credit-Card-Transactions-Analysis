# Credit Card Transactions Analysis

## 📌 Project Overview
This project analyzes credit card transactions to uncover spending patterns, city-wise expenditures, and card type preferences. The dataset contains transaction details such as city, date, card type, expense type, gender, and transaction amount. SQL queries are used for data loading and insightful analysis.

## 💻 Technologies Used
- **SQL** (Data Analysis & Queries)
- **Microsoft SQL Server** (Database Management)
- **CSV Data Handling** (Bulk Import)

## 📂 Dataset Details
- **File Name**: `credit_card_transcations.csv`
- **Columns**:
  - `transaction_id`: Unique ID for transactions
  - `city`: Location where the transaction occurred
  - `transaction_date`: Date of transaction
  - `card_type`: Type of credit card used (Visa, Mastercard, etc.)
  - `exp_type`: Type of expense (e.g., Shopping, Travel, Food)
  - `gender`: Gender of the cardholder
  - `amount`: Transaction amount

## 🚀 How to Use the Project
1. **Load Data into Database**
   - Ensure the `transactions` database exists.
   - Execute `credit_card_transactions_load_data.sql` to create the table and import data.

2. **Run Analysis Queries**
   - Execute `credit_card_transactions_analysis.sql` to get insights such as:
     - Top 5 cities with the highest credit card spending
     - Month-wise highest spending for each card type
     - Other spending trends and patterns

## 📊 Analysis & Insights
- **Top 5 Cities by Total Spend**
  - Identifies cities with the highest credit card usage.
  - Calculates their percentage contribution to total transactions.

- **Highest Spending Month for Each Card Type**
  - Determines the month where each card type recorded peak spending.

## 🔮 Future Improvements
- Add **data visualizations** using Python (Matplotlib/Seaborn) or Tableau.
- Enhance queries to include **seasonal trends & customer segmentation**.
- Automate data loading using a **script or stored procedure**.

---
📢 **Contributions & Feedback:** Open to improvements! Feel free to fork and enhance the analysis. 🚀

