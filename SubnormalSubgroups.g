# Находит все субнормальные подгруппы группы g
AllSubnormalSubgroups := function(g)
    return Filtered(AllSubgroups(g), x -> IsSubnormal(g, x));
end;

# Печатает все субнормальные подгруппы группы g
PrintAllSubnormalSubgroups := function(g)
    local h;
    for h in AllSubnormalSubgroups(g) do
        Print(StructureDescription(h), " => ", h, "\n");
    od;
end;
