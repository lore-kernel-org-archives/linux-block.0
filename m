Return-Path: <axboe@kernel.dk>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] blktest: remove instances of null_blk queue_mode=1
Message-ID: <dbede61b-13fb-5b5e-3827-fd4b831f9004@kernel.dk>
Date: Thu, 25 Oct 2018 15:03:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

This is no longer supported in recent kernels, get rid of
any testing of queue_mode=1. queue_mode=1 tested the legacy
IO path, which is going away completely. As such, there's
no point in doing anymore testing with it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Replaces the two previous patches - covers 024 as well, and folds the
other two.

diff --git a/tests/block/017 b/tests/block/017
index 715c4e59c514..cea29beaf062 100755
--- a/tests/block/017
+++ b/tests/block/017
@@ -26,27 +26,23 @@ show_inflight() {
 test() {
 	echo "Running ${TEST_NAME}"
 
-	for ((queue_mode = 1; queue_mode <= 2; queue_mode++)) do
-		echo "queue mode $queue_mode"
+	if ! _init_null_blk queue_mode=2 irqmode=2 \
+	     completion_nsec=500000000; then
+		return 1
+	fi
 
-		if ! _init_null_blk queue_mode="$queue_mode" irqmode=2 \
-		     completion_nsec=500000000; then
-			continue
-		fi
+	dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1 status=none &
+	sleep 0.1
+	show_inflight
 
-		dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1 status=none &
-		sleep 0.1
-		show_inflight
+	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1 status=none &
+	sleep 0.1
+	show_inflight
 
-		dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1 status=none &
-		sleep 0.1
-		show_inflight
+	wait
+	show_inflight
 
-		wait
-		show_inflight
-
-		_exit_null_blk
-	done
+	_exit_null_blk
 
 	echo "Test complete"
 }
diff --git a/tests/block/017.out b/tests/block/017.out
index 93d67c98e159..e2ecf978af5f 100644
--- a/tests/block/017.out
+++ b/tests/block/017.out
@@ -1,18 +1,4 @@
 Running block/017
-queue mode 1
-sysfs inflight reads 1
-sysfs inflight writes 0
-sysfs stat 1
-diskstats 1
-sysfs inflight reads 1
-sysfs inflight writes 1
-sysfs stat 2
-diskstats 2
-sysfs inflight reads 0
-sysfs inflight writes 0
-sysfs stat 0
-diskstats 0
-queue mode 2
 sysfs inflight reads 1
 sysfs inflight writes 0
 sysfs stat 1
diff --git a/tests/block/018 b/tests/block/018
index 279dc7a31958..731272399a82 100755
--- a/tests/block/018
+++ b/tests/block/018
@@ -29,37 +29,33 @@ show_times() {
 }
 
 test() {
-	echo "Running ${TEST_NAME}"
-
-	for ((queue_mode = 1; queue_mode <= 2; queue_mode++)) do
-		local init_read_ms init_write_ms read_ms write_ms
+	local init_read_ms init_write_ms read_ms write_ms
 
-		echo "queue mode $queue_mode"
+	echo "Running ${TEST_NAME}"
 
-		if ! _init_null_blk queue_mode="$queue_mode" irqmode=2 \
-		     completion_nsec=1000000000; then
-			continue
-		fi
+	if ! _init_null_blk queue_mode=2 irqmode=2 \
+	     completion_nsec=1000000000; then
+		return 1
+	fi
 
-		init_times
-		show_times
+	init_times
+	show_times
 
-		dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1 status=none
-		show_times
+	dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1 status=none
+	show_times
 
-		dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1 status=none
-		show_times
+	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1 status=none
+	show_times
 
-		dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1 status=none &
-		dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1 status=none &
-		dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1 status=none &
-		wait
-		show_times
+	dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1 status=none &
+	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1 status=none &
+	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1 status=none &
+	wait
+	show_times
 
-		_exit_null_blk
+	_exit_null_blk
 
-		unset init_read_ms init_write_ms read_ms write_ms
-	done
+	unset init_read_ms init_write_ms read_ms write_ms
 
 	echo "Test complete"
 }
diff --git a/tests/block/018.out b/tests/block/018.out
index facb7c2be260..27c74bec2337 100644
--- a/tests/block/018.out
+++ b/tests/block/018.out
@@ -1,14 +1,4 @@
 Running block/018
-queue mode 1
-read 0 s
-write 0 s
-read 1 s
-write 0 s
-read 1 s
-write 1 s
-read 2 s
-write 3 s
-queue mode 2
 read 0 s
 write 0 s
 read 1 s
diff --git a/tests/block/023 b/tests/block/023
index b053af45adb0..b0739f72e46d 100755
--- a/tests/block/023
+++ b/tests/block/023
@@ -19,7 +19,7 @@ test() {
 	echo "Running ${TEST_NAME}"
 
 	local queue_mode
-	for ((queue_mode = 0; queue_mode <= 2; queue_mode++)); do
+	for queue_mode in 0 2; do
 		if _init_null_blk gb=1 queue_mode="$queue_mode"; then
 			echo "Queue mode $queue_mode"
 			dd if=/dev/nullb0 of=/dev/null iflag=direct bs=64k status=none
diff --git a/tests/block/023.out b/tests/block/023.out
index a2f376d979e2..3216d0c4b5c1 100644
--- a/tests/block/023.out
+++ b/tests/block/023.out
@@ -1,5 +1,4 @@
 Running block/023
 Queue mode 0
-Queue mode 1
 Queue mode 2
 Test complete
diff --git a/tests/block/024 b/tests/block/024
index 31898e42145d..cf1470709169 100755
--- a/tests/block/024
+++ b/tests/block/024
@@ -31,41 +31,37 @@ show_times() {
 }
 
 test() {
-	echo "Running ${TEST_NAME}"
-
-	for ((queue_mode = 1; queue_mode <= 2; queue_mode++)) do
-		local init_read_ms init_write_ms read_ms write_ms
+	local init_read_ms init_write_ms read_ms write_ms
 
-		echo "queue mode $queue_mode"
+	echo "Running ${TEST_NAME}"
 
-		# The maximum value for CONFIG_HZ is 1000. I.e., a tick is one
-		# millisecond. So, make each I/O take half a millisecond.
-		if ! _init_null_blk queue_mode="$queue_mode" irqmode=2 \
-		     completion_nsec=500000; then
-			continue
-		fi
+	# The maximum value for CONFIG_HZ is 1000. I.e., a tick is one
+	# millisecond. So, make each I/O take half a millisecond.
+	if ! _init_null_blk queue_mode=2 irqmode=2 \
+	     completion_nsec=500000; then
+		return 1
+	fi
 
-		init_times
-		show_times
+	init_times
+	show_times
 
-		# 1500 * 0.5 ms is 0.75 seconds, allowing for some overhead so
-		# that it rounds to one second.
-		dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1500 status=none
-		show_times
+	# 1500 * 0.5 ms is 0.75 seconds, allowing for some overhead so
+	# that it rounds to one second.
+	dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1500 status=none
+	show_times
 
-		dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1500 status=none
-		show_times
+	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1500 status=none
+	show_times
 
-		dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1500 status=none &
-		dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1500 status=none &
-		dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1500 status=none &
-		wait
-		show_times
+	dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1500 status=none &
+	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1500 status=none &
+	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1500 status=none &
+	wait
+	show_times
 
-		_exit_null_blk
+	_exit_null_blk
 
-		unset init_read_ms init_write_ms read_ms write_ms
-	done
+	unset init_read_ms init_write_ms read_ms write_ms
 
 	echo "Test complete"
 }
diff --git a/tests/block/024.out b/tests/block/024.out
index 7600389291af..3cff4189c711 100644
--- a/tests/block/024.out
+++ b/tests/block/024.out
@@ -1,14 +1,4 @@
 Running block/024
-queue mode 1
-read 0 s
-write 0 s
-read 1 s
-write 0 s
-read 1 s
-write 1 s
-read 2 s
-write 3 s
-queue mode 2
 read 0 s
 write 0 s
 read 1 s

-- 
Jens Axboe
