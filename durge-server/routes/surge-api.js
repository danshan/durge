var express = require('express');
var request = require('request');
var router = express.Router();

router.get('/:location?', function (req, res, next) {
  // res.json(getStubWeatherData(req.params.location));
  var url = "http://127.0.0.1:6166"
    request({uri: url, method: "GET", json: true}, function (_err, _res, _resBody) {
      res.json(_resBody);
    });
});

function getStubWeatherData(location) {
  var currentSeconds = new Date().getSeconds();
  return {
    weather: {
      location: location || 'londonon',
      temperature: `${currentSeconds / 2}\u2103`,
      weatherDescription: currentSeconds % 2 == 0 ? 'partly cloudy' : 'sunny'
    }
  };
}

module.exports = router;
