Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	kernel-team@fb.com,
	linux-block@vger.kernel.org
Subject: [PATCH 1/6] blk-iolatency: use q->nr_requests directly
Date: Mon, 10 Sep 2018 16:49:27 -0400
Message-Id: <20180910204932.14323-2-josef@toxicpanda.com>
In-Reply-To: <20180910204932.14323-1-josef@toxicpanda.com>
References: <20180910204932.14323-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

We were using blk_queue_depth() assuming that it would return
nr_requests, but we hit a case in production on drives that had to have
NCQ turned off in order for them to not shit the bed which resulted in a
qd of 1, even though the nr_requests was much larger.  iolatency really
only cares about requests we are allowed to queue up, as any io that
get's onto the request list is going to be serviced soonish, so we want
to be throttling before the bio gets onto the request list.  To make
iolatency work as expected, simply use q->nr_requests instead of
blk_queue_depth() as that is what we actually care about.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-iolatency.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 19923f8a029d..9b8d2012ea88 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -255,7 +255,7 @@ static void scale_cookie_change(struct blk_iolatency *blkiolat,
 				struct child_latency_info *lat_info,
 				bool up)
 {
-	unsigned long qd = blk_queue_depth(blkiolat->rqos.q);
+	unsigned long qd = blkiolat->rqos.q->nr_requests;
 	unsigned long scale = scale_amount(qd, up);
 	unsigned long old = atomic_read(&lat_info->scale_cookie);
 	unsigned long max_scale = qd << 1;
@@ -295,7 +295,7 @@ static void scale_cookie_change(struct blk_iolatency *blkiolat,
  */
 static void scale_change(struct iolatency_grp *iolat, bool up)
 {
-	unsigned long qd = blk_queue_depth(iolat->blkiolat->rqos.q);
+	unsigned long qd = iolat->blkiolat->rqos.q->nr_requests;
 	unsigned long scale = scale_amount(qd, up);
 	unsigned long old = iolat->rq_depth.max_depth;
 	bool changed = false;
@@ -884,7 +884,7 @@ static void iolatency_pd_init(struct blkg_policy_data *pd)
 
 	rq_wait_init(&iolat->rq_wait);
 	spin_lock_init(&iolat->child_lat.lock);
-	iolat->rq_depth.queue_depth = blk_queue_depth(blkg->q);
+	iolat->rq_depth.queue_depth = blkg->q->nr_requests;
 	iolat->rq_depth.max_depth = UINT_MAX;
 	iolat->rq_depth.default_depth = iolat->rq_depth.queue_depth;
 	iolat->blkiolat = blkiolat;
-- 
2.14.3
