within CHEETA.Aircraft.Electrical.HTS.GasCooled;
model HTS_GasCooling_Voltage "HTS line using Stekly equations"
   parameter Integer l "Length of wire";
  parameter Modelica.SIunits.ElectricFieldStrength E_0 = 1e-4 "Reference electric field";
  parameter Real n = 5.29 "Intrinstic value of the superconductor";
  parameter Real I_c0 = 1 "Reference corner current";
  parameter Modelica.SIunits.Area A = 1 "Area";
  parameter Modelica.SIunits.Area A_cu = 1 "Area of copper in wire";
  parameter Modelica.SIunits.Current I_crit "Critical current";
  parameter Modelica.SIunits.Temp_K T_c = 92 "Critical temperature";
  //Losses
  parameter Modelica.SIunits.Resistance R_L "Resistance of the brass connectors";
  parameter Modelica.SIunits.Power G_d = 3.527*10^4 "Extra heat generation due to fault";
  //Characteristics of the line
  parameter Modelica.SIunits.Radius a = 2e-1
                                            "Inner radius of co-axial cable";
  parameter Modelica.SIunits.Radius b = 4e-1
                                            "Outer radius of co-axial cable";

  parameter Modelica.SIunits.Radius R_c = 5e-1
                                            "Inner radius of cryostat";

  parameter Modelica.SIunits.Radius R_0 = 4e-1
                                            "Outer radius of co-axial cable";
  parameter Modelica.SIunits.Permeability mu_r = 1;
  parameter Modelica.SIunits.Permittivity epsilon_r = 1;
  parameter Modelica.SIunits.Length P = 0.1035 "Perimeter of line";
  parameter Modelica.SIunits.Frequency f = 60 "Frequency of AC system";
  parameter Modelica.SIunits.Conductivity kappa = 400;

  parameter Modelica.SIunits.Velocity v = 1 "Velocity of gas";
  parameter Modelica.SIunits.HeatCapacity C_pv = 5200 "Heat capacity";

  Real G;

  //Constants
  Real pi= Modelica.Constants.pi;
  Modelica.SIunits.PermeabilityOfVacuum mu_0 = 4*pi*10e-7;
  Modelica.SIunits.PermittivityOfVacuum epsilon_0 = 8.854e-12;
  Modelica.SIunits.Permeability mu;
  Modelica.SIunits.Permittivity epsilon;
  Modelica.SIunits.Resistivity omega = f*2*pi;
  Modelica.SIunits.Resistivity delta = 30;

  //Line heat transfer characeteristics
  Real h "Heat transfer coefficient of surfaces";
  Real dT[100] "Change in temperature";
  Real dT_rho "Change in temperature";
  Real T[100] "Temperature at point z on line";
  Real Q_flow[100] "heat dissipation from line";
  Modelica.SIunits.Current I_c "corner current";
  Modelica.SIunits.ElectricFieldStrength E "Electric field";

  //Resistances, inductances, and currents
  Modelica.SIunits.Resistance R_pi;
  Modelica.SIunits.Resistance R_ac;
  Modelica.SIunits.Inductance L_pi;
  Modelica.SIunits.Capacitance C_pi;

  Modelica.SIunits.Resistivity rho;

  Real x(start=0);
  //Real y(start = 0.07);
  Real r;
  Real z[100];
  Real aa;



  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p             annotation (Placement(
        transformation(extent={{-100,-10},{-80,10}}),iconTransformation(extent={{-100,
            -10},{-80,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (Placement(
        transformation(extent={{80,-10},{100,10}}),iconTransformation(extent={{80,-10},
            {100,10}})));

  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R_L)
    annotation (Placement(transformation(extent={{-70,-6},{-58,6}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=R_L)
    annotation (Placement(transformation(extent={{60,-6},{72,6}})));
  Modelica.Electrical.Analog.Basic.VariableInductor
                                            inductor
    annotation (Placement(transformation(extent={{-46,10},{-34,22}})));
  Modelica.Electrical.Analog.Basic.VariableResistor
                                            resistor2
    annotation (Placement(transformation(extent={{-46,6},{-34,-6}})));
  Modelica.Electrical.Analog.Basic.VariableInductor
                                            inductor1(
    Lmin=Modelica.Constants.eps)
    annotation (Placement(transformation(extent={{-6,10},{6,22}})));
  Modelica.Electrical.Analog.Basic.VariableResistor
                                            resistor3
    annotation (Placement(transformation(extent={{-6,6},{6,-6}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-22,-30},{-14,-22}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=R_pi)
    annotation (Placement(transformation(extent={{-64,-34},{-52,-26}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=C_pi)
    annotation (Placement(transformation(extent={{-38,-18},{-28,-10}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=L_pi)
    annotation (Placement(transformation(extent={{-54,30},{-44,38}})));

  Modelica.Blocks.Sources.RealExpression realExpression3(y=R_ac)
    annotation (Placement(transformation(extent={{28,-18},{16,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-8,-50},{12,-30}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(v(start=1000, fixed=true),
      C=3.4565684e-10)                                                      annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=270,
        origin={-18,-10})));
initial algorithm


algorithm
  for n in 1:l*10 loop
    T[n] := DymolaModels.Functions.Math.divNoZero(n*0.1*(-port_a.Q_flow),(v*C_pv*2*pi*(R_c-R_0)^2)) + port_a.T;
    r := 100;
    dT[n] := T[n] - port_a.T;
    x := (v*C_pv*2*pi*(a-b)^2);
  // HYDROGEN h = smooth(10,noEvent(if dT<3 then 100*(dT)^n elseif (dT>=3 and dT<100) then 10^5/(dT) else 1000));

  //z = noEvent(if dT<3 then 0 elseif (dT>3 and dT<100) then 1 else 2);
    Q_flow[n] :=0.05*dT[n];
    z[n] :=n*0.1;

  end for;

equation

    I_c =I_c0*(1 - (port_a.T/T_c));
    dT_rho = DymolaModels.Functions.Math.divNoZero(port_a.T*(rho *I_c^2/(P*A_cu)),(h));
    E =E_0*(pin_p.i/I_c)^n;
    rho =DymolaModels.Functions.Math.divNoZero(E, (I_c/A));
    h = smooth(10,noEvent(if dT_rho<3 then 100*(dT_rho)^n elseif (dT_rho>=3 and dT_rho<100) then 10^5/(dT_rho) else 1000));
    mu =mu_0*mu_r;
    epsilon =epsilon_0*epsilon_r;
    port_a.Q_flow = -h*dT_rho - G;
    L_pi =l*mu/(2*pi)*log(b/a);
    C_pi =l*2*pi*epsilon/(log(b/a));
    R_pi =l*E_0*DymolaModels.Functions.Math.divNoZero((pin_p.i/I_c)^n, pin_p.i);
    R_ac =DymolaModels.Functions.Math.divNoZero(tan(delta), omega)*C_pi;

    if noEvent(pin_p.i>I_crit) then
      aa=1;
      G = (rho * I_c^2 * 10^3 / A_cu*P) + G_d*A_cu;
    else
      aa=0;
      G = 0;
    end if;

  connect(pin_p, resistor.p)
    annotation (Line(points={{-90,0},{-70,0}}, color={0,0,255}));
  connect(resistor.n, resistor2.p)
    annotation (Line(points={{-58,0},{-46,0}}, color={0,0,255}));
  connect(inductor1.n, resistor3.n)
    annotation (Line(points={{6,16},{14,16},{14,0},{6,0}},
                                              color={0,0,255}));
  connect(resistor2.R, realExpression.y) annotation (Line(points={{-40,-7.2},{-40,
          -30},{-51.4,-30}}, color={0,0,127}));
  connect(resistor3.R, realExpression.y)
    annotation (Line(points={{0,-7.2},{0,-30},{-51.4,-30}},  color={0,0,127}));
  connect(resistor3.p, resistor2.n)
    annotation (Line(points={{-6,0},{-34,0}},color={0,0,255}));
  connect(inductor.L, realExpression2.y)
    annotation (Line(points={{-40,23.2},{-40,34},{-43.5,34}},
                                                            color={0,0,127}));
  connect(inductor1.L, realExpression2.y)
    annotation (Line(points={{0,23.2},{0,34},{-43.5,34}}, color={0,0,127}));
  connect(resistor1.n, pin_n)
    annotation (Line(points={{72,0},{90,0}}, color={0,0,255}));
  connect(resistor1.p, resistor3.n)
    annotation (Line(points={{60,0},{6,0}}, color={0,0,255}));
  connect(inductor.p, resistor2.p) annotation (Line(points={{-46,16},{-48,16},{
          -48,0},{-46,0}}, color={0,0,255}));
  connect(inductor.n, inductor1.p)
    annotation (Line(points={{-34,16},{-6,16}}, color={0,0,255}));
  connect(resistor3.p, capacitor.p)
    annotation (Line(points={{-6,0},{-18,0},{-18,-4}}, color={0,0,255}));
  connect(capacitor.n, ground.p)
    annotation (Line(points={{-18,-16},{-18,-22}}, color={0,0,255}));
  connect(capacitor.p, inductor1.p)
    annotation (Line(points={{-18,-4},{-18,16},{-6,16}}, color={0,0,255}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-80,-40},
            {80,40}}),     graphics={
                  Rectangle(
          extent={{-80,40},{80,-40}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-60,20},{60,-20}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),Text(
          extent={{-60,20},{60,-20}},
          lineColor={255,255,0},
          textString="%name")}),                                  Diagram(
         coordinateSystem(preserveAspectRatio=false, extent={{-80,-40},{80,40}})),
    Documentation(info="<html>
<p>This transmission line model is a pi-line model. The capactiance, resistance, and inductance of the line depend on the physical dimensions and current of the line. The resistance in parallel to the capacitor is used as a modeled loss.</p>
</html>"),              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-80,-40},
            {80,40}}),     graphics={
                  Rectangle(
          extent={{-80,40},{80,-40}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-60,20},{60,-20}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),Text(
          extent={{-60,20},{60,-20}},
          lineColor={255,255,0},
          textString="%name")}),                                  Diagram(
         coordinateSystem(preserveAspectRatio=false, extent={{-80,-40},{80,40}})),
    Documentation(info="<html>
<p>This transmission line model is a pi-line model. The capactiance, resistance, and inductance of the line depend on the physical dimensions and current of the line. The resistance in parallel to the capacitor is used as a modeled loss.</p>
</html>"),
    experiment(__Dymola_NumberOfIntervals=1000, __Dymola_Algorithm="Dassl"));
end HTS_GasCooling_Voltage;
