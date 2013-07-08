autoWatch = false;

basePath = '';

frameworks = ['jasmine'];

browsers = ['Safari']//, 'Firefox']//, 'PhantomJS'];
  /*
    Chrome
    ChromeCanary
    Firefox
    Opera
    Safari
    PhantomJS
  */
//captureTimeout = 60000,

colors = true;

//exclude = [],
files = [
  JASMINE,
  JASMINE_ADAPTER,
  //'src/**/*.coffee',
  'libs/*.js',
  'tests/*.coffee'
];


reporters = ['dots']; /* dots progress junit growl coverage */

singleRun = false;
//urlRoot = ''


