Return-Path: <m.mizuma@jp.fujitsu.com>
Message-ID: <583FE310.7040607@jp.fujitsu.com>
Date: Thu, 1 Dec 2016 17:45:04 +0900
From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
MIME-Version: 1.0
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] block: avoid incorrect bdi_unregiter call in blk_cleanup_queue
Content-Type: text/plain; charset="iso-2022-jp"
List-ID: <linux-block@vger.kernel.org>

blk_cleanup_queue() should call bdi_unregister() only if WB_registered
is set to bdi->wb.state. Because, blk_cleanup_queue() may be called
before bdi_register() is called, for example, error path.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 block/blk-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 14d7c07..c1ab17e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -595,7 +595,8 @@ void blk_cleanup_queue(struct request_queue *q)
 		q->queue_lock = &q->__queue_lock;
 	spin_unlock_irq(lock);
 
-	bdi_unregister(&q->backing_dev_info);
+	if (test_bit(WB_registered, &q->backing_dev_info.wb.state))
+		bdi_unregister(&q->backing_dev_info);
 
 	/* @q is and will stay empty, shutdown and put */
 	blk_put_queue(q);
-- 
1.8.3.1
