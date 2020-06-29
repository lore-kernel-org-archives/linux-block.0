Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC1FC433E0
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 18:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3902063A
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 18:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u8WJXKmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgF2Ssb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729346AbgF2Sro (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 14:47:44 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB1C02F03D
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=TcGJwTqvIQqP0XnrEl/0hhdFwTBppd9xNEkujBMY1ac=; b=u8WJXKmtZJO9ykeFShVr2XNmpd
        rf2UQwSRHKwKyEjZi1hgg8Lp/aBqMGI3YOI/nr9srnt//2mR0Q5QL3otljnukYJaaNy0McwDobG1g
        LrK2oP6EbtirL/CJFrLdAMV8rgbu8La6Cimc4udtR55l9bz02/lr2siUBJDbGxg5iPNN+K+EBrNtL
        7pDPtGQDQosUT5xaJAeciBP1a8BYy6m4zMHgDfy+14jh8qgwrcR0/sGTxdAZNKDPlih1VNgWeyE19
        mQHzk5pzPo2n3iWTKkt8CkGr3if0g9Zui/z37DyYoX92c7SUafW1xKBzPOaKEVHwVO4mjGR3ITYg/
        vXOv42ww==;
Received: from [2001:4bb8:184:76e3:6bff:e1fc:8865:1ab0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpvOc-0003MB-T2; Mon, 29 Jun 2020 15:08:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: remove the BLK_MQ_REQ_INTERNAL flag
Date:   Mon, 29 Jun 2020 17:08:34 +0200
Message-Id: <20200629150834.2699386-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just check for a non-NULL elevator directly to make the code more clear.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-tag.c     |  4 ++--
 block/blk-mq.c         | 10 +++-------
 block/blk-mq.h         |  2 +-
 include/linux/blk-mq.h |  2 --
 4 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index ae722f8b13fb2c..281367b0452764 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -90,9 +90,9 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 			    struct sbitmap_queue *bt)
 {
-	if (!(data->flags & BLK_MQ_REQ_INTERNAL) &&
-	    !hctx_may_queue(data->hctx, bt))
+	if (!data->q->elevator && !hctx_may_queue(data->hctx, bt))
 		return BLK_MQ_NO_TAG;
+
 	if (data->shallow_depth)
 		return __sbitmap_queue_get_shallow(bt, data->shallow_depth);
 	else
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b8738b3c6d06a2..2e1d7b435e9a91 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -279,7 +279,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	struct request *rq = tags->static_rqs[tag];
 	req_flags_t rq_flags = 0;
 
-	if (data->flags & BLK_MQ_REQ_INTERNAL) {
+	if (data->q->elevator) {
 		rq->tag = BLK_MQ_NO_TAG;
 		rq->internal_tag = tag;
 	} else {
@@ -364,8 +364,6 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
 
 	if (e) {
-		data->flags |= BLK_MQ_REQ_INTERNAL;
-
 		/*
 		 * Flush requests are special and go directly to the
 		 * dispatch list. Don't include reserved tags in the
@@ -380,7 +378,7 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 retry:
 	data->ctx = blk_mq_get_ctx(q);
 	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
-	if (!(data->flags & BLK_MQ_REQ_INTERNAL))
+	if (!e)
 		blk_mq_tag_busy(data->hctx);
 
 	/*
@@ -476,9 +474,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
-	if (q->elevator)
-		data.flags |= BLK_MQ_REQ_INTERNAL;
-	else
+	if (!q->elevator)
 		blk_mq_tag_busy(data.hctx);
 
 	ret = -EWOULDBLOCK;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index b3ce0f3a2ad2a7..c6330335767ce9 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -159,7 +159,7 @@ struct blk_mq_alloc_data {
 
 static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data *data)
 {
-	if (data->flags & BLK_MQ_REQ_INTERNAL)
+	if (data->q->elevator)
 		return data->hctx->sched_tags;
 
 	return data->hctx->tags;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1641ec6cd7e551..8986e88a986b14 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -447,8 +447,6 @@ enum {
 	BLK_MQ_REQ_NOWAIT	= (__force blk_mq_req_flags_t)(1 << 0),
 	/* allocate from reserved pool */
 	BLK_MQ_REQ_RESERVED	= (__force blk_mq_req_flags_t)(1 << 1),
-	/* allocate internal/sched tag */
-	BLK_MQ_REQ_INTERNAL	= (__force blk_mq_req_flags_t)(1 << 2),
 	/* set RQF_PREEMPT */
 	BLK_MQ_REQ_PREEMPT	= (__force blk_mq_req_flags_t)(1 << 3),
 };
-- 
2.26.2

