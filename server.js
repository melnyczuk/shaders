const express = require('express');
const app = express();
const port = 3000;

app.use(express.static(__dirname + '/'));

app.get('/:day', (req, res) => res.sendFile(`${__dirname}/${req.params.day}/index.html`));

app.listen(port, () => console.log(`listening on port ${port}!`));

