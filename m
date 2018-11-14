Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4302EC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039D5208E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X/120YSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039D5208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387542AbeKOCG1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:06:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeKOCG1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+xxOZLze7UKRw3jhMPYhyfeitkLchix2EdxHjAdtu3s=; b=X/120YSStvTHH09PwktQ/cjj6v
        U7TlUSq+bOaRzZPDWdyzBukw3oKPlwfI7Co8dZn5NTbbE+HMeyF1YkTkkWqZ6a7H/dpCBbG36OIgC
        F6xks+Cwq8VQ/T+cw2xQEaVAH2mufqMWMyeANFa2nP65vjm2uQ4bXcLOQfT/uOJuhm2GKQIq5pIZ8
        iMP27S1LD58kr3SRBeZ+tnR/4+AzYL8SEjAC8wWjbSObGmV0PgqdEyfvBZYcsEO10Z6ORxRx4BjG1
        Mb+j8nPeApacpsjxUgD3Ae1IlRWACM4dFYn3srgKzepinBfesCCTOIdQfhR0fw37ZAEUu6Rk6BkG1
        HafpL6EA==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxcj-0006Aw-V6; Wed, 14 Nov 2018 16:02:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: [PATCH 06/16] block-iolatency: remove the unused lock argument to rq_qos_throttle
Date:   Wed, 14 Nov 2018 17:02:09 +0100
Message-Id: <20181114160219.28328-7-hch@lst.de>
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

Unused now that the legacy request path is gone.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-iolatency.c | 24 ++++++------------------
 block/blk-mq.c        |  2 +-
 block/blk-rq-qos.c    |  5 ++---
 block/blk-rq-qos.h    |  4 ++--
 block/blk-wbt.c       | 16 ++++------------
 5 files changed, 15 insertions(+), 36 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 38c35c32aff2..8edf1b353ad1 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -276,10 +276,8 @@ static inline bool iolatency_may_queue(struct iolatency_grp *iolat,
 
 static void __blkcg_iolatency_throttle(struct rq_qos *rqos,
 				       struct iolatency_grp *iolat,
-				       spinlock_t *lock, bool issue_as_root,
+				       bool issue_as_root,
 				       bool use_memdelay)
-	__releases(lock)
-	__acquires(lock)
 {
 	struct rq_wait *rqw = &iolat->rq_wait;
 	unsigned use_delay = atomic_read(&lat_to_blkg(iolat)->use_delay);
@@ -311,14 +309,7 @@ static void __blkcg_iolatency_throttle(struct rq_qos *rqos,
 		if (iolatency_may_queue(iolat, &wait, first_block))
 			break;
 		first_block = false;
-
-		if (lock) {
-			spin_unlock_irq(lock);
-			io_schedule();
-			spin_lock_irq(lock);
-		} else {
-			io_schedule();
-		}
+		io_schedule();
 	} while (1);
 
 	finish_wait(&rqw->wait, &wait);
@@ -478,8 +469,7 @@ static void check_scale_change(struct iolatency_grp *iolat)
 	scale_change(iolat, direction > 0);
 }
 
-static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio,
-				     spinlock_t *lock)
+static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio)
 {
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
 	struct blkcg *blkcg;
@@ -495,13 +485,11 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio,
 	bio_associate_blkcg(bio, &blkcg->css);
 	blkg = blkg_lookup(blkcg, q);
 	if (unlikely(!blkg)) {
-		if (!lock)
-			spin_lock_irq(q->queue_lock);
+		spin_lock_irq(q->queue_lock);
 		blkg = blkg_lookup_create(blkcg, q);
 		if (IS_ERR(blkg))
 			blkg = NULL;
-		if (!lock)
-			spin_unlock_irq(q->queue_lock);
+		spin_unlock_irq(q->queue_lock);
 	}
 	if (!blkg)
 		goto out;
@@ -518,7 +506,7 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio,
 		}
 
 		check_scale_change(iolat);
