Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33506 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755853AbdJJDNi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Oct 2017 23:13:38 -0400
Received: by mail-oi0-f68.google.com with SMTP id 14so2700634oii.0
        for <linux-block@vger.kernel.org>; Mon, 09 Oct 2017 20:13:38 -0700 (PDT)
Subject: [PATCH] blk-throttle: fix null pointer dereference while throttling
 writeback IOs
References: <9fdd7f4b-91b5-7612-bf91-7b18defffb58@gmail.com>
To: linux-block@vger.kernel.org
Cc: Shaohua Li <shli@fb.com>, Jens Axboe <axboe@fb.com>,
        wenqing.lz@taobao.com, boyu.mt@taobao.com,
        jiufei.xjf@alibaba-inc.com
From: xuejiufei <xuejiufei@gmail.com>
Message-ID: <5e5b83db-6f78-9869-fe9c-b1f6a09281ca@gmail.com>
Date: Tue, 10 Oct 2017 11:13:32 +0800
MIME-Version: 1.0
In-Reply-To: <9fdd7f4b-91b5-7612-bf91-7b18defffb58@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Jiufei Xue <jiufei.xjf@alibaba-inc.com>

A null pointer dereference can occur when blkcg is removed manually
with writeback IOs inflight. This is caused by the following case:

Writeback kworker submit the bio and set bio->bi_cg_private to tg
in blk_throtl_assoc_bio.
Then we remove the block cgroup manually, the blkg and tg would be
freed if there is no request inflight.
When the submitted bio come back, blk_throtl_bio_endio() fetch the tg
which was already freed.

Fix this by increasing the refcount of blkg in funcion
blk_throtl_assoc_bio() so that the blkg will not be freed until the
bio_endio called.

Signed-off-by: Jiufei Xue <jiufei.xjf@alibaba-inc.com>
---
 block/blk-throttle.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 17816a0..d80c3f0 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2112,8 +2112,12 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
 {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	if (bio->bi_css)
+	if (bio->bi_css) {
+		if (bio->bi_cg_private)
+			blkg_put(tg_to_blkg(bio->bi_cg_private));
 		bio->bi_cg_private = tg;
+		blkg_get(tg_to_blkg(tg));
+	}
 	blk_stat_set_issue(&bio->bi_issue_stat, bio_sectors(bio));
 #endif
 }
@@ -2283,8 +2287,10 @@ void blk_throtl_bio_endio(struct bio *bio)
 
 	start_time = blk_stat_time(&bio->bi_issue_stat) >> 10;
 	finish_time = __blk_stat_time(finish_time_ns) >> 10;
-	if (!start_time || finish_time <= start_time)
+	if (!start_time || finish_time <= start_time) {
+		blkg_put(tg_to_blkg(tg));
 		return;
+	}
 
 	lat = finish_time - start_time;
 	/* this is only for bio based driver */
@@ -2314,6 +2320,8 @@ void blk_throtl_bio_endio(struct bio *bio)
 		tg->bio_cnt /= 2;
 		tg->bad_bio_cnt /= 2;
 	}
+
+	blkg_put(tg_to_blkg(tg));
 }
 #endif
 
-- 
1.9.4
