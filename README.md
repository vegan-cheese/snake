# Snake :snake:

This is a game made in [Lua](https://www.lua.org/) using the [Love](https://love2d.org/) game engine.  
It is a copy of the classic game **Snake** and the objective is the same: get the food, don't crash into yourself or the walls and reach the highest score that you can!

***
## How to install

### **Prerequisites**
To run the game on **Windows** or **MacOS**, you will need the Love binary (which can be downloaded from the [Love home page](https://love2d.org/)) in the area of an environment variable so that it can be accessed from a command prompt or terminal.

On **Linux**, you will need the Love AppImage binary ([download here](https://love2d.org/)) in the `~/Applications` folder.

> If you are on **Linux** and you want to install Love from your distribution's repository, the following are available:  
>***
> On Ubuntu's standard repository:
> ```bash
> $ sudo apt install love
> ```
> Love also has an Ubuntu PPA, which they list on their [website](https://love2d.org/) in the download section.
>
> On Fedora:
> ```bash
> $ sudo dnf install love
> ```
> On Arch Linux:
> ```bash
> $ sudo pacman -S love
> ```
> However, I still recommend the AppImage because it is what the game was tested with, and is the official download from the [Love website](https://love2d.org/).
***
### **The Game**
**Open a terminal/command prompt/powershell.** To install the game, just clone the repository on whichever operating system you are using:  
```bash
$ git clone https://github.com/programming-in-fm/love-snake.git
```
Then, `cd` into the directory:
```bash
$ cd love-snake
```

#### **On Windows:**
```powershell
> love .
```

#### **On MacOS:**
```bash
$ love .
```

#### **On Linux (AppImage):**
```bash
$ cd run
$ ./run-linux.sh
```

#### **On Linux (package):**
```bash
$ love .
```

***