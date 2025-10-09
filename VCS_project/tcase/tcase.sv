initial begin
    test t0;
    t0 = new;
    t0.e0.vif = _if;
    t0.run();
    #50 $finish;
end
