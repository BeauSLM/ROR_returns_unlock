#import "Compiler";
#import "Basic";

#run {
    w := compiler_create_workspace();

    options := get_build_options();

    options.output_executable_name = "ror_unlocks";
    options.output_path = "./out/";

    // TODO: why just why
    import_path: [..] string;
    array_add(*import_path, .. options.import_path);
    array_add(*import_path, "./modules");

    options.import_path = import_path;

    set_build_options(options, w);

    add_build_file( "main.jai", w );

    set_build_options_dc( .{ do_output=false } );
};

