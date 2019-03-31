const express = require('express');
const app = express();
const port = 3000;

app.get('/:day', (req, res) => res.sendFile(`${__dirname}/${req.params.day}/index.html`));
app.get('/:day/index.js', (req, res) => res.sendFile(`${__dirname}/${req.params.day}/index.js`));
app.get('/:day/vert', (req, res) => res.sendFile(`${__dirname}/${req.params.day}/vert.glsl`));
app.get('/:day/frag', (req, res) => res.sendFile(`${__dirname}/${req.params.day}/frag.glsl`));

app.listen(port, () => console.log(`listening on port ${port}!`));