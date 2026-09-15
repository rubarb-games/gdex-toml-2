#ifndef GDEX_TOML_2_TOML_READER_H
#define GDEX_TOML_2_TOML_READER_H

#define TOML_EXCEPTIONS 0
#include <godot_cpp/classes/ref_counted.hpp>
#include <toml.hpp>

using namespace godot;

class TomlReader : public RefCounted {
    GDCLASS(TomlReader, RefCounted);

private:
    std::string last_error;
    bool enable_logging = false;
    std::unique_ptr<toml::table> t;

    void log(const String &msg, const Array &args = {}) const;

protected:
    static void _bind_methods();

public:
    TomlReader();
    ~TomlReader();

    void   set_logging(bool val);
    bool   try_parse(const String &contents);
    String get_last_error() const;
    void   done();
};

#endif //GDEX_TOML_2_TOML_READER_H
