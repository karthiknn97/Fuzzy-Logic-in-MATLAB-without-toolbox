function y=traplmf(x,a)
if x <= a(1)
    y=0;
elseif x >= a(2)
    y=1;
else
    y=(x-a(1))/(a(2)-a(1));
end
end