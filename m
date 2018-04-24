Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750919AbeDXQRQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Apr 2018 12:17:16 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH blktests 3/3] nvme: add a regression test for UUID ns descriptops
Date: Tue, 24 Apr 2018 10:12:51 -0600
Message-Id: <20180424161251.6502-3-jthumshirn@suse.de>
In-Reply-To: <20180424161251.6502-1-jthumshirn@suse.de>
References: <20180424161251.6502-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add a regression test for NVMe 1.3's UUID Namespace Descriptors.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 tests/nvme/004     | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/004.out |  4 +++
 2 files changed, 78 insertions(+)
 create mode 100755 tests/nvme/004
 create mode 100644 tests/nvme/004.out

diff --git a/tests/nvme/004 b/tests/nvme/004
new file mode 100755
index 000000000000..cc1c3fd41b25
--- /dev/null
+++ b/tests/nvme/004
@@ -0,0 +1,74 @@
+#!/bin/bash
+#
+# Regression test for commits d934f9848a77 ("nvme: provide UUID value to
+# userspace") and 6484f5d16f9d ("nvme: also provide a UUID in the WWID sysfs
+# attribute")
+#
+# Copyright (C) 2018 Johannes Thumshirn
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
+# TODO: fill in a very brief description of what this test does. The
+# description should complete the sentence "This test will...". For example,
+# "run a mixed read/write workload" would be a good description.
+DESCRIPTION="Test nvme and nvmet UUID NS descriptors"
+
+QUICK=1
+
+requires() {
+	_have_program nvme && _have_module nvme-loop && _have_module loop \
+	    && _have_configfs
+}
+
+_find_nvme_loop_dev() {
+	for dev in /sys/block/nvme*; do
+		dev="$(basename $dev)"
+		transport="$(cat /sys/block/${dev}/device/transport)"
+		if [[ "$transport" == "loop" ]]; then
+			echo "$dev"
+		fi
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	modprobe nvmet
+	modprobe nvme-loop
+
+	local port
+	port="$(_create_nvmet_port "loop")"
+
+	truncate -s 1G "$TMPDIR/img"
+
+	local loop_dev
+	loop_dev="$(losetup -f --show "$TMPDIR/img")"
+
+	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}" "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
+
+	nvme connect -t loop -n blktests-subsystem-1
+
+	local nvmedev="$(_find_nvme_loop_dev)"
+	cat /sys/block/${nvmedev}/uuid
+	cat /sys/block/${nvmedev}/wwid
+
+	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
+	_remove_nvmet_subsystem "blktests-subsystem-1"
+	_remove_nvmet_port "${port}"
+	losetup -d "$loop_dev"
+	rm "$TMPDIR/img"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/004.out b/tests/nvme/004.out
new file mode 100644
index 000000000000..53f911ecf329
--- /dev/null
+++ b/tests/nvme/004.out
@@ -0,0 +1,4 @@
+Running nvme/004
+91fdba0d-f87b-4c25-b80f-db7be1418b9e
+uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
+Test complete
-- 
2.16.3
