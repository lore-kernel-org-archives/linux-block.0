Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Omar Sandoval <osandov@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block/023: performance test on queue creation & cleanup
Date: Wed,  4 Jul 2018 13:29:56 +0800
Message-Id: <20180704052956.5110-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

SCSI may have lots of channels, targets or LUNs, so it may
take long time for creating and cleaning up queues.

So introduce block/023 and uses null_blk to run this test
on both blk-mq and legacy mode, then compare both and check
the difference.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tests/block/023     | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/023.out |   2 ++
 2 files changed, 103 insertions(+)
 create mode 100755 tests/block/023
 create mode 100755 tests/block/023.out

diff --git a/tests/block/023 b/tests/block/023
new file mode 100755
index 000000000000..5a8f323bd42a
--- /dev/null
+++ b/tests/block/023
@@ -0,0 +1,101 @@
+#!/bin/bash
+#
+# Performance regression test on blk-mq queue creation & cleanup. Measure
+# the time for creating & cleaning up null_blk queues in both legacy and
+# blk-mq mode, then compare both & check if there is performance regression.
+#
+# Copyright (C) 2018 Ming Lei
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
+. tests/block/rc
+
+DESCRIPTION="performance regression test on null_blk queue creation & cleanup"
+QUICK=1
+
+requires() {
+	_have_module null_blk
+}
+
+remove_null_blk_mod() {
+	delay=$1
+	while true; do
+		modprobe -r null_blk > /dev/null 2>&1
+		[ $? -eq 0 ] && break
+		sleep $delay
+	done
+}
+
+test_null_blk_queue_perf() {
+	QUEUE_MODE=$1
+
+	remove_null_blk_mod 1
+
+	start_time=`date +'%s'`
+	modprobe null_blk nr_devices=4096 queue_mode=$QUEUE_MODE
+	end_time=`date +'%s'`
+	create_time=`expr $end_time - $start_time + 1`
+
+	start_time=`date +'%s'`
+	remove_null_blk_mod 0.1
+	end_time=`date +'%s'`
+	cleanup_time=`expr $end_time - $start_time + 1`
+
+	echo $create_time $cleanup_time
+}
+
+check_diff() {
+	src=$1
+	dst=$2
+	msg=$3
+
+	diff=`expr $dst - $src`
+	[ $diff -le 10 ] && return
+
+	result=`echo "scale=0;($diff - $src * 0.4) / 1" | bc`
+	[ $result -ge 0 ] && echo $msg
+}
+
+check_limit() {
+	src=$1
+	dst=$2
+	msg=$3
+
+	result=`echo "scale=0;$dst - $src * 20" | bc`
+	[ $result -ge 0 ] && echo $msg
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	rq_time=($(test_null_blk_queue_perf 1))
+	mq_time=($(test_null_blk_queue_perf 2))
+
+	echo ${rq_time[0]} ${mq_time[0]} >> "$FULL"
+	echo ${rq_time[1]} ${mq_time[1]} >> "$FULL"
+
+	msg="blk_mq takes too long(${mq_time[0]}s) to create queues compared with block rq(${rq_time[0]}s)"
+	check_diff ${rq_time[0]} ${mq_time[0]} "$msg"
+
+	msg="blk_mq takes too long(${mq_time[1]}s) to cleanup queues compared with block rq(${rq_time[1]}s)"
+	check_diff ${rq_time[1]} ${mq_time[1]} "$msg"
+
+	msg="block rq takes too long(${rq_time[1]}s) to cleanup queues compared with creating queues(${rq_time[0]}s)"
+	check_limit ${rq_time[0]} ${rq_time[1]} "$msg"
+
+	msg="blk_mq takes too long(${mq_time[1]}s) to cleanup queues compared with creating queues(${mq_time[0]}s)"
+	check_limit ${mq_time[0]} ${mq_time[1]} "$msg"
+
+	echo "Test complete"
+}
diff --git a/tests/block/023.out b/tests/block/023.out
new file mode 100755
index 000000000000..4a11db1f10fe
--- /dev/null
+++ b/tests/block/023.out
@@ -0,0 +1,2 @@
+Running block/023
+Test complete
-- 
2.9.5
