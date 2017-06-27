Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40302 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752128AbdF0NnF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2017 09:43:05 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH blktests v2 2/2] block/011: Perform PCI reset while doing IO
Date: Tue, 27 Jun 2017 15:42:57 +0200
Message-Id: <20170627134257.15863-3-jthumshirn@suse.de>
In-Reply-To: <20170627134257.15863-1-jthumshirn@suse.de>
References: <20170627134257.15863-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This test-case performs I/O with fio while doing PCI disable/enable
cycles.

In the results we don't care for I/O errors but for hiccups in dmesg only.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 tests/block/011     | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/011.out |  2 ++
 2 files changed, 57 insertions(+)
 create mode 100755 tests/block/011
 create mode 100644 tests/block/011.out

diff --git a/tests/block/011 b/tests/block/011
new file mode 100755
index 000000000000..65ed3dfa7092
--- /dev/null
+++ b/tests/block/011
@@ -0,0 +1,55 @@
+#!/bin/bash
+#
+# Do disable PCI device while doing I/O to it
+#
+# Copyright (C) 2017 Johannes Thumshirn <jthumshirn@suse.de>
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
+DESCRIPTION="disable PCI device while doing I/O"
+TIMED=1
+
+requires() {
+	_have_fio
+}
+
+device_requires() {
+	_test_dev_is_pci
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	pdev=$(_get_pci_dev_from_blkdev)
+
+	if _test_dev_is_rotational; then
+		size="32m"
+	else
+		size="1g"
+	fi
+
+	# start fio job
+	_run_fio --bs=4k --rw=randread --norandommap \
+		--name=reads --filename="$TEST_DEV" --size="$size" \
+		--numjobs=8 --direct=1 --ignore_error=EIO,ENXIO,ENODEV &
+
+	while kill -0 $! 2>/dev/null; do
+		echo 0 > "/sys/bus/pci/devices/${pdev}/enable"
+		sleep .2
+		echo 1 > "/sys/bus/pci/devices/${pdev}/enable"
+		sleep .2
+	done
+
+	echo "Test complete"
+}
diff --git a/tests/block/011.out b/tests/block/011.out
new file mode 100644
index 000000000000..8e067df63097
--- /dev/null
+++ b/tests/block/011.out
@@ -0,0 +1,2 @@
+Running block/011
+Test complete
-- 
2.12.3
