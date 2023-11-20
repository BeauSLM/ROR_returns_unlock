main :: () {
    success: bool = ---;
    save_json: Save_Json = ---;
    unlock_json: Unlock_Json = ---;

    save_json = attempt_parse_json("save.json", Save_Json);

    unlock_json = attempt_parse_json("unlocked.json", Unlock_Json);

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
    assert(test_flag_adding(save_json, unlock_json));

    json_write_file("save_new.json", save_json);
}

// checks that all the flags in unlock_json are in save_json
test_flag_adding :: ( save_json: Save_Json, unlock_json: Unlock_Json ) -> bool {
    for unlocked_flag: unlock_json.flags {
        worked := false;
        for saved_flag: save_json.flags {
            if compare(saved_flag, unlocked_flag) continue;
            worked = true;
            break;
        }
        if !worked { return false; }
    }

    return true;
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

#import "jaison";
#import "Basic";
#import "Hash_Table";
#import "String";
