#include "toml_reader.h"
#include <toml.hpp>
#include <godot_cpp/core/class_db.hpp>
#include "utils.h"

using namespace godot;

void TomlReader::log(const String &msg, const Array &args) const {
    if (enable_logging) {
        UtilityFunctions::print(msg.format(args));
    }
}

void TomlReader::_bind_methods() {
    ClassDB::bind_method(D_METHOD("set_logging", "val"), &TomlReader::set_logging);
    ClassDB::bind_method(D_METHOD("try_parse", "contents"), &TomlReader::try_parse);
    ClassDB::bind_method(D_METHOD("done"), &TomlReader::done);
    ClassDB::bind_method(D_METHOD("get_last_error"), &TomlReader::get_last_error);
}

TomlReader::TomlReader() {
    last_error = {};
}

TomlReader::~TomlReader() {
}

void TomlReader::set_logging(const bool val) {
    enable_logging = val;
}

bool TomlReader::try_parse(const String &contents) {
    if (t) {
        t.reset();
    }

    toml::parse_result result = toml::parse(to_std_string(contents));
    if (!result) {
        last_error = result.error().description();
        log("[INFO] TomlReader : Failed to parse contents as TOML. Error: {0}", {
            to_gd_string(result.error().description())}
            );
        return false;
    }

    t = std::make_unique<toml::table>(result.table());
    return true;
}

String TomlReader::get_last_error() const {
    return to_gd_string(last_error);
}

void TomlReader::done() {
    if (t) {
        t.reset();
    }
}
