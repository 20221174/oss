const express = require('express');

// Constants
const PORT = process.env.PORT || 5000;

// App
const app = express();
app.get('/', function (req, res) {
  res.send('PR test\n');
});

app.listen(PORT);
console.log('Running on http://localhost:' + PORT);
