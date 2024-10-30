const { Router } = require('express');
const router = Router();

router.get('/', (req, res) => {
    res.send('Hi, my name is Hugo Vega and this is a practice for Containers subject')
});

module.exports = router;