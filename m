Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/30] blk-mq: provide mq_ops->busy() hook
Date: Wed, 31 Oct 2018 11:58:59 -0600
Message-Id: <20181031175922.8849-8-axboe@kernel.dk>
In-Reply-To: <20181031175922.8849-1-axboe@kernel.dk>
References: <20181031175922.8849-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We'll hook into this from blk_lld_busy(), allowing blk-mq to also
return whether or not a given queue currently has requests in
progress.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       | 2 ++
 include/linux/blk-mq.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index bc6ea87d10e0..c99088d0e80b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3429,6 +3429,8 @@ int blk_lld_busy(struct request_queue *q)
 {
 	if (q->lld_busy_fn)
 		return q->lld_busy_fn(q);
+	if (q->mq_ops && q->mq_ops->busy)
+		return q->mq_ops->busy(q);
 
 	return 0;
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2286dc12c6bc..5c8418ebbfd6 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -114,6 +114,7 @@ typedef void (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
 typedef void (busy_tag_iter_fn)(struct request *, void *, bool);
 typedef int (poll_fn)(struct blk_mq_hw_ctx *, unsigned int);
 typedef int (map_queues_fn)(struct blk_mq_tag_set *set);
+typedef bool (busy_fn)(struct request_queue *);
 
 
 struct blk_mq_ops {
@@ -165,6 +166,11 @@ struct blk_mq_ops {
 	/* Called from inside blk_get_request() */
 	void (*initialize_rq_fn)(struct request *rq);
 
+	/*
+	 * If set, returns whether or not this queue currently is busy
+	 */
+	busy_fn			*busy;
+
 	map_queues_fn		*map_queues;
 
 #ifdef CONFIG_BLK_DEBUG_FS
-- 
2.17.1
