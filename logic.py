from PyQt5.QtCore import QTimer, QObject, pyqtSignal

from time import strftime, localtime


class Backend(QObject):

    # signal to pass a string`
    updated = pyqtSignal(str, arguments=["time"])
    hms = pyqtSignal(int, int, int, arguments=["hours", "minutes", "seconds"])

    # initializes the object created on main.py
    def __init__(self):
        super().__init__()

        # updating
        self.timer = QTimer()
        self.timer.setInterval(100)
        self.timer.timeout.connect(self.update_time)
        self.timer.start()

    def update_time(self):
        time = localtime()
        curr_time = strftime("%I:%M:%S %p", time)
        # calling signal to return curr_time through it
        self.updated.emit(curr_time)
        self.hms.emit(time.tm_hour, time.tm_min, time.tm_sec)

    # def mousePressEvent(self, event):
    #     self.dragPos = event.globalPosition().toPoint()

    # def mouseMoveEvent(self, event):
    #     self.move(self.pos() + event.globalPosition().toPoint() - self.dragPos)
    #     self.dragPos = event.globalPosition().toPoint()
    #     event.accept()
