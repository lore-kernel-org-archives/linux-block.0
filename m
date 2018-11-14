Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC634C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A106320815
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MBvmubA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A106320815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbeKOCGV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:06:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeKOCGV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zpdEs4UZ+n6gntxYI/Nz2VJH2s96UOe7pYVp6oYYQDU=; b=MBvmubA6o/Djf6oWj6GcaL1e1u
        CM9v9rG56skU2h5+7IUsaFeIRNw0idPmt0kGcoRDWanuKvI7lV+DmfPrjkgAM0BLpMeNa+v5Vl0PT
        Pt4Hc4XVo85l70EXE1Wzzo+zbWgw94oKKa8I3JuzPoKD4zo+wiB5655dfTUmv8bBPsvRYiwEspQSd
        xnd2liYnAWbW2KIURWcQGNL+9PJBnLszoIA2ExfXG0deruy6jqutnVHtgT6KrcUt1PcPG0geLMUc7
        wh0LqE0CBnkCsxHNvwyE52SyXzNFYQDjh4t9XleYIZMaLd9Gsm5vNetGW2TyW/zZ1OwVpHKZ9oV5l
        SgPxmHjQ==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxce-00069z-7E; Wed, 14 Nov 2018 16:02:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: [PATCH 04/16] block: use atomic bitops for ->queue_flags
Date:   Wed, 14 Nov 2018 17:02:07 +0100
Message-Id: <20181114160219.28328-5-hch@lst.de>
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

->queue_flags is generally not set or cleared in the fast path, and also
generally set or cleared one flag at a time.  Make use of the normal
atomic bitops for it so that we don't need to take the queue_lock,
which is otherwise mostly unused in the core block layer now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       | 54 ++++++----------------------------------
 block/blk-mq.c         |  2 +-
 block/blk-settings.c   | 10 +++-----
 block/blk-sysfs.c      | 28 +++++++++------------
 block/blk.h            | 56 ------------------------------------------
 include/linux/blkdev.h |  1 -
 6 files changed, 24 insertions(+), 127 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1c9b6975cf0a..5c8e66a09d82 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -74,11 +74,7 @@ static struct workqueue_struct *kblockd_workqueue;
  */
 void blk_queue_flag_set(unsigned int flag, struct request_queue *q)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	queue_flag_set(flag, q);
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	set_bit(flag, &q->queue_flags);
 }
 EXPORT_SYMBOL(blk_queue_flag_set);
 
@@ -89,11 +85,7 @@ EXPORT_SYMBOL(blk_queue_flag_set);
  */
 void blk_queue_flag_clear(unsigned int flag, struct request_queue *q)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	queue_flag_clear(flag, q);
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	clear_bit(flag, &q->queue_flags);
 }
 EXPORT_SYMBOL(blk_queue_flag_clear);
 
@@ -107,38 +99,10 @@ EXPORT_SYMBOL(blk_queue_flag_clear);
  */
 bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q)
 {
-	unsigned long flags;
-	bool res;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	res = queue_flag_test_and_set(flag, q);
-	spin_unlock_irqrestore(q->queue_lock, flags);
-
-	return res;
+	return test_and_set_bit(flag, &q->queue_flags);
 }
 EXPORT_SYMBOL_GPL(blk_queue_flag_test_and_set);
 
