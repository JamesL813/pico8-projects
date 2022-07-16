pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
--minesweeper

function _init()
	state="game"
	t=0
	_x=0
	_y=0
	st=0
	ed=15
	cur={x=1,y=1}
	cols={12,3,8,1,2,13,9,10}
	
	grid={}
	rev={}
	for i=st,ed do
		grid[i]={}
		rev[i]={}
		for j=st,ed do
			--0=empty, -1=bomb
  	
  	if rnd(7)<1 then
  		grid[i][j]=-1
  	else
  		grid[i][j]=0
  	end
  	
  	rev[i][j]=0
  	
  end
	end
	
	for i=st,ed do
		for j=st,ed do
			local val=grid[i][j]
  	local t0p=true
  	local left=i>st
  	local right=i<ed
  	local bot=j<ed
  	
  	if val==0 then
  		cnt=0
  		
  		if left and
  			grid[i-1][j-1]==-1	then
  			cnt+=1 end
  			
  		if  
  			grid[i][j-1]==-1 then
  			cnt+=1 end
  			
  		if right and
  			grid[i+1][j-1]==-1 then
  			cnt+=1 end
  			
  		if left and
  		 grid[i-1][j]==-1 then
  			cnt+=1 end
  		if right and
  			grid[i+1][j]==-1 then
  			cnt+=1 end
  		if left and bot and
  			grid[i-1][j+1]==-1 then
  			cnt+=1 end
  		if bot and
  			grid[i][j+1]==-1 then
  			cnt+=1 end
  		if right and bot and
  			grid[i+1][j+1]==-1 then
  			cnt+=1 end
  		
  		grid[i][j]=cnt
  	end
  	
  end
	end
	
end

function _update60()
	t+=1
	controls()
end

function _draw()
	cls(7)
	for i=st,ed do
		for j=st,ed do
			local x=i*8
			local y=j*8
			local val=grid[i][j]
			local col=5
			
			
			rectfill(x,y,
				x+8,y+8,col)
			rect(x,y,
				x+8,y+8,0)
			
				
			if val>0 then
				print(val,x+3,y+2,cols[val]) end
				
			if val==-1 then
				circfill(x+4,y+4,2,0) 
			end
		end
	end
	
	draw_blocks()
	
	--draw blinking cursor
	--if t%50>25 then
		pal(7,1)
		spr(2,cur.x,cur.y,2,2)
	--end
	
	pal(7,7)
		--print(((cur.x-1)/8)..", "..(cur.y-1)/8,2,2,8)
end
-->8
--controls

function controls()
	if btnp(⬅️) then cur.x-=8 end
	if btnp(➡️) then cur.x+=8 end
	if btnp(⬆️) then cur.y-=8 end
	if btnp(⬇️) then cur.y+=8 end
	cur.x=mid((st*8)+1,cur.x,(ed*8)+1)
	cur.y=mid((st*8)+1,cur.y,(ed*8)+1)
	
	
	if btnp(❎) then
		local x=(cur.x-1)/8
		local y=(cur.y-1)/8
		reveal(x,y) end
	
	if btnp(🅾️) then
		local x=(cur.x-1)/8
		local y=(cur.y-1)/8
		flag(x,y) end
	
	
	
end

function reveal(x,y)
	
	rev[x][y]=1
	
	if grid[x][y]==0 then
		for i=-1,1 do
			for j=-1,1 do
				if (i!=0 or j!=0)
					and mid(st,x+i,ed)==x+i
					and mid(st,y+i,ed)==y+i
					and rev[x+i][y+j]==0
					then
						reveal(x+i,y+j) 
						_draw()
					end
			end
		end
	end
end

function flag(x,y)
	if rev[x][y]==0 then
		rev[x][y]=-1 
	elseif rev[x][y]==-1 then
		rev[x][y]=0
	end
end
-->8
--draw blocks

function draw_blocks()
	for i=st,ed do
		for j=st,ed do
			local x=i*8+1
			local y=j*8+1
			local val=rev[i][j]
			if val<=0 then
				rectfill(x,y,x+6,y+6,6)
				line(x,y,x,y+5,7)
				line(x,y,x+5,y,7)
				line(x+6,y+6,x+6,y+1,5)
				line(x+6,y+6,x+1,y+6,5)
				if val==-1 then 
					spr(1,x,y) end
			end
		end
	end
end
__gfx__
00000000000000007700077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008880007000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700008888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000008880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700088800007000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000007700077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
