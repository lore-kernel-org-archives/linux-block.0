Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Josef Bacik <jbacik@fb.com>
Subject: [PATCH] blk-wbt: fix IO hang in wbt_wait()
Date: Tue, 14 Aug 2018 23:57:49 +0800
Message-Id: <20180814155749.28912-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On wbt invariant is that if one IO is tracked via WBT_TRACKED, rqw->inflight
should be updated for tracking this IO.

But commit c1c80384c8f ("block: remove external dependency on wbt_flags")
forgets to remove the early handling of !rwb_enabled(rwb) inside wbt_wait(),
then the inflight counter may not be increased in wbt_wait(), but decreased
in wbt_done() for this kind of IO, so this counter may become negative, then
wbt_wait() may wait forever.

This patch fixes the report in the following link:

	https://marc.info/?l=linux-block&m=153221542021033&w=2

Fixes: c1c80384c8f ("block: remove external dependency on wbt_flags")
Cc: Josef Bacik <jbacik@fb.com>
Reported-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-wbt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 1d94a20374fc..bb93c7c2b182 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -576,12 +576,8 @@ static void wbt_wait(struct rq_qos *rqos, struct bio *bio, spinlock_t *lock)
 	struct rq_wb *rwb = RQWB(rqos);
 	enum wbt_flags flags;
 
-	if (!rwb_enabled(rwb))
-		return;
-
 	flags = bio_to_wbt_flags(rwb, bio);
-
-	if (!wbt_should_throttle(rwb, bio)) {
+	if (!(flags & WBT_TRACKED)) {
 		if (flags & WBT_READ)
 			wb_timestamp(rwb, &rwb->last_issue);
 		return;
-- 
2.9.5
