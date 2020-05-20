Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529F5C433E0
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 17:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 131D2206B6
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 17:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BoGz61Rv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgETRGp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 13:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgETRGo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 13:06:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8622C061A0E
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 10:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TCMDxmwNRP2oknSJ46WhD78QVLYrIfVtAtrewmd6Ipo=; b=BoGz61RvNxJAlB/esYsbKWDTFs
        OOFlN66BqxCwB4ZYe1+a2qZBYF2/vtgI+G6tXcuI/ddcuixlRGVFhi1Ep5ZqUDr3fpyke3WH+LVoX
        Oh7lqftJMd1DMdxno0lJImpvYRT+O/MwVEKRRJ3TczN6OQYQTCL/xGevtpaX+YNkvTJ/LmwGRbN6E
        M+NyviYYLogDZaVe+ZI2+ggkNsHiz5RysBeXUw3k50gaGOG75qD+iaR5Wi3l9nQr5X72FjI6Yo36Z
        og028nMiDaLBVcnnzicI6FOx5ZghLHDB0PDYB6ZRhOKRJsbq/FaENUwQF77uPAQ8aErosSWBUYEF3
        fT+GGEdg==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbSB2-00037G-FV; Wed, 20 May 2020 17:06:44 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/6] blk-mq: move more request initialization to blk_mq_rq_ctx_init
Date:   Wed, 20 May 2020 19:06:32 +0200
Message-Id: <20200520170635.2094101-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520170635.2094101-1-hch@lst.de>
References: <20200520170635.2094101-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't split request initialization between __blk_mq_alloc_request and
blk_mq_rq_ctx_init.  Also remove a pointless argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2250e6397559b..1ffbc5d9e7cfe 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -271,7 +271,7 @@ static inline bool blk_mq_need_time_stamp(struct request *rq)
 }
 
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
-		unsigned int tag, unsigned int op, u64 alloc_time_ns)
+		unsigned int tag, u64 alloc_time_ns)
 {
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct request *rq = tags->static_rqs[tag];
@@ -295,7 +295,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->mq_ctx = data->ctx;
 	rq->mq_hctx = data->hctx;
 	rq->rq_flags = rq_flags;
-	rq->cmd_flags = op;
+	rq->cmd_flags = data->cmd_flags;
 	if (data->flags & BLK_MQ_REQ_PREEMPT)
 		rq->rq_flags |= RQF_PREEMPT;
 	if (blk_queue_io_stat(data->q))
@@ -327,8 +327,23 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->end_io = NULL;
 	rq->end_io_data = NULL;
 
-	data->ctx->rq_dispatched[op_is_sync(op)]++;
+	data->ctx->rq_dispatched[op_is_sync(data->cmd_flags)]++;
 	refcount_set(&rq->ref, 1);
+
+	if (!op_is_flush(data->cmd_flags)) {
+		struct elevator_queue *e = data->q->elevator;
+
+		rq->elv.icq = NULL;
+		if (e && e->type->ops.prepare_request) {
+			if (e->type->icq_cache)
+				blk_mq_sched_assign_ioc(rq);
+
+			e->type->ops.prepare_request(rq);
+			rq->rq_flags |= RQF_ELVPRIV;
+		}
+	}
+
+	data->hctx->queued++;
 	return rq;
 }
 
@@ -336,7 +351,6 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 {
 	struct request_queue *q = data->q;
 	struct elevator_queue *e = q->elevator;
-	struct request *rq;
 	unsigned int tag;
 	bool clear_ctx_on_error = false;
 	u64 alloc_time_ns = 0;
@@ -378,19 +392,7 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 		return NULL;
 	}
 
-	rq = blk_mq_rq_ctx_init(data, tag, data->cmd_flags, alloc_time_ns);
-	if (!op_is_flush(data->cmd_flags)) {
-		rq->elv.icq = NULL;
-		if (e && e->type->ops.prepare_request) {
-			if (e->type->icq_cache)
-				blk_mq_sched_assign_ioc(rq);
-
-			e->type->ops.prepare_request(rq);
-			rq->rq_flags |= RQF_ELVPRIV;
-		}
-	}
-	data->hctx->queued++;
-	return rq;
+	return blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
 }
 
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
-- 
2.26.2

