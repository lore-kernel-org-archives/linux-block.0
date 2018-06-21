Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:55055 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754451AbeFUDHV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jun 2018 23:07:21 -0400
From: Liu Bo <bo.liu@linux.alibaba.com>
To: <linux-block@vger.kernel.org>
Subject: [PATCH] Block: initialize bio_cnt_ret_time for the first time
Date: Thu, 21 Jun 2018 11:07:04 +0800
Message-Id: <1529550424-105210-1-git-send-email-bo.liu@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When a new tg is created, tg->bio_cnt_ret_time is 0, so if the first
IO going thru this tg turns out to be a bad one, we fail to record it
in tg->bad_bio_cnt as

if (jiffies > bio_cnt_ret_time) {
	tg->bad_bio_cnt /= 2;
}

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 block/blk-throttle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 82282e6fdcf8..8bd54118dc0a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2329,6 +2329,8 @@ void blk_throtl_bio_endio(struct bio *bio)
 		tg->bio_cnt++;
 	}
 
+	if (unlikely(!tg->bio_cnt_reset_time))
+		tg->bio_cnt_reset_time = jiffies;
 	if (time_after(jiffies, tg->bio_cnt_reset_time) || tg->bio_cnt > 1024) {
 		tg->bio_cnt_reset_time = tg->td->throtl_slice + jiffies;
 		tg->bio_cnt /= 2;
-- 
1.8.3.1
