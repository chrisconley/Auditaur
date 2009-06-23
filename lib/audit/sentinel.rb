class Sentinel
  VAR_START_CHAR = /[a-zA-Z_\$]/
  VAR_CHAR = /[a-zA-Z_]/
  STRING = /"[^"\r\n]*"|'[^"\r\n]*'/
  INTERPOLATED_VAR = /(\".*\#\{.*\")/
  CONCATENATED_VAR = /(#{STRING})\s*\+\s*#{VAR_START_CHAR}|#{VAR_START_CHAR}[^\s\+]\s*\+\s*(#{STRING})/
  
  def self.sql_injection
    /#{hash_key(:conditions)}\[?(#{INTERPOLATED_VAR}|#{CONCATENATED_VAR}|#{VAR_START_CHAR})/
  end
  
  def self.method_call(method_name, options = {})
    option_regex = options[:with].blank? ? '' : hash_key(options[:with])
    /#{method_name.to_s}\b.*#{option_regex}/
  end
  
  def self.hash_key(key)
    /#{key.to_s}\"?\s*=>\s*/
  end
end