% randtable(p,n) returns n discrete random draws from the probability
% distribution with unnormalized contingency table p.
function x = randtable (p, n)

  % Get the number of random draws to generate.
  if ~exist('n')
    n = 1;
  end

  % Get the number of classes.
  m = numel(p);

  % Normalize the probability table.
  p = p(:)';
  p = p/sum(p);
  
  % Create the CDF.
  ub = cumsum(p);
  lb = [0 ub(1:m-1)];
  
  % Generate the discrete random deviates.
  x = zeros(n,1);
  for i = 1:n
    u    = repmat(rand,1,m);
    x(i) = sum((lb <= u & u < ub) .* (1:m));
  end
