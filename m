Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE63C4338F
	for <linux-block@archiver.kernel.org>; Fri, 30 Jul 2021 07:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317F060E97
	for <linux-block@archiver.kernel.org>; Fri, 30 Jul 2021 07:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbhG3Hjq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jul 2021 03:39:46 -0400
Received: from mx21.baidu.com ([220.181.3.85]:48412 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237616AbhG3Hjq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jul 2021 03:39:46 -0400
Received: from BC-Mail-Ex20.internal.baidu.com (unknown [172.31.51.14])
        by Forcepoint Email with ESMTPS id BA9D7C26B4CB0661D364;
        Fri, 30 Jul 2021 15:39:35 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex20.internal.baidu.com (172.31.51.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Fri, 30 Jul 2021 15:39:35 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 30 Jul 2021 15:39:35 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH] block: Fix typo in comments
Date:   Fri, 30 Jul 2021 15:39:28 +0800
Message-ID: <20210730073928.2813-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX08.internal.baidu.com (172.31.51.48) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix typo:
*submited  ==> submitted
*IFF  ==> if
*becasue  ==> because
*idential  ==> identical
*iff  ==> if
*trival  ==> trivial
*splitted  ==> split
*attributs  ==> attributes
*insted  ==> instead
*removeable  ==> removable
*unnecessarilly  ==> unnecessarily
*prefered  ==> preferred
*IFF  ==> If

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 block/blk-core.c      | 2 +-
 block/blk-merge.c     | 6 +++---
 block/blk-mq.c        | 6 +++---
 block/blk-settings.c  | 2 +-
 block/blk.h           | 4 ++--
 block/genhd.c         | 4 ++--
 block/kyber-iosched.c | 2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 04477697ee4b..04674ad82371 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1032,7 +1032,7 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
 	/*
 	 * We only want one ->submit_bio to be active at a time, else stack
 	 * usage with stacked devices could be a problem.  Use current->bio_list
-	 * to collect a list of requests submited by a ->submit_bio method while
+	 * to collect a list of requests submitted by a ->submit_bio method while
 	 * it is active, and then process them after it returned.
 	 */
 	if (current->bio_list) {
diff --git a/block/blk-merge.c b/block/blk-merge.c
index a11b3b53717e..246ebd28d2da 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -283,7 +283,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	/*
 	 * Bio splitting may cause subtle trouble such as hang when doing sync
 	 * iopoll in direct IO routine. Given performance gain of iopoll for
-	 * big IO can be trival, disable iopoll when split needed.
+	 * big IO can be trivial, disable iopoll when split needed.
 	 */
 	bio->bi_opf &= ~REQ_HIPRI;
 
@@ -341,7 +341,7 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
 	}
 
 	if (split) {
-		/* there isn't chance to merge the splitted bio */
+		/* there isn't chance to merge the split bio */
 		split->bi_opf |= REQ_NOMERGE;
 
 		bio_chain(split, *bio);
@@ -686,7 +686,7 @@ void blk_rq_set_mixed_merge(struct request *rq)
 	/*
 	 * @rq will no longer represent mixable attributes for all the
 	 * contained bios.  It will just track those of the first one.
-	 * Distributes the attributs to each bio.
+	 * Distributes the attributes to each bio.
 	 */
 	for (bio = rq->bio; bio; bio = bio->bi_next) {
 		WARN_ON_ONCE((bio->bi_opf & REQ_FAILFAST_MASK) &&
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c4ac51e54eb..d7bc9dad7ef0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -924,7 +924,7 @@ static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 
 	/*
 	 * Just do a quick check if it is expired before locking the request in
-	 * so we're not unnecessarilly synchronizing across CPUs.
+	 * so we're not unnecessarily synchronizing across CPUs.
 	 */
 	if (!blk_mq_req_expired(rq, next))
 		return true;
@@ -1646,7 +1646,7 @@ static bool blk_mq_has_sqsched(struct request_queue *q)
 }
 
 /*
- * Return prefered queue to dispatch from (if any) for non-mq aware IO
+ * Return preferred queue to dispatch from (if any) for non-mq aware IO
  * scheduler.
  */
 static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
@@ -2838,7 +2838,7 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 		__ctx->queue = q;
 
 		/*
-		 * Set local node, IFF we have more than one hw queue. If
+		 * Set local node, If we have more than one hw queue. If
 		 * not, we remain on the home node of the device
 		 */
 		for (j = 0; j < set->nr_maps; j++) {
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 109012719aa0..ec0fd7d537dd 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -715,7 +715,7 @@ void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
 	/*
 	 * Devices that require a virtual boundary do not support scatter/gather
 	 * I/O natively, but instead require a descriptor list entry for each
-	 * page (which might not be idential to the Linux PAGE_SIZE).  Because
+	 * page (which might not be identical to the Linux PAGE_SIZE).  Because
 	 * of that they are not limited by our notion of "segment size".
 	 */
 	if (mask)
diff --git a/block/blk.h b/block/blk.h
index 56f33fbcde59..ed7d254e543c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -234,7 +234,7 @@ enum elv_merge blk_try_merge(struct request *rq, struct bio *bio);
 int blk_dev_init(void);
 
 /*
- * Contribute to IO statistics IFF:
+ * Contribute to IO statistics if:
  *
  *	a) it's attached to a gendisk, and
  *	b) the queue had IO stats enabled when this request was started
@@ -252,7 +252,7 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
 }
 
 /*
- * The max size one bio can handle is UINT_MAX becasue bvec_iter.bi_size
+ * The max size one bio can handle is UINT_MAX because bvec_iter.bi_size
  * is defined as 'unsigned int', meantime it has to aligned to with logical
  * block size which is the minimum accepted unit by hardware.
  */
diff --git a/block/genhd.c b/block/genhd.c
index 38f053074159..402d07d557c2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -82,7 +82,7 @@ EXPORT_SYMBOL_GPL(set_capacity_and_notify);
  * and return a pointer to that same buffer for convenience.
  *
  * Note: do not use this in new code, use the %pg specifier to sprintf and
- * printk insted.
+ * printk instead.
  */
 const char *bdevname(struct block_device *bdev, char *buf)
 {
@@ -780,7 +780,7 @@ static int show_partition(struct seq_file *seqf, void *v)
 	struct block_device *part;
 	unsigned long idx;
 
-	/* Don't show non-partitionable removeable devices or empty devices */
+	/* Don't show non-partitionable removable devices or empty devices */
 	if (!get_capacity(sgp) || (!disk_max_parts(sgp) &&
 				   (sgp->flags & GENHD_FL_REMOVABLE)))
 		return 0;
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 81e3279ecd57..6ad91d8ef26b 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -340,7 +340,7 @@ static void kyber_timer_fn(struct timer_list *t)
 
 		/*
 		 * If this domain has bad latency, throttle less. Otherwise,
-		 * throttle more iff we determined that there is congestion.
+		 * throttle more if we determined that there is congestion.
 		 *
 		 * The new depth is scaled linearly with the p99 latency vs the
 		 * latency target. E.g., if the p99 is 3/4 of the target, then
-- 
2.25.1

