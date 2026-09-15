#ifndef GDEX_TOML_2_UTILS_H
#define GDEX_TOML_2_UTILS_H
#include <string>

using namespace godot;

inline std::string to_std_string(const String &p_string) {
    return p_string.utf8().get_data();
}

inline String to_gd_string(const std::string &p_val) {
    return {p_val.c_str()};
}

inline String to_gd_string(const std::string_view &p_val) {
    const auto s = std::string(p_val);
    return {s.c_str()};
}

#endif //GDEX_TOML_2_UTILS_H
