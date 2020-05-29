Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA072C433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 13:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9652206A1
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 13:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T9yx7gJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgE2Nx2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 09:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2Nx1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 09:53:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8AAC03E969
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VvLKWA71OANoo922Wht7iHAQfAI5iri7SHordecipUI=; b=T9yx7gJVJwhG788PXJ640u22xt
        +OfaIo5I2+WensjwD4MktWYvmyxI9h+msGrbY97ujgV8n8vv9dRm4OsUpzDnl+ztAPaPpWb0bnMMA
        4kpMcU/k4K2c8ZIL0GmSjq+/OxW3Ss9DF8YNceicbR/Xs7cND7HaAt2hqg+p9CxhK1WMHjv1PtUZH
        z59c+ZYZItWlHSsIZekPTsKcGxO+IP7BuAeU6fRHyKMMwtJZ0FG3I1Ybt27Zr9nh0ioU2WKT9JJTZ
        CU1Y4+5OeSPtmvySVPdZ8plTzWcFZBy4SlCbCPZtZEgBZOsXaMB2eI6wdZzTuqojbDDE4ueAJrcwM
        NhDN/47w==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jefRu-0000oK-0o; Fri, 29 May 2020 13:53:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 3/8] blk-mq: move more request initialization to blk_mq_rq_ctx_init
Date:   Fri, 29 May 2020 15:53:10 +0200
Message-Id: <20200529135315.199230-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529135315.199230-1-hch@lst.de>
References: <20200529135315.199230-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't split request initialization between __blk_mq_alloc_request and
blk_mq_rq_ctx_init.  Also remove the op argument as it can be derived
from the blk_mq_alloc_data structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 block/blk-mq.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c1e66c014be1d..89c6223c1b603 100644
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

