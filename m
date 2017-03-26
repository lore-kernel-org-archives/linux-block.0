Return-Path: <jhugo@codeaurora.org>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [BUG] Deadlock due due to interactions of block, RCU, and cpu offline
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: pprakash@codeaurora.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Richard Cochran <rcochran@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Richard Weinberger <richard@nod.at>
Message-ID: <db9c91f6-1b17-6136-84f0-03c3c2581ab4@codeaurora.org>
Date: Sun, 26 Mar 2017 17:10:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hello,

I observe that running stress-ng with the cpu-online and fstat tests 
results in a deadlock of hung tasks:

[  366.810486] INFO: task stress-ng-cpu-o:2590 blocked for more than 120 
seconds.
[  366.817689]       Not tainted 4.9.0 #39
[  366.821504] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  366.829320] stress-ng-cpu-o D    0  2590   2589 0x00000008
[  366.834803] Call trace:
[  366.837222] [<ffff000008085dd0>] __switch_to+0x60/0x70
[  366.842338] [<ffff000008a23c18>] __schedule+0x178/0x648
[  366.847550] [<ffff000008a24120>] schedule+0x38/0x98
[  366.852408] [<ffff00000848b774>] blk_mq_freeze_queue_wait+0x64/0x1a8
[  366.858749] [<ffff00000848e9d4>] blk_mq_queue_reinit_work+0x74/0x110
[  366.865081] [<ffff00000848ea94>] blk_mq_queue_reinit_dead+0x24/0x30
[  366.871335] [<ffff0000080c9898>] cpuhp_invoke_callback+0x98/0x4a8
[  366.877411] [<ffff0000080cb084>] cpuhp_down_callbacks+0x114/0x150
[  366.883484] [<ffff000008a22578>] _cpu_down+0x100/0x1d8
[  366.888609] [<ffff0000080cbfdc>] do_cpu_down+0x4c/0x78
[  366.893727] [<ffff0000080cc02c>] cpu_down+0x24/0x30
[  366.898593] [<ffff0000086aaf28>] cpu_subsys_offline+0x20/0x30
[  366.904318] [<ffff0000086a53d8>] device_offline+0xa8/0xd8
[  366.909704] [<ffff0000086a550c>] online_store+0x4c/0xa8
[  366.914907] [<ffff0000086a241c>] dev_attr_store+0x44/0x60
[  366.920294] [<ffff0000082b6a24>] sysfs_kf_write+0x5c/0x78
[  366.925672] [<ffff0000082b5cec>] kernfs_fop_write+0xbc/0x1e8
[  366.931318] [<ffff000008238320>] __vfs_write+0x48/0x138
[  366.936526] [<ffff000008239078>] vfs_write+0xa8/0x1c0
[  366.941557] [<ffff00000823a08c>] SyS_write+0x54/0xb0
[  366.946511] [<ffff000008083370>] el0_svc_naked+0x24/0x28
[  366.951800] INFO: task stress-ng-fstat:2591 blocked for more than 120 
seconds.
[  366.959008]       Not tainted 4.9.0 #39
[  366.962823] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  366.970640] stress-ng-fstat D    0  2591   2589 0x00000000
[  366.976105] Call trace:
[  366.978540] [<ffff000008085dd0>] __switch_to+0x60/0x70
[  366.983658] [<ffff000008a23c18>] __schedule+0x178/0x648
[  366.988870] [<ffff000008a24120>] schedule+0x38/0x98
[  366.993727] [<ffff00000848b774>] blk_mq_freeze_queue_wait+0x64/0x1a8
[  367.000068] [<ffff00000848e2d0>] blk_mq_freeze_queue+0x28/0x38
[  367.005880] [<ffff0000086d480c>] lo_release+0x64/0x90
[  367.010919] [<ffff000008278bd4>] __blkdev_put+0x26c/0x2c8
[  367.016300] [<ffff000008278fec>] blkdev_put+0x54/0x128
[  367.021418] [<ffff0000082790ec>] blkdev_close+0x2c/0x40
[  367.026631] [<ffff00000823ab58>] __fput+0xa0/0x1e0
[  367.031401] [<ffff00000823ad10>] ____fput+0x20/0x30
[  367.036266] [<ffff0000080e7a40>] task_work_run+0xc8/0xe8
[  367.041557] [<ffff0000080882b4>] do_notify_resume+0xac/0xb8
[  367.047116] [<ffff000008083294>] work_pending+0x8/0x10

I have tested and found this issue to be reproducible on both x86 and 
ARM64 architectures on 4.7, 4.8, 4.9, 4.10, and 4.11-rc3 kernels.

