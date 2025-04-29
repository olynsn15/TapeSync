var express = require('express')
const db = require("../database/connection.js")
var router = express.Router()

// 3 endpoint
// get all recipe
// insert
// delete

router.get("/", (req, res, next) => {
    const genre = req.query.genre;  
    let sql = 'SELECT * FROM tapes';  

    if (genre) {
        sql += ` WHERE tape_genre = '${genre}'`;
    }

    db.query(sql, (err, result) => {
        if (err) {
            return res.status(500).send({error: err.message});
        }
        res.status(200).send(result);
    });
});

var multer = require("multer")
var storage = multer.diskStorage({
    destination: (req, file, cb) =>{
        cb(null, "./assets/")
    },
    filename: (req, file, cb) =>{
        cb(null, file.originalname)
    }
})

var uploud = multer({ storage: storage })

router.post("/", uploud.single("TapeImage"), (req, res, next) => {
    const data = req.body
    const file = req.file

    const filePath = "/" + file.path.replace("\\", "/")
    db.query(`INSERT INTO tapes VALUES ('0', '${data.TapeTitle}', '${data.description}', '${data.TapeGenre}', '${data.TapePrice}', '${data.TapeYear}' ,'${filePath}', '${data.level}')`, 
        (err, result) => {
            if(err) throw err;
            res.status(200).send(result)
        }
    )
})

// router.post('/purchases', (req, res) => {
//     const { items } = req.body;

//     if (!items || items.length === 0) {
//         return res.status(400).send('Missing purchase details');
//     }

//     const tapeIDs = items.map(item => item.TapeID);

//     // Check if all TapeIDs exist in the tapes table
//     const checkTapesQuery = 'SELECT id FROM tapes WHERE id IN (?)';
//     db.query(checkTapesQuery, [tapeIDs], (err, results) => {
//         if (err) {
//             console.error('Error checking tapes:', err);
//             return res.status(500).send('Error checking tapes');
//         }

//         const existingTapeIDs = results.map(row => row.id);
//         const missingTapeIDs = tapeIDs.filter(id => !existingTapeIDs.includes(id));

//         if (missingTapeIDs.length > 0) {
//             return res.status(400).send({
//                 message: 'Invalid TapeID(s)',
//                 missingTapeIDs,
//             });
//         }

//         // Proceed with purchase insertion
//         const purchaseQuery = 'INSERT INTO purchases (tape_id, quantity, purchase_date, user_id, total_price) VALUES ?';
//         const values = items.map(item => [item.TapeID, item.Quantity, new Date(), 1]); // Assuming user_id is 1 for now

//         db.query(purchaseQuery, [values], (err, result) => {
//             if (err) {
//                 console.error('Error saving purchase:', err);
//                 return res.status(500).send('Error saving purchase');
//             }
//             res.status(200).send({ message: 'Purchase completed successfully' });
//         });
//     });
// });

module.exports = router;