% part a, b
N = 1000;
X = zeros(100,1);
X(1,1) = 1;
X(2,1) = 0.5;
H = zeros(N - 2, 2);
y = zeros(N - 2, 1);
thetas = zeros(100,2);
for j = 1:100
    for i=3:N
        w = normrnd(0, 1);
        X(i,1) = X(i-1,1) - 0.1*X(i-2) + w;
        H(i-2,:) = [X(i-1,1), X(i-2,1)];
        y(i-2,1) = X(i,1);
    end
    theta = inv(H'*H)*H'*y;
    thetas(j,:) = theta';
end
mean_theta = mean(thetas)
std_theta = std(thetas)

% part c
N = 1000;
X = zeros(100,1);
X(1,1) = 1;
X(2,1) = 0.5;
H = zeros(N - 2, 2);
y = zeros(N - 2, 1);
thetas = zeros(100,2);
w = normrnd(0,1);
for j = 1:5
    for i=3:N
        w = normrnd(0, 2*abs(w));
        X(i,1) = X(i-1,1) - 0.1*X(i-2) + w;
        H(i-2,:) = [X(i-1,1), X(i-2,1)];
        y(i-2,1) = X(i,1);
    end
    theta = inv(H'*H)*H'*y;
    thetas(j,:) = theta';
end
mean_theta = mean(thetas)
std_theta = std(thetas)

% part d
N = 1000;
X = zeros(100,1);
X(1,1) = 1;
X(2,1) = 0.5;
H = zeros(N - 2, 1);
y = zeros(N - 2, 1);
thetas = zeros(100,1);
w = normrnd(0,1);
for j = 1:100
    for i=3:N
        w = normrnd(0, 1);
        X(i,1) = 0.1*X(i-1,1)*X(i-2) + w;
        H(i-2,:) = [X(i-1,1)*X(i-2,1)];
        y(i-2,1) = X(i,1);
    end
    theta = inv(H'*H)*H'*y;
    thetas(j,:) = theta';
end
mean_theta = mean(thetas)
std_theta = std(thetas)