Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] blk-mq: Revert "blk-mq: reimplement blk_mq_hw_queue_mapped"
Date: Wed, 11 Apr 2018 18:47:44 +0800
Message-Id: <20180411104744.21228-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

This reverts commit 127276c6ce5a30fcc806b7fe53015f4f89b62956.

When all CPUs of one hw queue become offline, there still may have IOs
not completed from this hctx. But blk_mq_hw_queue_mapped() is called in
blk_mq_queue_tag_busy_iter(), which is used for iterating request in timeout
handler, timeout event will be missed on the inactive hctx, then request may
never be completed.

Also the replementation of blk_mq_hw_queue_mapped() doesn't match the helper's
name any more, and it should have been named as blk_mq_hw_queue_active().

Even other callers need further verification about this reimplemenation.

So revert this patch now, and we can improve hw queue activate/inactivate event
after adequent researching and test.

Cc: Stefan Haberland <sth@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reported-by: Jens Axboe <axboe@kernel.dk>
Fixes: 	127276c6ce5a30fcc ("blk-mq: reimplement blk_mq_hw_queue_mapped")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 502af371b83b..88c558f71819 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -181,7 +181,7 @@ static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
 
 static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 {
-	return cpumask_first_and(hctx->cpumask, cpu_online_mask) < nr_cpu_ids;
+	return hctx->nr_ctx && hctx->tags;
 }
 
 void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
-- 
2.9.5
