within CHEETA.Aircraft.Electrical.HTS.Examples;
model Fixed_Rotor

  Modelica.Electrical.Analog.Sources.ConstantVoltage
                                                 constantVoltage(V=1000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-84,-14})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-94,-50},{-74,-30}})));
  Modelica.Blocks.Sources.Constant
                               tauRef(k=733.038285)
               annotation (Placement(transformation(extent={{-28,12},{-8,32}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-20,-78},{-40,-58}})));
  Modelica.Blocks.Sources.Constant const(k=20)
    annotation (Placement(transformation(extent={{26,-78},{6,-58}})));
  LiquidCooled.HTS_filmboiling_Voltage2 hTS_filmboiling3_2(
    l=10,
    n=20,
    I_c0=9000,
    A=0.1,
    A_cu=0.1,
    I_crit=10000,
    T_c(displayUnit="K"),
    R_L=1e-6,
    G_d=0,
    a=0.1,
    b=0.5,
    P=10) annotation (Placement(transformation(extent={{-60,-4},{-44,4}})));
  ElectrifiedPowertrains.ElectricDrives.AIM.ElectroMechanical.SpeedFOC
    electricDrive(
    redeclare ElectrifiedPowertrains.ElectricMachines.AIM.Controllers.Speed
      controller(redeclare
        Machines.Records.CHEETA_Records.CHEETA_1MW_controller data),
    redeclare
      ElectrifiedPowertrains.PowerElectronics.Inverters.PWM.NoModulation
      modulationMethod,
    redeclare
      ElectrifiedPowertrains.PowerElectronics.Inverters.Averaged.ConstantEfficiency
      inverter(redeclare
        ElectrifiedPowertrains.PowerElectronics.Inverters.Averaged.Electrical.Records.Data.ConstantEfficiency.Constant98percent
        data),
    useThermalPort=false,
    redeclare
      ElectrifiedPowertrains.ElectricMachines.AIM.ElectroMechanical.LinearSquirrelCage
      machine(redeclare Machines.Records.CHEETA_Records.CHEETA_1MW data))
    annotation (Placement(transformation(extent={{8,-16},{28,4}})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{-16,-40},{4,-20}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=1)
    annotation (Placement(transformation(extent={{40,-48},{60,-28}})));
  Modelica.Mechanics.Rotational.Sensors.MultiSensor multiSensor annotation (Placement(transformation(extent={{42,-12},
            {54,0}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed
    annotation (Placement(transformation(extent={{60,-48},{80,-28}})));
equation
  connect(prescribedTemperature.T,const. y)
    annotation (Line(points={{-18,-68},{5,-68}}, color={0,0,127}));
  connect(ground1.p,electricDrive. pin_n)
    annotation (Line(points={{-6,-20},{-6,-12},{8,-12}},     color={0,0,255}));
  connect(constantVoltage.p, hTS_filmboiling3_2.pin_p)
    annotation (Line(points={{-84,-4},{-84,0},{-61,0}}, color={0,0,255}));
  connect(hTS_filmboiling3_2.port_a, prescribedTemperature.port) annotation (
      Line(points={{-51.8,-4},{-52,-4},{-52,-68},{-40,-68}}, color={191,0,0}));
  connect(hTS_filmboiling3_2.pin_n, electricDrive.pin_p)
    annotation (Line(points={{-43,0},{8,0}}, color={0,0,255}));
  connect(tauRef.y, electricDrive.desiredSpeed)
    annotation (Line(points={{-7,22},{18,22},{18,6}}, color={0,0,127}));
  connect(multiSensor.flange_a, electricDrive.flange)
    annotation (Line(points={{42,-6},{28,-6}}, color={0,0,0}));
  connect(inertia.flange_a, multiSensor.flange_b) annotation (Line(points={{40,
          -38},{34,-38},{34,-20},{70,-20},{70,-6},{54,-6}}, color={0,0,0}));
  connect(constantVoltage.n, ground.p)
    annotation (Line(points={{-84,-24},{-84,-30}}, color={0,0,255}));
  connect(inertia.flange_b, fixed.flange)
    annotation (Line(points={{60,-38},{70,-38}}, color={0,0,0}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,60}})), Icon(
        coordinateSystem(extent={{-100,-100},{100,60}})));
end Fixed_Rotor;