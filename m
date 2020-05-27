Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B03C433DF
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F892084C
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o5ula6HI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389124AbgE0SHA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 14:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388952AbgE0SHA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:07:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DEEC03E97D
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 11:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UzEzEYXNdRdDbJ5uFS+DTXsQmTTRtclxcsjkl2MiQkU=; b=o5ula6HI5yBPNqbCkRU2PlOSpf
        LmpxXVVmePtQMuBQsBvqs4subHuC5Xozh77XARkmNpn1Xs1hhfSfM3Ily7IzK8yZF0iLjBObkoPsz
        ljWJ3vpezU1QRUxW8i+l12BnRNiPej0mxK6VWB+JHPF0OGgmgBt9wIel6eOrU8AtdAOiOAxseVNgO
        iFKaEGloiurpNLYwnhr8pKXgBn95ZYFkKceij0gS+YK38Ncy84m89rs58Aod6vsh3/z8VWId7Z+iL
        Rb7qFJTjnOcOYKmmEd/5EiwVAfoqMmsj4Jf14UVKWC2PEHH+63r4r328k+LTwrFJiudPj8+rMhsXz
        cPyFzfDQ==;
Received: from p4fdb0aaa.dip0.t-ipconnect.de ([79.219.10.170] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1je0SB-000515-QG; Wed, 27 May 2020 18:07:00 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5/8] blk-mq: use BLK_MQ_NO_TAG in more places
Date:   Wed, 27 May 2020 20:06:41 +0200
Message-Id: <20200527180644.514302-6-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527180644.514302-1-hch@lst.de>
References: <20200527180644.514302-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace various magic -1 constants for tags with BLK_MQ_NO_TAG.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-tag.c |  8 ++++----
 block/blk-mq.c     | 14 +++++++-------
 block/blk-mq.h     |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index c76ba4f90fa09..597ff9c27cf63 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -92,7 +92,7 @@ static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 {
 	if (!(data->flags & BLK_MQ_REQ_INTERNAL) &&
 	    !hctx_may_queue(data->hctx, bt))
-		return -1;
+		return BLK_MQ_NO_TAG;
 	if (data->shallow_depth)
 		return __sbitmap_queue_get_shallow(bt, data->shallow_depth);
 	else
@@ -121,7 +121,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	}
 
 	tag = __blk_mq_get_tag(data, bt);
-	if (tag != -1)
+	if (tag != BLK_MQ_NO_TAG)
 		goto found_tag;
 
 	if (data->flags & BLK_MQ_REQ_NOWAIT)
@@ -143,13 +143,13 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		 * as running the queue may also have found completions.
 		 */
 		tag = __blk_mq_get_tag(data, bt);
-		if (tag != -1)
+		if (tag != BLK_MQ_NO_TAG)
 			break;
 
 		sbitmap_prepare_to_wait(bt, ws, &wait, TASK_UNINTERRUPTIBLE);
 
 		tag = __blk_mq_get_tag(data, bt);
-		if (tag != -1)
+		if (tag != BLK_MQ_NO_TAG)
 			break;
 
 		bt_prev = bt;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 826ff8f97489c..cde2aec558ac5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -278,7 +278,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	req_flags_t rq_flags = 0;
 
 	if (data->flags & BLK_MQ_REQ_INTERNAL) {
-		rq->tag = -1;
+		rq->tag = BLK_MQ_NO_TAG;
 		rq->internal_tag = tag;
 	} else {
 		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
@@ -286,7 +286,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 			atomic_inc(&data->hctx->nr_active);
 		}
 		rq->tag = tag;
-		rq->internal_tag = -1;
+		rq->internal_tag = BLK_MQ_NO_TAG;
 		data->hctx->tags->rqs[rq->tag] = rq;
 	}
 
@@ -483,9 +483,9 @@ static void __blk_mq_free_request(struct request *rq)
 	blk_crypto_free_request(rq);
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
-	if (rq->tag != -1)
+	if (rq->tag != BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
-	if (sched_tag != -1)
+	if (sched_tag != BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->sched_tags, ctx, sched_tag);
 	blk_mq_sched_restart(hctx);
 	blk_queue_exit(q);
@@ -534,7 +534,7 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 		blk_stat_add(rq, now);
 	}
 
-	if (rq->internal_tag != -1)
+	if (rq->internal_tag != BLK_MQ_NO_TAG)
 		blk_mq_sched_completed_request(rq, now);
 
 	blk_account_io_done(rq, now);
@@ -1033,7 +1033,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
 	};
 	bool shared;
 
-	if (rq->tag != -1)
+	if (rq->tag != BLK_MQ_NO_TAG)
 		return true;
 
 	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
@@ -1049,7 +1049,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
 		data.hctx->tags->rqs[rq->tag] = rq;
 	}
 
-	return rq->tag != -1;
+	return rq->tag != BLK_MQ_NO_TAG;
 }
 
 static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 10bfdfb494faf..a139b06318174 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -201,7 +201,7 @@ static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 					   struct request *rq)
 {
 	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
-	rq->tag = -1;
+	rq->tag = BLK_MQ_NO_TAG;
 
 	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
 		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
@@ -211,7 +211,7 @@ static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 
 static inline void blk_mq_put_driver_tag(struct request *rq)
 {
-	if (rq->tag == -1 || rq->internal_tag == -1)
+	if (rq->tag == BLK_MQ_NO_TAG || rq->internal_tag == BLK_MQ_NO_TAG)
 		return;
 
 	__blk_mq_put_driver_tag(rq->mq_hctx, rq);
-- 
2.26.2