Using the below test methodology [1], the issue reproduces within a few 
minutes.

Using ftrace, I have analyzed the issue on 4.9 and I believe I've found 
the root cause [2].

Based on my analysis, I have developed a fix [3], which addresses the 
issue as I am able to run stress-ng for over an hour where I was unable 
to do so before, however I do not know the full extend of impacts from 
this fix, and look for guidance from the community to determine the 
final fix.


[1] Test methodology
--------------------
Boot a multicore system such as a desktop i5 system with nr_cpus=2

Enable all logging to determine when the deadlock occurs (prints from 
test stop flowing out of the serial port)
      echo 1 > /sys/module/printk/parameters/ignore_loglevel

Run stress-ng
      stress-ng --fstat 1 --cpu-online 1 -t 3600

Wait for the test output to stop, and the hung task watchdog to fire.


[2] Analysis
------------
Again, this analysis is based upon the 4.9 kernel, but believe it to 
still apply to newer kernels.

I conclude that the hung tasks occur due to a race condition which 
results in a deadlock.

The race condition occurs between "normal" work in the block layer on a 
core (the stress-ng-fstat task in the above dump) and cpu offline of 
that core (the stress-ng-cpu-o task in the above dump).

The fput() from userspace in the fstat task results in a call to 
blk_mq_freeze_queue(), which drops the last reference to the queue via 
percpu_ref_kill(), and then waits for the ref count of the queue to hit 
0 in blk_mq_freeze_queue_wait().  percpu_ref_kill() will result in 
__percpu_ref_switch_to_atomic() which will use call_rcu_sched() to setup 
delayed work to finalize the percpu_ref cleanup and drop the ref count to 0.

Note that call_rcu_sched() queues the work to a per-cpu queue, thus the 
work can only be run on the core it is queued on, by the work thread 
that is pinned to that core.

It is a race between this work running, and the cpu offline processing.

If the cpu offline processing is able to get to and process the 
RCU/tree:online state before the queued work from the block layer,  then 
the pinned work thread will be migrated to another core via 
rcutree_offline_cpu(), and the work will not be able to execute.

This race condition does not result in deadlock until later in the cpu 
offline processing.  Once we hit the block/mq:prepare state the block 
layer freezes all the queues and waits for the ref counts to hit 0. 
This normally works because at this point the cpu being offlined is dead 
from cpu:teardown, and the offline processing is occuring on another 
active cpu, so call_rcu_sched() will queue work to an active cpu where 
it can get processed.  However the fstat process already did that work 
for one of the queues to be frozen in the block layer, so the processing 
of the block/mq:prepare state waits on the same ref count as fstat to 
hit 0.  Thus we see the result of this as the stress-ng-cpu-o task above.

The block/mq:prepare processing stalls the cpu offline processing which 
causes a deadlock because the processing does not get to the 
RCU/tree:prepare state which migrates all of the queued work from the 
offline cpu to another cpu, which would allow the work that the fstat 
task queued to execute, drop the ref count to 0, and unblock both 
stalled tasks.

By reordering the cpu offline states such the shutdown processing of 
RCU/tree:prepare occurs before block/mq:prepare [3], we prevent deadlock 
by enabling the queued work in the RCU framework to run elsewhere, and 
eventually unblock the tasks waiting on the ref count.

However, it is not entirely clear what are the full ramifications of 
this reorder.  I assume the ordering of these cpu online/offline states 
is carefully considered, and without that knowledge, I could not say for 
certain that my fix [3] is safe.

What is the opinion of the domain experts?

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.


[3] Proposed fix
---8>---
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index afe641c..9b86db9 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -49,6 +49,7 @@ enum cpuhp_state {
         CPUHP_ARM_SHMOBILE_SCU_PREPARE,
         CPUHP_SH_SH3X_PREPARE,
         CPUHP_BLK_MQ_PREPARE,
+       CPUHP_RCUTREE_PREP2,
         CPUHP_TIMERS_DEAD,
         CPUHP_NOTF_ERR_INJ_PREPARE,
         CPUHP_MIPS_SOC_PREPARE,
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 29de1a9..b46c573 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1289,6 +1289,11 @@ static int __init cpu_hotplug_pm_sync_init(void)
         [CPUHP_RCUTREE_PREP] = {
                 .name                   = "RCU/tree:prepare",
                 .startup.single         = rcutree_prepare_cpu,
+               .teardown.single        = NULL,
+       },
+       [CPUHP_RCUTREE_PREP2] = {
+               .name                   = "RCU/tree:dead",
+               .startup.single         = NULL,
                 .teardown.single        = rcutree_dead_cpu,
         },
         /*
