# Snake :snake:

This is a game made in [Lua](https://www.lua.org/) using the [Love](https://love2d.org/) game engine.  
It is a copy of the classic game **Snake** and the objective is the same: get the food, don't crash into yourself or the walls and reach the highest score that you can!

***
## How to install

### **Prerequisites**
To run the game on **Windows**, you will need the Love binary (which can be downloaded from the [Love home page](https://love2d.org/)) in the area of an environment variable so that it can be accessed from a command prompt.

If you are on **Linux**, you can install Love from your distribution's repository:
***
 On Ubuntu's standard repository:
 ```bash
 $ sudo apt install love
 ```
 Love also has an Ubuntu PPA, which they list on their [website](https://love2d.org/) in the download section.

 On Fedora:
 ```bash
 $ sudo dnf install love
 ```
 On Arch Linux:
 ```bash
 $ sudo pacman -S love
 ```

> Note: If you want to use the Linux AppImage on [Love's website](https://love2d.org/), this is possible but there is not a script for it in the `run` folder of the project so you will have to run it yourself.

***

### **The Game**
**Open a terminal/command prompt/powershell.** To install the game, just clone the repository on whichever operating system you are using:  
```bash
$ git clone https://github.com/vegan-cheese/snake.git
```
Then, `cd` into the directory:
```bash
$ cd snake
```

#### **On Windows:**
```powershell
> ./run.bat
```

#### **On Linux:**
```bash
$ ./run.sh
```

***
