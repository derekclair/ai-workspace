"""Smoke tests for the RiskEngine.

These verify the engine is importable and its main entry point returns a
well-formed result, which doubles as a quick check that the development
environment is set up correctly.
"""

from risk.engine import RiskEngine, RiskValidationResult


def test_validate_trade_returns_result():
    engine = RiskEngine()
    result = engine.validate_trade({}, {}, {})

    assert isinstance(result, RiskValidationResult)
    # Placeholder implementation rejects (size 0) until full logic lands.
    assert result.approved_size == 0.0
    assert result.audit_record["engine_version"] == "0.1"


def test_default_config_has_required_limits():
    engine = RiskEngine()

    for key in (
        "target_portfolio_vol",
        "kelly_fraction",
        "max_position_pct",
        "daily_loss_limit_pct",
        "trailing_dd_stop_pct",
        "min_liquidity_multiple",
        "leverage_cap",
    ):
        assert key in engine.config
