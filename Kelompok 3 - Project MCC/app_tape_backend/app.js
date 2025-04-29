var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
require('dotenv').config();

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');

var tapesRouter = require('./routes/tapes');
var adminRouter = require('./routes/admin');
var app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);

console.log("App is starting..."); 

app.use('/tapes', tapesRouter);
app.use('/admin', adminRouter);
app.use("/assets", express.static("assets"));
module.exports = app;
