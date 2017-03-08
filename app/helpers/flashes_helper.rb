module FlashesHelper

  FLASH_CLASSED = { alert: "danger", notice: "success", warning: "warning"}.freeze

  def flash_key(key)
    FLASH_CLASSED.fetch key.to_sym, key
  end

  def user_facing_flashes
    flash.to_hash.slice "alert", "notice", "warning"
  end

end
