Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk, shli@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-throttle: only update last_low_overflow_time when LIMIT_MAX
Date: Mon,  9 Apr 2018 14:16:02 +0800
Message-Id: <1523254562-2006-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Currently, last_low_overflow_time will be updated whenever bios
are throttled and queued. This is true when LIMIT_MAX, but not
for LIMIT_LOW. what last_low_overflow_time indicates is dispatching
not submitting. When LIMIT_LOW, the dispatch bps/iops should never
be above the low limit, we should not update last_low_overflow_time
at the moment. Otherwise, it will be hard to upgrade limit_index
when there is always bios to be submitted.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-throttle.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 851aa16..b5ba845 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2214,7 +2214,8 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 		/* if above limits, break to queue */
 		if (!tg_may_dispatch(tg, bio, NULL)) {
-			tg->last_low_overflow_time[rw] = jiffies;
+			if (td->limit_index == LIMIT_MAX)
+				tg->last_low_overflow_time[rw] = jiffies;
 			if (throtl_can_upgrade(td, tg)) {
 				throtl_upgrade_state(td);
 				goto again;
@@ -2258,7 +2259,8 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		   tg->io_disp[rw], tg_iops_limit(tg, rw),
 		   sq->nr_queued[READ], sq->nr_queued[WRITE]);
 
-	tg->last_low_overflow_time[rw] = jiffies;
+	if (td->limit_index == LIMIT_MAX)
+		tg->last_low_overflow_time[rw] = jiffies;
 
 	td->nr_queued[rw]++;
 	throtl_add_bio_tg(bio, qn, tg);
-- 
2.7.4
