function tmc_rpt( p, t, s, d, ttle )%TMC_RPT - Final graphical output with numerical results. %                % Syntax: tmr_rpt( p, t, s, d, ttle )%%   p = parameters of the model%   p(1) = b  = slope of the straight line ( = 0.183/T )%   p(2) = t0 = intercept with the horizontal axis for s = 0%   p(3) = ti = time of intersection between the 2 straight lines%%   t = measured time%   s = measured drawdown%   d(1) = r = distance from the pumping well %   ttle = Title of the figure %% Description: %   Produces the final figure and results for Theis model with a constant%   head boundary for multiple rate tests (1935).%% See also: tmc_dmo, tmc_dim, tmc_pre, tmc_gssglobal NBPUMPINGPERIOD BEGINTIME PUMPINGRATESclfif(nargin==4) % Default value for d if not given by user  ttle='Interference test';end% Rename the parameters for a more intuitive check of the formulasa=p(1); t0=p(2); ti=p(3);r=d(1); % Compute the transmissivity, storativity and radius of influenceT=0.1832339./a;S=2.2458394.*T*t0/r.^2;ri=sqrt(2.2458394*T*p(3)./S);% Calls an internal script that computes drawdown, derivative, and residualsfunc='tmc'; rpt_cmp% Defines the text of the left side of the legend lgdl=char('Test data:');lgdl=char(lgdl, sprintf(' Number of steps: %3.2e m^3/s',NBPUMPINGPERIOD));lgdl=char(lgdl, sprintf(' Distance to the well r: %0.2g m',r));lgdl=char(lgdl, ' ');lgdl=char(lgdl, 'Hydraulic parameters:');lgdl=char(lgdl, sprintf(' Transmissivity T: %3.1e m^2/s',T));lgdl=char(lgdl, sprintf(' Storativity S: %3.1e',S));lgdl=char(lgdl, sprintf(' Distance to image well ri: %0.2g m',ri));% Defines the text of the right side of the legend lgdr=char('Theis (1935) Multiple Rate with a constant');lgdr=char(lgdr, 'head boundary Model');lgdr=char(lgdr, ' ');lgdr=char(lgdr, 'Fitting parameters:');lgdr=char(lgdr, sprintf(' slope a: %0.2g m',a));lgdr=char(lgdr, sprintf(' intercept t0: %0.2g m',t0));lgdr=char(lgdr, sprintf(' intercept ti: %0.2g m',ti));lgdr=char(lgdr, sprintf(' mean residual: %0.2g m',mr));lgdr=char(lgdr, sprintf(' 2 standard deviation: %0.2g m',sr));% Calls an internal script that place the legendrpt_lgd% Calls an internal script that plot the model and the datarpt_plt