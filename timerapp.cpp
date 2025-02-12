#include "timerapp.h"
#include <QDBusConnection>
#include <QDBusInterface>
#include <QDBusMessage>
#include <QDir>
#include <QFile>
#include <QHBoxLayout>
#include <QMessageBox>
#include <QPushButton>
#include <QTextStream>
#include <QVBoxLayout>
#include <QDebug>
#include <QSystemTrayIcon>
#include <QMenu>
#include <QCloseEvent>
#include <QAction>
#include <QStyle>
#include <QApplication>
#include <QKeyEvent> // For handling key presses
#include <QFrame>    // For adding a border around the timer display

TimerApp::TimerApp(QWidget *parent) : QMainWindow(parent), isDarkMode(false) {
    qDebug() << "Initializing TimerApp...";

    // Set window flags to prevent the window from appearing in the taskbar
    setWindowFlags(Qt::Tool | Qt::WindowStaysOnTopHint);

    // Set up the central widget and layout
    QWidget *centralWidget = new QWidget(this);
    setCentralWidget(centralWidget);

    // Load theme preference from config file
    QSettings settings("Ghemx", "Timer");
    QString theme = settings.value("theme", "light").toString(); // Default to light theme
    isDarkMode = (theme == "dark");

    // Widgets
    QLabel *titleLabel = new QLabel("Timer Title:", centralWidget);
    titleLabel->setAlignment(Qt::AlignLeft); // Left-justify the label

    QLabel *helpHintLabel = new QLabel("Press F1 for help", centralWidget);
    helpHintLabel->setAlignment(Qt::AlignRight); // Right-justify the label

    // Layout for title and help hint
    QHBoxLayout *titleLayout = new QHBoxLayout();
    titleLayout->addWidget(titleLabel); // Left-justified
    titleLayout->addStretch(); // Add stretch to push the next widget to the right
    titleLayout->addWidget(helpHintLabel); // Right-justified

    titleEdit = new QLineEdit(centralWidget);
    titleEdit->setAlignment(Qt::AlignCenter); // Center the text in the text box

    QLabel *hoursLabel = new QLabel("H:", centralWidget);
    hoursEdit = new QLineEdit(centralWidget);
    hoursEdit->setPlaceholderText("00");
    hoursEdit->setMaxLength(2);
    hoursEdit->setFixedWidth(40);
    hoursEdit->setAlignment(Qt::AlignCenter);

    QLabel *minutesLabel = new QLabel("M:", centralWidget);
    minutesEdit = new QLineEdit(centralWidget);
    minutesEdit->setPlaceholderText("00");
    minutesEdit->setMaxLength(2);
    minutesEdit->setFixedWidth(40);
    minutesEdit->setAlignment(Qt::AlignCenter);

    QLabel *secondsLabel = new QLabel("S:", centralWidget);
    secondsEdit = new QLineEdit(centralWidget);
    secondsEdit->setPlaceholderText("00");
    secondsEdit->setMaxLength(2);
    secondsEdit->setFixedWidth(40);
    secondsEdit->setAlignment(Qt::AlignCenter);

    QPushButton *startButton = new QPushButton("Start Timer", centralWidget);
    QPushButton *saveButton = new QPushButton("Save Timer", centralWidget);
    QPushButton *loadButton = new QPushButton("Load Timer", centralWidget);
    QPushButton *stopButton = new QPushButton("Stop Timer", centralWidget);

    // Timer display with a border and padding
    QFrame *timerDisplayFrame = new QFrame(centralWidget);
    timerDisplayFrame->setFrameShape(QFrame::Box); // Add a border
    timerDisplayFrame->setLineWidth(2); // Border width
    timerDisplayFrame->setMidLineWidth(2); // Border width

    QVBoxLayout *timerDisplayLayout = new QVBoxLayout(timerDisplayFrame);
    timerDisplayLayout->setContentsMargins(10, 12, 10, 12); // Add 12px vertical padding

    timerDisplay = new QLabel("00h:00m:00s", timerDisplayFrame);
    timerDisplay->setAlignment(Qt::AlignCenter);
    timerDisplay->setStyleSheet("font-size: 24px; font-weight: bold;");

    timerDisplayLayout->addWidget(timerDisplay);

    // Layout for time inputs
    QHBoxLayout *timeLayout = new QHBoxLayout();
    timeLayout->addStretch();
    timeLayout->addWidget(hoursLabel);
    timeLayout->addWidget(hoursEdit);
    timeLayout->addWidget(minutesLabel);
    timeLayout->addWidget(minutesEdit);
    timeLayout->addWidget(secondsLabel);
    timeLayout->addWidget(secondsEdit);
    timeLayout->addStretch();

    // Layout for buttons
    QHBoxLayout *buttonLayout = new QHBoxLayout();
    buttonLayout->addWidget(startButton);
    buttonLayout->addWidget(saveButton);
    buttonLayout->addWidget(loadButton);
    buttonLayout->addWidget(stopButton);

    // Main layout
    QVBoxLayout *layout = new QVBoxLayout(centralWidget);
    layout->setSpacing(12); // Add 12px of vertical space between rows
    layout->addLayout(titleLayout); // Add the title and help hint layout
    layout->addWidget(titleEdit, 0, Qt::AlignCenter); // Center the text box
    layout->addLayout(timeLayout);
    layout->addWidget(timerDisplayFrame, 0, Qt::AlignCenter); // Add the framed timer display
    layout->addLayout(buttonLayout);

    // Connections
    connect(startButton, &QPushButton::clicked, this, &TimerApp::startTimer);
    connect(saveButton, &QPushButton::clicked, this, &TimerApp::saveTimer);
    connect(loadButton, &QPushButton::clicked, this, &TimerApp::loadTimer);
    connect(stopButton, &QPushButton::clicked, this, &TimerApp::stopTimer);

    // Timer setup
    timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &TimerApp::updateTimer);

    // System Tray Icon
    if (!QSystemTrayIcon::isSystemTrayAvailable()) {
        qDebug() << "System tray is not available.";
        QMessageBox::critical(this, "Error", "System tray is not available on this system.");
        return;
    }

    trayIcon = new QSystemTrayIcon(this);
    if (!trayIcon) {
        qDebug() << "Failed to create system tray icon.";
        return;
    }

    trayIconMenu = new QMenu(this);
    if (!trayIconMenu) {
        qDebug() << "Failed to create system tray menu.";
        return;
    }

    QAction *toggleThemeAction = new QAction("Toggle Theme", this);
    connect(toggleThemeAction, &QAction::triggered, this, &TimerApp::toggleTheme);

    QAction *stopTimerAction = new QAction("Stop Timer", this);
    connect(stopTimerAction, &QAction::triggered, this, &TimerApp::stopTimer);

    QAction *quitAction = new QAction("Quit", this);
    connect(quitAction, &QAction::triggered, qApp, &QApplication::quit);

    trayIconMenu->addAction(toggleThemeAction);
    trayIconMenu->addAction(stopTimerAction);
    trayIconMenu->addAction(quitAction);

    trayIcon->setContextMenu(trayIconMenu);
    connect(trayIcon, &QSystemTrayIcon::activated, this, &TimerApp::iconActivated);

    updateIcons();
    trayIcon->show();

    // Start minimized
    hide();

    qDebug() << "TimerApp initialized successfully.";
}

