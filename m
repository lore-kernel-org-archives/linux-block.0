Return-Path: <prvs=5014e5409=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 2/7] block: Document more locking requirements
Date: Thu, 30 Nov 2017 16:08:43 -0800
Message-Id: <20171201000848.2656-3-bart.vanassche@wdc.com>
In-Reply-To: <20171201000848.2656-1-bart.vanassche@wdc.com>
References: <20171201000848.2656-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq.c      | 13 +++++++++++--
 block/blk-timeout.c |  3 +++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e1ca7661daa5..7f290a91a612 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -74,6 +74,8 @@ static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
 static void blk_mq_hctx_mark_pending(struct blk_mq_hw_ctx *hctx,
 				     struct blk_mq_ctx *ctx)
 {
+	lockdep_assert_held(&ctx->lock);
+
 	if (!sbitmap_test_bit(&hctx->ctx_map, ctx->index_hw))
 		sbitmap_set_bit(&hctx->ctx_map, ctx->index_hw);
 }
@@ -81,6 +83,8 @@ static void blk_mq_hctx_mark_pending(struct blk_mq_hw_ctx *hctx,
 static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
 				      struct blk_mq_ctx *ctx)
 {
+	lockdep_assert_held(&ctx->lock);
+
 	sbitmap_clear_bit(&hctx->ctx_map, ctx->index_hw);
 }
 
@@ -1003,9 +1007,14 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
 				int flags, void *key)
 {
-	struct blk_mq_hw_ctx *hctx;
+	struct blk_mq_hw_ctx *hctx =
+		container_of(wait, struct blk_mq_hw_ctx, dispatch_wait);
+
+#ifdef CONFIG_LOCKDEP
+	struct sbq_wait_state *ws = bt_wait_ptr(&hctx->tags->bitmap_tags, hctx);
 
-	hctx = container_of(wait, struct blk_mq_hw_ctx, dispatch_wait);
+	lockdep_assert_held(&ws->wait.lock);
+#endif
 
 	list_del_init(&wait->entry);
 	blk_mq_run_hw_queue(hctx, true);
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 764ecf9aeb30..77bf0c6e7c7e 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -77,6 +77,9 @@ ssize_t part_timeout_store(struct device *dev, struct device_attribute *attr,
  */
 void blk_delete_timer(struct request *req)
 {
+	lockdep_assert_held(req->q->queue_lock);
+	WARN_ON_ONCE(req->q->mq_ops);
+
 	list_del_init(&req->timeout_list);
 }
 
-- 
2.15.0
