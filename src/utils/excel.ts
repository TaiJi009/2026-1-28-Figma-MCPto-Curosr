import * as XLSX from 'xlsx';
import type { Transaction, TransactionType } from '../types';

const HEADER_ALIASES: Record<string, string> = {
  '日期': 'date', '类型': 'type', '金额': 'amount', '分类': 'category', '备注': 'note',
  'date': 'date', 'type': 'type', 'amount': 'amount', 'category': 'category', 'note': 'note',
};

function normalizeHeader(str: unknown): string {
  if (typeof str !== 'string') return '';
  return String(str).trim();
}

function parseDate(val: unknown): string {
  if (typeof val === 'number' && val > 0) {
    const d = XLSX.SSF.parse_date_code(val);
    if (d) return `${d.y}-${String(d.m).padStart(2, '0')}-${String(d.d).padStart(2, '0')}`;
  }
  if (typeof val === 'string') {
    const m = val.match(/(\d{4})[-\/]?(\d{1,2})[-\/]?(\d{1,2})/);
    if (m) return `${m[1]}-${m[2].padStart(2, '0')}-${m[3].padStart(2, '0')}`;
  }
  return '';
}

function parseAmount(val: unknown): number {
  if (typeof val === 'number' && !Number.isNaN(val)) return val;
  if (typeof val === 'string') {
    const n = parseFloat(val.replace(/[^\d.-]/g, ''));
    return Number.isNaN(n) ? 0 : n;
  }
  return 0;
}

function parseType(val: unknown): TransactionType {
  const s = String(val ?? '').toLowerCase().trim();
  if (s === '收入' || s === 'income' || s === 'in') return 'income';
  return 'expense';
}

export function parseExcelFile(file: File): Promise<Transaction[]> {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      try {
        const data = e.target?.result;
        if (!data) return reject(new Error('无法读取文件'));
        const wb = XLSX.read(data, { type: 'binary' });
        const firstSheet = wb.SheetNames[0];
        const sheet = wb.Sheets[firstSheet];
        const rows = XLSX.utils.sheet_to_json<Record<string, unknown>>(sheet, { header: 1, defval: '' }) as unknown[][];
        if (rows.length < 2) return resolve([]);
        const headerRow = (rows[0] as unknown[]).map(normalizeHeader);
        const colIndex: Record<string, number> = {};
        headerRow.forEach((h, i) => {
          const key = HEADER_ALIASES[h] ?? h;
          if (key) colIndex[key] = i;
        });
        const hasDate = 'date' in colIndex;
        const hasAmount = 'amount' in colIndex;
        if (!hasDate || !hasAmount) {
          return reject(new Error('Excel 需包含「日期」和「金额」列，建议也包含「类型」「分类」「备注」。'));
        }
        const out: Transaction[] = [];
        for (let i = 1; i < rows.length; i++) {
          const row = rows[i] as unknown[];
          const date = parseDate(row[colIndex['date']]);
          const amount = parseAmount(row[colIndex['amount']]);
          if (!date || amount === 0) continue;
          const type = 'type' in colIndex ? parseType(row[colIndex['type']]) : 'expense';
          const category = 'category' in colIndex ? String(row[colIndex['category']] ?? '').trim() : '';
          const note = 'note' in colIndex ? String(row[colIndex['note']] ?? '').trim() : '';
          out.push({
            id: `row-${i}-${Date.now()}`,
            date,
            type,
            amount: Math.abs(amount),
            category,
            note,
          });
        }
        resolve(out);
      } catch (err) {
        reject(err instanceof Error ? err : new Error('解析失败'));
      }
    };
    reader.onerror = () => reject(new Error('文件读取失败'));
    reader.readAsBinaryString(file);
  });
}
