Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731548AbeGQOEK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jul 2018 10:04:10 -0400
From: Hannes Reinecke <hare@suse.de>
To: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 2/2] blktests: add test for ANA state transition
Date: Tue, 17 Jul 2018 15:31:18 +0200
Message-Id: <20180717133118.39026-3-hare@suse.de>
In-Reply-To: <20180717133118.39026-1-hare@suse.de>
References: <20180717133118.39026-1-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 tests/nvme/014     | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/014.out |  17 ++++++
 2 files changed, 175 insertions(+)
 create mode 100755 tests/nvme/014
 create mode 100644 tests/nvme/014.out

diff --git a/tests/nvme/014 b/tests/nvme/014
new file mode 100755
index 0000000..4b57229
--- /dev/null
+++ b/tests/nvme/014
@@ -0,0 +1,158 @@
+#!/bin/bash
+#
+# Regression test for ANA base support
+#
+# Copyright (C) 2018 Hannes Reinecke
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 3 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+. tests/nvme/rc
+
+DESCRIPTION="test ANA optimized/transitioning/inaccessible support"
+QUICK=1
+
+switch_nvmet_anagroup() {
+	local port1="$1"
+	local port2="$2"
+	local mode="$3"
+
+	echo "ANA state ${mode}"
+
+	if [ "${mode}" = "change" ] ; then
+		_set_nvmet_anagroup_state "${port1}" "1" "change"
+		_set_nvmet_anagroup_state "${port1}" "2" "change"
+		_set_nvmet_anagroup_state "${port2}" "1" "change"
+		_set_nvmet_anagroup_state "${port2}" "2" "change"
+	elif [ "${mode}" = "failover" ] ; then
+		_set_nvmet_anagroup_state "${port1}" "1" "inaccessible"
+		_set_nvmet_anagroup_state "${port1}" "2" "optimized"
+		_set_nvmet_anagroup_state "${port2}" "1" "optimized"
+		_set_nvmet_anagroup_state "${port2}" "2" "inaccessible"
+	else
+		_set_nvmet_anagroup_state "${port1}" "1" "optimized"
+		_set_nvmet_anagroup_state "${port1}" "2" "inaccessible"
+		_set_nvmet_anagroup_state "${port2}" "1" "inaccessible"
+		_set_nvmet_anagroup_state "${port2}" "2" "optimized"
+	fi
+}
+
+_display_ana_state() {
+	local grpid state
+	for nvme in /sys/class/nvme/* ; do
+		for c in ${nvme}/nvme* ; do
+			if [ ! -d ${c} ] ; then
+				echo "${nvme##*/}: ANA disabled"
+				continue
+			fi
+			grpid="$(cat "${c}/ana_grpid")"
+			state="$(cat "${c}/ana_state")"
+			echo "${c##*/}: grpid ${grpid} state ${state}"
+		done
+	done
+}
+
+_switch_ana_states() {
+	local port1=$1
+	local port2=$2
+
+}
+
+requires() {
+	_have_program nvme && _have_module nvme-loop && _have_module loop && \
+		_have_configfs && _have_fio
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	modprobe nvmet
+	modprobe nvme-loop
+
+	local port1
+	port1="$(_create_nvmet_port "loop")"
+	ag1="$(_create_nvmet_anagroup "${port1}")"
+
+	local port2
+	port2="$(_create_nvmet_port "loop")"
+	ag2="$(_create_nvmet_anagroup "${port2}")"
+
+	truncate -s 1G "$TMPDIR/img1"
+
+	local loop_dev1
+	loop_dev1="$(losetup -f --show "$TMPDIR/img1")"
+
+	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev1}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" "1"
+
+	truncate -s 1G "$TMPDIR/img2"
+
+	local loop_dev2
+	loop_dev2="$(losetup -f --show "$TMPDIR/img2")"
+
+	_create_nvmet_ns "blktests-subsystem-1" "2" "${loop_dev2}" \
+		"9aed0138-bfd9-46f5-92ac-24c70377fd49" "2"
+
+	_add_nvmet_subsys_to_port "${port1}" "blktests-subsystem-1"
+	_add_nvmet_subsys_to_port "${port2}" "blktests-subsystem-1"
+
+	switch_nvmet_anagroup "${port1}" "${port2}" failback
+
+	nvme connect -t loop -a "${port1}" -n blktests-subsystem-1
+	nvme connect -t loop -a "${port2}" -n blktests-subsystem-1
+
+	_display_ana_state
+
+	_run_fio_rand_io --size=256m --filename="/dev/nvme0n1" &
+	trap "kill $!" EXIT
+
+	sleep 10
+
+	switch_nvmet_anagroup "${port1}" "${port2}" "change"
+
+	# Insert a delay to allow the AEN to be processed
+	sleep 1
+
+	_display_ana_state
+
+	sleep 6
+
+	switch_nvmet_anagroup "${port1}" "${port2}" "failover"
+
+	# Insert a delay to allow the AEN to be processed
+	sleep 1
+
+	_display_ana_state
+
+	wait
+	trap - EXIT
+
+	nvme disconnect -n blktests-subsystem-1
+
+	_remove_nvmet_subsystem_from_port "${port1}" "blktests-subsystem-1"
+	_remove_nvmet_subsystem_from_port "${port2}" "blktests-subsystem-1"
+	_remove_nvmet_ns "blktests-subsystem-1" "2"
+	_remove_nvmet_subsystem "blktests-subsystem-1"
+	_remove_nvmet_anagroup "${port1}" "2"
+	_remove_nvmet_port "${port1}"
+	_remove_nvmet_anagroup "${port2}" "2"
+	_remove_nvmet_port "${port2}"
+	losetup -d "$loop_dev2"
+	rm "$TMPDIR/img2"
+	losetup -d "$loop_dev1"
+	rm "$TMPDIR/img1"
+
+	modprobe -r nvme-loop
+	modprobe -r nvmet
+	echo "Test complete"
+}
diff --git a/tests/nvme/014.out b/tests/nvme/014.out
new file mode 100644
index 0000000..0a6ed35
--- /dev/null
+++ b/tests/nvme/014.out
@@ -0,0 +1,17 @@
+Running nvme/016
+nvme0c1n1: grpid 1 state optimized
+nvme0c1n2: grpid 2 state inaccessible
+nvme0c2n1: grpid 1 state inaccessible
+nvme0c2n2: grpid 2 state optimized
+ANA state transition
+nvme0c1n1: grpid 1 state change
+nvme0c1n2: grpid 2 state change
+nvme0c2n1: grpid 1 state change
+nvme0c2n2: grpid 2 state change
+ANA state failover
+nvme0c1n1: grpid 1 state inaccessible
+nvme0c1n2: grpid 2 state optimized
+nvme0c2n1: grpid 1 state optimized
+nvme0c2n2: grpid 2 state inaccessible
+NQN:blktests-subsystem-1 disconnected 2 controller(s)
+Test complete
-- 
2.12.3
