Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACA9C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 16:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B5221479
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 16:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l6tSYChd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B5221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbeKVC7f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:59:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730375AbeKVC7e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 21:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Kw9NAKxjo/4mF0drF5UKQGwYF4+4sSj/14xPX01TlLc=; b=l6tSYChd9fACBr8YGbcr9RPahL
        zz164ato0OJSLfvpTe5B1z7i50jNU6UThMJAa7r1oCVNTx5vAjBZ8qJW+IazbNMvC7njrNQoW3fT2
        oSfEvRF040hrJwjfC7odQRLxIYT9DNhNQw/UuVzIgtA63ZCNM5MrnMoL8dV1QOItE2OlcZJoIIoeF
        TPB5UrHLrctLfVdlf3YmGCNqq+orDAe2ubDj8O18IXcSWoTVFARBQfmQOYOy+XLPIAuSk6lt0QRcB
        v3hIQbI5JsjMiGTn82ZxfQ5G0KdsqXqUV1Krv1NuRgsYRaZtie8WVA+f7gNc310HWdwdU3NczMBAh
        U/q/oylA==;
Received: from 089144201193.atnat0010.highway.a1.net ([89.144.201.193] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPVIb-0003Qd-0Z; Wed, 21 Nov 2018 16:24:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 11/13] block: remove ->poll_fn
Date:   Wed, 21 Nov 2018 17:23:45 +0100
Message-Id: <20181121162347.17430-12-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121162347.17430-1-hch@lst.de>
References: <20181121162347.17430-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This was intended to support users like nvme multipath, but is just
getting in the way and adding another indirect call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       | 11 -----------
 block/blk-mq.c         | 12 +++++++-----
 include/linux/blkdev.h |  2 --
 3 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f7ffc43ada14..b641175d50c2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1273,17 +1273,6 @@ blk_qc_t submit_bio(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio);
 
-int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
-{
-	if (!q->poll_fn || !blk_qc_t_valid(cookie))
-		return false;
-
-	if (current->plug)
-		blk_flush_plug_list(current->plug, false);
-	return q->poll_fn(q, cookie, spin);
-}
-EXPORT_SYMBOL_GPL(blk_poll);
-
 /**
  * blk_cloned_rq_check_limits - Helper function to check a cloned request
  *                              for new the queue limits
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cda698804422..32e43bea36e3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -38,7 +38,6 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
-static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, bool spin);
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
@@ -2794,8 +2793,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	spin_lock_init(&q->requeue_lock);
 
 	blk_queue_make_request(q, blk_mq_make_request);
-	if (q->mq_ops->poll)
-		q->poll_fn = blk_mq_poll;
 
 	/*
 	 * Do this after blk_queue_make_request() overrides it...
@@ -3356,14 +3353,18 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 	return blk_mq_poll_hybrid_sleep(q, hctx, rq);
 }
 
-static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
+int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
 	struct blk_mq_hw_ctx *hctx;
 	long state;
 
-	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+	if (!blk_qc_t_valid(cookie) ||
+	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
 
+	if (current->plug)
+		blk_flush_plug_list(current->plug, false);
+
 	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
 
 	/*
@@ -3404,6 +3405,7 @@ static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	__set_current_state(TASK_RUNNING);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(blk_poll);
 
 unsigned int blk_mq_rq_cpu(struct request *rq)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e3c0a8ec16a7..cf95e0e7e182 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -283,7 +283,6 @@ static inline unsigned short req_get_ioprio(struct request *req)
 struct blk_queue_ctx;
 
 typedef blk_qc_t (make_request_fn) (struct request_queue *q, struct bio *bio);
-typedef int (poll_q_fn) (struct request_queue *q, blk_qc_t, bool spin);
 
 struct bio_vec;
 typedef int (dma_drain_needed_fn)(struct request *);
@@ -401,7 +400,6 @@ struct request_queue {
 	struct rq_qos		*rq_qos;
 
 	make_request_fn		*make_request_fn;
-	poll_q_fn		*poll_fn;
 	dma_drain_needed_fn	*dma_drain_needed;
 
 	const struct blk_mq_ops	*mq_ops;
-- 
2.19.1

