pico-8 cartridge // http://www.pico-8.com
version 36
__lua__

function _init()

	show="graph"

	n=ceil(sqrt(rnd(25))+2)
	k=rnd(2)
	cur=1
	t={}
	c={}
	for i=1,n do
		t[i]={}
		c[i]={-1,-1}
		for j=1,n do
			local val=-1
			if rnd(10)<5 then
				val=flr(rnd(10))
			end
			t[i][j]=val
			if t[j]==nil then
				t[j]={}
			end
			t[j][i]=val
		end
		t[i][i]=0
	end
	
	c[cur]={cur,0}
	

	

end

function _update60()
	f = time() / 24
	update_cursor()
	if btnp(❎) then
		if show=="graph" then
			show="table"
		else
			show="graph"
		end
	end
end

function _draw()
	cls()
	--
	
	if show=="graph" then
		draw_graph(t)
	else
		print_table(t)
	end
	--draw_cursor()

end


-->8

function print_table(t)
	for i=0,n do
		for j=0,n do
		
			if i==0 or j==0 then
				col=5 else col=7 end
			
			if i==0 and j==0
			then pr="" 
			elseif i==0 and j>0
			then pr=j 
			elseif j==0 and i>0
			then pr=i else
			pr=t[i][j] end
			
			if pr==-1 then pr="-" end
			
			print(pr,i*128/n,
												j*128/n,col)
		end
	end
end

function draw_graph(t)

	draw_lines(t)
	draw_cost(t)
	draw_circles(t)

end


function draw_circles(t)
	for i=1,#t do
			local x = get_x(i)
			local y = get_y(i)
			circfill(x+1,y+2,7,7)
			print(i,x,y,0)
			
			if i==c then
				circ(x+1,y+2,9,11)
			end
			
	end
end

function draw_lines(t)
	for j=1,#t do
			local x = get_x(j)
			local y = get_y(j)
			for i=j,n do
				if t[i][j]>0 then
					local x2=get_x(i)
					local y2=get_y(i)
					line(x,y,x2,y2,7+i)
				end
			end
	end
end

function draw_cost(t)
	for j=1,#t do
			local x = get_x(j)
			local y = get_y(j)
			for i=j,n do
				if t[i][j]>0 then
					local x2=get_x(i)
					local y2=get_y(i)
					local dx=avg(x,x2)-1
					local dy=avg(y,y2)-1
					rectfill(dx-1,dy-1,
														dx+3,dy+5,0)
					print(t[i][j],dx,dy,7)
				end
			end
	end
end

--*((n+1)%2+1)
--*(n%2+1)
function get_x(p)
 return	64+50*cos(p^2/#t+f)
end

function get_y(p)
	return 64+50*sin(p/#t+f)
end

function avg(a,b)
	return (a*(1.1)+b*(0.9))/2
end


function update_cursor()
	local lc=cur
	if btnp(⬅️) then lc-=1	end
	if btnp(➡️) then lc+=1	end
	lc = mid(1,lc,n)
	cur=lc
end
-->8
--djk

function init_djk()
	c={}
	for i=1,n do
		c[i]={-1,-1}
	end
	c[c]={c,0}
end


function djk()
	local curr=_min()
	for i=1,n do
		c_c={curr,c[curr]+t[i][curr]}
		com=comp(c[i],c_c)
		
		if com<0 then c[i]=c_c
		end
	end
end

function _min()
	local m=1
	for i=2,n do
		local curr=c[i]
		local com=comp(c[m][2],
												c[curr][2])
		if com<0 then m=curr end
	end
	
	return curr
end


function comp(a,b)
	ac=a[2] 
	bc=b[2]
	if ac<0 and bc<0 then
		ac=a[1]
		bc=b[1]
		if ac<0 and bc<0 then
			return 0 end
	end
	if ac<0 then return 1 end
	if bc<0 then return -1 end

	com=a[2]-b[2]
	if com==0 then
	com=a[1]-a[2] end
	return com
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
