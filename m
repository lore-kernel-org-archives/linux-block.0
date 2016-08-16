Return-Path: <Bart.VanAssche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH] block: Fix race triggered by blk_set_queue_dying()
Message-ID: <e50dbd54-30fb-bf59-0ce6-5ccf1d830017@sandisk.com>
Date: Tue, 16 Aug 2016 16:48:36 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

blk_set_queue_dying() can be called while another thread is
submitting I/O or changing queue flags, e.g. through dm_stop_queue().
Hence protect the QUEUE_FLAG_DYING flag change with locking.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: stable <stable@vger.kernel.org>
---
 block/blk-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e0bc563..96d5835 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -515,7 +515,9 @@ EXPORT_SYMBOL_GPL(blk_queue_bypass_end);
 
 void blk_set_queue_dying(struct request_queue *q)
 {
-	queue_flag_set_unlocked(QUEUE_FLAG_DYING, q);
+	spin_lock_irq(q->queue_lock);
+	queue_flag_set(QUEUE_FLAG_DYING, q);
+	spin_unlock_irq(q->queue_lock);
 
 	if (q->mq_ops)
 		blk_mq_wake_waiters(q);
-- 
2.9.2
