Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58047 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034179AbeBPOVQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Feb 2018 09:21:16 -0500
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH blktests] tests/nvme: add NVMe test group and tracepoint test
Date: Fri, 16 Feb 2018 15:21:04 +0100
Message-Id: <20180216142104.25756-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add a NVMe test group and a tracepoint test as the first test case.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 common/nvme        | 28 +++++++++++++++++++++++
 tests/nvme/001     | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/001.out | 12 ++++++++++
 tests/nvme/group   | 28 +++++++++++++++++++++++
 4 files changed, 134 insertions(+)
 create mode 100644 common/nvme
 create mode 100755 tests/nvme/001
 create mode 100644 tests/nvme/001.out
 create mode 100644 tests/nvme/group

diff --git a/common/nvme b/common/nvme
new file mode 100644
index 000000000000..ec3986f43e21
--- /dev/null
+++ b/common/nvme
@@ -0,0 +1,28 @@
+#!/bin/bash
+#
+# Default helper functions for NVMe devices.
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
+shopt -s extglob
+
+_test_dev_is_nvme() {
+	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
+		SKIP_REASON="$TEST_DEV is not a NVMe device"
+		return 1
+	fi
+	return 0
+}
diff --git a/tests/nvme/001 b/tests/nvme/001
new file mode 100755
index 000000000000..ff4a9047c884
--- /dev/null
+++ b/tests/nvme/001
@@ -0,0 +1,66 @@
+#!/bin/bash
+#
+# Regression test for commit 3d030e41d96f ("nvme: add tracepoint for
+# nvme_setup_cmd")
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
+DESCRIPTION="enable nvme_setup_nvm_cmd trace point and submit I/O to the
+device"
+
+QUICK=1
+
+# This function normalizes the variable parts of the trace on the individual
+# test system so the known good result in test/nvme/001.out matches if all is
+# OK.
+# If anyone finds a readable way of definig this filter I'm all ears.
+filter_trace() {
+	sed -r "s/dd-[0-9]+\s+\[[0-9]+\]\s+\.{4}\s+[0-9]+\.[0-9]+: nvme_setup_nvm_cmd:\s+qid=[0-9]+, nsid=[0-9]+, cmdid=[0-9]+, flags=0x0, meta=0x0, cmd=\(nvme_cmd_read slba=0, len=31, ctrl=0x0, dsmgmt=0, reftag=0\)/dd-XXX   [XXX] ....     X.XXXXXX: nvme_setup_nvm_cmd: qid=X, nsid=X, cmdid=X, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=31, ctrl=0x0, dsmgmt=0, reftag=0)/"
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+	cleanup_debugfs=0
+	cleanup_tracefs=0
+
+	if ! grep -q debugfs /proc/mounts; then
+		mount -t debugfs none /sys/kernel/debug
+		cleanup_debugfs=1
+	fi
+
+	if ! grep -q tracefs /proc/mounts; then
+		mount -t tracefs none /sys/kernel/debug/tracing
+		cleanup_tracefs=1
+	fi
+
+	echo 1 > /sys/kernel/debug/tracing/events/nvme/nvme_setup_nvm_cmd/enable
+
+	dd if=${TEST_DEV} of=/dev/null bs=512 count=1 >>$FULL 2> /dev/null
+
+	cat /sys/kernel/debug/tracing/trace | filter_trace
+
+	echo 0 > /sys/kernel/debug/tracing/events/nvme/nvme_setup_nvm_cmd/enable
+
+	if [[ $cleanup_tracefs == 1 ]]; then
+		umount /sys/kernel/debug/tracing
+	fi
+
+	if [[ $cleanup_debugfs == 1 ]]; then
+		umount /sys/kernel/debug
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/001.out b/tests/nvme/001.out
new file mode 100644
index 000000000000..bca1d0fc27b1
--- /dev/null
+++ b/tests/nvme/001.out
@@ -0,0 +1,12 @@
+Running nvme/001
+# tracer: nop
+#
+#                              _-----=> irqs-off
+#                             / _----=> need-resched
+#                            | / _---=> hardirq/softirq
+#                            || / _--=> preempt-depth
+#                            ||| /     delay
+#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
+#              | |       |   ||||       |         |
+              dd-XXX   [XXX] ....     X.XXXXXX: nvme_setup_nvm_cmd: qid=X, nsid=X, cmdid=X, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=31, ctrl=0x0, dsmgmt=0, reftag=0)
+Test complete
diff --git a/tests/nvme/group b/tests/nvme/group
new file mode 100644
index 000000000000..5e4e65c922c7
--- /dev/null
+++ b/tests/nvme/group
@@ -0,0 +1,28 @@
+#!/bin/bash
+#
+# Test specific to NVMe devices
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
+. common/nvme
+
+group_requires() {
+	_have_root
+}
+
+group_device_requires() {
+	_test_dev_is_nvme
+}
-- 
2.13.6
