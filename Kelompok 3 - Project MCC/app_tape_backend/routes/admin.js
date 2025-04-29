var express = require('express');
const db = require('../database/connection.js');
var router = express.Router();
var bcrypt = require('bcrypt');

router.post('/insert', (req, res) => {
  const { admin_name, admin_password, role } = req.body;

  bcrypt.hash(admin_password, 10, (err, hashedPassword) => {
    if (err) {
      console.error('Error hashing password:', err); // Log error hashing
      return res.status(500).json({ message: 'Password hashing failed', error: err.message });
    }

    const query = 'INSERT INTO admin (admin_name, admin_password, role) VALUES (?, ?, ?)';
    db.query(query, [admin_name, hashedPassword, role], (err, result) => {
      if (err) {
        console.error('Error inserting admin:', err); // Log error inserting admin
        return res.status(500).json({ message: 'Failed to insert admin', error: err.message });
      }
      res.status(200).json({ message: 'Admin inserted successfully' });
    });
  });
});

module.exports = router;