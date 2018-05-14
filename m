Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:3943 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751422AbeENUAp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 May 2018 16:00:45 -0400
From: Keith Busch <keith.busch@intel.com>
To: Omar Sandoval <osandov@osandov.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH blktests] nvme: Add command timeout injection test
Date: Mon, 14 May 2018 14:02:37 -0600
Message-Id: <20180514200237.15135-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This test will run a background IO process and inject an admin command
with a very short timeout that is all but guaranteed to expire without
a completion: the async event request.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 tests/nvme/005     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/005.out |  3 +++
 2 files changed, 45 insertions(+)
 create mode 100755 tests/nvme/005
 create mode 100644 tests/nvme/005.out

diff --git a/tests/nvme/005 b/tests/nvme/005
new file mode 100755
index 0000000..3fe9cbe
--- /dev/null
+++ b/tests/nvme/005
@@ -0,0 +1,42 @@
+#!/bin/bash
+#
+# Regression test for timeout handling.
+#
+# Copyright (C) 2018 Keith Busch
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
+DESCRIPTION="test nvme admin command timeout handling with in-flight io"
+
+QUICK=1
+
+requires() {
+	_have_program nvme
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	# start fio job
+	_run_fio_rand_io --filename="${TEST_DEV}" --time_based --runtime=20 &
+
+	sleep 5
+
+	# send nvme admin command 'async event request', which  will surely time out
+	nvme admin-passthru ${TEST_DEV} -o 0xc --timeout=1
+
+	wait
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/005.out b/tests/nvme/005.out
new file mode 100644
index 0000000..f4ff837
--- /dev/null
+++ b/tests/nvme/005.out
@@ -0,0 +1,3 @@
+Running nvme/005
+passthru: Interrupted system call
+Test complete
-- 
2.14.3