void TimerApp::closeEvent(QCloseEvent *event) {
    if (trayIcon && trayIcon->isVisible()) {
        hide();
        event->ignore();
    }
}

void TimerApp::changeEvent(QEvent *event) {
    if (event->type() == QEvent::WindowStateChange) {
        if (isMinimized()) {
            hide(); // Hide the window instead of minimizing it to the taskbar
        }
    }
    QMainWindow::changeEvent(event);
}

void TimerApp::iconActivated(QSystemTrayIcon::ActivationReason reason) {
    if (reason == QSystemTrayIcon::DoubleClick || reason == QSystemTrayIcon::Trigger) {
        if (isHidden()) {
            show();
        }
        activateWindow();
        raise();
        setWindowState((windowState() & ~Qt::WindowMinimized) | Qt::WindowActive);
    }
}

void TimerApp::updateTooltip() {
    if (timer && timer->isActive()) {
        QString tooltipText = timerDisplay->text();
        trayIcon->setToolTip("Ghemx: " + tooltipText);
    } else {
        trayIcon->setToolTip("Ghemx\nClick to set Timer"); // Updated tooltip text
    }
}

void TimerApp::keyPressEvent(QKeyEvent *event) {
    if (event->key() == Qt::Key_F1) {
        QMessageBox::information(this, "Help",
            "Ghemx Timer Help:\n\n"
            "1. Enter a title for your timer.\n"
            "2. Set the hours, minutes, and seconds.\n"
            "3. Click 'Start Timer' to begin.\n"
            "4. Use the system tray icon to stop or restart the timer.\n"
            "5. Save and load timers for future use.\n"
            "6. Toggle between light and dark themes from the system tray menu.\n"
            "7. The config file is located at: ~/.config/Ghemx/Timer.conf\n\n"
        );
    } else {
        QMainWindow::keyPressEvent(event);
    }
}

