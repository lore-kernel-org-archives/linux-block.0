Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A51C433E2
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618352075A
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eDUWFqBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbgE0SGz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 14:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388952AbgE0SGz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:06:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD4BC03E97D
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pK2iNjr38Ma0vdcmJbx2jzT0j5QZb+bdcUG7kz3OAHo=; b=eDUWFqBbohKaV3WBZ2lquE0KA0
        MSjHlOE4cM9/Zk2NLNAK4b+4gNeW7xH4gp5ShoiAhixlEnOwRWjm3CdLxwdJ2hYBsb/Vkj3my5gQe
        lP1mxLjLfLlbsB2ViM24uIfhPWd7aBgn0d3YPoLoU1+hrw3JHF9FKvtpfujDoltGf4yWwjkBU5zI4
        lwhYFWMhEkmIENeAwukSSx+UPBaxosReYWqtiboaQmn54xcF5yQxBoG6j3SF6xos0zxESydfMciKZ
        T3IlqXOH+hBkRLOj18lICrc0flKHxprZ+RcttPfiZaO3TUbmnwjTEnbBITW45hvm7njy1QELUIToJ
        5pfqA1vg==;
Received: from p4fdb0aaa.dip0.t-ipconnect.de ([79.219.10.170] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1je0S7-00050e-0j; Wed, 27 May 2020 18:06:55 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 3/8] blk-mq: move more request initialization to blk_mq_rq_ctx_init
Date:   Wed, 27 May 2020 20:06:39 +0200
Message-Id: <20200527180644.514302-4-hch@lst.de>
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

Don't split request initialization between __blk_mq_alloc_request and
blk_mq_rq_ctx_init.  Also remove the op argument as it can be derived
from the blk_mq_alloc_data structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
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

