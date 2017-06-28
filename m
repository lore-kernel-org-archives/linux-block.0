Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752111AbdF1Qa0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 12:30:26 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH V4 09/12] block: always attach cgroup info into bio
Date: Wed, 28 Jun 2017 09:29:59 -0700
Message-Id: <bdaef41bad52dcff246e00b1cb3cbe7fea40e562.1498666964.git.shli@fb.com>
In-Reply-To: <cover.1498666964.git.shli@fb.com>
References: <cover.1498666964.git.shli@fb.com>
In-Reply-To: <cover.1498666964.git.shli@fb.com>
References: <cover.1498666964.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

blkcg_bio_issue_check() already gets blkcg for a BIO.
bio_associate_blkcg() uses a percpu refcounter, so it's a very cheap
operation. There is no point we don't attach the cgroup info into bio at
blkcg_bio_issue_check. This also makes blktrace outputs correct cgroup
info.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c       | 7 +------
 include/linux/blk-cgroup.h | 3 +++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a7285bf..a6ebd2b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2104,14 +2104,9 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
 {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	int ret;
-
-	ret = bio_associate_current(bio);
-	if (ret == 0 || ret == -EBUSY)
+	if (bio->bi_css)
 		bio->bi_cg_private = tg;
 	blk_stat_set_issue(&bio->bi_issue_stat, bio_sectors(bio));
-#else
-	bio_associate_current(bio);
 #endif
 }
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 7104bea..9d92153 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -691,6 +691,9 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 	rcu_read_lock();
 	blkcg = bio_blkcg(bio);
 
+	/* associate blkcg if bio hasn't attached one */
+	bio_associate_blkcg(bio, &blkcg->css);
+
 	blkg = blkg_lookup(blkcg, q);
 	if (unlikely(!blkg)) {
 		spin_lock_irq(q->queue_lock);
-- 
2.9.3
