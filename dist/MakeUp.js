/*
 @{#}Object:        MakeUp
 @{#}Version:       1.1.1
 @{#}Last Updated:  sept 12, 2013
 @{#}Purpose:       A base class to extend and create different input
                    formatting tools.
 @{#}Author:        Blaine Kasten
 @{#}Copyright:     MIT License (MIT) Copyright (c) 2013 Blaine Kasten
                    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY 
                    OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
                    LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS 
                    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
                    EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
                    FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN 
                    AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
                    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
                    OR OTHER DEALINGS IN THE SOFTWARE.
*/


(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.MakeUp = (function() {
    MakeUp.prototype.keyMap = {
      65: 'a',
      66: 'b',
      67: 'c',
      68: 'd',
      69: 'e',
      70: 'f',
      71: 'g',
      72: 'h',
      73: 'i',
      74: 'j',
      75: 'k',
      76: 'l',
      77: 'm',
      78: 'n',
      79: 'o',
      80: 'p',
      81: 'q',
      82: 'r',
      83: 's',
      84: 't',
      85: 'u',
      86: 'v',
      87: 'w',
      88: 'x',
      89: 'y',
      90: 'z',
      48: 0,
      49: 1,
      50: 2,
      51: 3,
      52: 4,
      53: 5,
      54: 6,
      55: 7,
      56: 8,
      57: 9,
      96: 0,
      97: 1,
      98: 2,
      99: 3,
      100: 4,
      101: 5,
      102: 6,
      103: 7,
      104: 8,
      105: 9,
      190: '.',
      191: '/',
      111: '/',
      8: "delete",
      37: "left",
      39: "right",
      91: "cmd",
      9: "tab",
      16: "shift"
    };

    MakeUp.prototype.format = '';

    function MakeUp(inputType, el) {
      this.el = el;
      switch (inputType) {
        case "phone":
          new MakeUp.Phone(this.el);
          break;
        case "date":
          new MakeUp.Date(this.el);
          break;
        case "numbers":
          new MakeUp.Numbers(this.el);
          break;
        case "email":
          new MakeUp.Email(this.el);
          break;
        case "state":
          new MakeUp.State(this.el);
      }
    }

    MakeUp.prototype.bindEvents = function() {
      var _this = this;
      this.el.onkeydown = function(e) {
        if (!(_this.alwaysAcceptableKeys().includes(e.which) || e.metaKey)) {
          e.preventDefault();
          _this.shouldApply = false;
          return _this.keydown(_this.keyMap[e.which]);
        }
      };
      this.el.onkeyup = function(e) {
        return _this.keyup(_this.keyMap[e.which]);
      };
      return this.el.onblur = function(e) {
        return _this.blur(e);
      };
    };

    MakeUp.prototype.modifyData = function(modifyType, resetText) {
      var _this = this;
      if (resetText == null) {
        resetText = "";
      }
      this.el.blur();
      switch (modifyType) {
        case "reset":
          this.el.value = resetText;
          break;
        case "clear":
          this.el.value = "";
      }
      return setTimeout((function() {
        return _this.el.focus();
      }), 300);
    };

    MakeUp.prototype.setPlaceholder = function(placeholder) {
      if (this.el.placeholder === "") {
        return this.el.placeholder = placeholder;
      }
    };

    MakeUp.prototype.acceptedCharsAtIndex = function(regex, index, key) {
      var currIndex;
      currIndex = index.toArray().includes(this.el.value.length);
      if (currIndex && regex.test(key)) {
        return this.shouldApply = true;
      } else {
        return this.shouldApply = false;
      }
    };

    MakeUp.prototype.acceptedChars = function(regex, key) {
      if (regex.test(key)) {
        return this.shouldApply = true;
      } else {
        return this.shouldApply = false;
      }
    };

    MakeUp.prototype.insertCharsAtIndex = function(str, index) {
      var i, _i, _len, _results;
      if (index instanceof Array) {
        _results = [];
        for (_i = 0, _len = index.length; _i < _len; _i++) {
          i = index[_i];
          if (this.el.value.length === i) {
            _results.push(this.el.value += str);
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      } else {
        if (this.el.value.length === index) {
          return this.el.value += str;
        }
      }
    };

    MakeUp.prototype.applyChar = function(key) {
      if (!(this.el.value.length >= this.limit)) {
        if (this.shouldApply === true) {
          return this.el.value += key;
        }
      }
    };

    MakeUp.prototype.alwaysAcceptableKeys = function() {
      return [91, 16, 9, 8, 46, 37, 38, 39, 40];
    };

    MakeUp.prototype.keydown = function() {};

    MakeUp.prototype.keyup = function() {};

    MakeUp.prototype.blur = function() {
      return this.validate();
    };

    return MakeUp;

  })();

  /*
   @{#}Object:        MakeUpLoader
   @{#}Version:       1.1.0
   @{#}Last Updated:  sept 12, 2013
   @{#}Purpose:       An object to instantiate a MakeUp object, and give the ability to reload the makeup objects
   @{#}Author:        Blaine Kasten
   @{#}Copyright:     MIT License (MIT) Copyright (c) 2013 Blaine Kasten
                      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY 
                      OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
                      LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS 
                      FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
                      EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
                      FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN 
                      AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
                      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
                      OR OTHER DEALINGS IN THE SOFTWARE.
  */


  window.MakeUpLoader = (function() {
    function MakeUpLoader() {
      this.makeUpReload();
    }

    MakeUpLoader.prototype.makeUpReload = function() {
      var arrayOfInputElements, element, inputType, _i, _len, _results;
      arrayOfInputElements = document.getElementsByTagName('input');
      _results = [];
      for (_i = 0, _len = arrayOfInputElements.length; _i < _len; _i++) {
        element = arrayOfInputElements[_i];
        inputType = element.getAttribute('data-format');
        _results.push(new window.MakeUp(inputType, element));
      }
      return _results;
    };

    return MakeUpLoader;

  })();

  document.addEventListener("DOMContentLoaded", function() {
    return new window.MakeUpLoader();
  });

  /*
   @{#}Object:        MakeUp.Date
   @{#}Version:       1.1.1
   @{#}Last Updated:  sept 12, 2013
   @{#}Purpose:       Provide date formatting to input fields
   @{#}Author:        Blaine Kasten
   @{#}Copyright:     MIT License (MIT) Copyright (c) 2013 Blaine Kasten
                      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY 
                      OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
                      LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS 
                      FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
                      EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
                      FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN 
                      AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
                      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
                      OR OTHER DEALINGS IN THE SOFTWARE.
  */


  MakeUp.Date = (function(_super) {
    __extends(Date, _super);

    function Date(el) {
      this.el = el;
      this.setPlaceholder('01/31/1971');
      this.format = 'date';
      this.limit = 10;
      this.bindEvents();
    }

    Date.prototype.keydown = function(key) {
      this.acceptedCharsAtIndex(/[0-9]/, '0-1,3-4,6-10', key);
      return this.applyChar(key);
    };

    Date.prototype.keyup = function(key) {
      this.easeUse(key);
      if (key !== 'delete') {
        return this.insertCharsAtIndex('/', [2, 5]);
      }
    };

    Date.prototype.validate = function() {
      var date, daysInMonths, februaryDays, month, text, year;
      text = this.el.value;
      month = Number(text.substring(0, 2));
      date = text.substring(3, 5);
      year = text.substring(6);
      if (year % 4 === 0) {
        februaryDays = 29;
      } else {
        februaryDays = 28;
      }
      daysInMonths = {
        1: 31,
        2: februaryDays,
        3: 31,
        4: 30,
        5: 31,
        6: 30,
        7: 31,
        8: 31,
        9: 30,
        10: 31,
        11: 30,
        12: 31
      };
      if (month > 12) {
        alert("There isn't a month higher than 12");
        this.modifyData("clear");
      }
      if (date > daysInMonths[month]) {
        alert("That is not a valid day for this month");
        return this.modifyData("clear");
      }
    };

    Date.prototype.easeUse = function(key) {
      var val;
      val = this.el.value;
      if (val.length === 1) {
        if (/[2-9]/.test(key)) {
          return this.el.value = "0" + val;
        } else if (key === '/') {
          return this.el.value = "0" + val + "/";
        }
      } else if (val.length === 2) {
        if (val === '13') {
          return this.el.value = "0" + val[0] + "/" + val[1];
        }
      }
    };

    return Date;

  })(MakeUp);

  /*
   @{#}Object:        MakeUp.Email
   @{#}Version:       1.1.1
   @{#}Last Updated:  sept 12, 2013
   @{#}Purpose:       Provide email formatting to input fields
   @{#}Author:        Blaine Kasten
   @{#}Copyright:     MIT License (MIT) Copyright (c) 2013 Blaine Kasten
                      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY 
                      OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
                      LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS 
                      FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
                      EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
                      FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN 
                      AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
                      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
                      OR OTHER DEALINGS IN THE SOFTWARE.
  */


  MakeUp.Email = (function(_super) {
    __extends(Email, _super);

    function Email(el) {
      this.el = el;
      this.format = "email";
      this.setPlaceholder("user@domain.com");
      this.bindEvents();
    }

    Email.prototype.keydown = function(key) {
      this.shouldApply = true;
      return this.applyChar(key);
    };

    Email.prototype.validate = function() {
      if (/.*\@.*\.(com|org|net)/.test(this.el.value) === false && this.el.value.length > 0) {
        alert('The format you entered is not a valid email format. Please try again');
        return this.el.value = '';
      }
    };

    Email.prototype.alwaysAcceptableKeys = function() {
      return [91, 16, 9, 8, 46, 37, 38, 39, 40, shiftKey];
    };

    return Email;

  })(MakeUp);

  /*
   @{#}Object:        MakeUp.Numbers
   @{#}Version:       1.1.1
   @{#}Last Updated:  sept 12, 2013
   @{#}Purpose:       Provide number formatting to input fields
   @{#}Author:        Blaine Kasten
   @{#}Copyright:     MIT License (MIT) Copyright (c) 2013 Blaine Kasten
                      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY 
                      OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
                      LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS 
                      FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
                      EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
                      FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN 
                      AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
                      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
                      OR OTHER DEALINGS IN THE SOFTWARE.
  */


  MakeUp.Numbers = (function(_super) {
    __extends(Numbers, _super);

    function Numbers(el, options) {
      this.el = el;
      if (options == null) {
        options = '';
      }
      this.format = "numbers";
      this.bindEvents();
    }

    Numbers.prototype.keydown = function(key) {
      this.shouldApply = false;
      this.acceptedChars(/[0-9]/, key);
      return this.applyChar(key);
    };

    Numbers.prototype.validate = function() {
      if (/^[0-9]+$/.test(this.el.value) === false && this.el.value.length > 0) {
        alert('This field will only accept numbers.');
        return this.el.value = '';
      }
    };

    return Numbers;

  })(MakeUp);

  /*
   @{#}Object:        MakeUp.Phone
   @{#}Version:       1.1.1
   @{#}Last Updated:  sept 12, 2013
   @{#}Purpose:       Provide phone formatting to input fields
   @{#}Author:        Blaine Kasten
   @{#}Copyright:     MIT License (MIT) Copyright (c) 2013 Blaine Kasten
                      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY 
                      OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
                      LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS 
                      FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
                      EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
                      FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN 
                      AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
                      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
                      OR OTHER DEALINGS IN THE SOFTWARE.
  */


  MakeUp.Phone = (function(_super) {
    __extends(Phone, _super);

    function Phone(el) {
      this.el = el;
      this.format = "phone";
      this.limit = 12;
      this.setPlaceholder('000-000-0000');
      this.bindEvents();
    }

    Phone.prototype.keydown = function(key) {
      this.acceptedCharsAtIndex(/[0-9]/, '0-2,4-6,8-12', key);
      return this.applyChar(key);
    };

    Phone.prototype.keyup = function(key) {
      if (key !== 'delete') {
        return this.insertCharsAtIndex('-', [3, 7]);
      }
    };

    Phone.prototype.validate = function() {
      if (/[0-9]{3}-[0-9]{3}-[0-9]{4}/.test(this.el.value) === false && this.el.value.length > 0) {
        alert("The phone number format you entered is not correct.");
        return this.el.value = '';
      }
    };

    return Phone;

  })(MakeUp);

  /*
   @{#}Object:        MakeUp.State
   @{#}Version:       1.1.1
   @{#}Last Updated:  sept 12, 2013
   @{#}Purpose:       Provide state formatting to input fields
   @{#}Author:        Blaine Kasten
   @{#}Copyright:     MIT License (MIT) Copyright (c) 2013 Blaine Kasten
                      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY 
                      OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
                      LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS 
                      FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
                      EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
                      FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN 
                      AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
                      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
                      OR OTHER DEALINGS IN THE SOFTWARE.
  */


  MakeUp.State = (function(_super) {
    __extends(State, _super);

    function State(el) {
      this.el = el;
      this.setPlaceholder('MN');
      this.format = 'state';
      this.limit = 2;
      this.bindEvents();
    }

    State.prototype.keydown = function(key) {
      var ey;
      ey = this.uppercaseChar(key);
      this.acceptedChars(/[A-Z]/, key);
      return this.applyChar(key);
    };

    State.prototype.validate = function() {
      if (/[A-Z]{2}/.test(this.el.value) === false && this.el.value.length > 0) {
        alert('The format for this field needs to be "MN"');
        return this.el.value = '';
      }
    };

    State.prototype.uppercaseChar = function(key) {
      if (/[a-zA-Z]/.test(key) && key !== void 0) {
        return key.toUpperCase();
      }
    };

    return State;

  })(MakeUp);

  Array.prototype.includes = function(val) {
    if (this.lastIndexOf(val) === -1) {
      return false;
    } else {
      return true;
    }
  };

  String.prototype.toArray = function() {
    var i, indices, j, max, min, split, _i, _j, _len, _ref;
    indices = [];
    _ref = this.split(/,/);
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      i = _ref[_i];
      split = i.split(/-/);
      min = Number(split[0]);
      max = Number(split[1]);
      for (j = _j = min; min <= max ? _j <= max : _j >= max; j = min <= max ? ++_j : --_j) {
        indices.push(j);
      }
    }
    return indices;
  };

}).call(this);
