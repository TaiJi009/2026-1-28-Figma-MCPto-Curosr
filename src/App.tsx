import { useCallback, useMemo, useState } from 'react';
import { parseExcelFile } from './utils/excel';
import {
  filterByYearMonth,
  getSummary,
  getMonthlyData,
  getCategoryData,
  getAvailableYearsMonths,
} from './utils/aggregate';
import type { Transaction } from './types';
import { UploadZone } from './components/UploadZone';
import { Filters } from './components/Filters';
import { SummaryCards } from './components/SummaryCards';
import { TrendChart } from './components/TrendChart';
import { CategoryChart } from './components/CategoryChart';
import { DataTable } from './components/DataTable';
import styles from './App.module.css';

export default function App() {
  const [transactions, setTransactions] = useState<Transaction[]>([]);
  const [error, setError] = useState<string | null>(null);
  const [filterYear, setFilterYear] = useState('');
  const [filterMonth, setFilterMonth] = useState('');

  const handleFile = useCallback((file: File) => {
    parseExcelFile(file)
      .then((rows) => {
        setTransactions(rows);
        setError(null);
        setFilterYear('');
        setFilterMonth('');
      })
      .catch((err) => {
        setError(err instanceof Error ? err.message : '解析失败');
        setTransactions([]);
      });
  }, []);

  const { years, monthsByYear } = useMemo(
    () => getAvailableYearsMonths(transactions),
    [transactions]
  );

  const filtered = useMemo(
    () => filterByYearMonth(transactions, filterYear, filterMonth),
    [transactions, filterYear, filterMonth]
  );

  const summary = useMemo(() => getSummary(filtered), [filtered]);
  const monthlyData = useMemo(() => getMonthlyData(filtered), [filtered]);
  const categoryData = useMemo(() => getCategoryData(filtered), [filtered]);

  const hasData = transactions.length > 0;

  return (
    <div className={styles.app}>
      <header className={styles.header}>
        <h1 className={styles.title}>个人财务看板</h1>
        <p className={styles.subtitle}>上传 Excel 查看收入支出与趋势</p>
      </header>

      <main className={styles.main}>
        <section className={styles.upload}>
          <UploadZone
            onFile={handleFile}
            error={error}
            clearError={() => setError(null)}
          />
        </section>

        {hasData && (
          <>
            <section className={styles.filters}>
              <Filters
                years={years}
                monthsByYear={monthsByYear}
                year={filterYear}
                month={filterMonth}
                onYearChange={setFilterYear}
                onMonthChange={setFilterMonth}
              />
            </section>

            <section className={styles.summary}>
              <SummaryCards summary={summary} />
            </section>

            <section className={styles.charts}>
              <TrendChart data={monthlyData} />
              <CategoryChart data={categoryData} />
            </section>

            <section className={styles.table}>
              <DataTable rows={filtered} />
            </section>
          </>
        )}
      </main>

      <footer className={styles.footer}>
        <p>数据仅存于当前页面，刷新后清空。Excel 表头需含「日期」「金额」，建议含「类型」「分类」「备注」。</p>
      </footer>
    </div>
  );
}
