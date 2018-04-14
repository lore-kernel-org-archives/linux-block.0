Return-Path: <alan.christopher.jenkins@gmail.com>
Return-Path: <alan.christopher.jenkins@gmail.com>
Subject: Re: blktest for [PATCH v2] block: do not use interruptible wait
 anywhere
To: Johannes Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <Bart.VanAssche@wdc.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <13e67e1243ebd96f3f56a150d47444ada47ebde0.camel@wdc.com>
 <20180412181158.8884-1-alan.christopher.jenkins@gmail.com>
 <1523608284.7787.3.camel@suse.de>
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <d1ce87d6-f77c-96d0-a3df-5ee5ed73a0bf@gmail.com>
Date: Sat, 14 Apr 2018 20:46:36 +0100
MIME-Version: 1.0
In-Reply-To: <1523608284.7787.3.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 13/04/18 09:31, Johannes Thumshirn wrote:
> Hi Alan,
>
> On Thu, 2018-04-12 at 19:11 +0100, Alan Jenkins wrote:
>> # dd if=/dev/sda of=/dev/null iflag=direct & \
>>    while killall -SIGUSR1 dd; do sleep 0.1; done & \
>>    echo mem > /sys/power/state ; \
>>    sleep 5; killall dd  # stop after 5 seconds
> Can you please also add a regression test to blktests[1] for this?
>
> [1] https://github.com/osandov/blktests
>
> Thanks,
> 	Johannes

Good question. It would be nice to promote this test.

Template looks like I need the commit (sha1) first.

I had some ideas about automating it, so I wrote a standalone (see 
end).  I can automate the wakeup by using pm_test, but this is still a 
system suspend test.  Unfortunately I don't think there's any 
alternative. To give the most dire example

     # This test is non-destructive, but it exercises suspend in all drivers.
     # If your system has a problem with suspend, it might not wake up again.


So I'm not sure if it would be acceptable for the default set?

How useful is this going to be? Is there an expanded/full set of tests 
that gets run somewhere?

If you can't guarantee it's going to be run somewhere, I'd worry the 
cost/benefit  feels a little narrow :-(. There were one or two further 
"interesting" details, and it might theoretically bitrot if it's not run 
periodically.

If you look at the diff and title for the fix, I don't think it's at 
high risk of being reversed unintentionally.

And I think you can trust users will notice if the fix gets merged away 
accidentally, before it hits -stable releases :-). The issue kills the 
entire GUI session on resume from suspend, say once every three days, on 
gnome-shell (due to Xwayland). One unfortunate user switched to Xorg 
only to find that was also affected.  I honestly assume the issue 
applies generally to laptop systems.  The only mitigating factor is if 
you have RAM to spare, so you don't hit the major pagefaults during resume.

#!/bin/bash

# This test is non-destructive, but it exercises suspend in all drivers.
# If your system has a problem with suspend, it might not wake up again.

# TEST_DEV must be SCSI (inc. libata).
#
# Additionally, this test will abort if $TEST_DEV is too tiny
# and we finish reading it within 3 seconds.  Sorry.
TEST_DEV=sda

# RATIONALE
#
# The original root cause issue was the behaviour around blk_queue_freeze().
# It put tasks into an interruptible wait, which is wrong for block devices.
#
# XXX Insert reference to fix commit XXX
#
# The freeze feature is not directly exposed to userspace, so I can not test
# it directly :(.  (It's used to "guarantee no request is in use, so we can
# change any data structure of the queue afterward".  I.e. freeze, modify the
# queue structure, unfreeze).
#
# However, this lead to a regression with a decent reproducer.  In v4.15 the
# same interruptible wait was also used for SCSI suspend/resume.  SCSI resume
# can take a second or so... hence we like to do it asynchronously.  This
# means we can observe the wait at resume time, and we can test if it is
# interruptible.
#
# Note `echo quiesce > /sys/class/scsi_device/*/device/state` can *not*
# trigger the specific wait in the block layer.  That code path only
# sets the SCSI device state; it does not set any block device state.
# (It does not call into blk_queue_freeze() or blk_set_preempt_only();
#  it literally just sets sdev->sdev_state to SDEV_QUIESCE).

set -o nounset

abort() {
     echo "$*"
     echo "=== Test ERROR ==="
     exit 2
}

SYSFS_PM_TEST_DELAY=/sys/module/suspend/parameters/pm_test_delay
SAVED_PM_TEST_DELAY=

