Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8F0C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E99208E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NqhQBVZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E99208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbeKOCGQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:06:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeKOCGP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GgkbLm4aj778i58LRBJCVM4tY1mReXiv/WOPYxzOVg4=; b=NqhQBVZ2+7ojq4QXLc59+oI3oa
        pl94huKOlRGmfSX5XnuqVsZc3wQ3N3bLoWtBRSLDg6BVChunn2qTSThuhfBdqu9DRED2ezhhWXMG3
        mj+KsMtjPwVUh/rp88ouv1nKZI/CkGNBYtMeQggBUuc8oRnH7YUmrzm9i/0BKuveAqO8YHCGv+eHl
        YnRxjPzi67ztT26pVanV/JN3E+o4H1r7k+9NXNUqvroSAvigjvyLdOEKQVOvSI3kUHuPqPiw+jled
        xQr/s7DuvCWMoCchBo4VRUPbPmP9/wJkTULVyT8A97MLaui244GXAIS3j6A5Ev70YZeGk3klDvgd7
        rQjX3lqA==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxcY-00068R-Me; Wed, 14 Nov 2018 16:02:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: [PATCH 02/16] block: remove deadline __deadline manipulation helpers
Date:   Wed, 14 Nov 2018 17:02:05 +0100
Message-Id: <20181114160219.28328-3-hch@lst.de>
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

No users left since the removal of the legacy request interface, we can
remove all the magic bit stealing now and make it a normal field.

But use WRITE_ONCE/READ_ONCE on the new deadline field, given that we
don't seem to have any mechanism to guarantee a new value actually
gets seen by other threads.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         |  4 ++--
 block/blk-timeout.c    |  8 +++++---
 block/blk.h            | 35 -----------------------------------
 include/linux/blkdev.h |  4 +---
 4 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 411be60d0cb6..4c82b4b4fa3e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -325,7 +325,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->special = NULL;
 	/* tag was already set */
 	rq->extra_len = 0;
-	rq->__deadline = 0;
+	WRITE_ONCE(rq->deadline, 0);
 
 	rq->timeout = 0;
 
@@ -839,7 +839,7 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 	if (rq->rq_flags & RQF_TIMED_OUT)
 		return false;
 
-	deadline = blk_rq_deadline(rq);
+	deadline = READ_ONCE(rq->deadline);
 	if (time_after_eq(jiffies, deadline))
 		return true;
 
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 006cff4390c0..3b0179fbdd6a 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -84,7 +84,7 @@ void blk_abort_request(struct request *req)
 	 * immediately and that scan sees the new timeout value.
 	 * No need for fancy synchronizations.
 	 */
-	blk_rq_set_deadline(req, jiffies);
+	WRITE_ONCE(req->deadline, jiffies);
 	kblockd_schedule_work(&req->q->timeout_work);
 }
 EXPORT_SYMBOL_GPL(blk_abort_request);
@@ -121,14 +121,16 @@ void blk_add_timer(struct request *req)
 		req->timeout = q->rq_timeout;
 
 	req->rq_flags &= ~RQF_TIMED_OUT;
-	blk_rq_set_deadline(req, jiffies + req->timeout);
+
+	expiry = jiffies + req->timeout;
+	WRITE_ONCE(req->deadline, expiry);
 
 	/*
 	 * If the timer isn't already pending or this timeout is earlier
 	 * than an existing one, modify the timer. Round up to next nearest
 	 * second.
 	 */
-	expiry = blk_rq_timeout(round_jiffies_up(blk_rq_deadline(req)));
+	expiry = blk_rq_timeout(round_jiffies_up(expiry));
 
 	if (!timer_pending(&q->timeout) ||
 	    time_before(expiry, q->timeout.expires)) {
diff --git a/block/blk.h b/block/blk.h
index 41b64e6e101b..08a5845b03ba 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -238,26 +238,6 @@ void blk_account_io_start(struct request *req, bool new_io);
 void blk_account_io_completion(struct request *req, unsigned int bytes);
 void blk_account_io_done(struct request *req, u64 now);
 
-/*
- * EH timer and IO completion will both attempt to 'grab' the request, make
- * sure that only one of them succeeds. Steal the bottom bit of the
- * __deadline field for this.
- */
-static inline int blk_mark_rq_complete(struct request *rq)
-{
-	return test_and_set_bit(0, &rq->__deadline);
-}
-
-static inline void blk_clear_rq_complete(struct request *rq)
-{
-	clear_bit(0, &rq->__deadline);
-}
-
-static inline bool blk_rq_is_complete(struct request *rq)
-{
-	return test_bit(0, &rq->__deadline);
-}
-
 /*
  * Internal elevator interface
  */
@@ -322,21 +302,6 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
 		q->last_merge = NULL;
 }
 
-/*
- * Steal a bit from this field for legacy IO path atomic IO marking. Note that
- * setting the deadline clears the bottom bit, potentially clearing the
- * completed bit. The user has to be OK with this (current ones are fine).
- */
-static inline void blk_rq_set_deadline(struct request *rq, unsigned long time)
-{
-	rq->__deadline = time & ~0x1UL;
-}
-
-static inline unsigned long blk_rq_deadline(struct request *rq)
-{
-	return rq->__deadline & ~0x1UL;
-}
-
 /*
  * Internal io_context interface
  */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c92aafcde0b8..1aa94759d219 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -224,9 +224,7 @@ struct request {
 	refcount_t ref;
 
 	unsigned int timeout;
-
-	/* access through blk_rq_set_deadline, blk_rq_deadline */
-	unsigned long __deadline;
+	unsigned long deadline;
 
 	union {
 		struct __call_single_data csd;
-- 
2.19.1

