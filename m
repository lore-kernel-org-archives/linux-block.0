Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:62316 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbeDXVkj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Apr 2018 17:40:39 -0400
From: Keith Busch <keith.busch@intel.com>
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH blktests] Add surprise removal block test
Date: Tue, 24 Apr 2018 15:41:46 -0600
Message-Id: <20180424214146.31168-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 common/rc       | 17 +++++++++++++++++
 tests/block/016 | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100755 tests/block/016

diff --git a/common/rc b/common/rc
index 1bd0374..979c8c2 100644
--- a/common/rc
+++ b/common/rc
@@ -171,6 +171,23 @@ _get_pci_dev_from_blkdev() {
 		tail -1
 }
 
+_get_pci_parent_from_blkdev() {
+	readlink -f "$TEST_DEV_SYSFS/device" | \
+		grep -Eo '[0-9a-f]{4,5}:[0-9a-f]{2}:[0-9a-f]{2}\.[0-9a-f]' | \
+		tail -2 | head -1
+}
+
+_test_hotplug_slot() {
+	parent="$(_get_pci_parent_from_blkdev)"
+
+	slt_cap=$(setpci -s ${parent} CAP_EXP+14.w)
+	if [ $((0x${slt_cap} & 0x20)) -eq 0 ]; then
+		SKIP_REASON="$TEST_DEV is not in a hot pluggable slot"
+		return 1
+	fi
+	return 0
+}
+
 # Older versions of xfs_io use pwrite64 and such, so the error messages won't
 # match current versions of xfs_io. See c52086226bc6 ("filter: xfs_io output
 # has dropped "64" from error messages") in xfstests.
diff --git a/tests/block/016 b/tests/block/016
new file mode 100755
index 0000000..4c2e294
--- /dev/null
+++ b/tests/block/016
@@ -0,0 +1,52 @@
+#!/bin/bash
+#
+# Do disable PCI device while doing I/O to it
+#
+# Copyright (C) 2018 Keith Busch <keith.busch@intel.com>
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
+DESCRIPTION="break PCI link while doing I/O"
+TIMED=1
+
+requires() {
+	_have_fio
+}
+
+device_requires() {
+	_test_dev_is_pci
+	_test_hotplug_slot
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	parent="$(_get_pci_parent_from_blkdev)"
+
+	if _test_dev_is_rotational; then
+		size="32m"
+	else
+		size="1g"
+	fi
+
+	# start fio job
+	_run_fio_rand_io --filename="$TEST_DEV" --size="$size" \
+			--ignore_error=EIO,ENXIO,ENODEV &
+
+	setpci -s ${parent} CAP_EXP+10.w=10:10
+	sleep 10
+	setpci -s ${parent} CAP_EXP+10.w=00:10
+
+	echo "Test complete"
+}
-- 
2.14.3