void TimerApp::startTimer() {
    int hours = hoursEdit->text().toInt();
    int minutes = minutesEdit->text().toInt();
    int seconds = secondsEdit->text().toInt();
    QString title = titleEdit->text();

    if (title.isEmpty()) {
        QMessageBox::warning(this, "Error", "Please enter a timer title.");
        return;
    }

    totalSeconds = hours * 3600 + minutes * 60 + seconds;
    if (totalSeconds <= 0) {
        QMessageBox::warning(this, "Error", "Please enter a valid time.");
        return;
    }

    timer->start(1000);
    updateTooltip(); // Update tooltip when the timer starts
}

void TimerApp::updateTimer() {
    if (totalSeconds > 0) {
        totalSeconds--;
        int hours = totalSeconds / 3600;
        int minutes = (totalSeconds % 3600) / 60;
        int seconds = totalSeconds % 60;

        QString timeStr = QString("%1h:%2m:%3s")
                              .arg(hours, 2, 10, QChar('0'))
                              .arg(minutes, 2, 10, QChar('0'))
                              .arg(seconds, 2, 10, QChar('0'));
        timerDisplay->setText(timeStr);
        updateTooltip(); // Update tooltip on every timer tick
    } else {
        timer->stop();
        notifyUser();
    }
}

void TimerApp::stopTimer() {
    if (timer) {
        timer->stop();
        timerDisplay->setText("00h:00m:00s");
        updateTooltip(); // Update tooltip when the timer stops
    }
}

void TimerApp::notifyUser() {
    QString title = titleEdit->text();
    QString timeStr = QString("[%1h:%2m:%3s]")
                          .arg(hoursEdit->text().toInt(), 2, 10, QChar('0'))
                          .arg(minutesEdit->text().toInt(), 2, 10, QChar('0'))
                          .arg(secondsEdit->text().toInt(), 2, 10, QChar('0'));

    QDBusInterface notificationInterface(
        "org.freedesktop.Notifications",
        "/org/freedesktop/Notifications",
        "org.freedesktop.Notifications",
        QDBusConnection::sessionBus()
    );

    if (notificationInterface.isValid()) {
        QList<QVariant> args;
        args << "Ghemx"                          // App name
             << (uint)0                          // Notification ID (0 = new)
             << ""                               // Icon
             << title                            // Summary
             << timeStr                          // Body
             << QStringList()                    // Actions
             << QVariantMap{ {"urgency", 2} }    // Hints (urgency level: 2 = critical)
             << (int)-1;                         // Timeout (-1 = requires manual dismissal)

        notificationInterface.callWithArgumentList(
            QDBus::AutoDetect, "Notify", args
        );
    } else {
        QMessageBox::warning(this, "Error", "DBus notification failed.");
    }
}

void TimerApp::saveTimer() {
    QString title = titleEdit->text().toLower();
    if (title.isEmpty()) {
        QMessageBox::warning(this, "Error", "Please enter a timer title.");
        return;
    }

    QSettings settings("Ghemx", "Timer");
    settings.beginGroup(title);
    settings.setValue("hours", hoursEdit->text());
    settings.setValue("minutes", minutesEdit->text());
    settings.setValue("seconds", secondsEdit->text());
    settings.endGroup();

    QMessageBox::information(this, "Timer Saved", "The timer has been saved.");
}

void TimerApp::loadTimer() {
    QString title = titleEdit->text().toLower();
    if (title.isEmpty()) {
        QMessageBox::warning(this, "Error", "Please enter a timer title.");
        return;
    }

    QSettings settings("Ghemx", "Timer");
    settings.beginGroup(title);
    hoursEdit->setText(settings.value("hours", "00").toString());
    minutesEdit->setText(settings.value("minutes", "00").toString());
    secondsEdit->setText(settings.value("seconds", "00").toString());
    settings.endGroup();

    QMessageBox::information(this, "Timer Loaded", "The timer has been loaded.");
}

void TimerApp::toggleTheme() {
    isDarkMode = !isDarkMode;
    updateIcons();

    // Save the theme preference to the config file
    QSettings settings("Ghemx", "Timer");
    settings.setValue("theme", isDarkMode ? "dark" : "light");
}

void TimerApp::updateIcons() {
    QString iconPath = isDarkMode ? ":/icons/ghemx_tray_dark.png" : ":/icons/ghemx_tray_light.png";
    if (trayIcon) {
        trayIcon->setIcon(QIcon(iconPath));
    }
    setWindowIcon(QIcon(iconPath));
}
