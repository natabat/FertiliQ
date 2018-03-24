using Toybox.WatchUi as Ui;

class FertiliQDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new FertiliQMenuDelegate(), Ui.SLIDE_UP);
        return true;
    }
}