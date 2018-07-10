Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:38747 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732337AbeGJTQU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jul 2018 15:16:20 -0400
From: Liu Bo <bo.liu@linux.alibaba.com>
To: <linux-block@vger.kernel.org>
Subject: [PATCH] Block: blk-throttle: skip wait time calculation if not asked
Date: Wed, 11 Jul 2018 03:15:29 +0800
Message-Id: <1531250129-18354-1-git-send-email-bo.liu@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

tg_may_dispatch() uses @wait to retrieve how long the next bio can be
dispatched, but if it doesn't ask for that, it's OK for
tg_with_in_{bps,iops}_limit() to return immediately.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 block/blk-throttle.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 423551f92b2c..c70aa396a793 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -954,6 +954,9 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 		return true;
 	}
 
+	if (!wait)
+		return false;
+
 	/* Calc approx time to dispatch */
 	jiffy_wait = ((tg->io_disp[rw] + 1) * HZ) / tg_iops_limit(tg, rw) + 1;
 
@@ -962,8 +965,7 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 	else
 		jiffy_wait = 1;
 
-	if (wait)
-		*wait = jiffy_wait;
+	*wait = jiffy_wait;
 	return false;
 }
 
@@ -995,6 +997,9 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 		return true;
 	}
 
+	if (!wait)
+		return false;
+
 	/* Calc approx time to dispatch */
 	extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
 	jiffy_wait = div64_u64(extra_bytes * HZ, tg_bps_limit(tg, rw));
@@ -1007,8 +1012,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	 * up we did. Add that time also.
 	 */
 	jiffy_wait = jiffy_wait + (jiffy_elapsed_rnd - jiffy_elapsed);
-	if (wait)
-		*wait = jiffy_wait;
+	*wait = jiffy_wait;
 	return false;
 }
 
-- 
1.8.3.1
