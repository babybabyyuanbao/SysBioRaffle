
%Load images:
allImages = loadAllImages('contendants');
imageSize = size(allImages{1});
imageSize = imageSize(1:2);

%Load sound and other images:
[click,~]   = audioread('click.mp3');
[fanfare,~] = audioread('fanfare.wav');
sysbio      = imread('sysbio.jpg');
sysSize     = size(sysbio);
CVlogo      = imread('CVlogo.jpg');
CVsize      = size(CVlogo);

%Random orders:
rdmTable = dlmread('random.txt','\t');
start    = 1+floor((300-1)*rand(1,20));

%Parameters to play with:
N        = 50;      %Number of pictures to go through per iteration
maxValue = 0.7;     %Final time

%Function that makes images show fast in the begining and slow down
timePoints = linspace(0.05,1,N);
speedFactor = ((exp(timePoints)-1)/(exp(1)-1))*maxValue;
colorFactor = [0.4 0.7 1 0.7 0.4];

image([-200 +200],[200 600],CVlogo)
set(gca,'xcolor',get(gcf,'color'));
set(gca,'xtick',[]);
set(gca,'ytick',[]);    
set(gcf,'Color','black')
axis equal
pause
clf

for i = 1:20
    order = rdmTable(start:start+N+10,i);
    for j = 1:N
        sound(click)
        currentImage = order(j:j+5);
        pause(speedFactor(j))
        hold all
        image([-500 -250],[450 300],sysbio)
        image([300 500],[480 280],CVlogo)
        
        for k = 1:5
             image([-200 imageSize(2)-200],[imageSize(1)*(k+1) imageSize(1)*(k)], ...
                    colorFactor(k) *allImages{currentImage(k)});
        end
        patch('Faces',1:4,'Vertices',[-200 imageSize(1)*3; -200 imageSize(1)*4; ...
              imageSize(2)-200 imageSize(1)*4; imageSize(2)-200 imageSize(1)*3], ...
              'FaceColor','none','EdgeColor','r','LineWidth',4);
        
        set(gca,'xcolor',get(gcf,'color'));
        set(gca,'xtick',[]);
        set(gca,'ytick',[]);    
        set(gcf,'Color','black')
        axis equal
        hold off
    end
    pause(0.5)
    sound(fanfare)
    pause
    clf
end