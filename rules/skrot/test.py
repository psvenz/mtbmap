def cycleLabel(e):
    str_list = []
    for set in e.tagSets:
        if set.hasTag('ref'):
            str_list.append(set['ref'])

    str_list.sort()
    return '+'.join(str_list)