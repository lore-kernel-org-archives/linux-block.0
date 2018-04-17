Return-Path: <alan.christopher.jenkins@gmail.com>
Return-Path: <alan.christopher.jenkins@gmail.com>
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: Johannes Thumshirn <jthumshirn@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
	Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH v3] blktests: regression test "block: do not use interruptible wait anywhere"
Date: Tue, 17 Apr 2018 16:10:00 +0100
Message-Id: <20180417151000.9931-1-alan.christopher.jenkins@gmail.com>
In-Reply-To: <78254510-5ba0-1bba-dd4a-87fdc88e55ee@gmail.com>
References: <78254510-5ba0-1bba-dd4a-87fdc88e55ee@gmail.com>
List-ID: <linux-block@vger.kernel.org>

> Without this fix, I get an IO error in this test:
>
> # dd if=/dev/sda of=/dev/null iflag=direct & \
>   while killall -SIGUSR1 dd; do sleep 0.1; done & \
>   echo mem > /sys/power/state ; \
>   sleep 5; killall dd  # stop after 5 seconds

linux-block specifically asked for a test derived from this reproducer.
They didn't come up with any suggestion for testing the code more directly
(and robustly).  So this test uses system suspend, automated with pm_test.

Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
---
v3: Switch from dd to fio, clarify some comment.
    The HAVE_BARE_METAL_SCSI check is left unchanged,
    waiting for further discussion.

 tests/scsi/004     | 255 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/scsi/004.out |  12 +++
 2 files changed, 267 insertions(+)
 create mode 100755 tests/scsi/004
 create mode 100644 tests/scsi/004.out

