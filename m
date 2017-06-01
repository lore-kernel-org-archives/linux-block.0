Return-Path: <jiangqi903@gmail.com>
Return-Path: <jiangqi903@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
 boyu.mt@taobao.com, wenqing.lz@taobao.com, qijiang.qj@alibaba-inc.com
From: Joseph Qi <jiangqi903@gmail.com>
Subject: blk-mq: free callback if error occurs in blk_mq_init_allocated_queue
Message-ID: <728065d3-0100-514a-70b0-66b1cfe85480@gmail.com>
Date: Thu, 1 Jun 2017 13:02:40 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

From: Joseph Qi <qijiang.qj@alibaba-inc.com>

If error occurs, we have to free the allocated callback in
blk_mq_init_allocated_queue to avoid memory leaking.

Fixes: 34dbad5d26e2 ("blk-stat: convert to callback-based statistics reporting")
Signed-off-by: Joseph Qi <qijiang.qj@alibaba-inc.com>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f2224ffd..50b5d7b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2273,7 +2273,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	q->queue_ctx = alloc_percpu(struct blk_mq_ctx);
 	if (!q->queue_ctx)
-		goto err_exit;
+		goto err_poll_cb;
 
 	/* init q->mq_kobj and sw queues' kobjects */
 	blk_mq_sysfs_init(q);
@@ -2346,6 +2346,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	kfree(q->queue_hw_ctx);
 err_percpu:
 	free_percpu(q->queue_ctx);
+err_poll_cb:
+	blk_stat_free_callback(q->poll_cb);
 err_exit:
 	q->mq_ops = NULL;
 	return ERR_PTR(-ENOMEM);
-- 
1.8.3.1