-/**
- * blk_queue_flag_test_and_clear - atomically test and clear a queue flag
- * @flag: flag to be cleared
- * @q: request queue
- *
- * Returns the previous value of @flag - 0 if the flag was not set and 1 if
- * the flag was set.
- */
-bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q)
-{
-	unsigned long flags;
-	bool res;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	res = queue_flag_test_and_clear(flag, q);
-	spin_unlock_irqrestore(q->queue_lock, flags);
-
-	return res;
-}
-EXPORT_SYMBOL_GPL(blk_queue_flag_test_and_clear);
-
 void blk_rq_init(struct request_queue *q, struct request *rq)
 {
 	memset(rq, 0, sizeof(*rq));
@@ -368,12 +332,10 @@ void blk_cleanup_queue(struct request_queue *q)
 	/* mark @q DYING, no new request or merges will be allowed afterwards */
 	mutex_lock(&q->sysfs_lock);
 	blk_set_queue_dying(q);
-	spin_lock_irq(lock);
 
-	queue_flag_set(QUEUE_FLAG_NOMERGES, q);
-	queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
-	queue_flag_set(QUEUE_FLAG_DYING, q);
-	spin_unlock_irq(lock);
+	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, q);
+	blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
+	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
 	mutex_unlock(&q->sysfs_lock);
 
 	/*
@@ -384,9 +346,7 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	rq_qos_exit(q);
 
-	spin_lock_irq(lock);
-	queue_flag_set(QUEUE_FLAG_DEAD, q);
-	spin_unlock_irq(lock);
+	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
 
 	/*
 	 * make sure all in-progress dispatch are completed because
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c82b4b4fa3e..e2717e843727 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2756,7 +2756,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
 
 	if (!(set->flags & BLK_MQ_F_SG_MERGE))
-		queue_flag_set_unlocked(QUEUE_FLAG_NO_SG_MERGE, q);
+		blk_queue_flag_set(QUEUE_FLAG_NO_SG_MERGE, q);
 
 	q->sg_reserved_size = INT_MAX;
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index cca83590a1dc..3abe831e92c8 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -834,16 +834,14 @@ EXPORT_SYMBOL(blk_set_queue_depth);
  */
 void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
 {
-	spin_lock_irq(q->queue_lock);
 	if (wc)
-		queue_flag_set(QUEUE_FLAG_WC, q);
+		blk_queue_flag_set(QUEUE_FLAG_WC, q);
 	else
-		queue_flag_clear(QUEUE_FLAG_WC, q);
+		blk_queue_flag_clear(QUEUE_FLAG_WC, q);
 	if (fua)
-		queue_flag_set(QUEUE_FLAG_FUA, q);
+		blk_queue_flag_set(QUEUE_FLAG_FUA, q);
 	else
-		queue_flag_clear(QUEUE_FLAG_FUA, q);
-	spin_unlock_irq(q->queue_lock);
+		blk_queue_flag_clear(QUEUE_FLAG_FUA, q);
 
 	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index d4b1b84ba8ca..22fd086eba9f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -316,14 +316,12 @@ static ssize_t queue_nomerges_store(struct request_queue *q, const char *page,
 	if (ret < 0)
 		return ret;
 
-	spin_lock_irq(q->queue_lock);
-	queue_flag_clear(QUEUE_FLAG_NOMERGES, q);
-	queue_flag_clear(QUEUE_FLAG_NOXMERGES, q);
+	blk_queue_flag_clear(QUEUE_FLAG_NOMERGES, q);
+	blk_queue_flag_clear(QUEUE_FLAG_NOXMERGES, q);
 	if (nm == 2)
-		queue_flag_set(QUEUE_FLAG_NOMERGES, q);
+		blk_queue_flag_set(QUEUE_FLAG_NOMERGES, q);
 	else if (nm)
-		queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
-	spin_unlock_irq(q->queue_lock);
+		blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
 
 	return ret;
 }
@@ -347,18 +345,16 @@ queue_rq_affinity_store(struct request_queue *q, const char *page, size_t count)
 	if (ret < 0)
 		return ret;
 
-	spin_lock_irq(q->queue_lock);
 	if (val == 2) {
-		queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
-		queue_flag_set(QUEUE_FLAG_SAME_FORCE, q);
+		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
+		blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, q);
 	} else if (val == 1) {
-		queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
-		queue_flag_clear(QUEUE_FLAG_SAME_FORCE, q);
+		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
+		blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, q);
 	} else if (val == 0) {
-		queue_flag_clear(QUEUE_FLAG_SAME_COMP, q);
-		queue_flag_clear(QUEUE_FLAG_SAME_FORCE, q);
+		blk_queue_flag_clear(QUEUE_FLAG_SAME_COMP, q);
+		blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, q);
 	}
-	spin_unlock_irq(q->queue_lock);
 #endif
 	return ret;
 }
@@ -889,7 +885,7 @@ int blk_register_queue(struct gendisk *disk)
 	WARN_ONCE(test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags),
 		  "%s is registering an already registered queue\n",
 		  kobject_name(&dev->kobj));
-	queue_flag_set_unlocked(QUEUE_FLAG_REGISTERED, q);
+	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
 
 	/*
 	 * SCSI probing may synchronously create and destroy a lot of
@@ -901,7 +897,7 @@ int blk_register_queue(struct gendisk *disk)
 	 * request_queues for non-existent devices never get registered.
 	 */
 	if (!blk_queue_init_done(q)) {
-		queue_flag_set_unlocked(QUEUE_FLAG_INIT_DONE, q);
+		blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, q);
 		percpu_ref_switch_to_percpu(&q->q_usage_counter);
 	}
 
diff --git a/block/blk.h b/block/blk.h
index 08a5845b03ba..f2ddc71e93da 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -48,62 +48,6 @@ static inline void queue_lockdep_assert_held(struct request_queue *q)
 		lockdep_assert_held(q->queue_lock);
 }
 
-static inline void queue_flag_set_unlocked(unsigned int flag,
-					   struct request_queue *q)
-{
-	if (test_bit(QUEUE_FLAG_INIT_DONE, &q->queue_flags) &&
-	    kref_read(&q->kobj.kref))
-		lockdep_assert_held(q->queue_lock);
-	__set_bit(flag, &q->queue_flags);
-}
-
-static inline void queue_flag_clear_unlocked(unsigned int flag,
-					     struct request_queue *q)
-{
-	if (test_bit(QUEUE_FLAG_INIT_DONE, &q->queue_flags) &&
-	    kref_read(&q->kobj.kref))
-		lockdep_assert_held(q->queue_lock);
-	__clear_bit(flag, &q->queue_flags);
-}
-
-static inline int queue_flag_test_and_clear(unsigned int flag,
-					    struct request_queue *q)
-{
-	queue_lockdep_assert_held(q);
-
-	if (test_bit(flag, &q->queue_flags)) {
-		__clear_bit(flag, &q->queue_flags);
-		return 1;
-	}
-
-	return 0;
-}
-
-static inline int queue_flag_test_and_set(unsigned int flag,
-					  struct request_queue *q)
-{
-	queue_lockdep_assert_held(q);
-
-	if (!test_bit(flag, &q->queue_flags)) {
-		__set_bit(flag, &q->queue_flags);
-		return 0;
-	}
-
-	return 1;
-}
-
-static inline void queue_flag_set(unsigned int flag, struct request_queue *q)
-{
-	queue_lockdep_assert_held(q);
-	__set_bit(flag, &q->queue_flags);
-}
-
-static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
-{
-	queue_lockdep_assert_held(q);
-	__clear_bit(flag, &q->queue_flags);
-}
-
 static inline struct blk_flush_queue *
 blk_get_flush_queue(struct request_queue *q, struct blk_mq_ctx *ctx)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1aa94759d219..2b887e24837e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -624,7 +624,6 @@ struct request_queue {
 void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
 void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
-bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 
 #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
-- 
2.19.1

