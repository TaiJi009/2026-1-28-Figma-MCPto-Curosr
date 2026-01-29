import { useCallback, useState } from 'react';
import type { DragEvent } from 'react';
import styles from './UploadZone.module.css';

interface UploadZoneProps {
  onFile: (file: File) => void;
  error: string | null;
  clearError: () => void;
}

export function UploadZone({ onFile, error, clearError }: UploadZoneProps) {
  const [drag, setDrag] = useState(false);

  const handleFile = useCallback(
    (file: File | null) => {
      if (!file) return;
      const name = file.name.toLowerCase();
      if (!name.endsWith('.xlsx') && !name.endsWith('.xls')) {
        return;
      }
      onFile(file);
      clearError();
    },
    [onFile, clearError]
  );

  const onDrop = useCallback(
    (e: DragEvent<HTMLDivElement>) => {
      e.preventDefault();
      setDrag(false);
      const f = e.dataTransfer.files[0];
      handleFile(f ?? null);
    },
    [handleFile]
  );

  const onDragOver = useCallback((e: DragEvent<HTMLDivElement>) => {
    e.preventDefault();
    setDrag(true);
  }, []);

  const onDragLeave = useCallback(() => {
    setDrag(false);
  }, []);

  const onInputChange = useCallback(
    (e: React.ChangeEvent<HTMLInputElement>) => {
      const f = e.target.files?.[0];
      handleFile(f ?? null);
      e.target.value = '';
    },
    [handleFile]
  );

  return (
    <div
      className={`${styles.zone} ${drag ? styles.drag : ''}`}
      onDrop={onDrop}
      onDragOver={onDragOver}
      onDragLeave={onDragLeave}
    >
      <input
        type="file"
        accept=".xlsx,.xls"
        onChange={onInputChange}
        className={styles.input}
        id="excel-upload"
        aria-label="选择 Excel 文件"
      />
      <label htmlFor="excel-upload" className={styles.label}>
        拖拽 Excel 到此处，或点击选择文件
      </label>
      <p className={styles.hint}>支持 .xlsx / .xls，表头需包含「日期」「金额」，建议含「类型」「分类」「备注」</p>
      {error && <p className={styles.error} role="alert">{error}</p>}
    </div>
  );
}
