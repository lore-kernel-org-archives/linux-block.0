Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C063C433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 06:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073AF20787
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 06:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ERZbpcMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgERGj5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 02:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgERGj5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 02:39:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C59C061A0C
        for <linux-block@vger.kernel.org>; Sun, 17 May 2020 23:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OCGHL/7OKzWSzrEzUzSSvli0jyCv23Sqm2eQ46Oh21k=; b=ERZbpcMOc2KFcdtUyIySBig0Ez
        WzMpxCGWyjSE2GOIGLRukoDV3tamAV8ZL2eGyio0L/QjvgGOrm8Emre2SvM+W4lGAOH2vr68gHM37
        y0VPrKy9htPEv3ZHYGp5PWex4vb2KOGtkhsAT+fQxYQqU30VyFedjaTWE62/XjhYbNpaRaGL5RHTE
        EHuMiBFt+N/UfELsOQppnCvkhinisWvRx8dAkFUzjFGeYVrerMi2pkRsS+7069ga0xHtCO0AtD8pW
        oih44CUd+/cxtkYinsSpFweNckYkZSqJ2B/wWVuNcH+5bJ/1kjTsIsPeot3160I75gkQuj3+prwtc
        wSEhY4oA==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaZRM-0001z5-On; Mon, 18 May 2020 06:39:57 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6/9] blk-mq: don't set data->ctx and data->hctx in __blk_mq_alloc_request
Date:   Mon, 18 May 2020 08:39:34 +0200
Message-Id: <20200518063937.757218-7-hch@lst.de>
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

Now that blk_mq_alloc_request_hctx doesn't set ->ctx and ->hctx itself,
all setting of it can be done in the low-level blk_mq_get_tag helper.

Based on patch from Ming Lei <ming.lei@redhat.com>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-tag.c |  8 +++++++-
 block/blk-mq.c     | 15 +--------------
 block/blk-mq.h     |  4 ++--
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index e5b17300ec882..b526f1f5a3bf3 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -101,13 +101,19 @@ static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 
 unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 {
-	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
+	struct blk_mq_tags *tags;
 	struct sbitmap_queue *bt;
 	struct sbq_wait_state *ws;
 	DEFINE_SBQ_WAIT(wait);
 	unsigned int tag_offset;
 	int tag;
 
+	data->ctx = blk_mq_get_ctx(data->q);
+	data->hctx = blk_mq_map_queue(data->q, data->cmd_flags, data->ctx);
+	tags = blk_mq_tags_from_data(data);
+	if (!(data->flags & BLK_MQ_REQ_INTERNAL))
+		blk_mq_tag_busy(data->hctx);
+
 	if (data->flags & BLK_MQ_REQ_RESERVED) {
 		if (unlikely(!tags->nr_reserved_tags)) {
 			WARN_ON_ONCE(1);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 540b5845cd1d3..74c2d8f61426c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -276,7 +276,6 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 	struct elevator_queue *e = q->elevator;
 	struct request *rq;
 	unsigned int tag;
-	bool clear_ctx_on_error = false;
 	req_flags_t rq_flags = 0;
 	u64 alloc_time_ns = 0;
 
@@ -284,13 +283,6 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 	if (blk_queue_rq_alloc_time(q))
 		alloc_time_ns = ktime_get_ns();
 
-	if (likely(!data->ctx)) {
-		data->ctx = blk_mq_get_ctx(q);
-		clear_ctx_on_error = true;
-	}
-	if (likely(!data->hctx))
-		data->hctx = blk_mq_map_queue(q, data->cmd_flags,
-						data->ctx);
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
 
@@ -306,16 +298,11 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 		    e->type->ops.limit_depth &&
 		    !(data->flags & BLK_MQ_REQ_RESERVED))
 			e->type->ops.limit_depth(data->cmd_flags, data);
-	} else {
-		blk_mq_tag_busy(data->hctx);
 	}
 
 	tag = blk_mq_get_tag(data);
-	if (tag == BLK_MQ_TAG_FAIL) {
-		if (clear_ctx_on_error)
-			data->ctx = NULL;
+	if (tag == BLK_MQ_TAG_FAIL)
 		return NULL;
-	}
 
 	if (data->flags & BLK_MQ_REQ_INTERNAL) {
 		rq = data->hctx->sched_tags->static_rqs[tag];
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 82921b30b6afa..1338be9d51777 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -146,13 +146,13 @@ static inline struct blk_mq_ctx *blk_mq_get_ctx(struct request_queue *q)
 }
 
 struct blk_mq_alloc_data {
-	/* input parameter */
+	/* input parameters */
 	struct request_queue *q;
 	blk_mq_req_flags_t flags;
 	unsigned int shallow_depth;
 	unsigned int cmd_flags;
 
-	/* input & output parameter */
+	/* output parameters */
 	struct blk_mq_ctx *ctx;
 	struct blk_mq_hw_ctx *hctx;
 
-- 
2.26.2

