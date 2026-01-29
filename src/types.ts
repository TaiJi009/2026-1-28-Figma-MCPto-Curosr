export type TransactionType = 'income' | 'expense';

export interface Transaction {
  id: string;
  date: string;       // YYYY-MM-DD
  type: TransactionType;
  amount: number;
  category: string;
  note: string;
}

export interface Summary {
  totalIncome: number;
  totalExpense: number;
  balance: number;
}

export interface MonthlyData {
  month: string;
  income: number;
  expense: number;
  balance: number;
}

export interface CategoryData {
  category: string;
  amount: number;
  type: TransactionType;
}
