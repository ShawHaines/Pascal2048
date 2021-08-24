program Game2048;
Uses Crt;
type
  location=array[1..2]of byte;
var
  brick:array[1..4,1..4]of byte;
  empty:array[1..16]of location;
  x,y,i,j:byte;
function power(a:byte):word;
var
  i:byte;
begin
  power:=1;
  for i:=1 to a do power:=power*2;
end;
procedure createmap;
begin
  textbackground(White);clrscr;
  window(1,1,7,3);textbackground(Yellow);clrscr;
  gotoxy(2,2);textcolor(White);write(2048);
  window(9,1,15,2);textbackground(Black);clrscr;
  gotoxy(2,1);write('Score');gotoxy(4,2);write(0);
  window(1,4,28,4);clrscr;
  for x:=1 to 4 do
  begin
    window(7*x,5,7*x,16);
    clrscr;
  end;
  window(1,17,28,17);clrscr;
  window(1,1,80,25);
end;
procedure print;
begin
  for y:=1 to 4 do
  for x:=1 to 4 do
  begin
    case brick[x,y] of
    0:textbackground(White);
    1,2:textbackground(Yellow);
    3,4:textbackground(6);
    5,6:textbackground(Red);
    7,8:textbackground(3);
    9,10:textbackground(Blue);
    11,12:textbackground(Green);
    end;
    window(x*7-6,y*3+2,x*7-1,y*3+4);clrscr;
    window(1,1,80,25);
    if brick[x,y]>0 then begin
      gotoxy(x*7-4,y*3+3);
      write(power(brick[x,y]));
    end;
  end;
end;
procedure appear;
begin
  fillchar(empty,sizeof(location),0);
  i:=0;
  for y:=1 to 4 do
  for x:=1 to 4 do
  if brick[x,y]=0 then
  begin
    inc(i);
    empty[i][1]:=x;
    empty[i][2]:=y;
  end;
  j:=random(i);
  brick[empty[j][1],empty[j][2]]:=1;
end;
begin
  randomize;
  cursoroff;
  fillchar(brick,sizeof(brick),0);
  createmap;
  repeat
    if not keypressed then continue;
    delay(500);
    appear;
    print;
  until false;
end.

