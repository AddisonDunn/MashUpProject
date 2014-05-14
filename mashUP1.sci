function y = mashUP(song1, fs1, song2, fs2)
    s1 = length(song1)
    s2 = length(song2)
    if s2 > s1 then
        song2 = song2(1, s1);
    elseif s1 > s2 then
        song1 = song1(1, s2);
    end
    higher = highPass(song1, fs1)
    lower = lowPass(song2, fs2)
    y = conv(higher, lower)
endfunction
function y = highPass(t, fs)
    fc = 1475
    time = 2001
    index = fc*time/fs + 1
    y = ones(1:time)'
    for x = 1:index
        y(x) = 0
    end
    for x = (time-index):time
        y(x) = 0
    end
    y = (1/time)*real(fft(y))
    y = [y(int(time/2):time)', y(1:int(time/2))']
    //disp(length(y))
    y=conv(y,t)
    y = conv(y, t)
    //sound(conv(t, y))
endfunction
function y = lowPass(t, fs)
    fc = 700
    time = 2001
    index = fc*time/fs + 1
    y = zeros(1:time)'
    for x = 1:index
        y(x) = 1
    end
    for x = (time-index):time
        y(x) = 1
    end
    y = (1/time)*real(fft(y))
    y = [y(time/2:time)', y(1:time/2)']
    y = conv(y, t)
    y = conv(t, y)
    //sound(conv(t, y))
endfunction
