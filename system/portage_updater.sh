#!/usr/bin/env bash

set -u

function write_mail {
  cat ${log} | mailx -s 'tpad weekly system update' user@server.com
}

log=/var/log/portage_updater.log
rm ${log}
touch ${log}

ping ya.ru -c 1 -W 3 &> /dev/null
ping_status=$?

echo 'Ping status: '${ping_status} | tee -a ${log}
if [ ${ping_status} -ne 0 ]; then
  exit 1
fi

eix-sync 2>&1 | tee -a ${log}
layman -S 2>&1 | tee -a ${log}

echo '=== systemd emerge === ' | tee -a ${log}
sudo emerge --update --deep --newuse --tree --quiet \
            sys-apps/systemd 2>&1 | tee -a ${log}

echo '=== world emerge === ' | tee -a ${log}
sudo emerge --update --deep --newuse --tree --quiet \
            @world 2>&1 | tee -a ${log}

if [ $? -eq 0 ]; then
  echo '=== @preserved-rebuild === ' | tee -a ${log}
  emerge --quiet @preserved-rebuild 2>&1 | tee -a ${log}

  echo '=== revdep-rebuild === ' | tee -a ${log}
  revdep-rebuild -v 2>&1 | tee -a ${log}
  
  perl-cleaner --all 2>&1 | tee -a ${log}
  echo '=== depclean === ' | tee -a ${log}
  emerge --depclean --quiet 2>&1 | tee -a ${log}
  glsa-check -t all 2>&1 | tee -a ${log}
  glsa-check -f all 2>&1 | tee -a ${log}
  eclean-dist -d

  echo '=== eix-test-obsolete === ' | tee -a ${log}
  eix-test-obsolete
else
  echo 'emerge failed, skip post-emerge steps' | tee -a ${log}
fi

echo '=== finish === ' | tee -a ${log}
write_mail
