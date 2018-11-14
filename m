Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84991C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46673208E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mYLPQwL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46673208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732862AbeKOCGN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:06:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeKOCGN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X2hmQjy4rOQfvgAUOXU2QZ8dYub4HG/IXGgzkcqQcHk=; b=mYLPQwL+YwsISM6MwdrDE+MTme
        800bG/Q4/ToCIk8cDKsiOV249oFmNqKe3h7jyYC1oiWQgb58P8Y29N8jTM8eFMFCiBk1s1HqYVd7e
        ksF5k0seZgNf8FWgY1B4b3bVisM+QWhz2Tf5BOQUV7cj+/buIixLgdHXeUzyCouF07ajlw9JTn9Wp
        VusYmrXn3/QRW6X7DrSZAGcqFzAxpPEzsquDcnzg4Sf6RKdf+j+9eGBeFn8akITYi0L2Nk7CZhZhA
        70fbgMImZW+SWWHfD7E44zIcCNY1mpq2p2yk1pfb6LWefwM7BGh5Z+lkQb2w2/Xf6lpj/x2HzzPth
        5H1kaMEg==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxcV-00068B-SV; Wed, 14 Nov 2018 16:02:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: [PATCH 01/16] block: remove QUEUE_FLAG_BYPASS and ->bypass
Date:   Wed, 14 Nov 2018 17:02:04 +0100
Message-Id: <20181114160219.28328-2-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unused since the removal of the legacy request code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c         | 15 ---------------
 block/blk-core.c           | 21 ---------------------
 block/blk-mq-debugfs.c     |  1 -
 block/blk-throttle.c       |  3 ---
 include/linux/blk-cgroup.h |  6 +-----
 include/linux/blkdev.h     |  3 ---
 6 files changed, 1 insertion(+), 48 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 6c65791bc3fe..a95cddb39f1c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -270,13 +270,6 @@ struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 	WARN_ON_ONCE(!rcu_read_lock_held());
 	lockdep_assert_held(q->queue_lock);
 
-	/*
-	 * This could be the first entry point of blkcg implementation and
-	 * we shouldn't allow anything to go through for a bypassing queue.
-	 */
-	if (unlikely(blk_queue_bypass(q)))
-		return ERR_PTR(blk_queue_dying(q) ? -ENODEV : -EBUSY);
-
 	blkg = __blkg_lookup(blkcg, q, true);
 	if (blkg)
 		return blkg;
@@ -741,14 +734,6 @@ static struct blkcg_gq *blkg_lookup_check(struct blkcg *blkcg,
 
 	if (!blkcg_policy_enabled(q, pol))
 		return ERR_PTR(-EOPNOTSUPP);
-
-	/*
-	 * This could be the first entry point of blkcg implementation and
-	 * we shouldn't allow anything to go through for a bypassing queue.
-	 */
-	if (unlikely(blk_queue_bypass(q)))
-		return ERR_PTR(blk_queue_dying(q) ? -ENODEV : -EBUSY);
-
 	return __blkg_lookup(blkcg, q, true /* update_hint */);
 }
 
diff --git a/block/blk-core.c b/block/blk-core.c
index fdc0ad2686c4..1c9b6975cf0a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -370,18 +370,6 @@ void blk_cleanup_queue(struct request_queue *q)
 	blk_set_queue_dying(q);
 	spin_lock_irq(lock);
 
-	/*
-	 * A dying queue is permanently in bypass mode till released.  Note
-	 * that, unlike blk_queue_bypass_start(), we aren't performing
-	 * synchronize_rcu() after entering bypass mode to avoid the delay
-	 * as some drivers create and destroy a lot of queues while
-	 * probing.  This is still safe because blk_release_queue() will be
-	 * called only after the queue refcnt drops to zero and nothing,
-	 * RCU or not, would be traversing the queue by then.
-	 */
-	q->bypass_depth++;
-	queue_flag_set(QUEUE_FLAG_BYPASS, q);
-
 	queue_flag_set(QUEUE_FLAG_NOMERGES, q);
 	queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
 	queue_flag_set(QUEUE_FLAG_DYING, q);
@@ -589,15 +577,6 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
 
 	q->queue_lock = lock ? : &q->__queue_lock;
 
-	/*
-	 * A queue starts its life with bypass turned on to avoid
-	 * unnecessary bypass on/off overhead and nasty surprises during
-	 * init.  The initial bypass will be finished when the queue is
-	 * registered by blk_register_queue().
-	 */
-	q->bypass_depth = 1;
-	queue_flag_set_unlocked(QUEUE_FLAG_BYPASS, q);
-
 	init_waitqueue_head(&q->mq_freeze_wq);
 
 	/*
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index f021f4817b80..a32bb79d6c95 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -114,7 +114,6 @@ static int queue_pm_only_show(void *data, struct seq_file *m)
 static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(STOPPED),
 	QUEUE_FLAG_NAME(DYING),
-	QUEUE_FLAG_NAME(BYPASS),
 	QUEUE_FLAG_NAME(BIDI),
 	QUEUE_FLAG_NAME(NOMERGES),
 	QUEUE_FLAG_NAME(SAME_COMP),
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index db1a3a2ae006..8e6f3c9821c2 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2145,9 +2145,6 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 	throtl_update_latency_buckets(td);
 
-	if (unlikely(blk_queue_bypass(q)))
-		goto out_unlock;
-
 	blk_throtl_assoc_bio(tg, bio);
 	blk_throtl_update_idletime(tg);
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 1b299e025e83..2c68efc603bd 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -325,16 +325,12 @@ static inline struct blkcg_gq *__blkg_lookup(struct blkcg *blkcg,
  * @q: request_queue of interest
  *
  * Lookup blkg for the @blkcg - @q pair.  This function should be called
- * under RCU read lock and is guaranteed to return %NULL if @q is bypassing
- * - see blk_queue_bypass_start() for details.
+ * under RCU read loc.
  */
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
 					   struct request_queue *q)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
-
-	if (unlikely(blk_queue_bypass(q)))
-		return NULL;
 	return __blkg_lookup(blkcg, q, false);
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e67ad2dd025e..c92aafcde0b8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -551,7 +551,6 @@ struct request_queue {
 
 	struct mutex		sysfs_lock;
 
-	int			bypass_depth;
 	atomic_t		mq_freeze_depth;
 
 #if defined(CONFIG_BLK_DEV_BSG)
@@ -589,7 +588,6 @@ struct request_queue {
 
 #define QUEUE_FLAG_STOPPED	1	/* queue is stopped */
 #define QUEUE_FLAG_DYING	2	/* queue being torn down */
-#define QUEUE_FLAG_BYPASS	3	/* act as dumb FIFO queue */
 #define QUEUE_FLAG_BIDI		4	/* queue supports bidi requests */
 #define QUEUE_FLAG_NOMERGES     5	/* disable merge attempts */
 #define QUEUE_FLAG_SAME_COMP	6	/* complete on same CPU-group */
@@ -633,7 +631,6 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
 #define blk_queue_dead(q)	test_bit(QUEUE_FLAG_DEAD, &(q)->queue_flags)
-#define blk_queue_bypass(q)	test_bit(QUEUE_FLAG_BYPASS, &(q)->queue_flags)
 #define blk_queue_init_done(q)	test_bit(QUEUE_FLAG_INIT_DONE, &(q)->queue_flags)
 #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)
 #define blk_queue_noxmerges(q)	\
-- 
2.19.1

