Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: brking@linux.vnet.ibm.com,
	bart.vanassche@wdc.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/6] sbitmap: make sb_for_each_fn() return void
Date: Fri,  4 Aug 2017 09:04:22 -0600
Message-Id: <1501859062-11120-7-git-send-email-axboe@kernel.dk>
In-Reply-To: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

The intent was for users to be able to continue/break iteration
based on the return value of this callback function, but all
callers now always return true. Hence it's pointless to return
anything at all. Change it to void, and update the users of it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-tag.c      | 6 ++----
 block/blk-mq.c          | 3 +--
 include/linux/sbitmap.h | 6 ++----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index b856b2827157..5ee218f11f81 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -202,7 +202,7 @@ struct bt_iter_data {
 	bool reserved;
 };
 
-static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
+static void bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 {
 	struct bt_iter_data *iter_data = data;
 	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
@@ -216,7 +216,6 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 
 	if (rq && rq->q == hctx->queue)
 		iter_data->fn(hctx, rq, iter_data->data, reserved);
-	return true;
 }
 
 static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
@@ -239,7 +238,7 @@ struct bt_tags_iter_data {
 	bool reserved;
 };
 
-static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
+static void bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 {
 	struct bt_tags_iter_data *iter_data = data;
 	struct blk_mq_tags *tags = iter_data->tags;
@@ -251,7 +250,6 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	rq = tags->rqs[bitnr];
 	if (rq)
 		iter_data->fn(rq, iter_data->data, reserved);
-	return true;
 }
 
 static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 410ed246bc9b..c8d568aafcec 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -846,7 +846,7 @@ struct flush_busy_ctx_data {
 	struct list_head *list;
 };
 
-static bool flush_busy_ctx(struct sbitmap *sb, unsigned int bitnr, void *data)
+static void flush_busy_ctx(struct sbitmap *sb, unsigned int bitnr, void *data)
 {
 	struct flush_busy_ctx_data *flush_data = data;
 	struct blk_mq_hw_ctx *hctx = flush_data->hctx;
@@ -856,7 +856,6 @@ static bool flush_busy_ctx(struct sbitmap *sb, unsigned int bitnr, void *data)
 	spin_lock(&ctx->lock);
 	list_splice_tail_init(&ctx->rq_list, flush_data->list);
 	spin_unlock(&ctx->lock);
-	return true;
 }
 
 /*
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index a1904aadbc45..33c3d8957927 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -211,7 +211,7 @@ bool sbitmap_any_bit_set(const struct sbitmap *sb);
  */
 bool sbitmap_any_bit_clear(const struct sbitmap *sb);
 
-typedef bool (*sb_for_each_fn)(struct sbitmap *, unsigned int, void *);
+typedef void (*sb_for_each_fn)(struct sbitmap *, unsigned int, void *);
 
 /**
  * sbitmap_for_each_set() - Iterate over each set bit in a &struct sbitmap.
@@ -241,9 +241,7 @@ static inline void sbitmap_for_each_set(struct sbitmap *sb, sb_for_each_fn fn,
 			if (nr >= word->depth)
 				break;
 
-			if (!fn(sb, off + nr, data))
-				return;
-
+			fn(sb, off + nr, data);
 			nr++;
 		}
 	}
-- 
2.7.4
