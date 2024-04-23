import csv


def min_bez(b_in, bez):
    if b_in > bez /12:
        b_out = b_in - bez / 12
        pers_kost = bez / 12
        return pers_kost, b_out
    else:
        b_out = 0
        pers_kost = b_in
        return pers_kost, b_out


def soc_bijd_ink(b_in):
    soc_bijd = 0.205 * b_in
    b_out = b_in - soc_bijd
    return soc_bijd, b_out


def forf_kost(b_in):
    # Accountant, car and
    # other benefits that can ben deducted as a fiscal cost
    b_out = (1 - 0.15) * b_in
    return b_out


# 0.03 * 45000 = Forfaitaire beroepskosten van bedrijfsleiders
# aanslagjaar 2023, inkomstenjaar 2022
# https://www.practicali.be/blog/geindexeerde-bedragen-aj-2023#barema4
def personenbelasting(n_bezold, bez):
    if n_bezold <= 13870 / 12:
        pb = n_bezold * 0.25 \
             - 0.03 * bez / 12
        netto_pers = n_bezold - pb
        return pb, netto_pers
    elif n_bezold <= 24480 / 12:
        pb = 13870 / 12 * 0.25 \
             + (n_bezold - 13870 / 12) * 0.40 \
             - 0.03 * bez / 12
        netto_pers = n_bezold - pb
        return pb, netto_pers
    elif n_bezold <= 42370 / 12:
        pb = 13870 / 12 * 0.25 \
             + (24480 - 13870) / 12 * 0.4 \
             + (n_bezold - 24480 / 12) * 0.45 \
             - 0.03 * bez / 12
        netto_pers = n_bezold - pb
        return pb, netto_pers
    else:
        pb = 13870 / 12 * 0.25 \
             + (24480 - 13870) / 12 * 0.4 \
             + (42370 - 24480) / 12 * 0.45 \
             + (n_bezold - 42370 / 12) * 0.50 \
             - 0.03 * bez / 12
        netto_pers = n_bezold - pb
        return pb, netto_pers


def vennootschapsbelasting(omzet_min_pers_kost):
    if (omzet_min_pers_kost > 0):
        belastingen = omzet_min_pers_kost * 0.25
        winst_na_belastingen = omzet_min_pers_kost - belastingen
        return belastingen, winst_na_belastingen
    else:
        return 0, 0


def vvpr_bis_uitkering(netto_ven):
    # Assumption: Corporation exists for at least three tax years
    if (netto_ven > 0):
        rv = netto_ven * 0.15
        dividend = netto_ven - rv
        return rv, dividend
    else:
        return 0, 0


def start(facturatie, bez):
    forfait_kosten = forf_kost(facturatie)
    pers_kost, omzet_min_pers_kost = min_bez(forfait_kosten, bez)
    sb, n_bezold = soc_bijd_ink(pers_kost)
    pb, netto_pers = personenbelasting(n_bezold, bez)
    venb, netto_ven = vennootschapsbelasting(omzet_min_pers_kost)
    rv, dividend = vvpr_bis_uitkering(netto_ven)

    writer.writerow([facturatie, round(forfait_kosten, 2), round(sb, 2),
                     round(pb, 2), round(venb, 2), round(rv, 2),
                     round(sb + pb + venb + rv, 2),
                     round((sb + pb + venb + rv) / facturatie, 4)])


if __name__ == '__main__':
    with open('file.csv', 'w', newline='') as file:
        writer = csv.writer(file, delimiter=';')
        writer.writerow(['omzet_ven', 'omzet_ven_min_kosten', 'soc_bijd',
                         'pb', 'venb', 'rv_vvpr_bis',
                         'totale_bel_rsz', 'bel_druk'])
        for i in range(3000, 10001):
            start(facturatie=i, bez=70000)
