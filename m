Return-Path: <prvs=400f95d56=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jens Axboe <axboe@kernel.dk>,
	Dmitry Vyukov <dvyukov@google.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v2 2/2] block: Make I/O timeout failure injection again task-independent
Date: Tue, 22 Aug 2017 16:00:43 -0700
Message-Id: <20170822230043.9968-3-bart.vanassche@wdc.com>
In-Reply-To: <20170822230043.9968-1-bart.vanassche@wdc.com>
References: <20170822230043.9968-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Commit e41d58185f14 made all faults that are triggered from task
context, including I/O timeouts, dependent on the failure
injection settings for that task. Make it again possible to inject
I/O timeout failures independent of task context. An example for a
fault injection for which this patch makes a difference (from a VM
booted with the 'threadirqs' command line parameter):

FAULT_INJECTION: forcing a failure. name fail_io_timeout, interval 1, probability 100, space 0, times 1
CPU: 6 PID: 1253 Comm: irq/36-skd0-msi Not tainted 4.13.0-rc2-dbg+ #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc26 04/01/2014
Call Trace:
 dump_stack+0x8e/0xcd
 should_fail+0x154/0x160
 blk_should_fake_timeout+0x27/0x30
 blk_mq_complete_request+0x11/0x30
 skd_end_request+0x32/0xc0 [skd]
 skd_isr_completion_posted.isra.30+0x14a/0x400 [skd]
 skd_comp_q+0x40/0xb0 [skd]
 irq_forced_thread_fn+0x2a/0x70
 irq_thread+0x144/0x1a0
 kthread+0x125/0x140
 ret_from_fork+0x2a/0x40

Fixes: commit e41d58185f14 ("fault-inject: support systematic fault injection")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 block/blk-timeout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 17ec83bb0900..2e92b20b125f 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -11,7 +11,7 @@
 
 #ifdef CONFIG_FAIL_IO_TIMEOUT
 
-static DECLARE_FAULT_ATTR(fail_io_timeout);
+static DECLARE_GLOBAL_FAULT_ATTR(fail_io_timeout);
 
 static int __init setup_fail_io_timeout(char *str)
 {
-- 
2.14.0
