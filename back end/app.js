require('dotenv').config();
const express = require('express');
const mysql = require('mysql2/promise');
const app = express();

async function getConn() {
  return await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT
  });
}

app.get('/data', async (req, res) => {
  try {
    const conn = await getConn();
    const [rows] = await conn.query('SELECT * FROM products LIMIT 50');
    await conn.end();
    res.json(rows);
  } catch (err) {
    res.status(500).send(err.message);
  }
});

app.listen(3000, () => console.log('Server running http://localhost:3000/data'));