# Child process IDs
DD=
SUBSHELL=

cleanup() {
     # In many cases the subshell will already have exited...
     # and semantics for `wait` are crappy in shell.
     # Failure will be harmless in most cases.
     # Just try to provide enough context for the user to guess.

     echo "Cleaning up"
     
     if [ -n "$SUBSHELL" ]; then
         echo "Killing sub-shell PID $SUBSHELL..."
         kill $SUBSHELL
         wait $SUBSHELL
     fi
     if [ -n "$DD" ]; then
         echo "Killing 'dd' PID $DD..."
         kill $DD
         wait $DD
     fi

     echo "Resetting pm_test"
     echo none > /sys/power/pm_test
     
     echo "Resetting pm_test_delay"
     if [ -n "$SAVED_PM_TEST_DELAY" ]; then
         echo "$SAVED_PM_TEST_DELAY" > "$SYSFS_PM_TEST_DELAY"
     fi
}
trap cleanup EXIT

# "If a user has disabled async probing a likely reason
#  is due to a storage enclosure that does not inject
#  staggered spin-ups. For safety, make resume
#  synchronous as well in that case."
if ! SCAN="$(cat /sys/module/scsi_mod/parameters/scan)"; then
     abort "error reading '/sys/module/scsi_mod/parameters/scan' ?"
fi
if [ "$SCAN" != "async" ]; then
     abort "This test does not work if you have set 'scsi_mod.scan=sync'"
fi

# Ignore USR1, in the hope that this applies to child processes.
# This allows us to safely `kill -USR1 $DD`, when we don't know
# whether the child process has fully started yet.
#
# I think this is the only place I relied on the specific
# shell (bash) behaviour.
trap "" USR1

# Check dd can work
if ! dd iflag=direct if="/dev/$TEST_DEV" of=/dev/null count=1 status=none; then
     abort "'dd'"
fi

# Start dd, as a background process which submits IOs and yells when one fails.
# We want to hit the block layer, so use direct IO to avoid being served from
# page cache.
dd iflag=direct if="/dev/$TEST_DEV" of=/dev/null status=none &
DD=$!

if ! echo devices > /sys/power/pm_test; then
     abort "Setting pm_test failed, does your kernel lack CONFIG_PM_TEST?"
fi

if ! SAVED_PM_TEST_DELAY="$(cat "$SYSFS_PM_TEST_DELAY")"; then
     abort "error reading pm_test_delay"
fi
if ! echo 0 > "$SYSFS_PM_TEST_DELAY"; then
     abort "error setting pm_test_delay"
fi

# Just keep sending signals to 'dd' as long as it's alive.
# dd accepts USR1 signal to print status.  It doesn't seem to be a problem
# that we told dd not to actually *print* anything ('status=none').
#
# In theory this script is probably subject to various pid re-use races.
# But I started in sh... so far blktests does not depend on python...
# also direct IO is best to reproduce this, which is not built in to python.
#
( while kill -USR1 $DD 2>/dev/null; do true; done ) &

SUBSHELL=$!

# Wait a second without suspending, it might pick up typos
# or other unexpected errors.
sleep 1
if ! kill -0 $DD; then
     DD=
     wait $DD || echo "'dd' exited with error"
     abort "'dd' exited early?"
fi
if ! kill -0 $SUBSHELL; then
     SUBSHELL=
     abort "subshell exited early?"
fi

# Log that we're suspending.  User might not have guessed,
# or maybe suspend (or pm_test suspend) is broken on this system.
echo "Now simulating suspend/resume"

if ! echo mem > /sys/power/state; then
     abort "system suspend failed or not supported?"
fi

# Now wait for TEST_DEV to resume asynchronously
if ! dd iflag=direct if="/dev/$TEST_DEV" of=/dev/null count=1 status=none; then
     abort "'dd'"
fi

# Wait another second.  This might be useful in the case dd got blocked on a
# page fault during the suspend; it will have a second to get sorted out,
# while potentially receiving an IO error and exiting.
sleep 1

if ! kill -0 $DD 2>/dev/null; then
     if wait $DD; then
         DD=
         abort "'dd' exited early, without error.  Device too tiny?"
     fi
     
     echo "'dd' exited with error"
     echo "=== Test FAIL ==="
     DD=
     exit 1
fi
echo "=== Test PASS ==="
