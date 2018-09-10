Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	kernel-team@fb.com,
	linux-block@vger.kernel.org
Subject: [PATCH 2/6] blk-iolatency: delete changed variable
Date: Mon, 10 Sep 2018 16:49:28 -0400
Message-Id: <20180910204932.14323-3-josef@toxicpanda.com>
In-Reply-To: <20180910204932.14323-1-josef@toxicpanda.com>
References: <20180910204932.14323-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

This was from a previous iteration when we returned whether or not we
changed the scale.  It is unused so remove it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-iolatency.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 9b8d2012ea88..8f32aa1817f8 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -298,7 +298,6 @@ static void scale_change(struct iolatency_grp *iolat, bool up)
 	unsigned long qd = iolat->blkiolat->rqos.q->nr_requests;
 	unsigned long scale = scale_amount(qd, up);
 	unsigned long old = iolat->rq_depth.max_depth;
-	bool changed = false;
 
 	if (old > qd)
 		old = qd;
@@ -308,7 +307,6 @@ static void scale_change(struct iolatency_grp *iolat, bool up)
 			return;
 
 		if (old < qd) {
-			changed = true;
 			old += scale;
 			old = min(old, qd);
 			iolat->rq_depth.max_depth = old;
@@ -316,7 +314,6 @@ static void scale_change(struct iolatency_grp *iolat, bool up)
 		}
 	} else if (old > 1) {
 		old >>= 1;
-		changed = true;
 		iolat->rq_depth.max_depth = max(old, 1UL);
 	}
 }
-- 
2.14.3
