# Lean 4 Formalization of JSP-000825 (Erdős Problem #992)

This repository provides a standalone, reproducible Lean 4 verification package for **JSP-000825** (Erdős Problem #992).

## Mathematical Overview

- **Problem Statement**: For typical irrational scale factors, what is the discrepancy of fractional parts of a scaled integer sequence?
- **Mathematical Resolution**: István Berkes & Walter Philipp (1994) [BePh94], building on earlier work by Paul Erdős & J. F. Koksma (1949) [ErKo49], J. W. S. Cassels (1950) [Ca50], and R. C. Baker (1981) [Ba81].
- **Result Details**: Erdős asked whether for every strictly increasing sequence of integers $x_n$, the unnormalised discrepancy $D_N(\alpha)$ of the fractional parts $\{\alpha x_n : 1 \le n \le N\}$ satisfies $D_N(\alpha) = O(\sqrt{N \log \log N})$ for almost all $\alpha$, or at least $D_N(\alpha) = o(\sqrt{N \log N})$ almost everywhere. Berkes and Philipp (1994) answered both questions in the negative by proving that there exists a strictly increasing sequence of integers $x_n$ and an absolute constant $c > 0$ such that for Lebesgue-almost every $\alpha \in [0, 1]$,
  $$\limsup_{N \to \infty} \frac{D_N(\alpha)}{\sqrt{N \log N}} \ge c.$$
- **Formalization Authors**: Codex and GPT-5.6 Sol (upstream formalization in `plby/lean-proofs`).
- **Packaging & Verification**: Qin Zhao (`@Drag0ndddd1118`).

## Contract and Verification Architecture

- **`Challenge.lean`**: Defines the contract statement:
  ```lean
  def jsp00825Statement : Prop :=
    ∃ x : ℕ → ℤ, StrictMono x ∧
      ∃ c : ℝ, 0 < c ∧
        ∀ᵐ α : ℝ ∂volume, α ∈ Icc 0 1 →
          ∃ᶠ N : ℕ in atTop,
            c * Real.sqrt ((N : ℝ) * Real.log N) ≤
              intervalDiscrepancy x α N
  ```
- **`Submission.lean`**: Formal resolution bridging to `Erdos992.not_erdos_992`:
  ```lean
  theorem jsp_000825_solved : jsp00825Statement := by
    change ∃ x : ℕ → ℤ, StrictMono x ∧
      ∃ c : ℝ, 0 < c ∧
        ∀ᵐ α : ℝ ∂volume, α ∈ Icc 0 1 →
          ∃ᶠ N : ℕ in atTop,
            c * Real.sqrt ((N : ℝ) * Real.log N) ≤
              Erdos992.intervalDiscrepancy x α N
    exact Erdos992.not_erdos_992
  ```
- **`check.py`**: Automated mechanical verification ensuring:
  1. Complete clean build via `lake build`;
  2. Zero `sorry`, `admit`, `axiom`, `opaque`, `unsafe`, `partial`, or `native_decide`;
  3. Exact bridge typecheck: `example : jsp00825Statement := jsp_000825_solved`;
  4. Standard foundational axioms only: `[propext, Classical.choice, Quot.sound]`.

## Axiom Verification

`#print axioms jsp_000825_solved` relies strictly on standard Lean foundational axioms:
- `propext`
- `Classical.choice`
- `Quot.sound`

Zero `sorry`, zero `admit`, zero custom unproved axioms.

## Building and Verifying

Requires `elan` and Lean `v4.34.0`:

```bash
lake exe cache get
lake build
python3 check.py
```

## License

This project is licensed under the Apache License 2.0. See [LICENSE](LICENSE) for details.
