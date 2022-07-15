pico-8 cartridge // http://www.pico-8.com
version 33
__lua__

function _init()
	tw=16 --tile width
	th=14  		--tile height

	s=1
	st=2
end

function _update60()
	st-=1
	if st<=0 then
		--s+=2
		st=2
	end
	
	if s>13 then
		s=1
	end
end

function _draw()
	cls()
	
	for i=0,8 do
		for j=0,8 do
			col=4
			if (i+j)%2==0 then
				col=15
			end
			rectfill(i*tw, j*th,
				i*tw+tw, j*th+th, col)
			spr(s,i*tw,j*th - 2,2,2)
		end
	end
	

	
end
__gfx__
0000000000000000000000000000000000000000000007eeeee0000000000e888880000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000007eeeee000000007e88888888000000e88888822200000007eeeeeee000000007eeeeeee0000000000000000000000000000
0070070000007eeeeeee00000007e88888888000007882222228880000e882222222220000ee88888888220007ee888888888220000000000000000000000000
00077000007e888888888800007882222228880007882888888888800e8222222222222007888888888222207888888888888222000000000000000000000000
00077000078822222222888007882888888888800e82888888888880e822200000022222e8882222222222228888888888882222000000000000000000000000
00700700788288888888888878828888888888887828888888888e82822202222222222288222222222222228888222222222222000000000000000000000000
000000008828888888888e888828888888888e88e828888888888e8222202222222222228222000000002222822222222222222207eeeeeeeeeeeee000000000
000000008828888888888e888828888888888e88e828888888888e82220222222222282222202222222222222220000000000222788888888888222200000000
0000000088888888888878888828888888888e88e828888888888e82220222222222282222022222222228222202222222222822e88888888888222200000000
000000008888eeeeeeee88828888888888887888e828888888888e82220222222222282222022222222228222202222222222822e88888888882222200000000
0000000088888888888888228888888888878882e828888888888e82222222222222822222222222222282222228888888888222022222222222222000000000
00000000888888888888222288888eeeeee888220888888888887820022222222228222002228888888822200222222222222220000000000000000000000000
00000000088882222222222008888888888882200888888888878820002228888882220000222222222222000000222222220000000000000000000000000000
000000000088222222222200008888888882220000888eeeeee88200000222222222200000002222222200000000000000000000000000000000000000000000
00000000000022222222000000088822222220000008888888822000000002222220000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000222222000000000022222200000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000007ddddd0000000000d55555000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000007ddddd000000007d55555555000000d55555511100000007ddddddd000000007ddddddd000000000000000000000000000000000000
00007ddddddd00000007d55555555000007551111115550000d551111111110000dd55555555110007dd55555555511000000000000000000000000000000000
007d555555555500007551111115550007551555555555500d511111111111100755555555511110755555555555511100000000000000000000000000000000
075511111111555007551555555555500d51555555555550d511100000011111d555111111111111555555555555111100000000000000000000000000000000
755155555555555575515555555555557515555555555d5151110111111111115511111111111111555511111111111100000000000000000000000000000000
5515555555555d555515555555555d55d515555555555d5111101111111111115111000000001111511111111111111107dddddddddd55500000000000000000
5515555555555d555515555555555d55d515555555555d5111011111111115111110111111111111111000000000011175555555555511110000000000000000
55555555555575555515555555555d55d515555555555d51110111111111151111011111111115111101111111111511d5555555555511110000000000000000
5555dddddddd55515555555555557555d515555555555d51110111111111151111011111111115111101111111111511d5555555555111110000000000000000
55555555555555115555555555575551d515555555555d5111111111111151111111111111115111111555555555511101111111111111100000000000000000
555555555555111155555dddddd55511055555555555751001111111111511100111555555551110011111111111111000000000000000000000000000000000
55555111111111110555555555555110055555555557551000111555555111000011111111111100000011111111000000000000000000000000000000000000
0555111111111110005555555551110000555dddddd5510000011111111110000000111111110000000000000000000000000000000000000000000000000000
00551111111111000005551111111000000555555551100000000111111000000000000000000000000000000000000000000000000000000000000000000000
00001111111100000000011111100000000001111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000