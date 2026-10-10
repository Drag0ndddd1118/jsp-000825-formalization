import Challenge
import ErdosProblems.Erdos992

open Set Filter MeasureTheory
open JSP000825

/-- Top-level bridge theorem proving JSP-000825 / Erdős Problem #992. -/
theorem jsp_000825_solved : jsp000825Statement := by
  change ∃ x : ℕ → ℤ, StrictMono x ∧
    ∃ c : ℝ, 0 < c ∧
      ∀ᵐ α : ℝ ∂volume, α ∈ Icc 0 1 →
        ∃ᶠ N : ℕ in atTop,
          c * Real.sqrt ((N : ℝ) * Real.log N) ≤
            Erdos992.intervalDiscrepancy x α N
  exact Erdos992.not_erdos_992
