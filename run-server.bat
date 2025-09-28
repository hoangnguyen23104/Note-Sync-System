@echo off
echo ============================
echo  Starting Note Sync Server
echo ============================

:: Set JAVA_HOME nếu cần (sửa đường dẫn cho đúng JDK bạn đã cài)
set "JAVA_HOME=C:\Program Files\Java\jdk-17"
set "PATH=%JAVA_HOME%\bin;%PATH%"

:: Kiểm tra Java
java -version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Java not found! Please install Java JDK.
    pause
    exit /b 1
)

:: Kiểm tra thư mục build
if not exist build (
    echo [ERROR] Build directory not found!
    pause
    exit /b 1
)

:: Copy file config
copy config.properties build\ >nul 2>&1

:: Chạy server
cd build
for %%f in (h2*.jar) do set H2_JAR=%%f

echo Running: java -cp ".;%H2_JAR%" server.NoteSyncServer
echo --------------------------------
java -cp ".;%H2_JAR%" server.NoteSyncServer || (
    echo [ERROR] Failed to start Note Sync Server.
    pause
    exit /b 1
)

echo --------------------------------
echo [INFO] Note Sync Server stopped.
pause
