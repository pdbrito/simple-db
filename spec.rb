describe 'database' do
    def run_script(commands)
        raw_output = nil
        IO.popen("./cmake-build-debug/simpledb", "r+") do |pipe|
            commands.each do |command|
                pipe.puts command
            end

            pipe.close_write

            raw_output = pipe.gets(nil)
        end
        raw_output.split("\n")
    end

    it 'inserts and selects a row' do
        result = run_script([
            "insert 1 user user@example.com",
            "select",
            ".exit",
        ])
        expect(result).to match_array([
            "db > Executed.",
            "db > (1, user, user@example.com)",
            "Executed.",
            "db > ",
        ])
    end
end
