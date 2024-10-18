# Проверяет является ли подгруппа h N-максимальной в g
IsNMaxSubgroup := function(g, h)
    local nilpotentSubgroups, nilpotentSubgroupsLargeThanH, s;

    # Проверяем, что сама подгруппа является нильпотентной
    if not IsNilpotent(h) then
        return false;
    fi;

    # Находим все нильпотентные подгруппы группы g
    nilpotentSubgroups := Filtered(AllSubgroups(g), IsNilpotent);

    # Находим все нильпотентные подгруппы группы g, для которых h является подгруппой
    nilpotentSubgroupsLargeThanH := Filtered(nilpotentSubgroups, x -> IsSubgroup(x, h));

    # Для каждой бОльшей нильпотентной подгруппы s проверяем, что h совпадает с ней
    for s in nilpotentSubgroupsLargeThanH do
        # Если не совпадает – значит h – не N-максимальна
        if s <> h then
            return false;
        fi;
    od;

    return true;
end;

# Находит все N-максимальные подгруппы группы g
AllNMaxSubgroups := function(g)
    return Filtered(AllSubgroups(g), x -> IsNMaxSubgroup(g, x));
end;

# Печатает все N-максимальные подгруппы группы g
PrintAllNMaxSubgroups := function(g)
    local h;
    for h in AllNMaxSubgroups(g) do
        Print(StructureDescription(h), " => ", h, "\n");
    od;
end;

# Проверяет является ли подгруппа h N-инъектором в g
IsNInjector := function(g, h)
    local subnormalSubgroups, s;

    # Проверяем, что h – N-максимальная подгруппа в g
    if not IsNMaxSubgroup(g, h) then
        return false;
    fi;

    # Находим все субнормальные подгруппы группы g
    subnormalSubgroups := Filtered(AllSubgroups(g), x -> IsSubnormal(g, x));

    # Для каждой субнормальной подгруппы группы g
    for s in subnormalSubgroups do
        # Если пересечение h и субнормальной s – не N-максимальная подгруппа в s, то h – не N-инъектор
        if not IsNMaxSubgroup(s, Intersection(h, s)) then
            return false;
        fi;
    od;

    return true;
end;

# Находит все N-инъекторы группы g
AllNInjectors := function(g)
    return Filtered(AllNMaxSubgroups(g), x -> IsNInjector(g, x));
end;

# Печатает все N-инъекторы группы g
PrintAllNInjectors := function(g)
    local h;
    for h in AllNInjectors(g) do
        Print(StructureDescription(h), " => ", h, "\n");
    od;
end;