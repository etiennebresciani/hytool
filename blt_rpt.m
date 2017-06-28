function blt_rpt( p, t, s, d, ttle )%BLT_RPT - Reports the results of the interpretation with the Boulton model%                % Syntax: blt_rpt( p, t, s, d, ttle )%%   p = parameters of the model%   p(1) = a   = slope of the straight lines%   p(2) = t0  = intercept with the horizontal axis the first line%   p(3) = t1  = intercept with the horizontal axis the second line%   p(4) = phi = empirical parameter that trigger the delay%   d(1) = q = pumping rate %   d(2) = r = distance between pumping well and piezometer%   t = measured time%   s = measured drawdown%   ttle = Title of the figure %% Description:%   Produces the final figure and results for the Boulton model (1963).%% See also: blt_dmo, blt_dim, blt_pre, blt_gss%% % global BLT_R BLT_Q% if(  isempty(BLT_R) ) %     disp(' ERROR: blt_rpt: You must run BLT_PRE before using the blt model')%     return;% endif(nargin==4) % Default value for d if not given by user  ttle=' ';end% Rename the parameters for a more intuitive check of the formulasa=p(1); t0=p(2); t1=p(3); phi=p(4);%r=BLT_R; q=BLT_Q;q=d(1);r=d(2); % Compute the transmissivity, storativity and radius of influenceT=0.1832339.*q./a;S=2.2458394.*T*t0/r^2;omegad=2.2458394.*T*t1/r^2-S;Ri=2*sqrt(T*t(end)/omegad);% Calculate the drawdown and derivative[td,sd]=ldiffs(t,s,30);tplot=logspace(log10(t(1)),log10(t(end)));sc=feval('blt_dim',p,tplot);[tdc,dsc]=ldiff(tplot,sc);residual=s-feval('blt_dim',p,t);mr=mean(residual);sr=2*std(residual);% Calls an internal script that computes drawdown, derivative, and residualsfunc='blt'; rpt_cmp% Defines the text of the left side of the legend lgdl=char('Test data:');lgdl=char(lgdl, sprintf(' Discharge rate: %3.2e m^3/s',q));lgdl=char(lgdl, sprintf(' Radial distance: %0.2g m',r));lgdl=char(lgdl, ' ');lgdl=char(lgdl, 'Hydraulic parameters:');lgdl=char(lgdl, sprintf(' Transmissivity T: %3.1e m^2/s',T));lgdl=char(lgdl, sprintf(' Storativity S: %3.1e',S));lgdl=char(lgdl, sprintf(' Drainage Porosity: %3.1e',omegad));lgdl=char(lgdl, sprintf(' Radius of Investigation Ri: %0.2g m',Ri));% Defines the text of the right side of the legend lgdr=char('Boulton (1963) Model');lgdr=char(lgdr, ' ');lgdr=char(lgdr, 'Fitting parameters:');lgdr=char(lgdr, sprintf(' slope a: %0.2g m',a));lgdr=char(lgdr, sprintf(' intercept t0: %0.2g s',t0));lgdr=char(lgdr, sprintf(' intercept t1: %0.2g s',t1));lgdr=char(lgdr, sprintf(' phi: : %0.2g m',phi));lgdr=char(lgdr, sprintf(' mean residual: %0.2g m',mr));lgdr=char(lgdr, sprintf(' 2 standard deviation: %0.2g m',sr));% Calls an internal script that place the legendrpt_lgd% Calls an internal script that plot the model and the datarpt_plt