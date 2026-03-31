const express = require('express');
const { createClient } = require('@supabase/supabase-js');

const app = express();
app.use(express.json());

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_KEY
);

app.post('/employee', async (req, res) => {
  const { name, email } = req.body;

  const { data, error } = await supabase
    .from('employees')
    .insert([{ name, email }]);

  res.json({ data, error });
});

app.get('/employees', async (req, res) => {
  const { data, error } = await supabase
    .from('employees')
    .select('*');

  res.json(data);
});

app.listen(3000, () => console.log('Server running'));