-		__blkcg_iolatency_throttle(rqos, iolat, lock, issue_as_root,
+		__blkcg_iolatency_throttle(rqos, iolat, issue_as_root,
 				     (bio->bi_opf & REQ_SWAP) == REQ_SWAP);
 		blkg = blkg->parent;
 	}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e2717e843727..a3f057fdd045 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1886,7 +1886,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	if (blk_mq_sched_bio_merge(q, bio))
 		return BLK_QC_T_NONE;
 
-	rq_qos_throttle(q, bio, NULL);
+	rq_qos_throttle(q, bio);
 
 	rq = blk_mq_get_request(q, bio, &data);
 	if (unlikely(!rq)) {
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 0005dfd568dd..f8a4d3fbb98c 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -67,14 +67,13 @@ void rq_qos_requeue(struct request_queue *q, struct request *rq)
 	}
 }
 
-void rq_qos_throttle(struct request_queue *q, struct bio *bio,
-		     spinlock_t *lock)
+void rq_qos_throttle(struct request_queue *q, struct bio *bio)
 {
 	struct rq_qos *rqos;
 
 	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
 		if (rqos->ops->throttle)
-			rqos->ops->throttle(rqos, bio, lock);
+			rqos->ops->throttle(rqos, bio);
 	}
 }
 
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 32b02efbfa66..b6b11d496007 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -25,7 +25,7 @@ struct rq_qos {
 };
 
 struct rq_qos_ops {
-	void (*throttle)(struct rq_qos *, struct bio *, spinlock_t *);
+	void (*throttle)(struct rq_qos *, struct bio *);
 	void (*track)(struct rq_qos *, struct request *, struct bio *);
 	void (*issue)(struct rq_qos *, struct request *);
 	void (*requeue)(struct rq_qos *, struct request *);
@@ -103,7 +103,7 @@ void rq_qos_done(struct request_queue *, struct request *);
 void rq_qos_issue(struct request_queue *, struct request *);
 void rq_qos_requeue(struct request_queue *, struct request *);
 void rq_qos_done_bio(struct request_queue *q, struct bio *bio);
-void rq_qos_throttle(struct request_queue *, struct bio *, spinlock_t *);
+void rq_qos_throttle(struct request_queue *, struct bio *);
 void rq_qos_track(struct request_queue *q, struct request *, struct bio *);
 void rq_qos_exit(struct request_queue *);
 #endif
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 0fc222d4194b..e5a66c574683 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -521,9 +521,7 @@ static int wbt_wake_function(struct wait_queue_entry *curr, unsigned int mode,
  * the timer to kick off queuing again.
  */
 static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
-		       unsigned long rw, spinlock_t *lock)
-	__releases(lock)
-	__acquires(lock)
+		       unsigned long rw)
 {
 	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
 	struct wbt_wait_data data = {
@@ -561,13 +559,7 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 			break;
 		}
 
-		if (lock) {
-			spin_unlock_irq(lock);
-			io_schedule();
-			spin_lock_irq(lock);
-		} else
-			io_schedule();
-
+		io_schedule();
 		has_sleeper = false;
 	} while (1);
 
@@ -624,7 +616,7 @@ static void wbt_cleanup(struct rq_qos *rqos, struct bio *bio)
  * in an irq held spinlock, if it holds one when calling this function.
  * If we do sleep, we'll release and re-grab it.
  */
-static void wbt_wait(struct rq_qos *rqos, struct bio *bio, spinlock_t *lock)
+static void wbt_wait(struct rq_qos *rqos, struct bio *bio)
 {
 	struct rq_wb *rwb = RQWB(rqos);
 	enum wbt_flags flags;
@@ -636,7 +628,7 @@ static void wbt_wait(struct rq_qos *rqos, struct bio *bio, spinlock_t *lock)
 		return;
 	}
 
-	__wbt_wait(rwb, flags, bio->bi_opf, lock);
+	__wbt_wait(rwb, flags, bio->bi_opf);
 
 	if (!blk_stat_is_active(rwb->cb))
 		rwb_arm_timer(rwb);
-- 
2.19.1

