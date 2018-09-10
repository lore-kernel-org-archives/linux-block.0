Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	kernel-team@fb.com,
	linux-block@vger.kernel.org
Subject: [PATCH 3/6] blk-iolatency: deal with nr_requests == 1
Date: Mon, 10 Sep 2018 16:49:29 -0400
Message-Id: <20180910204932.14323-4-josef@toxicpanda.com>
In-Reply-To: <20180910204932.14323-1-josef@toxicpanda.com>
References: <20180910204932.14323-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

Hitting the case where blk_queue_depth() returned 1 uncovered the fact
that iolatency doesn't actually handle this case properly, it simply
doesn't scale down anybody.  For this case we should go straight into
applying the time delay, which we weren't doing.  Since we already limit
the floor at 1 request this if statement is not needed, and this allows
us to set our depth to 1 which allows us to apply the delay if needed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-iolatency.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 8f32aa1817f8..4ed05d09a69e 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -312,7 +312,7 @@ static void scale_change(struct iolatency_grp *iolat, bool up)
 			iolat->rq_depth.max_depth = old;
 			wake_up_all(&iolat->rq_wait.wait);
 		}
-	} else if (old > 1) {
+	} else {
 		old >>= 1;
 		iolat->rq_depth.max_depth = max(old, 1UL);
 	}
-- 
2.14.3
