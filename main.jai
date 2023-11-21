// TODO: command line arg to run tests?
RUN_TEST :: false;

main :: () {
    save_json: Save_Json = ---;
    unlock_json: Unlock_Json = ---;

    // backup `save.json`
    if !copy_file(SAVE_FILE, BACKUP_FILE) {
        print("Failed to backup save.json - aborting\n");
        exit(1);
    }

    save_json = attempt_parse_json(SAVE_FILE, Save_Json);

    unlock_json = attempt_parse_json(BACKUP_FILE, Unlock_Json);

    flag_set: Table(string, void);
    init(*flag_set, save_json.flags.count * 2); // XXX: could use ensure_space but we're dealing with <10k items so its probably fine?

    for save_json.flags {
        add_to_set(*flag_set, it);
    }
    for unlock_json.flags {
        add_to_set(*flag_set, it);
    }

    new_save_flags: [..]string;
    for flag_set { array_add(*new_save_flags, it_index); }

    save_json.flags = new_save_flags;

    // uncomment to test that we didn't miss any flags - assertion will fail if we did
    #if RUN_TEST {
        print("Testing flag adding\n");
        for unlocked_flag: unlock_json.flags {
            worked := false;
            for saved_flag: save_json.flags {
                if saved_flag != unlocked_flag continue;
                worked = true;
                break;
            }
            assert(worked);
        }
    }

    json_write_file(SAVE_FILE, save_json);
}

// TODO: name better
Save_Json :: struct {
    flags:             []string;

    // other values, we're preserving them without change
    challenge:         *JSON_Value;
    last_stage_id:      string;
    loadout_choice:    *JSON_Value;
    lobby_settings:    *JSON_Value;
    lobby_votes:       *JSON_Value;
    lobby_votes_multi: *JSON_Value;
    mod_data_string:    string;
    run_history:        string;
    stats:             *JSON_Value;
    survivor_choice:    string;
    trial:             *JSON_Value;
};

// TODO: name better
Unlock_Json :: struct {
    flags: []string;
};

add_to_set :: (set: *Table(string, void), value: string) {
    wtf: void;
    table_set(set, value, wtf);
}

attempt_parse_json :: (filename: string, $T: Type) -> T {
    success, file := json_parse_file(filename, T);

    if !success {
        print("Failed to parse JSON file\n");
        exit(1);
    }

    return file;
}

SAVE_FILE :: "save.json";
BACKUP_FILE :: "save_old.json";
UNLOCKS_FILE :: "unlocked.json";

#import "jaison";
#import "Basic";
#import "Hash_Table";
#import "File_Utilities";
