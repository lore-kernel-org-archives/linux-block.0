Return-Path: <linux-fsdevel-owner@vger.kernel.org>
To: linux-block@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, tj@kernel.org
From: Fabiano Rosas <farosas@linux.ibm.com>
Subject: write call hangs in kernel space after virtio hot-remove
Date: Wed, 25 Apr 2018 17:07:48 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <f0787b79-1e50-5f55-a400-44f715451777@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

I'm looking into an issue where removing a virtio disk via sysfs while another
process is issuing write() calls results in the writing task going into a
livelock:


root@guest # cat test.sh
#!/bin/bash

dd if=/dev/zero of=/dev/vda bs=1M count=10000 &
sleep 1
echo 1 > /sys/bus/pci/devices/0000:00:04.0/remove

root@guest # ls /dev/vd*
/dev/vda

root@guest # grep Dirty /proc/meminfo
Dirty:                 0 kB

root@guest # sh test.sh

root@guest # ps aux | grep "[d]d if"
root      1699 38.6  0.0 111424  1216 hvc0     D+   10:48   0:01 dd if=/dev/zero of=/dev/vda bs=1M count=10000

root@guest # ls /dev/vd*
ls: cannot access /dev/vd*: No such file or directory

root@guest # cat /proc/1699/stack
[<0>] 0xc0000000ffe28218
[<0>] __switch_to+0x31c/0x480
[<0>] balance_dirty_pages+0x990/0xb90
[<0>] balance_dirty_pages_ratelimited+0x50c/0x6c0
[<0>] generic_perform_write+0x1b0/0x260
[<0>] __generic_file_write_iter+0x200/0x240
[<0>] blkdev_write_iter+0xa4/0x150
[<0>] __vfs_write+0x14c/0x240
[<0>] vfs_write+0xd0/0x240
[<0>] ksys_write+0x6c/0x110
[<0>] system_call+0x58/0x6c

root@guest # grep Dirty /proc/meminfo
Dirty:           1506816 kB

---

I have done some tracing and I believe this is caused by the clearing of
'WB_registered' in 'wb_shutdown':

<snip>
sh-1697  [000] ....  3994.541664: sysfs_remove_link <-del_gendisk
sh-1697  [000] ....  3994.541671: wb_shutdown <-bdi_unregister
<snip>

Later, when 'balance_dirty_pages' tries to start writeback, it doesn't happen
because 'WB_registered' is not set:

fs/fs-writeback.c

static void wb_wakeup(struct bdi_writeback *wb)
{
        spin_lock_bh(&wb->work_lock);
        if (test_bit(WB_registered, &wb->state))
                mod_delayed_work(bdi_wq, &wb->dwork, 0);
        spin_unlock_bh(&wb->work_lock);
}

So we get stuck in a loop in 'balance_dirty_pages':

root@guest # cat /sys/kernel/debug/tracing/set_ftrace_filter
balance_dirty_pages_ratelimited
balance_dirty_pages
wb_wakeup
wb_workfn
io_schedule_timeout

<snip>
dd-1699  [000] .... 11192.535946: wb_wakeup <-balance_dirty_pages
dd-1699  [000] .... 11192.535950: io_schedule_timeout <-balance_dirty_pages
dd-1699  [000] .... 11192.745968: wb_wakeup <-balance_dirty_pages
dd-1699  [000] .... 11192.745972: io_schedule_timeout <-balance_dirty_pages
<snip>


The test on 'WB_registered' before starting the writeback task is introduced
by: "5acda9 bdi: avoid oops on device removal".

I have made a *naive* attempt at fixing it by allowing writeback to happen even
without 'WB_registered':


diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index d4d04fe..050b067 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -982,7 +982,7 @@ void wb_start_background_writeback(struct bdi_writeback *wb)
 	 * writeback as soon as there is no other work to do.
 	 */
 	trace_writeback_wake_background(wb);
-	wb_wakeup(wb);
+	mod_delayed_work(bdi_wq, &wb->dwork, 0);
 }
 
 /*
@@ -1933,7 +1933,7 @@ void wb_workfn(struct work_struct *work)
 						struct bdi_writeback, dwork);
 	long pages_written;
 
-	set_worker_desc("flush-%s", dev_name(wb->bdi->dev));
+	set_worker_desc("flush-%s", wb->bdi->dev ? dev_name(wb->bdi->dev) : "?" );
 	current->flags |= PF_SWAPWRITE;
 
 	if (likely(!current_is_workqueue_rescuer() ||
--


The effect of that is that the 'dd' process now finishes successfully and we
get "Buffer I/O error"s for the dirty pages that remain. I believe this to be
in conformance with existing interfaces since dd does not issue any fsync()
calls.


Does my analysis make any sense and would something along these lines be
acceptable as a solution?


Cheers
