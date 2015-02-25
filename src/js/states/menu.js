var Menu = function () {
  this.text = null;
};

module.exports = Menu;

Menu.prototype = {

  create: function () {
    var x = this.game.width / 2;
    var y = this.game.height / 2;

    var style = { font: "40px Arial", fill: "#ff0000", align: "center" };

    this.text = this.add.text(0, y - 200, "Enter World of Darkness", style);

    this.input.onDown.add(this.onDown, this);
  },

  update: function () {
  },

  onDown: function () {
    this.game.state.start(playerState.currentLevel);
  }
};
