Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45658 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751835AbdJMSKr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 14:10:47 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9DIA7DE011559
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 11:10:47 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2dk0y5gd9p-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 11:10:47 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <Kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH] block-throttle: avoid double charge
Date: Fri, 13 Oct 2017 11:10:29 -0700
Message-ID: <aac85300238aec9e310b5092260a6ec6e6f02e04.1507918159.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If a bio is throttled and splitted after throttling, the bio could be
resubmited and enters the throttling again. This will cause part of the
bio is charged multiple times. If the cgroup has an IO limit, the double
charge will significantly harm the performance. The bio split becomes
quite common after arbitrary bio size change.

To fix this, we record the disk info a bio is throttled against. If a
bio is throttled and issued, we record the info. We copy the info to
cloned bio, so cloned bio (including splitted bio) will not be throttled
again. Stacked block device driver will change cloned bio's bi_disk, if
a bio's bi_disk is changed, the recorded throttle disk info is invalid,
we should throttle again. That's the reason why we can't use a single
bit to indicate if a cloned bio should be throttled.

We only record gendisk here, if a cloned bio is remapped to other disk,
it's very unlikely only partno is changed.

Some sort of this patch probably should go into stable since v4.2

Cc: Tejun Heo <tj@kernel.org>
Cc: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/bio.c               |  3 +++
 block/blk-throttle.c      | 15 ++++++++++++---
 include/linux/blk_types.h |  4 ++++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8338304..dce8314 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -597,6 +597,9 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	 * so we don't set nor calculate new physical/hw segment counts here
 	 */
 	bio->bi_disk = bio_src->bi_disk;
+#ifdef CONFIG_BLK_DEV_THROTTLING
+	bio->bi_throttled_disk = bio_src->bi_throttled_disk;
+#endif
 	bio_set_flag(bio, BIO_CLONED);
 	bio->bi_opf = bio_src->bi_opf;
 	bio->bi_write_hint = bio_src->bi_write_hint;
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index ee6d7b0..155549a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2130,9 +2130,15 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
-	/* see throtl_charge_bio() */
-	if (bio_flagged(bio, BIO_THROTTLED) || !tg->has_rules[rw])
+	/*
+	 * see throtl_charge_bio() for BIO_THROTTLED. If a bio is throttled
+	 * against a disk but remapped to other disk, we should throttle it
+	 * again
+	 */
+	if (bio_flagged(bio, BIO_THROTTLED) || !tg->has_rules[rw] ||
+	    (bio->bi_throttled_disk && bio->bi_throttled_disk == bio->bi_disk))
 		goto out;
+	bio->bi_throttled_disk = NULL;
 
 	spin_lock_irq(q->queue_lock);
 
@@ -2227,8 +2233,11 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	 * don't want bios to leave with the flag set.  Clear the flag if
 	 * being issued.
 	 */
-	if (!throttled)
+	if (!throttled) {
 		bio_clear_flag(bio, BIO_THROTTLED);
+		/* if the bio is cloned, we don't throttle it again */
+		bio->bi_throttled_disk = bio->bi_disk;
+	}
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	if (throttled || !td->track_bio_latency)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3385c89..2507566 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -89,6 +89,10 @@ struct bio {
 	void			*bi_cg_private;
 	struct blk_issue_stat	bi_issue_stat;
 #endif
+#ifdef CONFIG_BLK_DEV_THROTTLING
+	/* record which disk the bio is throttled against */
+	struct gendisk		*bi_throttled_disk;
+#endif
 #endif
 	union {
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
-- 
2.9.5
