program paint;
uses crt;
var
  a:array[1..80,1..25]of byte;
  b:char;
  x,y,color:byte;
begin
  assign(input,'picture.out');
  reset(input);
  fillchar(a,sizeof(a),7);
  for y:=1 to 25 do
  begin
    for x:=1 to 80 do read(a[x,y]);
    readln;
  end;
  close(input);
  assign(input,'CON');
  reset(input);
  textbackground(White);
  textcolor(Black);
  clrscr;
  for y:=1 to 24 do
  begin
    gotoxy(1,y);
    for x:=1 to 80 do begin textbackground(a[x,y]);write(' ');end;
  end;
  x:=1;y:=1;color:=7;gotoxy(1,1);
  repeat
    while not keypressed do;
    b:=readkey;
    case ord(b)of
    ord('b'):begin
      gotoxy(65,25);
      textbackground(White);
      color:=0;
      write('Black    ');
      textbackground(Black);
      gotoxy(x,y);
    end;
    ord('g'):begin
      gotoxy(65,25);
      textbackground(White);
      color:=2;
      write('Green  ');
      textbackground(Green);
      gotoxy(x,y);
    end;
    ord('l'):begin
      gotoxy(65,25);
      textbackground(White);
      color:=3;
      write('Blue ');
      textbackground(Blue);
      gotoxy(x,y);
    end;
    ord('r'):begin
      gotoxy(65,25);
      textbackground(White);
      color:=4;
      write('Red    ');
      textbackground(Red);
      gotoxy(x,y);
    end;
    ord('p'):begin
      gotoxy(65,25);
      textbackground(White);
      color:=5;
      write('Pink');
      textbackground(color);
      gotoxy(x,y);
    end;
    ord('y'):begin
      gotoxy(65,25);
      textbackground(White);
      color:=6;
      write('Yellow');
      textbackground(Yellow);
      gotoxy(x,y);
    end;
    ord('w'):begin
      gotoxy(65,25);
      textbackground(White);
      color:=7;
      write('White  ');
      gotoxy(x,y);
    end;
    0:begin
      b:=readkey;
      case ord(b)of
        72:if y>1 then begin
          dec(y);
          gotoxy(75,25);
          textbackground(white);
          write(x:2,',',y:2);
          textbackground(color);
          gotoxy(x,y);
        end;
        80:begin
          inc(y);
          gotoxy(75,25);
          textbackground(white);
          write(x:2,',',y:2);
          textbackground(color);
          gotoxy(x,y);
        end;
        75:if x>1 then begin
          dec(x);
          gotoxy(75,25);
          textbackground(white);
          write(x:2,',',y:2);
          textbackground(color);
          gotoxy(x,y);
        end;
        77:begin
          inc(x);
          gotoxy(75,25);
          textbackground(white);
          write(x:2,',',y:2);
          textbackground(color);
          gotoxy(x,y);
        end;
        end;
      end;
    ord(' '):begin
      write(' ');
      a[x,y]:=color;
      inc(x);
      gotoxy(75,25);
      textbackground(white);
      write(x:2,',',y:2);
      textbackground(color);
      gotoxy(x,y);
    end;
    8:begin
      textbackground(white);
      if x>1 then dec(x);
      gotoxy(x,y);
      write(' ');
      a[x,y]:=color;
      gotoxy(75,25);
      write(x:2,',',y:2);
      gotoxy(x,y);
      textbackground(color);
    end;
    ord('0')..ord('9'):begin
      write(b);
      a[x,y]:=color;
      inc(x);
      gotoxy(75,25);
      textbackground(white);
      write(x:2,',',y:2);
      textbackground(color);
      gotoxy(x,y);
    end;
    27:begin
      assign(output,'picture.out');
      rewrite(output);
      for y:=1 to 25 do
      begin
        for x:=1 to 80 do write(a[x,y],' ');
        writeln;
      end;
      close(output);
      halt;
    end;
    13:begin
      textbackground(White);
      insline;
      textbackground(color);
    end;
    end;
  until false;
end.
