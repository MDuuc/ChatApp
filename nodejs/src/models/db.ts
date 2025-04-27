import { Pool } from 'pg';

const pool = new Pool({
  user: 'postgres',
  password: 'taokobiet',
  host: 'localhost',
  port: 5432,
  database: 'worldb'
});

export default pool;
