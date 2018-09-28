Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/5] blk-iolatency: deal with nr_requests == 1
Date: Fri, 28 Sep 2018 13:45:40 -0400
Message-Id: <20180928174543.28486-3-josef@toxicpanda.com>
In-Reply-To: <20180928174543.28486-1-josef@toxicpanda.com>
References: <20180928174543.28486-1-josef@toxicpanda.com>
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
index c2e38bc12f27..8daea7a4fe49 100644
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
