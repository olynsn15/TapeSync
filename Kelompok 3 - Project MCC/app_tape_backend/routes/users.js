var express = require('express');
var router = express.Router();
var db = require("../database/connection.js");
var jwt = require('jsonwebtoken');
var bcrypt = require('bcrypt');

// Fungsi untuk generate token
function generateToken(user) {
  var payload = {
    id: user.id,
    username: user.username
  };
  return jwt.sign(payload, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '1h' });
}

//REGISTER
router.post('/register', async (req, res) => {
  const { username, email, password } = req.body;

  if (!username || !email || !password) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  try {
    const hashedPass = await bcrypt.hash(password, 10);
    const query = 'INSERT INTO users (name, email, password) VALUES (?, ?, ?)';
    db.query(query, [username, email, hashedPass], (err, result) => {
      if (err) {
        console.error('Error while inserting data:', err);
        return res.status(500).json({ message: 'Internal server error.' });
      }
      res.status(200).json({ message: 'Register successfully' });
    });
  } catch (err) {
    console.error('Error hashing password:', err);
    res.status(500).json({ message: 'Registration failed' });
  }
})

//LOGIN
router.post('/login', async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ message: 'Username and Password are required.' });
  }

  const adminQuery = 'SELECT * FROM admin WHERE admin_name = ?';
  db.query(adminQuery, [username], async (err, result) => {
    if (err) {
      return res.status(500).json({ message: 'Internal server error.' })
    }
    if (result.length > 0) {
      const isPasswordValid = await bcrypt.compare(password, result[0].admin_password);
      if (!isPasswordValid) {
        return res.status(400).json({ message: 'Invalid password.' });
      }

      const token = generateToken(result[0]);

      const updateAdminQuery = 'UPDATE admin SET token = ? WHERE id = ?';
      db.query(updateAdminQuery, [token, result[0].id], (err, updateResult) => {
        if (err) {
          return res.status(500).json({ message: 'Error updating token.' });
        }

        res.status(200).json({
          message: 'Login Successful!',
          token: token,
          role: 'admin',
        });
      });
    } else {
      const query = 'SELECT * FROM users WHERE name = ?';
      db.query(query, [username], async (err, result) => {
        if (err) {
          return res.status(500).json({ message: 'Internal server error.' });
        }

        if (result.length === 0) {
          return res.status(404).json({ message: 'User not found.' });
        }

        // Verifikasi password
        const isPasswordValid = await bcrypt.compare(password, result[0].password);
        if (!isPasswordValid) {
          return res.status(400).json({ message: 'Invalid password.' });
        }

        // Generate JWT token
        const token = generateToken(result[0]);

        // Update token di database
        const updateQuery = 'UPDATE users SET token = ? WHERE id = ?';
        db.query(updateQuery, [token, result[0].id], (err, updateResult) => {
          if (err) {
            return res.status(500).json({ message: 'Error updating token.' });
          }

          // Kirim token sebagai respons
          res.status(200).json({
            message: 'Login successful!',
            token: token,
          });
        });
      });
    }
  })
});

// Middleware untuk protection
function verifyToken(req, res, next) {
  const authHeader = req.headers.authorization;
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).send('No Token Provided');
  }

  const token = authHeader.split(' ')[1];

  try {
    const decoded = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);
    req.user = decoded;
    next();
  } catch (err) {
    if (err.name === 'TokenExpiredError') {
      return res.status(401).send('Token Expired');
    } else if (err.name === 'JsonWebTokenError') {
      return res.status(401).send('Invalid Token');
    } else {
      return res.status(401).send('Unauthorized access');
    }
  }
}

// Route protected dengan middleware
router.get('/secretLink', verifyToken, function (req, res, next) {
  console.log('THIS IS PROTECTED RESOURCE LINK');
  return res.send('Super secret message!');
});

module.exports = router;

/* GET users listing. */
router.get('/', function (req, res, next) {
  res.send('respond with a resource');
});

module.exports = router;
