#!/bin/python3
import turtle

# needs python3-tools

turtle.shape("circle")
turtle.speed(1)
turtle.color('#ff0000')
turtle.penup()
turtle.goto(-60,145)
turtle.pendown()
turtle.write('like it daddy')#, None, None, "20pt normal")
turtle.penup()
turtle.goto(-90,120)
turtle.pendown()
turtle.write('I learned python like a boss' "15pt normal")
turtle.penup()
turtle.goto(-30,100)
turtle.pendown()
turtle.write('HAHA!!!')#, None, None, "14pt normal")
turtle.penup()
turtle.goto(-30,50)
turtle.pendown()

turtle.write('Testing Testing Testing', move=False, align='left', font=('Arial', 8, 'normal'))
turtle.penup()
turtle.goto(-0,00)
turtle.pendown()
turtle.goto(0,0)
