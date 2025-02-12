#ifndef TIMERAPP_H
#define TIMERAPP_H

#include <QMainWindow>
#include <QLineEdit>
#include <QLabel>
#include <QTimer>
#include <QSettings>
#include <QSystemTrayIcon>
#include <QMenu>

class TimerApp : public QMainWindow {
    Q_OBJECT

public:
    TimerApp(QWidget *parent = nullptr);
    void closeEvent(QCloseEvent *event) override;

protected:
    void changeEvent(QEvent *event) override; // Handle window state changes
    void keyPressEvent(QKeyEvent *event) override; // Handle key presses

private slots:
    void startTimer();
    void updateTimer();
    void stopTimer();
    void notifyUser();
    void saveTimer();
    void loadTimer();
    void toggleTheme();
    void iconActivated(QSystemTrayIcon::ActivationReason reason);

private:
    QLineEdit *titleEdit;
    QLineEdit *hoursEdit;
    QLineEdit *minutesEdit;
    QLineEdit *secondsEdit;
    QLabel *timerDisplay;
    QTimer *timer;
    int totalSeconds;
    QSystemTrayIcon *trayIcon;
    QMenu *trayIconMenu;
    bool isDarkMode;
    void updateIcons();
    void updateTooltip(); // Declare updateTooltip here
};

#endif // TIMERAPP_H
