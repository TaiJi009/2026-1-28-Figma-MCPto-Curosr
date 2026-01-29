import type { Transaction, MonthlyData, CategoryData } from '../types';

export function filterByYearMonth(rows: Transaction[], year: string, month: string): Transaction[] {
  return rows.filter((r) => {
    const [y, m] = r.date.split('-');
    return y === year && (month === '' || m === month);
  });
}

export function getSummary(rows: Transaction[]): { totalIncome: number; totalExpense: number; balance: number } {
  let totalIncome = 0;
  let totalExpense = 0;
  for (const r of rows) {
    if (r.type === 'income') totalIncome += r.amount;
    else totalExpense += r.amount;
  }
  return { totalIncome, totalExpense, balance: totalIncome - totalExpense };
}

export function getMonthlyData(rows: Transaction[]): MonthlyData[] {
  const byMonth: Record<string, { income: number; expense: number }> = {};
  for (const r of rows) {
    const month = r.date.slice(0, 7);
    if (!byMonth[month]) byMonth[month] = { income: 0, expense: 0 };
    if (r.type === 'income') byMonth[month].income += r.amount;
    else byMonth[month].expense += r.amount;
  }
  return Object.entries(byMonth)
    .sort(([a], [b]) => a.localeCompare(b))
    .map(([month, { income, expense }]) => ({
      month,
      income,
      expense,
      balance: income - expense,
    }));
}

export function getCategoryData(rows: Transaction[]): CategoryData[] {
  const byCat: Record<string, { income: number; expense: number }> = {};
  for (const r of rows) {
    const cat = r.category || (r.type === 'income' ? '收入' : '未分类');
    if (!byCat[cat]) byCat[cat] = { income: 0, expense: 0 };
    if (r.type === 'income') byCat[cat].income += r.amount;
    else byCat[cat].expense += r.amount;
  }
  const out: CategoryData[] = [];
  for (const [category, v] of Object.entries(byCat)) {
    if (v.income > 0) out.push({ category: category + ' (收入)', amount: v.income, type: 'income' });
    if (v.expense > 0) out.push({ category: category + ' (支出)', amount: v.expense, type: 'expense' });
  }
  return out.sort((a, b) => b.amount - a.amount);
}

export function getAvailableYearsMonths(rows: Transaction[]): { years: string[]; monthsByYear: Record<string, string[]> } {
  const yearsSet = new Set<string>();
  const monthsByYear: Record<string, Set<string>> = {};
  for (const r of rows) {
    const [y, m] = r.date.split('-');
    yearsSet.add(y);
    if (!monthsByYear[y]) monthsByYear[y] = new Set();
    monthsByYear[y].add(m);
  }
  const years = Array.from(yearsSet).sort((a, b) => b.localeCompare(a));
  const out: Record<string, string[]> = {};
  for (const y of Object.keys(monthsByYear)) {
    out[y] = Array.from(monthsByYear[y]).sort((a, b) => a.localeCompare(b));
  }
  return { years, monthsByYear: out };
}
