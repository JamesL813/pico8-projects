pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
q
function _init()
	t=0

	init_sandbox()
	
	draw_sandbox()

end

function _update60()
	t+=1


end

function _draw()
	update_sandbox()
	
end
-->8
--sandbox

function init_sandbox()
	sand={}
	for y=1,126 do
		sand[y]={}
		for x=1,126 do
			if rnd(1.1)>1 then
				sand[y][x]=1
			else sand[y][x]=0 end
		end
	end
end

function update_sandbox()

	for y=126,1,-1 do
		for x=1,126 do
		
			if sand[y][x]!=0 then
			
				p=update_point(x,y)
			
				if p!=nil then
					local px=p[1]
					local py=p[2]
				
					sand[y][x]=0
					sand[py][px]=1
				
				end
				
			end
			
			pset(x,y,sand[y][x])
		end
	end
end

function draw_sandbox()
	cls(2)
	for y=126,1,-1 do
		for x=1,126 do
			pset(x,y,sand[y][x])
		end
	end
end


-->8
--points


function update_point(x,y)

	if sand[y][x]==0 then
		return nil end

	if y>=126 then return nil end

	if sand[y+1][x]==0 then
		return {x,y+1} end
	

	return nil
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000