diff --git a/tests/scsi/004 b/tests/scsi/004
new file mode 100755
index 0000000..2a7f794
--- /dev/null
+++ b/tests/scsi/004
@@ -0,0 +1,255 @@
+#!/bin/bash
+#
+# Regression test for patch "block: do not use interruptible wait anywhere".
+#
+# > Without this fix, I get an IO error in this test:
+# >
+# > # dd if=/dev/sda of=/dev/null iflag=direct & \
+# >   while killall -SIGUSR1 dd; do sleep 0.1; done & \
+# >   echo mem > /sys/power/state ; \
+# >   sleep 5; killall dd  # stop after 5 seconds
+#
+# AJ: linux-block specifically asked for a test derived from this reproducer.
+# They didn't come up with any suggestion for testing the code more directly
+# (and robustly).  So this test uses system suspend, automated with pm_test.
+#
+#
+# Rationale for the test needing system suspend:
+#
+# The original root cause issue was the behaviour around blk_queue_freeze().
+# It put tasks into an interruptible wait, which is wrong for block devices.
+#
+# The freeze feature is not directly exposed to userspace, so I can not test
+# it directly :(.  (It's used to "guarantee no request is in use, so we can
+# change any data structure of the queue afterward".  I.e. freeze, modify the
+# queue structure, unfreeze).
+#
+# However, this lead to a kernel regression with a decent reproducer.  In
+# v4.15 the same interruptible wait was also used for SCSI suspend/resume.
+# SCSI resume can take a second or so, hence we like to do it asynchronously.
+# This means we can observe the wait at resume time, and we can test if it is
+# interruptible.
+#
+# Note `echo quiesce > /sys/class/scsi_device/*/device/state` can *not*
+# trigger the specific wait in the block layer.  That code path only
+# sets the SCSI device state; it does not set any block device state.
+# (It does not call into blk_queue_freeze() or blk_set_preempt_only();
+#  it literally just sets sdev->sdev_state to SDEV_QUIESCE).
+#
+#
+# Copyright (C) 2018 Alan Jenkins
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
+DESCRIPTION="check SCSI blockdev suspend is not interruptible"
+
+QUICK=1
+
+requires() {
+	# I can't expect to hit the window using bash, if the device is
+	# emulated by cpu.
+	#
+	# Maybe annoying to see this message on Xen dom0,
+	# but I'm guessing that's not common.
+	#
+	if grep -q ^flags.*\ hypervisor /proc/cpuinfo &&
+	   (( !HAVE_BARE_METAL_SCSI )); then
+		SKIP_REASON=\
+"Hypervisor detected, but this test wants bare-metal SCSI timings.
+If you have a pass-through device, you may set HAVE_BARE_METAL_SCSI=1."
+		return 1
+	fi
+
+	# "If a user has disabled async probing a likely reason
+	#  is due to a storage enclosure that does not inject
+	#  staggered spin-ups. For safety, make resume
+	#  synchronous as well in that case."
+	if ! scan="$(cat /sys/module/scsi_mod/parameters/scan)"; then
+		SKIP_REASON="Could not read '/sys/module/scsi_mod/parameters/scan'"
+		return 1
+	fi
+	if [[ "$scan" != async ]]; then
+		SKIP_REASON="This test does not work if you have set 'scsi_mod.scan=sync'"
+		return 1
+	fi
+
+	if ! cat /sys/power/pm_test > /dev/null; then
+		SKIP_REASON="Error reading pm_test.  Maybe kernel lacks CONFIG_PM_TEST?"
+		return 1
+	fi
+
+	_have_fio
+}
+
+do_test_device() ( # run whole function in a subshell
+
+	sysfs_pm_test_delay=/sys/module/suspend/parameters/pm_test_delay
+	saved_pm_test_delay=
+	fio_pid=
+	subshell_pid=
+
+	# Fail the test early, in cases where it should not continue.
+	fail() {
+		echo "$*"
+		exit 1
+	}
+
+	# Terminate child process
+	cleanup_pid() {
+		local pid="$1"
+
+		# Suppress shell messages about killed process.
+		# The messages would vary, causing the test to fail.
+		exec 3>&1 4>&2
+		exec >>"$FULL" 2>&1
+
+		# Send terminate signal.  Also send the continue signal,
+		# in case the process was currently stopped.
+		(kill "$pid" && kill -CONT "$pid") >&3 2>&4
+
+		# Don't try to re-redirect output from `wait` just in case,
+		# if `wait` is executed in a subshell then it cannot work.
+		wait "$pid"
+
+		# Restore stdout/stderr
+		exec >&3 2>&4
+		exec 3>&- 4>&-
+	}
+
+	cleanup() {
+		if [[ -n "$subshell_pid" ]]; then
+			echo "Killing sub-shell..."
+			cleanup_pid "$subshell_pid"
+		fi
+		if [[ -n "$fio_pid" ]]; then
+			echo "Killing fio..."
+			cleanup_pid "$fio_pid"
+		fi
+
+		echo "Resetting pm_test_delay"
+		if [[ -n "$saved_pm_test_delay" ]]; then
+			echo "$saved_pm_test_delay" > "$sysfs_pm_test_delay"
+		fi
+
+		echo "Resetting pm_test"
+		echo none > /sys/power/pm_test
+	}
+	trap cleanup EXIT
+
+	# Start fio, as a background process which submits IOs and stops
+	# with an error when one fails.  Use threads instead of separate
+	# processes, so it's easier to send signals to the IO thread.
+	#
+	# This is the same behaviour as dd, except that we loop in case the
+	# device is tiny. (Strictly speaking, the block size is different too).
+	#
+	fio --output="${FULL}.fio" --filename="$TEST_DEV" \
+	    --thread --exitall_on_error --loops=1G \
+	    --direct=1 --rw=read --name=reads &
+	fio_pid=$!
+
+	# Keep sending signals to 'fio`.  Give it 1ms between
+	# signals so it gets a chance to actually submit IOs.
+	#
+	# In theory this script is probably subject to various
+	# pid re-use races.  But I started in sh... so far
+	# blktests does not depend on python... also direct IO
+	# is best to reproduce this, which is not built in to
+	# python.
+	(
+		while kill -STOP $fio_pid 2>>"$FULL" &&
+		      kill -CONT $fio_pid 2>>"$FULL"; do
+
+			sleep 0.001
+		done
+
+		# dd exited.  Wait to be killed, it simplifies cleanup.
+		while true; do
+			sleep 1
+		done
+	) &
+	subshell_pid=$!
+
+	# Here's the real race condition.
+	#
+	# We only want to suspend once both child processes have reached their
+	# main loops.  Otherwise we get a false pass.  We use the following
+	# mitigations:
+	#
+	# 1. Wait 1 second first.
+	#
+	# 2. Make sure to call this function twice, so hopefully the second
+	#    time will not have to wait to page anything in.
+	#
+	# 3. Wait for any pending writes first.  I think that this redundant in
+	#    principle, but will make for more consistent timings.
+	#
+	# (You can actually solve this precisely using strace or the like...
+	#  but it still looks weird, and adds another depedency)
+	#
+	sync
+	sleep 1
+
+	if ! echo devices > /sys/power/pm_test; then
+		fail "error setting pm_test"
+	fi
+
+	if ! saved_pm_test_delay="$(cat "$sysfs_pm_test_delay")"; then
+		fail "error reading pm_test_delay"
+	fi
+	if ! echo 0 > "$sysfs_pm_test_delay"; then
+		fail "error setting pm_test_delay"
+	fi
+
+	# Log that we're suspending.  User might not have guessed,
+	# or maybe suspend (or pm_test suspend) is broken on this system.
+	echo "Simulating suspend/resume now"
+	echo mem > /sys/power/state
+
+	# Now wait for TEST_DEV to resume asynchronously
+	dd iflag=direct if="$TEST_DEV" of=/dev/null count=1 status=none
+
+	# Wait again.  This will be useful in the case fio got blocked on a
+	# page fault during the suspend; it will have a second to get sorted out,
+	# so it can potentially receive an IO error and exit.
+	sleep 1
+	dd iflag=direct if="$TEST_DEV" of=/dev/null count=1 status=none
+
+	if ! kill -0 $fio_pid 2>/dev/null; then
+		# dd exited before we entered cleanup.
+		# Read its exit status
+		wait $fio_pid
+		ret=$?
+		fio_pid=
+
+		if [[ $ret == 0 ]]; then
+			fail "'fio' exited early, without error. Please report this as a bug."
+		else
+			# Test should already fail at this point due to
+			# error messages.  But let's log it while we're here,
+			# and also not run the second iteration of the test.
+			fail "'fio' exited with error $ret"
+		fi
+	fi
+) # end subshell function
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	# Run the test twice.  Hopefully the second iteration will
+	# have everything in page cache for consistent timings.
+	do_test_device && do_test_device
+
+	echo "Test complete"
+}
diff --git a/tests/scsi/004.out b/tests/scsi/004.out
new file mode 100644
index 0000000..7211b4d
--- /dev/null
+++ b/tests/scsi/004.out
@@ -0,0 +1,12 @@
+Running scsi/004
+Simulating suspend/resume now
+Killing sub-shell...
+Killing fio...
+Resetting pm_test_delay
+Resetting pm_test
+Simulating suspend/resume now
+Killing sub-shell...
+Killing fio...
+Resetting pm_test_delay
+Resetting pm_test
+Test complete
-- 
2.14.3
