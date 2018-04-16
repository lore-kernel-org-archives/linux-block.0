Return-Path: <alan.christopher.jenkins@gmail.com>
Return-Path: <alan.christopher.jenkins@gmail.com>
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-block@vger.kernel.org
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
	Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH] blktests: regression test "block: do not use interruptible wait anywhere"
Date: Mon, 16 Apr 2018 22:23:11 +0100
Message-Id: <20180416212311.19326-1-alan.christopher.jenkins@gmail.com>
In-Reply-To: <891e334c-cf19-032c-b996-59ac166fcde1@gmail.com>
References: <891e334c-cf19-032c-b996-59ac166fcde1@gmail.com>
List-ID: <linux-block@vger.kernel.org>

> Without this fix, I get an IO error in this test:
>
> # dd if=/dev/sda of=/dev/null iflag=direct & \
>   while killall -SIGUSR1 dd; do sleep 0.1; done & \
>   echo mem > /sys/power/state ; \
>   sleep 5; killall dd  # stop after 5 seconds

linux-block insisted they wanted this, based on my reproducer above.
If you start wondering why you wouldn't base it on scsi_debug with a new
"quiesce" option, that makes two of us.

Thread: http://lkml.kernel.org/r/891e334c-cf19-032c-b996-59ac166fcde1@gmail.com

Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
---
 tests/scsi/004     | 235 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/scsi/004.out |   7 ++
 2 files changed, 242 insertions(+)
 create mode 100755 tests/scsi/004
 create mode 100644 tests/scsi/004.out

diff --git a/tests/scsi/004 b/tests/scsi/004
new file mode 100755
index 0000000..791c76a
--- /dev/null
+++ b/tests/scsi/004
@@ -0,0 +1,235 @@
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
+# AJ: linux-block insisted they wanted this, based on my reproducer above.
+# If you start wondering why you wouldn't base it on scsi_debug with a new
+# "quiesce" option, that makes two of us.
+# Thread: http://lkml.kernel.org/r/891e334c-cf19-032c-b996-59ac166fcde1@gmail.com
+#
+#
+# RATIONALE for a suspend test:
+#
+# The original root cause issue was the behaviour around blk_queue_freeze().
+# It put tasks into an interruptible wait, which is wrong for block devices.
+#
+# The freeze feature is not directly exposed to userspace, so I can not test
+# it directly :(.  (It's used to "guarantee no request is in use, so we can
+# change any data structure of the queue afterward".  I.e. freeze, modify the
+# queue structure, unfreeze).
+#
+# However, this lead to a regression with a decent reproducer.  In v4.15 the
+# same interruptible wait was also used for SCSI suspend/resume.  SCSI resume
+# can take a second or so... hence we like to do it asynchronously.  This
+# means we can observe the wait at resume time, and we can test if it is
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
+	# Maybe annoying for Xen dom0, but I'm guessing it's not common.
+	if grep -q ^flags.*\ hypervisor /proc/cpuinfo &&
+	   ! [[ -e "$HAVE_BARE_METAL_SCSI" ]]; then
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
+	dd_pid=
+	subshell_pid=
+
+	fail() {
+		echo "$*"
+		exit 1
+	}
+
+	cleanup_pid() {
+		local pid="$1"
+
+		# Suppress shell messages, about killed process
+		exec 3>&1 4>&2
+		exec >>"$FULL" 2>&1
+
+		kill "$pid" >&3 2>&4
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
+		if [ -n "$subshell_pid" ]; then
+			echo "Killing sub-shell..."
+			cleanup_pid "$subshell_pid"
+		fi
+		if [ -n "$dd_pid" ]; then
+			echo "Killing dd..."
+			cleanup_pid "$dd_pid"
+		fi
+
+		echo "Resetting pm_test"
+		echo none > /sys/power/pm_test
+
+		echo "Resetting pm_test_delay"
+		if [ -n "$saved_pm_test_delay" ]; then
+			echo "$saved_pm_test_delay" > "$sysfs_pm_test_delay"
+		fi
+	}
+	trap cleanup EXIT
+
+	# Have not tested on devices which require larger IO,
+	# but let's not die if we see one.
+	bs="$(_test_dev_queue_get hw_sector_size)"
+
+	# Start dd, as a background process which submits IOs
+	# and yells when one fails.  We want to test the block
+	# layer, so we use direct IO to avoid being served
+	# from page cache.
+	#
+	# I tried using fio with the exact same IO pattern,
+	# sadly it was not 100% reliable at reproducing this
+	# issue.
+	#
+	dd iflag=direct if="$TEST_DEV" of=/dev/null bs=$bs status=none &
+	dd_pid=$!
+
+# 	fio --output="$FULL" --loops=65535 \
+# 	    --thread --exitall_on_error \
+# 	    --direct=1 \
+# 	    --bs=$bs --rw=read --name=reads \
+# 	    --filename="$TEST_DEV" &
+# 	fio_pid=$!
+
+	# Keep sending signals to 'dd'.  Give it 1ms between
+	# signals so it gets a chance to actually submit IOs.
+	#
+	# In theory this script is probably subject to various
+	# pid re-use races.  But I started in sh... so far
+	# blktests does not depend on python... also direct IO
+	# is best to reproduce this, which is not built in to
+	# python.
+	(
+		while kill -STOP $dd_pid 2>/dev/null &&
+		      kill -CONT $dd_pid 2>/dev/null; do
+
+			sleep 0.001
+		done
+
+		# Wait to be killed. Simplifies cleanup.
+		while true; do
+			sleep 1
+		done
+	) &
+	subshell_pid=$!
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
+	# Wait another second.  This might be useful in the case dd got blocked on a
+	# page fault during the suspend; it will have a second to get sorted out,
+	# so it can potentially receive an IO error and exit.
+	sleep 1
+
+	if ! kill -0 $dd_pid 2>/dev/null; then
+		# dd exited before we entered cleanup.
+		# Read its exit status
+		wait $dd_pid
+		ret=$?
+		dd_pid=
+
+		if [[ $ret == 0 ]]; then
+			echo "'dd' exited early, without error."
+			echo "Is your scsi device implausibly fast or small?"
+		else
+			# Test should already fail at this point due to
+			# error messages, but let's log it while we're here.
+			echo "'dd' exited with error $ret"
+		fi
+	fi
+) # end subshell function
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+	do_test_device
+	echo "Test complete"
+}
diff --git a/tests/scsi/004.out b/tests/scsi/004.out
new file mode 100644
index 0000000..4085f62
--- /dev/null
+++ b/tests/scsi/004.out
@@ -0,0 +1,7 @@
+Running scsi/004
+Simulating suspend/resume now
+Killing sub-shell...
+Killing dd...
+Resetting pm_test
+Resetting pm_test_delay
+Test complete
-- 
2.14.3
