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
      9: "tab"
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
          this.formatForNumbers("decimals");
          break;
        case "numbers-with-decimals":
          this.formatForNumbers("decimals");
      }
    }

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
          return _this._allowDefaults(e);
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
          return _this._allowDefaults(e);
        } else {
          return false;
        }
      };
      return this.el.onblur = function(e) {
        return _this._validateDate();
      };
    };

    MakeUp.prototype.formatForNumbers = function(options) {
      var _this = this;
      if (options == null) {
        options = "";
      }
      if (options === "decimals") {
        this.format = "numbers";
      } else {
        this.format = "numbersWithDecimals";
      }
      this.el.onkeydown = function(e) {
        var key;
        key = _this.keyMap[e.which];
        if (Number(key) || key === "delete" || key === "left" || key === "right" || key === "tab") {
          return true;
        } else if (e.metaKey) {
          return _this._allowDefaults(e);
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
      return this.el.onblur = function(e) {
        return _this._validateDate();
      };
    };

    MakeUp.prototype._validateDate = function() {
      var date, daysInMonths, month, text, year;
      text = this.el.value;
      month = Number(text.substring(0, 2));
      date = text.substring(3, 5);
      year = text.substring(6);
      daysInMonths = {
        1: 31,
        2: 29,
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
        this._modifyData("clear");
      }
      if (date > daysInMonths[month]) {
        alert("That is not a valid day for this month");
        return this._modifyData("clear");
      }
    };

    MakeUp.prototype._validatePaste = function(previousText) {
      if (this.format === "numbers") {
        if (/[^0-9]/.test(this.el.value) === false) {
          this._modifyData("reset", previousText);
        }
      }
      if (this.format === "date" || this.format === "phone") {
        return this._modifyData("reset", previousText);
      }
    };

    MakeUp.prototype._modifyData = function(modifyType, resetText) {
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
      }), 2);
    };

    MakeUp.prototype._allowDefaults = function(e, format) {
      var previousText;
      if (this.keyMap[e.which] === "v") {
        previousText = this.el.value;
        return this._validatePaste(previousText);
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
