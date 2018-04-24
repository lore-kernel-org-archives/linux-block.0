Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757532AbeDXMPP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Apr 2018 08:15:15 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 4/6] bcache: add wait_for_kthread_stop() in bch_allocator_thread()
Date: Tue, 24 Apr 2018 20:14:44 +0800
Message-Id: <20180424121446.130552-5-colyli@suse.de>
In-Reply-To: <20180424121446.130552-1-colyli@suse.de>
References: <20180424121446.130552-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When CACHE_SET_IO_DISABLE is set on cache set flags, bcache allocator
thread routine bch_allocator_thread() may stop the while-loops and
exit. Then it is possible to observe the following kernel oops message,

[  631.068366] bcache: bch_btree_insert() error -5
[  631.069115] bcache: cached_dev_detach_finish() Caching disabled for sdf
[  631.070220] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[  631.070250] PGD 0 P4D 0
[  631.070261] Oops: 0002 [#1] SMP PTI
[snipped]
[  631.070578] Workqueue: events cache_set_flush [bcache]
[  631.070597] RIP: 0010:exit_creds+0x1b/0x50
[  631.070610] RSP: 0018:ffffc9000705fe08 EFLAGS: 00010246
[  631.070626] RAX: 0000000000000001 RBX: ffff880a622ad300 RCX: 000000000000000b
[  631.070645] RDX: 0000000000000601 RSI: 000000000000000c RDI: 0000000000000000
[  631.070663] RBP: ffff880a622ad300 R08: ffffea00190c66e0 R09: 0000000000000200
[  631.070682] R10: ffff880a48123000 R11: ffff880000000000 R12: 0000000000000000
[  631.070700] R13: ffff880a4b160e40 R14: ffff880a4b160000 R15: 0ffff880667e2530
[  631.070719] FS:  0000000000000000(0000) GS:ffff880667e00000(0000) knlGS:0000000000000000
[  631.070740] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  631.070755] CR2: 0000000000000000 CR3: 000000000200a001 CR4: 00000000003606e0
[  631.070774] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  631.070793] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  631.070811] Call Trace:
[  631.070828]  __put_task_struct+0x55/0x160
[  631.070845]  kthread_stop+0xee/0x100
[  631.070863]  cache_set_flush+0x11d/0x1a0 [bcache]
[  631.070879]  process_one_work+0x146/0x340
[  631.070892]  worker_thread+0x47/0x3e0
[  631.070906]  kthread+0xf5/0x130
[  631.070917]  ? max_active_store+0x60/0x60
[  631.070930]  ? kthread_bind+0x10/0x10
[  631.070945]  ret_from_fork+0x35/0x40
[snipped]
[  631.071017] RIP: exit_creds+0x1b/0x50 RSP: ffffc9000705fe08
[  631.071033] CR2: 0000000000000000
[  631.071045] ---[ end trace 011c63a24b22c927 ]---
[  631.071085] bcache: bcache_device_free() bcache0 stopped

The reason is when cache_set_flush() tries to call kthread_stop() to stop
allocator thread, but it exits already due to cache device I/O errors.

This patch adds wait_for_kthread_stop() at tail of bch_allocator_thread(),
to prevent the thread routine exiting directly. Then the allocator thread
can be blocked at wait_for_kthread_stop() and wait for cache_set_flush()
to stop it by calling kthread_stop().

Fixes: 771f393e8ffc ("bcache: add CACHE_SET_IO_DISABLE to struct cache_set flags")
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 004cc3cc6123..dcf51db0971f 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -378,6 +378,7 @@ static int bch_allocator_thread(void *arg)
 			bch_prio_write(ca);
 		}
 	}
+	wait_for_kthread_stop();
 }
 
 /* Allocation */
-- 
2.16.2
