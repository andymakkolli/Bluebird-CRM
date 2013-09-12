// Generated by CoffeeScript 1.6.3
var Node, Tree, View, _treeUtils;

window.jstree["views"] = {
  exec: function(instance) {
    console.log("exec");
    return this.view = new View(instance);
  },
  done: function(instance) {
    var a, b, trees, _i, _len, _ref;
    trees = {};
    _ref = instance.treeNames;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      a = _ref[_i];
      b = _treeUtils.selectByTree(instance.autocomplete, a);
      trees[a] = new Tree(b, a, instance);
    }
    instance.trees = trees;
    return console.log("done");
  },
  view: {}
};

View = (function() {
  function View(instance) {
    this.instance = instance;
    this.writeContainers();
  }

  View.prototype.writeContainers = function() {
    this.formatPageElements();
    return this.addClassesToElement();
  };

  View.prototype.addClassesToElement = function() {
    this.cjInitHolderId.html("<div class='" + this.addClassHolderString + "'></div>");
    this.cjInitHolderId.prepend(this.menuHtml(this.menuName));
    this.cjInitHolderId.append(this.dataHolderHtml);
    this.cjInitHolderId.append(this.tokenHolderHtml(this.tokenHolder));
    return this.cjInitHolderId.removeClass(this.initHolderId).attr("id", this.addIdWrapperString);
  };

  View.prototype.formatPageElements = function() {
    var displayElements, i, pageElements, selector, _i, _len, _ref, _ref1;
    pageElements = this.instance.get('pageElements');
    displayElements = this.instance.get('displaySettings');
    _ref = ["", ""], this.tagHolderSelector = _ref[0], this.tagWrapperSelector = _ref[1];
    this.menuName = {
      menu: "",
      top: "",
      tabs: "",
      bottom: "",
      autocomplete: "",
      settings: ""
    };
    this.tokenHolder = {
      tokenHolder: "",
      options: "",
      body: "",
      resize: "",
      left: ""
    };
    this.addIdWrapperString = pageElements.wrapper;
    this.addBoxSizing = pageElements.size;
    this.addClassHolderString = pageElements.tagHolder;
    this.initHolderId = pageElements.init;
    this.cjInitHolderId = cj("." + this.initHolderId);
    this.addClassHolderString = this.ifisarrayjoin(this.addClassHolderString);
    _ref1 = pageElements.tagHolder;
    for (i = _i = 0, _len = _ref1.length; _i < _len; i = ++_i) {
      selector = _ref1[i];
      selector = selector.replace(" ", "-");
      this.menuName = this.concatOnObj(this.menuName, selector);
      this.tokenHolder = this.concatOnObj(this.tokenHolder, selector);
      this.tagHolderSelector = this.tagHolderSelector.concat("." + selector);
    }
    return this.tagWrapperSelector = this.tagWrapperSelector.concat("#" + pageElements.wrapper);
  };

  View.prototype.separateSizeElements = function(el) {
    var a, b, classNames, _i, _len;
    el.replace(/\./, "");
    el.replace(/#/, "");
    classNames = el.split(" ");
    for (b = _i = 0, _len = classNames.length; _i < _len; b = ++_i) {
      a = classNames[b];
      el += "." + b;
    }
    return el;
  };

  View.prototype.ifisarrayjoin = function(toJoin) {
    if (cj.isArray(toJoin)) {
      return toJoin = toJoin.join(" ");
    }
  };

  View.prototype.concatOnObj = function(obj, selector, classOrId) {
    var k, v;
    if (classOrId == null) {
      classOrId = ".";
    }
    for (k in obj) {
      v = obj[k];
      if (k.substr(0, 3) === "cj_") {
        break;
      }
      if (typeof obj["cj_" + k] === "undefined") {
        obj["cj_" + k] = "";
      }
      obj["cj_" + k] = obj["cj_" + k].concat("" + classOrId + selector + "-" + k);
      obj[k] = obj[k].concat("" + selector + "-" + k + " ");
    }
    return obj;
  };

  View.prototype.getCJQsaves = function() {
    this.cjTagWrapperSelector = cj(this.tagWrapperSelector);
    this.cjTagHolderSelector = cj(this.tagHolderSelector);
    this.cjInstanceSelector = cj(this.tagWrapperSelector.concat(" " + this.tagHolderSelector));
    return this.cjTabs = cj(this.menuName.cj_tabs);
  };

  View.prototype.menuHtml = function(name) {
    return "      <div class='" + name.menu + "'>       <div class='" + name.top + "'>        <div class='" + name.tabs + "'></div>        <div class='" + name.settings + "'></div>       </div>       <div class='" + name.bottom + "'>        <div class='" + name.autocomplete + "'>         <input type='text' id='JSTree-ac'>        </div>        <div class='" + name.settings + "'></div>       </div>      </div>    ";
  };

  View.prototype.tokenHolderHtml = function(name) {
    return "        <div class='" + name.tokenHolder + "'>         <div class='" + name.resize + "'></div>         <div class='" + name.body + "'>          <div class='" + name.left + "'></div>          <div class='" + name.options + "'></div>         </div>        </div>      ";
  };

  View.prototype.dataHolderHtml = function() {
    return "<div id='JSTree-data' style='display:none'></div>";
  };

  return View;

})();

Tree = (function() {
  Tree.prototype.domList = {};

  Tree.prototype.currentDepth = [];

  Tree.prototype.hierarchedList = {};

  Tree.prototype.nodeList = {};

  function Tree(tagList, tagId, instance) {
    var displaySettings;
    this.tagList = tagList;
    this.tagId = tagId;
    this.buildTree();
    displaySettings = instance.get("displaySettings");
    cj(".JSTree .top-" + displaySettings.defaultTree).addClass("active");
  }

  Tree.prototype.buildTree = function() {
    this.domList = cj();
    this.domList = this.domList.add("<div class='top-" + this.tagId + " tagContainer'></div>");
    return this.iterate(this.tagList);
  };

  Tree.prototype.iterate = function(ary) {
    var cjTagList, kNode, node, _i, _len;
    cjTagList = cj(this.domList);
    console.log(cjTagList);
    for (_i = 0, _len = ary.length; _i < _len; _i++) {
      node = ary[_i];
      this.nodeList[node.id] = kNode = new Node(node);
      if (node.parent === this.tagId) {
        cjTagList.append(kNode.html);
      } else {
        cjTagList.find("dl#tagDropdown_" + kNode.parent).append(kNode.html);
      }
    }
    return cjTagList.appendTo(".JSTree");
  };

  return Tree;

})();

_treeUtils = {
  selectByParent: function(list, parent) {
    var b, childList, _i, _len;
    childList = [];
    for (_i = 0, _len = list.length; _i < _len; _i++) {
      b = list[_i];
      if (b.parent === parent) {
        childList.push(b);
      }
    }
    return childList;
  },
  selectByTree: function(list, tree) {
    var b, treeList, _i, _len;
    treeList = [];
    for (_i = 0, _len = list.length; _i < _len; _i++) {
      b = list[_i];
      if (b.type === tree) {
        treeList.push(b);
      }
    }
    return treeList;
  }
};

Node = (function() {
  function Node(node) {
    this.data = node;
    this.parent = node.parent;
    this.hasDesc = "";
    this.description = node.description;
    this.descLength(node.description);
    this.id = node.id;
    this.children = node.children;
    this.name = node.name;
    this.html = this.html(node);
    return this;
  }

  Node.prototype.descLength = function(description) {
    this.description = description;
    if (this.description != null) {
      if (description.length > 0) {
        this.hasDesc = "description";
      }
      if (this.description.length > 0 && this.description.length <= 80) {
        this.hasDesc += " shortdescription";
      }
      if (this.description.length > 160) {
        this.hasDesc = "longdescription";
      }
      if (this.description.length > 80) {
        return this.description = _utils.textWrap(this.description, 80);
      }
    }
  };

  Node.prototype.html = function(node) {
    var html, treeButton;
    if (this.parent > 0) {
      treeButton = "treeButton";
    } else {
      treeButton = "";
    }
    if (parseFloat(node.is_reserved) !== 0) {
      this.reserved = true;
    } else {
      this.reserved = false;
    }
    html = "<dt class='lv-" + node.level + "' id='tagLabel_" + node.id + "' data-tagid='" + node.id + "' data-name='" + node.name + "' data-parentid='" + node.parent + "'>";
    html += "              <div class='tag'>                <div class='ddControl " + treeButton + "'></div>                <span class='name'>" + node.name + "</span>            ";
    if (this.hasDesc.length > 0) {
      html += "                <div class='description'>" + this.description + "</div>            ";
    }
    html += "              </div>              <div class='transparancyBox type-" + node.type + "'></div>            ";
    html += "</dt>";
    html += "              <dl class='lv-" + node.level + "' id='tagDropdown_" + node.id + "' data-name='" + node.name + "'></dl>            ";
    return html;
  };

  return Node;

})();
