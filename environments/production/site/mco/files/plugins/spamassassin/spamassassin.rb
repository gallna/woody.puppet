module MCollective
    module Agent
        class Spamassassin<RPC::Agent
            metadata    :name        => "SimpleRPC Agent For Spam Assassin Management",
                        :description => "Agent To Manage Spam Assassin",
                        :author      => "Mark Stanislav",
                        :license     => "GPLv2",
                        :version     => "1.3",
                        :url         => "https://github.com/mstanislav/mCollective-Agents",
                        :timeout     => 90

            def startup_hook
                @compiled_ruleset = @config.pluginconf["spamassassin.compiled_ruleset"] || "/var/lib/spamassassin/compiled/5.008/3.002005/bases_body_0.pl"
            end

            def status_action
                reply.data = %x[`/usr/bin/which service` spamassassin status > /dev/null 2>&1 && echo RUNNING || echo STOPPED].chomp
                if File.exists?(@compiled_ruleset)
                     reply.data += ", COMPILED RULESET " + File.mtime(@compiled_ruleset).to_s.upcase
                end
            end

            def lint_action
                reply.data = %x[OUTPUT=\"\$(spamassassin --lint 2>&1 | grep detected | awk '{ print \$4 }')\"; if [ \$OUTPUT ]; then echo \"\$OUTPUT SYNTAX ERRORS\"; else echo 'SYNTAX OK'; fi].chomp
            end

            def update_action
                reply.data = %x[/usr/bin/sa-update && echo 'UPDATES RETRIEVED' || echo 'NO UPDATES FOUND'].chomp
            end

            def compile_action
                reply.data = %x[/usr/bin/sa-compile > /dev/null 2>&1 && echo OK || echo FAILED].chomp
            end

            def restart_action
                reply.data = %x[`/usr/bin/which service` spamassassin restart > /dev/null 2>&1 && echo OK || echo FAILED].chomp
            end

            def full_action
                result_1 = update_action
                result_2 = compile_action
                result_3 = restart_action

                reply.data = result_1 + ", COMPILATION " + result_2 + ", RESTART " + result_3
            end
        end
    end
end
