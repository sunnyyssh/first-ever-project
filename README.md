<div align="center">
    <a href="https://git.io/typing-svg"><img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&weight=700&size=30&duration=1000&pause=2000&color=773AF7&background=7D63C811&center=true&vCenter=true&width=435&lines=my+first+ever+project;2-player+fighting+game" alt="Typing SVG" /></a>
</div>

### So, what?
![](docs/screen-record.gif)

### I wanna share you
I was **15 y.o.** and I was inspired by the idea of creating **my own game**. 
<br/> The only things I knew were **Pascal ABC** and pure **math**.
<br/> Pascal was my first language because of informatics lessons in school.

So, I found out how to create simple algorithms, how to draw an image on the screen and I thought **that was enough** to create a whole game.

Every frame is drawn by its own image which are made in pure Paint. Every move is **just calculation of coordinates**. This all is running in one thread and delta time is counted for every redraw iteration to find out how much coordinates should be changed.

All collisions are **hard-coded**. (Actually the word 'hard' also means how I was suffering holding all the coordinates in my brain). <br/>
Every button is also just picture and a check of coordinate of mouse press. <br/>
For my proud, window resize doesn't crash the drawing, all coordinates are recalculated.

**more fun:** Open [`Игра.pas`](Игра.pas) file and find out how it works, especially **how the state is stored** (tremendous amount of globals), how the **game logic** is implemented (many times nested if else) and so on.

### What is it for me?
These 1921 lines of code were first steps in my nowaday developer's journey. <br/> I made a lot of mistakes, which I learned from. <br/> And the important thing I've realized is that the only things that matter are **studying** and **desire to create**. 

### How to run?
Find a valid [Pascal ABC](https://pascalabc.net/ssyilki-dlya-skachivaniya) compiler and run `Игра.pas` file idk
