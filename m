Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Omar Sandoval <osandov@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH blktests] block/020: test IO req allocation
Date: Tue, 22 May 2018 19:12:49 +0800
Message-Id: <20180522111249.14136-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

IO request allocation may hang for ever if the allocation process
migrages. This test covers the request allocation code path.

The following patch can fix this issue on linus kernel:

https://marc.info/?l=linux-block&m=152671586923185&w=2

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tests/block/020     | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/020.out |  2 ++
 2 files changed, 52 insertions(+)
 create mode 100755 tests/block/020
 create mode 100755 tests/block/020.out

diff --git a/tests/block/020 b/tests/block/020
new file mode 100755
index 000000000000..b102d7f12173
--- /dev/null
+++ b/tests/block/020
@@ -0,0 +1,50 @@
+#!/bin/bash
+#
+# Test blk-mq IO request allocation.
+#
+# Copyright (C) 2018 Ming Lei <ming.lei@redhat.com>
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
+DESCRIPTION="check if IO req allocation may hang"
+QUICK=1
+
+requires() {
+	_have_module null_blk && _have_fio
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	modprobe -r null_blk
+	modprobe null_blk queue_mode=2 irqmode=2 completion_nsec=2000000 \
+			shared_tags=1 submit_queues=4 hw_queue_depth=1 || continue
+
+	local scheds
+	# shellcheck disable=SC2207
+	scheds=($(sed 's/[][]//g' /sys/block/nullb0/queue/scheduler))
+
+	for sched in "${scheds[@]}"; do
+		echo "Testing $sched" >> "$FULL"
+		echo "$sched" > /sys/block/nullb0/queue/scheduler
+		_fio_perf --bs=4k --ioengine=libaio --iodepth=1024 \
+				--numjobs="$(nproc)" --rw=randread --name=async \
+				--filename=/dev/nullb0 --size=1g --direct=1 \
+				--runtime=10
+	done
+
+	modprobe -r null_blk
+
+	echo "Test complete"
+}
diff --git a/tests/block/020.out b/tests/block/020.out
new file mode 100755
index 000000000000..dcb584d22e3e
--- /dev/null
+++ b/tests/block/020.out
@@ -0,0 +1,2 @@
+Running block/020
+Test complete
-- 
2.9.5
