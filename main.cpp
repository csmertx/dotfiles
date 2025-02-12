#include <QApplication>
#include "timerapp.h"

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);
    app.setApplicationName("Ghemx");
    app.setApplicationDisplayName("Ghemx Timer");
    TimerApp timerApp;
    timerApp.show();
    return app.exec();
}
