Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Akhil Bhansali <Akhil.Bhansali@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>,
	Andrew Morton <akpm@osdl.org>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH 01/55] block: Relax a check in blk_start_queue()
Date: Thu, 17 Aug 2017 13:12:44 -0700
Message-Id: <20170817201338.16537-2-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Calling blk_start_queue() from interrupt context with the queue
lock held and without disabling IRQs, as the skd driver does, is
safe. This patch avoids that loading the skd driver triggers the
following warning:

WARNING: CPU: 11 PID: 1348 at block/blk-core.c:283 blk_start_queue+0x84/0xa0
RIP: 0010:blk_start_queue+0x84/0xa0
Call Trace:
 skd_unquiesce_dev+0x12a/0x1d0 [skd]
 skd_complete_internal+0x1e7/0x5a0 [skd]
 skd_complete_other+0xc2/0xd0 [skd]
 skd_isr_completion_posted.isra.30+0x2a5/0x470 [skd]
 skd_isr+0x14f/0x180 [skd]
 irq_forced_thread_fn+0x2a/0x70
 irq_thread+0x144/0x1a0
 kthread+0x125/0x140
 ret_from_fork+0x2a/0x40

Fixes: commit a038e2536472 ("[PATCH] blk_start_queue() must be called with irq disabled - add warning")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: <stable@vger.kernel.org>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d836c84ad3da..d579501f24ba 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -280,7 +280,7 @@ EXPORT_SYMBOL(blk_start_queue_async);
 void blk_start_queue(struct request_queue *q)
 {
 	lockdep_assert_held(q->queue_lock);
-	WARN_ON(!irqs_disabled());
+	WARN_ON(!in_interrupt() && !irqs_disabled());
 	WARN_ON_ONCE(q->mq_ops);
 
 	queue_flag_clear(QUEUE_FLAG_STOPPED, q);
-- 
2.14.0
