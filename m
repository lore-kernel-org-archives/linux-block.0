Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751393AbdFBVyo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Jun 2017 17:54:44 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH 08/11] block: always attach cgroup info into bio
Date: Fri,  2 Jun 2017 14:54:01 -0700
Message-Id: <f998a0a4d1117f7438dea22c565aeb799d112d31.1496432591.git.shli@fb.com>
In-Reply-To: <cover.1496432591.git.shli@fb.com>
References: <cover.1496432591.git.shli@fb.com>
In-Reply-To: <cover.1496432591.git.shli@fb.com>
References: <cover.1496432591.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

blkcg_bio_issue_check() already gets blkcg for a BIO.
bio_associate_blkcg() uses a percpu refcounter, so it's a very cheap
operation. There is no point we don't attach the cgroup info into bio at
blkcg_bio_issue_check. This also makes blktrace outputs correct cgroup
info.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c       | 7 +------
 include/linux/blk-cgroup.h | 2 ++
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b78db2e..53d3e3d 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2033,14 +2033,9 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
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
index 01b62e7..d176247 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -691,6 +691,8 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 	rcu_read_lock();
 	blkcg = bio_blkcg(bio);
 
+	bio_associate_blkcg(bio, &blkcg->css);
+
 	blkg = blkg_lookup(blkcg, q);
 	if (unlikely(!blkg)) {
 		spin_lock_irq(q->queue_lock);
-- 
2.9.3
