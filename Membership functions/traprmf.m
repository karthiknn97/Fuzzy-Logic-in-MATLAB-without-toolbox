function y=traprmf(x,a)
if x>=a(2)
    y=0;
elseif x<=a(1)
    y=1;
else
    y=(a(2)-x)/(a(2)-a(1));
end
end