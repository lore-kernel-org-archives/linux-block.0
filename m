Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:55942 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729771AbeGNCHX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jul 2018 22:07:23 -0400
From: Liu Bo <bo.liu@linux.alibaba.com>
To: <linux-block@vger.kernel.org>
Subject: [PATCH] Block: blk-throttle: skip bad bio counting if io.low is not in use
Date: Sat, 14 Jul 2018 09:50:07 +0800
Message-Id: <1531533007-74040-1-git-send-email-bo.liu@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When only io.max is in use, tg->target_latency is set to the default
value, if that's the case, bad_bio_cnt is not checking at all, so it
makes no sense to check latency and do bad_bio_cnt counting in
blk_throtl_bio_endio().

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 block/blk-throttle.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 03b63d9aa756..4ac552850686 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2338,6 +2338,10 @@ void blk_throtl_bio_endio(struct bio *bio)
 		throtl_track_latency(tg->td, bio_issue_size(&bio->bi_issue),
 				     bio_op(bio), lat);
 
+	/* Skip bad bio counting if latency_target is not set. */
+	if (tg->latency_target == DFL_LATENCY_TARGET)
+		goto out;
+
 	if (tg->latency_target && lat >= tg->td->filtered_latency) {
 		int bucket;
 		unsigned int threshold;
@@ -2362,6 +2366,7 @@ void blk_throtl_bio_endio(struct bio *bio)
 		tg->bad_bio_cnt /= 2;
 	}
 
+out:
 	blkg_put(tg_to_blkg(tg));
 }
 #endif
-- 
1.8.3.1
