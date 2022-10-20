import sys

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

from logic import Backend

# the application window
app = QGuiApplication(sys.argv)

# load ui from qml and connect the exit with the application exit
engine = QQmlApplicationEngine()
engine.quit.connect(app.quit)
engine.load('main.qml')

# logic part from Backend class
backend = Backend()
# associate backend object with the root object of engine which here is application window from qml
engine.rootObjects()[0].setProperty("backend", backend)

# update time from logic before the execution
backend.update_time()
sys.exit(app.exec())
