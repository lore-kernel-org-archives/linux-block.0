Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE506C433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 06:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98EC020787
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 06:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NTr+2aXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgERGjw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 02:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgERGjv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 02:39:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15E0C061A0C
        for <linux-block@vger.kernel.org>; Sun, 17 May 2020 23:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EOAglXxi+diVBcJb1WRam/5jGjC7TUP+q22FCA2C/eQ=; b=NTr+2aXBt1WfT2a9RUoMdECWiw
        VaPMxcrk2HdSKRzbNUVyD1ki98ES1RUvZnmUmPLV4Fo9Og6iQ67fYVfVB/5+Q1mhakyXoSU78W4hJ
        fU/d/aDfSzruBlFXqcS73uTMADKTedMYkAneifMCvRUVQdIDHuajNdWIASJoVs3ptOrY/J2JWxzF6
        PcTy4m/0cbKCwgvUVaZMmS3k/DdqlnRkSpt1tH1O7u5tcJL3fvxcoxOwjs+09GUZnANd8QZZnVPKt
        yX/3eh8FAKfDQGm8onAVGmOgM8M/Io3bESViP47TGNThN+HuE5TQyGcn/41eOXMo11dRH5DdN/cre
        PDL5TYxQ==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaZRH-0001yD-BZ; Mon, 18 May 2020 06:39:51 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4/9] blk-mq: merge blk_mq_rq_ctx_init into __blk_mq_alloc_request
Date:   Mon, 18 May 2020 08:39:32 +0200
Message-Id: <20200518063937.757218-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518063937.757218-1-hch@lst.de>
References: <20200518063937.757218-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no logical split between what gets initialized by which
function, so just merge the two.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 103 +++++++++++++++++++----------------------
 include/linux/blkdev.h |   2 +-
 2 files changed, 49 insertions(+), 56 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ef8f50cdab858..fcfce666457e2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -270,17 +270,59 @@ static inline bool blk_mq_need_time_stamp(struct request *rq)
 	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS)) || rq->q->elevator;
 }
 
-static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
-		unsigned int tag, unsigned int op, u64 alloc_time_ns)
+static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 {
-	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
-	struct request *rq = tags->static_rqs[tag];
+	struct request_queue *q = data->q;
+	struct elevator_queue *e = q->elevator;
+	struct request *rq;
+	unsigned int tag;
+	bool clear_ctx_on_error = false;
 	req_flags_t rq_flags = 0;
+	u64 alloc_time_ns = 0;
+
+	/* alloc_time includes depth and tag waits */
+	if (blk_queue_rq_alloc_time(q))
+		alloc_time_ns = ktime_get_ns();
+
+	if (likely(!data->ctx)) {
+		data->ctx = blk_mq_get_ctx(q);
+		clear_ctx_on_error = true;
+	}
+	if (likely(!data->hctx))
+		data->hctx = blk_mq_map_queue(q, data->cmd_flags,
+						data->ctx);
+	if (data->cmd_flags & REQ_NOWAIT)
+		data->flags |= BLK_MQ_REQ_NOWAIT;
+
+	if (e) {
+		data->flags |= BLK_MQ_REQ_INTERNAL;
+
+		/*
+		 * Flush requests are special and go directly to the
+		 * dispatch list. Don't include reserved tags in the
+		 * limiting, as it isn't useful.
+		 */
+		if (!op_is_flush(data->cmd_flags) &&
+		    e->type->ops.limit_depth &&
+		    !(data->flags & BLK_MQ_REQ_RESERVED))
+			e->type->ops.limit_depth(data->cmd_flags, data);
+	} else {
+		blk_mq_tag_busy(data->hctx);
+	}
+
+	tag = blk_mq_get_tag(data);
+	if (tag == BLK_MQ_TAG_FAIL) {
+		if (clear_ctx_on_error)
+			data->ctx = NULL;
+		return NULL;
+	}
 
 	if (data->flags & BLK_MQ_REQ_INTERNAL) {
+		rq = data->hctx->sched_tags->static_rqs[tag];
 		rq->tag = -1;
 		rq->internal_tag = tag;
 	} else {
+		rq = data->hctx->tags->static_rqs[tag];
 		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
 			rq_flags = RQF_MQ_INFLIGHT;
 			atomic_inc(&data->hctx->nr_active);
@@ -295,7 +337,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->mq_ctx = data->ctx;
 	rq->mq_hctx = data->hctx;
 	rq->rq_flags = rq_flags;
-	rq->cmd_flags = op;
+	rq->cmd_flags = data->cmd_flags;
 	if (data->flags & BLK_MQ_REQ_PREEMPT)
 		rq->rq_flags |= RQF_PREEMPT;
 	if (blk_queue_io_stat(data->q))
@@ -327,58 +369,9 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->end_io = NULL;
 	rq->end_io_data = NULL;
 
-	data->ctx->rq_dispatched[op_is_sync(op)]++;
+	data->ctx->rq_dispatched[op_is_sync(data->cmd_flags)]++;
 	refcount_set(&rq->ref, 1);
-	return rq;
-}
-
-static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
-{
-	struct request_queue *q = data->q;
-	struct elevator_queue *e = q->elevator;
-	struct request *rq;
-	unsigned int tag;
-	bool clear_ctx_on_error = false;
-	u64 alloc_time_ns = 0;
-
-	/* alloc_time includes depth and tag waits */
-	if (blk_queue_rq_alloc_time(q))
-		alloc_time_ns = ktime_get_ns();
-
-	if (likely(!data->ctx)) {
-		data->ctx = blk_mq_get_ctx(q);
-		clear_ctx_on_error = true;
-	}
-	if (likely(!data->hctx))
-		data->hctx = blk_mq_map_queue(q, data->cmd_flags,
-						data->ctx);
-	if (data->cmd_flags & REQ_NOWAIT)
-		data->flags |= BLK_MQ_REQ_NOWAIT;
-
-	if (e) {
-		data->flags |= BLK_MQ_REQ_INTERNAL;
-
-		/*
-		 * Flush requests are special and go directly to the
-		 * dispatch list. Don't include reserved tags in the
-		 * limiting, as it isn't useful.
-		 */
-		if (!op_is_flush(data->cmd_flags) &&
-		    e->type->ops.limit_depth &&
-		    !(data->flags & BLK_MQ_REQ_RESERVED))
-			e->type->ops.limit_depth(data->cmd_flags, data);
-	} else {
-		blk_mq_tag_busy(data->hctx);
-	}
-
-	tag = blk_mq_get_tag(data);
-	if (tag == BLK_MQ_TAG_FAIL) {
-		if (clear_ctx_on_error)
-			data->ctx = NULL;
-		return NULL;
-	}
 
-	rq = blk_mq_rq_ctx_init(data, tag, data->cmd_flags, alloc_time_ns);
 	if (!op_is_flush(data->cmd_flags)) {
 		rq->elv.icq = NULL;
 		if (e && e->type->ops.prepare_request) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2b33166b9daf1..e44d56ee435db 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -126,7 +126,7 @@ enum mq_rq_state {
  * Try to put the fields that are referenced together in the same cacheline.
  *
  * If you modify this structure, make sure to update blk_rq_init() and
- * especially blk_mq_rq_ctx_init() to take care of the added fields.
+ * especially __blk_mq_alloc_request() to take care of the added fields.
  */
 struct request {
 	struct request_queue *q;
-- 
2.26.2

