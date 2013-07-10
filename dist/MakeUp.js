(function() {
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
          this.formatForPhone();
          break;
        case "date":
          this.formatForDate();
          break;
        case "numbers":
          this.formatForNumbers();
          break;
        case "numbers-with-decimals":
          this.formatForNumbers("decimals");
          break;
        case "email":
          this.formatForEmail();
      }
    }

    MakeUp.prototype.formatForEmail = function() {
      var _this = this;
      this.format = "email";
      if (this.el.placeholder === "") {
        this.el.placeholder = "user@domain.com";
      }
      this.el.onkeydown = function(e) {
        var atIndex, end, endIndex, key;
        key = _this.keyMap[e.which];
        if (_this.el.value.length === 0) {
          _this.el.value = "@";
          _this.el.setSelectionRange(0, -1);
        }
        if (_this.shouldPlacePeriod === true) {
          endIndex = _this.el.value.length;
          _this.el.value += ".";
          _this.el.setSelectionRange(endIndex, endIndex);
          _this.shouldPlacePeriod = false;
        }
        if (e.shiftKey) {
          if (key === 2) {
            atIndex = _this.el.value.indexOf("@");
            if (_this.el.selectionStart === atIndex) {
              _this.el.setSelectionRange(atIndex + 1, atIndex + 1);
              if (/\@.*\./.test(_this.el.value) !== true) {
                _this.shouldPlacePeriod = true;
              }
            }
            return false;
          }
        }
        if (key === ".") {
          if (/.*\@.*\./.test(_this.el.value) === true) {
            end = _this.el.value.length;
            _this.el.setSelectionRange(end, end);
            return false;
          }
        }
        if (key === "delete") {
          return _this.currVal = _this.el.value;
        }
      };
      return this.el.onkeyup = function(e) {
        var index, key;
        key = _this.keyMap[e.which];
        if (key === "delete") {
          if (/\@/.test(_this.el.value) === false) {
            if (_this.el.value !== "") {
              _this.modifyData("reset", _this.currVal);
              index = _this.el.value.indexOf("@");
              return _this.el.setSelectionRange(index, index);
            }
          }
        }
      };
    };

    MakeUp.prototype.formatForPhone = function() {
      var _this = this;
      this.format = "phone";
      if (this.el.placeholder === "") {
        this.el.placeholder = "000-000-0000";
      }
      return this.el.onkeydown = function(e) {
        var key;
        key = _this.keyMap[e.which];
        if (Number(key) || key === 0 || key === "delete" || key === "left" || key === "right" || key === "tab") {
          if ((_this.el.value.length === 3 || _this.el.value.length === 7) && key !== "delete") {
            _this.el.value = "" + _this.el.value + "-";
            return true;
          } else if (_this.el.value.length === 12 && key !== "delete" && key !== "tab") {
            return false;
          } else {
            return true;
          }
        } else if (e.metaKey) {
          return _this.allowDefaults(e);
        } else {
          return false;
        }
      };
    };

    MakeUp.prototype.formatForDate = function() {
      var _this = this;
      this.format = "date";
      if (this.el.placeholder === "") {
        this.el.placeholder = "01/01/1971";
      }
      this.el.onkeydown = function(e) {
        var key;
        key = _this.keyMap[e.which];
        if (Number(key) || key === 0 || key === "delete" || key === "left" || key === "right" || key === "tab") {
          if ((_this.el.value.length === 2 || _this.el.value.length === 5) && key !== "delete") {
            _this.el.value = "" + _this.el.value + "/";
            return true;
          } else if (_this.el.value.length === 10 && key !== "delete" && key !== "tab") {
            return false;
          } else {
            return true;
          }
        } else if (e.metaKey) {
          return _this.allowDefaults(e);
        } else {
          return false;
        }
      };
      return this.el.onblur = function(e) {
        return _this.validateDate();
      };
    };

    MakeUp.prototype.formatForNumbers = function(options) {
      var _this = this;
      if (options == null) {
        options = "";
      }
      if (options === "decimals") {
        this.format = "numbersWithDecimals";
      } else {
        this.format = "numbers";
      }
      return this.el.onkeydown = function(e) {
        var key;
        key = _this.keyMap[e.which];
        if (Number(key) || key === "delete" || key === "left" || key === "right" || key === "tab") {
          return true;
        } else if (e.metaKey) {
          return _this.allowDefaults(e);
        } else if (options === "decimals") {
          if (key === ".") {
            if (/\./.test(_this.el.value) === false) {
              return true;
            } else {
              return false;
            }
          } else {
            return false;
          }
        } else {
          return false;
        }
      };
    };

    MakeUp.prototype.validateDate = function() {
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

    MakeUp.prototype.validatePaste = function(previousText) {
      if (this.format === "numbers") {
        if (/[^0-9]/.test(this.el.value) === true) {
          this.modifyData("reset", previousText);
        }
      }
      if (this.format === "date" || this.format === "phone") {
        return this.modifyData("reset", previousText);
      }
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

    MakeUp.prototype.allowDefaults = function(e, format) {
      var previousText;
      if (this.keyMap[e.which] === "v") {
        previousText = this.el.value;
        return this.validatePaste(previousText);
      }
    };

    return MakeUp;

  })();

  document.addEventListener("DOMContentLoaded", function() {
    var arrayOfInputElements, element, inputType, _i, _len, _results;
    arrayOfInputElements = document.getElementsByTagName('input');
    _results = [];
    for (_i = 0, _len = arrayOfInputElements.length; _i < _len; _i++) {
      element = arrayOfInputElements[_i];
      inputType = element.getAttribute('data-format');
      _results.push(new window.MakeUp(inputType, element));
    }
    return _results;
  });

}).call(this);
