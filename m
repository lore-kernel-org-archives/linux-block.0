Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] block: Fix list corruption of blk stats callback list
Date: Tue, 11 Apr 2017 11:29:01 +0200
Message-Id: <20170411092901.5974-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

When CFQ calls wbt_disable_default(), it will call
blk_stat_remove_callback() to stop gathering IO statistics for the
purposes of writeback throttling. Later, when request_queue is
unregistered, wbt_exit() will call blk_stat_remove_callback() again
which will try to delete callback from the list again and possibly cause
list corruption.

Fix the problem by making wbt_disable_default() called wbt_exit() which
is properly guarded against being called multiple times.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-wbt.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

So this fixes the list debug errors reported by 0-day for me. It was a
pre-existing problem with wbt_disable_default().

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index ffa80e11cf14..b3b79149d3a0 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -653,19 +653,15 @@ void wbt_set_write_cache(struct rq_wb *rwb, bool write_cache_on)
 		rwb->wc = write_cache_on;
 }
 
- /*
- * Disable wbt, if enabled by default. Only called from CFQ, if we have
- * cgroups enabled
+/*
+ * Disable wbt, if enabled by default. Only called from CFQ.
  */
 void wbt_disable_default(struct request_queue *q)
 {
 	struct rq_wb *rwb = q->rq_wb;
 
-	if (rwb && rwb->enable_state == WBT_STATE_ON_DEFAULT) {
-		blk_stat_remove_callback(q, rwb->cb);
-		rwb->win_nsec = rwb->min_lat_nsec = 0;
-		wbt_update_limits(rwb);
-	}
+	if (rwb && rwb->enable_state == WBT_STATE_ON_DEFAULT)
+		wbt_exit(q);
 }
 EXPORT_SYMBOL_GPL(wbt_disable_default);
 
-- 
2.12.0
