# dump_objects.py — enumerate all PyMOL objects in a session
from pymol import cmd
from collections import Counter
import csv, math

def _q(name: str) -> str:
    return f'`{name}`'  # quote names so hyphens/spaces are safe

def dump_objects(csv_path=None, verbose=1):
    """
    List all objects with their PyMOL type (cgo, selection, measure, molecule, ...).
    For measurement objects, also report endpoints and distance.
    Usage in PyMOL:
      run /full/path/dump_objects.py
      load /full/path/session.pse
      dump_objects /full/path/objects.csv
    """
    # So selector errors from odd names don't spam the console
    cmd.feedback('disable', 'selector', 'errors')

    names = cmd.get_names('all')
    rows = []
    counts = Counter()

    for n in names:
        t = cmd.get_type(n) or ''
        counts[t] += 1

        rec = {"name": n, "type": t, "atom1": "", "resn1": "", "atom2": "", "resn2": "", "distance_A": ""}

        if t.startswith('object:measure'):
            try:
                m = cmd.get_model(_q(n))
                if len(m.atom) >= 2:
                    a1, a2 = m.atom[0], m.atom[1]
                    try:
                        d = round(math.dist(a1.coord, a2.coord), 3)
                    except Exception:
                        d = ""
                    rec.update({
                        "atom1": f"{a1.chain}/{a1.resi}/{a1.name}",
                        "resn1": a1.resn,
                        "atom2": f"{a2.chain}/{a2.resi}/{a2.name}",
                        "resn2": a2.resn,
                        "distance_A": d,
                    })
            except Exception:
                pass

        rows.append(rec)

    # Print summary
    total = sum(counts.values())
    print(f"Total objects: {total}")
    for k in sorted(counts):
        print(f"{k:>18}: {counts[k]}")

    if verbose:
        meas = [r for r in rows if r["type"].startswith('object:measure')]
        if meas:
            print("\nMeasurement objects:")
            for r in meas:
                print(f"{r['name']:>28}  {str(r['distance_A']):>6} Å  {r['atom1']} -- {r['atom2']}")
        else:
            print("\nNo measurement objects found (contacts likely stored as CGO/selection objects).")

    if csv_path:
        with open(csv_path, "w", newline="") as fh:
            w = csv.DictWriter(fh, fieldnames=list(rows[0].keys()))
            w.writeheader(); w.writerows(rows)
        print("Wrote", csv_path)

    # Re-enable selector feedback
    cmd.feedback('enable', 'selector', 'errors')

cmd.extend("dump_objects", dump_objects)