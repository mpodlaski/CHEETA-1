within CHEETA.Aircraft.Electrical.HTS.Stekly;
model Stekly_ColdEndCooling
  "HTS line using Stekly equations with cold end cooling"
  parameter Modelica.SIunits.Length l "Length of wire";
  parameter Modelica.SIunits.ElectricFieldStrength E_0 = 1e-4 "Reference electric field";
  parameter Real n = 2 "Intrinstic value of the superconductor";
  parameter Real I_c0 = 1 "Reference corner current";
  parameter Real dT = 2 "Change in temperature";
  parameter Modelica.SIunits.Area A = 1 "Area";
  parameter Modelica.SIunits.Area A_cu = 5.04e-6 "Area of copper section of cable";
  parameter Modelica.SIunits.Length P = 0.1035 "Perimeter of cable";
  parameter Modelica.SIunits.Resistivity rho = 2.1e-9 "Resitivity of copper";
  parameter Modelica.SIunits.Power G_d "Extra heat generation";
  parameter Modelica.SIunits.Radius R_0 "Wire radius";
  parameter Modelica.SIunits.Thickness h = 1 "Thickness of the tube for an up-gapped superconductor in simple transmission configuration";
  parameter Modelica.SIunits.Conductivity kappa = 400*10^3 "Cable thermal conductivity";
  parameter Modelica.SIunits.Resistance R "Line resistance";
  Modelica.SIunits.Current I_c "corner current";
  Modelica.SIunits.ElectricFieldStrength E "Electric field";
  Modelica.SIunits.Power G;
  Real pi = Modelica.Constants.pi;
  Modelica.SIunits.PermeabilityOfVacuum mu_0 = 4*pi*10e-7;
  Modelica.SIunits.Power Q;
  Modelica.SIunits.Power Q_ce;

  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p             annotation (Placement(
        transformation(extent={{-100,-10},{-80,10}}),iconTransformation(extent={{-100,
            -10},{-80,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (Placement(
        transformation(extent={{80,-10},{100,10}}),iconTransformation(extent={{80,-10},
            {100,10}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));

initial equation

equation
  port_a.Q_flow = (0.6953+0.001079*dT^4)*A;
  I_c = I_c0 *port_a.T;
  E = E_0 *(pin_p.i/I_c)^n;
  pin_n.i = pin_p.i;
  G = (rho * I_c^2 * 10^3 /P) + G_d*A_cu;
  Q = l*(mu_0 * h * I_c^2)/ (3*pi*R_0) * (I_c0/I_c)^3;

  Q_ce = port_a.T*sqrt(2*kappa*A_cu*P*h);
  pin_n.v = pin_p.v + E*l;
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-80,
           -40},{80,40}}), graphics={
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
         coordinateSystem(preserveAspectRatio=false, extent={{-80,-40},{80,40}})));
end Stekly_ColdEndCooling;