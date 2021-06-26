clear all
close all
clc
load Advanc.mat
load Advancp.mat
load Novic.mat
load Novicp.mat

Datap=[Advancp,Novicp(:,1:end-1)];
Data=[Advanc(:,1:6),Advanc(:,8:end),Novic(:,1:end-1)];

test=Novic(:,end)/norm(Novic(:,end));
testp=Novicp(:,end)/norm(Novic(:,end));
[a,b]=size(Data);
n=b;
for k=1:b
    Data(:,k) = Data(:,k)/norm(Data(:,k));
end

figure
imshow(Datap);
figure
imshow(testp);

%% L1 norm minimzation
cvx_begin;
    variable s(n);
    minimize(norm(s,1));
    subject to
        norm(Data*s-test,2)<=0.5;
cvx_end;
[i,j]=max(s);
if j>8
    class=2;
else
    class=1;
end
match_probability=max(s)/norm(s,2);
figure
plot(s);
xlabel('Image number');
ylabel('Coefficients');
legend(join(["Detected probability match:",num2str(match_probability)," with ",num2str(class),"th class"]));


    
