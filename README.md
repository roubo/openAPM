openAPM
=======

Test code for open souce UVA project APM ,By San412
---------------------------------------------------
测试APM源码
长春理工大学 光电工程学院 创新实验室 412

original APM introduce
======================

Building using arduino
--------------------------
To install the libraries:
 - copy Library Directories to your \arduino\hardware\libraries\ or arduino\libraries directory
 - Restart arduino IDE

 * Each library comes with a simple example. You can find the examples in menu File->Examples

Building using make 
-----------------------------------------------
 - go to directory of sketch and type "make".
 --type "make upload" to upload according to the parameters in config.mk .

Building using cmake
-----------------------------------------------
 - cd ArduPlane (ArduCopter etc ..)
 - mkdir build
 - cd build
 - cmake .. -DAPM_BOARD=mega -DAPM_PORT=/dev/ttyUSB0
    You can select from mega/mega2560.
    If you have arduino installed in a non-standard location you by specify it by using:
        -DARDUINO_SDK_PATH=/path/to/arduino ..
 - make (will build the sketch)
 - make ArduPlane-upload (will upload the sketch ArduPlane etc.)

    If you have a sync error during upload reset the board or power cycle the board
    before the upload starts.

 
Building using eclipse
-----------------------------------------------

    Getting the Source:

        assuming source located here: /home/name/apm-src
        You can either download it or grab it from git:
        git clone https://code.google.com/p/ardupilot-mega/ /home/name/apm-src

    Generating the Eclipse Project for Your System:
    
        mkdir /home/name/apm-build 
        cd /home/name/apm-build
        cmake -G"Eclipse CDT4 - Unix Makefiles" -D CMAKE_BUILD_TYPE=Debug ../apm-src -D BOARD=mega -D PORT=/dev/ttyUSB0

        Here apm-src can be any sketch, ArduPlane/ ArduCopter etc.

        Note: Unix can be substituted for MinGW/ MSYS/ NMake (for windows)
            (see http://www.vtk.org/Wiki/Eclipse_CDT4_Generator)

        input options:

            CMAKE_BUILD_TYPE choose from DEBUG, RELEASE etc.
            PORT is the port for uploading to the board, COM0 etc on windows. /dev/ttyUSB0 etc. on linux
            BOARD is your board type, mega for the 1280 or mega2560 for the 2560 boards.
            ARDUINO_SDK_PATH if it is not in default path can specify as /path/to/arduino
        
    Importing the Eclipse Build Project:

        Import project using Menu File->Import
        Select General->Existing projects into workspace:
        Browse where your build tree is and select the root build tree directory. 
        Keep "Copy projects into workspace" unchecked.
        You get a fully functional eclipse project

    Importing the Eclipse Source Project:
    
        You can also import the source repository (/home/name/apm-src) if you want to modify the source/ commit using git.

    Settings up Eclipse to Recognize PDE files:

         Window > Preferences > General > Content Types. This tree associates a
            filename or filename pattern with its content type so that tools can treat it
            properly. Source and header files for most languages are under the Text tree. 
            Add "*.pde" as a C++ Source.

  Autocompletion:
	
		Right click on source project -> Properties -> Project References -> apm-build Project
    
    Advanced:
    
        * Regenerating the eclipse source project file:
            cmake -G"Eclipse CDT4 - Unix Makefiles" -DECLIPSE_CDT4_GENERATE_SOURCE_PROJECT=TRUE /home/name/apm-src

Build a package using cpack
-----------------------------------------------
 - cd build
 - cmake ..
 - make package
 - make package_source


vim:ts=4:sw=4:expandtab

分析第一步
----------
分析源码结构，从主文件的头文件引用入手。
1、分析引用路径，摸清源码文件分布结构。
2、分析模块库使用情况，摸清系统使用的硬件和算法等相关模块的总类。
3、明确今后重点分析的模块文件。

分析第二步
-----------
分析类的组织结构，这个可以看看类的namespace
namespace AP_HAL {

    /* Toplevel pure virtual class Hal.*/
    class HAL;

    /* Toplevel class names for drivers: */
    class UARTDriver;
    class I2CDriver;

    class SPIDeviceDriver;
    class SPIDeviceManager;

    class AnalogSource;
    class AnalogIn;
    class Storage;
    class ConsoleDriver;
    class DigitalSource;
    class GPIO;
    class RCInput;
    class RCOutput;
    class Scheduler;
    class Semaphore;
    
    class Util;

    /* Utility Classes */
    class Print;
    class Stream;
    class BetterStream;

    /* Typdefs for function pointers (Procedure, Timed Procedure) */
    typedef void(*Proc)(void);
    typedef void(*TimedProc)(uint32_t);

    /**
     * Global names for all of the existing SPI devices on all platforms.
     */

    enum SPIDevice {
        SPIDevice_Dataflash,
        SPIDevice_ADS7844,
        SPIDevice_MS5611,
        SPIDevice_MPU6000,
        SPIDevice_ADNS3080_SPI0,
        SPIDevice_ADNS3080_SPI3
    };
}
分析第三步
----------
系统和模块的初始化流程分析
