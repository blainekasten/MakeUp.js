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
  var _ref, _ref1, _ref2, _ref3,
    __hasProp = {}.hasOwnProperty,
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

    MakeUp.prototype.placeholder = '';

    function MakeUp(el) {
      this.el = el;
      this.setPlaceholder();
      this.bindEvents();
    }

    MakeUp.prototype.bindEvents = function() {
      var _this = this;
      this.el.onkeydown = function(e) {
        _this.key = _this.keyMap[e.which];
        if (!(_this.alwaysAcceptableKeys().includes(e.which) || e.metaKey)) {
          e.preventDefault();
          _this.shouldApply = false;
          return _this.keydown();
        }
      };
      this.el.onkeyup = function(e) {
        return _this.keyup();
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
      console.log('This will deprecated in a future version. Do not call this method.');
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

    MakeUp.prototype.setPlaceholder = function() {
      if (this.el.placeholder === "") {
        return this.el.placeholder = this.placeholder;
      }
    };

    MakeUp.prototype.acceptedCharsAtIndex = function(regex, index) {
      var currIndex;
      currIndex = index.toArray().includes(this.el.value.length);
      if (currIndex && regex.test(this.key)) {
        return this.shouldApply = true;
      } else {
        return this.shouldApply = false;
      }
    };

    MakeUp.prototype.acceptedChars = function(regex) {
      if (regex.test(this.key)) {
        return this.shouldApply = true;
      } else {
        return this.shouldApply = false;
      }
    };

    MakeUp.prototype.insertCharsAtIndex = function(str, index) {
      var i, _i, _len, _results;
      if (this.key !== 'delete') {
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
      }
    };

    MakeUp.prototype.applyChar = function() {
      if (!(this.el.value.length >= this.limit)) {
        if (this.shouldApply === true) {
          return this.el.value += this.key;
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
        switch (inputType) {
          case "phone":
            _results.push(new MakeUp.Phone(element));
            break;
          case "date":
            _results.push(new MakeUp.Date(element));
            break;
          case "numbers":
            _results.push(new MakeUp.Numbers(element));
            break;
          case "email":
            _results.push(new MakeUp.Email(element));
            break;
          case "state":
            _results.push(new MakeUp.State(element));
            break;
          default:
            _results.push(void 0);
        }
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
   @{#}Author:        Blaine Kasten (http://www.github.com/blainekasten)
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

    function Date() {
      _ref = Date.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Date.prototype.format = 'date';

    Date.prototype.limit = 10;

    Date.prototype.placeholder = '01/31/1971';

    Date.prototype.keydown = function() {
      this.acceptedCharsAtIndex(/[0-9]/, '0-1,3-4,6-10');
      return this.applyChar();
    };

    Date.prototype.keyup = function() {
      this.easeUse();
      return this.insertCharsAtIndex('/', [2, 5]);
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
        return this.el.value = '';
      } else if (date > daysInMonths[month]) {
        alert("That is not a valid day for this month");
        return this.el.value = '';
      } else if (/[0-9]{2}\/[0-9]{2}\/[0-9]{4}/.test(this.el.value) === false && this.el.value.length > 0) {
        alert("The date format is not correct. It must be mm/dd/yyyy.");
        return this.el.value = '';
      }
    };

    Date.prototype.easeUse = function() {
      var val;
      val = this.el.value;
      if (val.length === 1) {
        if (/[2-9]/.test(this.key)) {
          this.el.value = "0" + val;
        } else if (this.key === '/') {
          this.el.value = "0" + val + "/";
        }
      } else if (val.length === 2) {
        if (val === '13') {
          this.el.value = "0" + val[0] + "/" + val[1];
        }
      }
      if (val.length === 8) {
        return this.fixYear();
      }
    };

    Date.prototype.fixYear = function() {
      var append, currYear, splitVal, year;
      splitVal = this.el.value.split('/');
      year = splitVal[2];
      if (!(year === '19' || year === '20')) {
        currYear = Number(String(new window.Date().getFullYear()).substring(2));
        if (year > currYear) {
          append = 19;
        } else {
          append = 20;
        }
        return this.el.value = "" + splitVal[0] + "/" + splitVal[1] + "/" + append + year;
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

    function Email() {
      _ref1 = Email.__super__.constructor.apply(this, arguments);
      return _ref1;
    }

    Email.prototype.format = 'email';

    Email.prototype.placeholder = 'user@domain.com';

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

    Numbers.prototype.format = 'numbers';

    function Numbers(el) {
      this.el = el;
      this.bindEvents();
    }

    Numbers.prototype.keydown = function() {
      this.shouldApply = false;
      this.acceptedChars(/[0-9]/);
      return this.applyChar();
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

    function Phone() {
      _ref2 = Phone.__super__.constructor.apply(this, arguments);
      return _ref2;
    }

    Phone.prototype.format = "phone";

    Phone.prototype.placeholder = '000-000-0000';

    Phone.prototype.limit = 12;

    Phone.prototype.keydown = function() {
      this.acceptedCharsAtIndex(/[0-9]/, '0-2,4-6,8-12');
      return this.applyChar();
    };

    Phone.prototype.keyup = function() {
      return this.insertCharsAtIndex('-', [3, 7]);
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

    function State() {
      _ref3 = State.__super__.constructor.apply(this, arguments);
      return _ref3;
    }

    State.prototype.placeholder = 'MN';

    State.prototype.format = 'state';

    State.prototype.limit = 2;

    State.prototype.keydown = function() {
      this.key = this.uppercaseChar(this.key);
      this.acceptedChars(/[A-Z]/);
      return this.applyChar();
    };

    State.prototype.validate = function() {
      if (/[A-Z]{2}/.test(this.el.value) === false && this.el.value.length > 0) {
        alert('The format for this field needs to be "MN"');
        return this.el.value = '';
      }
    };

    State.prototype.uppercaseChar = function() {
      if (/[a-zA-Z]/.test(this.key) && this.key !== void 0) {
        return this.key.toUpperCase();
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
    var i, indices, j, max, min, split, _i, _j, _len, _ref4;
    indices = [];
    _ref4 = this.split(/,/);
    for (_i = 0, _len = _ref4.length; _i < _len; _i++) {
      i = _ref4[_i];
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
