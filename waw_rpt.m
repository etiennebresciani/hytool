function waw_rpt( p, t, s, d, ttle )%WAW_RPT - Produces the final figure and results for the WAW model%                % Syntax:  waw_rpt( p, t, s, q, ttle )%%   p(1) = a  = slope of Jacob Straight Line%   p(2) = t0 = intercept with the horizontal axis for %               the early time asymptote%   p(3) = t1 = intercept with the horizontal axis for %               the late time asymptote%   p(4) = tm = time of the minimum of the derivative%   p(5) = Cd = well-bore storage coefficient%%   t = measured time%   s = measured drawdown%   q = Pumping rate%   ttle = Title of the figure %% Description: %   Produces the final figure and results for the Warren and Root model %   with well-bore storage effect   %% See also: waw_dim, waw_gssif(nargin==4) % Default value for d if not given by user  ttle='Diagnostic plot';end% Rename the parameters for a more intuitive check of the formulasQ=d(1); rc=d(2);  rw=d(3); a=p(1); t0=p(2); t1=p(3); tm=p(4); cd=p(5);% Compute the transmissivity, storativity and radius of influenceTf=0.1832339*Q/a;%Sf=2.245839*Tf*t0/r^2;%Sm=2.245839*Tf*t1/r^2-Sf;sigma=(t1-t0)./t0;lambda=2.2458394*t0*log(t1/t0)./tm;% Calls an internal script that computes drawdown, derivative, and residualsfunc='waw'; rpt_cmp% Defines the text of the left side of the legend lgdl=char('Test data:');lgdl=char(lgdl, sprintf('  Discharge rate: %3.2e m^3/s',Q));%lgdl=char(lgdl, sprintf('  Radius of casing: %0.2g m',rc));%lgdl=char(lgdl, sprintf('  Radius of screen: %0.2g m',rw));lgdl=char(lgdl, ' ');lgdl=char(lgdl, 'Hydraulic parameters:');lgdl=char(lgdl, sprintf('  Transmissivity Tf: %3.1e m^2/s',Tf));lgdl=char(lgdl, sprintf('  Interporosity flow lamda: %0.2e',lambda));lgdl=char(lgdl, ' ');lgdl=char(lgdl, 'Quality of the fit:');lgdl=char(lgdl, sprintf('  mean residual: %0.2g m',mr));lgdl=char(lgdl, sprintf('  2 standard deviation: %0.2g m',sr));% Defines the text of the right side of the legend lgdr=char('Warren and Root (1965) + Well-bore storage Model');lgdr=char(lgdr, ' ');lgdr=char(lgdr, 'Fitting parameters:');lgdr=char(lgdr, sprintf(' slope a: %0.2g m',a));lgdr=char(lgdr, sprintf(' intercept t0: %0.2g s',t0));lgdr=char(lgdr, sprintf(' Intercept t1: %0.2g s',t1));lgdr=char(lgdr, sprintf(' Minimum derivative tm: %0.2g s',tm));lgdr=char(lgdr, sprintf(' C_D: %0.2g',cd));% Calls an internal script that place the legendrpt_lgd% Calls an internal script that plot the model and the datarpt_plt