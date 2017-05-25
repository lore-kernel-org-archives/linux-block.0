Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, "Omar
 Sandoval" <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 11/19] blk-mq: Reduce blk_mq_hw_ctx size
Date: Thu, 25 May 2017 11:43:19 -0700
Message-ID: <20170525184327.23570-12-bart.vanassche@sandisk.com>
In-Reply-To: <20170525184327.23570-1-bart.vanassche@sandisk.com>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Since the srcu structure is rather large (184 bytes on an x86-64
system), only allocate it if needed.

Reported-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 16 +++++++++++++++-
 include/linux/blk-mq.h |  5 +++--
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index bc96e6007e53..b8092786d42f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2227,6 +2227,20 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_init_queue);
 
+static int blk_mq_hw_ctx_size(struct request_queue *q)
+{
+	int hw_ctx_size = sizeof(struct blk_mq_hw_ctx);
+
+	BUILD_BUG_ON(ALIGN(offsetof(struct blk_mq_hw_ctx, queue_rq_srcu),
+			   __alignof__(struct blk_mq_hw_ctx)) !=
+		     sizeof(struct blk_mq_hw_ctx));
+
+	if (tag_set->flags & BLK_MQ_F_BLOCKING)
+		hw_ctx_size += sizeof(struct srcu_struct);
+
+	return hw_ctx_size;
+}
+
 static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 						struct request_queue *q)
 {
@@ -2241,7 +2255,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 			continue;
 
 		node = blk_mq_hw_queue_to_node(q->mq_map, i);
-		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
+		hctxs[i] = kzalloc_node(blk_mq_hw_ctx_size(q),
 					GFP_KERNEL, node);
 		if (!hctxs[i])
 			break;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index c63d1d98404a..c589b81be491 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -39,8 +39,6 @@ struct blk_mq_hw_ctx {
 	struct blk_mq_tags	*tags;
 	struct blk_mq_tags	*sched_tags;
 
-	struct srcu_struct	queue_rq_srcu[1];
-
 	unsigned long		queued;
 	unsigned long		run;
 #define BLK_MQ_MAX_DISPATCH_ORDER	7
@@ -62,6 +60,9 @@ struct blk_mq_hw_ctx {
 	struct dentry		*debugfs_dir;
 	struct dentry		*sched_debugfs_dir;
 #endif
+
+	/* Must be the last member - see also blk_mq_hw_ctx_size(). */
+	struct srcu_struct	queue_rq_srcu[0];
 };
 
 struct blk_mq_tag_set {
-- 
2.12.2
