Return-Path: <axboe@kernel.dk>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Josef Bacik <josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blk-wbt: don't maintain inflight counts if disabled
Message-ID: <504f587c-681b-5502-30e3-9a3c4ed6c8fe@kernel.dk>
Date: Thu, 23 Aug 2018 09:15:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

A previous commit removed the ability to have per-rq flags. We used
those flags to maintain inflight counts. Since we don't have those
anymore, we have to always maintain inflight counts, even if wbt is
disabled. This is clearly suboptimal.

Add a queue quiesce around changing the wbt latency settings from sysfs
to work around this. With that, we can reliably put the enabled check in
our bio_to_wbt_flags(), since we know the WBT_TRACKED flag will be
consistent for the lifetime of the request.

Fixes: Fixes: c1c80384c8f ("block: remove external dependency on wbt_flags")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index bb109bb0a055..3772671cf2bc 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -453,9 +453,26 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 	else if (val >= 0)
 		val *= 1000ULL;
 
-	wbt_set_min_lat(q, val);
+	/*
+	 * Ensure that the queue is idled, in case the latency update
+	 * ends up either enabling or disabling wbt completely. We can't
+	 * have IO inflight if that happens.
+	 */
+	if (q->mq_ops) {
+		blk_mq_freeze_queue(q);
+		blk_mq_quiesce_queue(q);
+	} else
+		blk_queue_bypass_start(q);
 
+	wbt_set_min_lat(q, val);
 	wbt_update_limits(q);
+
+	if (q->mq_ops) {
+		blk_mq_unquiesce_queue(q);
+		blk_mq_unfreeze_queue(q);
+	} else
+		blk_queue_bypass_end(q);
+
 	return count;
 }
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index c9358f1981fb..85e4a40a2a0a 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -540,6 +546,9 @@ static enum wbt_flags bio_to_wbt_flags(struct rq_wb *rwb, struct bio *bio)
 {
 	enum wbt_flags flags = 0;
 
+	if (!rwb_enabled(rwb))
+		return 0;
+
 	if (bio_op(bio) == REQ_OP_READ) {
 		flags = WBT_READ;
 	} else if (wbt_should_throttle(rwb, bio)) {


-- 
Jens Axboe
