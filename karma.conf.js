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
  'src/**/*.coffee',
  //'libs/*.js',
  'tests/*.coffee'
];

preprocessors = {
  '**/*.coffee': 'coffee'
};

reporters = ['dots']; /* dots progress junit growl coverage */

port = 9876;
runnerPort = 9100;
//port = 3000;

singleRun = false;
//urlRoot = ''


