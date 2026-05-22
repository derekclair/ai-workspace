# RiskEngine.spec.md

**Version**: 0.1 | **Status**: Draft for Implementation | **Related Diagrams**: Risk & Position Sizing Logic, Autonomous Trading Logic Flow, Guardrails

> Single source of truth for the production-grade, code-enforced risk layer that **every** proposed trade (from quantbot, polymarket-arbitrager3000, or autonomous-trading-bot) must pass before any capital is at risk.

## Purpose

Prevent ruin. Enforce consistent, auditable, portfolio-aware position sizing and hard safety gates. This engine is deliberately **not** overridable by LLM prompts or agent reasoning — it is hard code + configuration.

## Inputs

- `portfolio_state`: Current positions, unrealized/realized P&L, current realized portfolio vol, correlation matrix snapshot
- `proposed_trade`: market/contract identifier, side, estimated edge, model probability, expected resolution probability, liquidity estimate
- `market_data`: current market price/probability, order book depth, historical volatility, time to resolution
- `config`: target_portfolio_vol, max_position_pct, daily_loss_limit, trailing_dd_stop, min_liquidity_multiple, kelly_fraction (0.25–0.5), etc.

## Outputs

- `approved_size`: float (0 if rejected)
- `rationale`: structured dict or Markdown explaining the decision, calculations, and any adjustments
- `audit_record`: immutable log entry (timestamp, all inputs, calculations, decision, version of engine + config)

## Core Modules

### 1. Volatility Targeting
- Calculate current realized volatility (EWMA with λ=0.94 recommended, or ATR-based with the 0.875 conversion factor)
- `position_scalar = target_portfolio_vol / current_realized_vol`
- Apply global leverage cap (e.g., 2–3× equivalent)
- Smooth transitions; avoid jumping from 0× to 5× overnight

### 2. Edge-Adjusted Fractional Kelly
- `edge = abs(model_prob - market_prob) - fees - resolution_risk_penalty`
- Classic Kelly: `f = (b * p - q) / b` where p = win probability, q = 1-p, b = net odds
- Use fractional Kelly (`kelly_fraction * f`) for robustness in uncertain prediction markets
- Further reduce for portfolio correlation/heat (theme concentration penalty)

### 3. Hard Limits & Circuit Breakers (Non-Overridable)
Must all pass or size → 0 and human escalation:
- Per-position / per-event-cluster max % of current bankroll
- Daily loss limit (absolute or %)
- Trailing peak-to-trough drawdown stop
- Liquidity check: proposed size must be fillable within X% of current depth without excessive slippage
- Agent confidence / uncertainty quantification gate (if agent-provided)
- Regime detection (e.g., abnormally high vol spike → tighter limits)

### 4. Portfolio-Aware Adjustment
- Query current open positions and correlation matrix
- Apply concentration penalty if proposed trade is highly correlated with existing exposure
- Optional: covariance-based portfolio optimization hint (reduce size or suggest offsetting trade)

### 5. Audit & Explainability
- Every decision produces a structured, queryable, exportable record
- Must be sufficient for tax reporting, regulatory review, and post-mortem analysis
- Include expected vs. actual outcome fields for later labeling/improvement

## Acceptance Criteria (for v0.1)

- [ ] All unit tests pass for math (vol targeting, Kelly, correlation adjustments)
- [ ] Integration test: proposed trade rejected when any hard limit is breached
- [ ] Integration test: size correctly scaled by volatility targeting + Kelly
- [ ] Audit log is written on every call (even rejections)
- [ ] Performance: validation completes in < 50 ms (target)
- [ ] Clear human-readable rejection messages
- [ ] Config-driven (limits and fractions changeable without code change)
- [ ] Callable both from normal Python code and as an agent tool

## Implementation Guidance

- Pure functions + dependency injection for config and portfolio state → highly testable
- Start in `src/risk/engine.py`
- Use the existing Postgres + Alembic pattern from silverback-market-observer for the audit log table if persistence is needed early
- Consider making the engine stateless where possible (config + current state passed in)
- Add feature flags / kill switch at the top level

## Open Questions for This Spec

- How aggressive should the correlation/heat penalty be for highly correlated political events?
- Should there be a “shadow mode” that logs what the engine *would* have done without enforcing it (useful during transition)?
- Exact data model for the audit log (fields, retention, export format for taxes)?

---

**Next**: Implement the engine, then wire it into the Autonomous Trading Logic Flow (Diagram 2) as the mandatory gate before any `Execute` step.
