Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D73BC433E1
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8BD2084C
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QW5ihjtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388709AbgE0SHD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 14:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387696AbgE0SHC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:07:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD5C03E97D
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 11:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cP74TfMeHrOjm15+vgH6/2x8rrfNvPddeOSpQnX7PPI=; b=QW5ihjtbNeVAMmw2JYNj/ssMub
        FflVowzyGcuAx2bR2/Xsbpj8UntCj3wvJVlpuSAHuYEsIyi6mRhZzBLcgWlUoseB5ymiWQgAJoO9M
        CrslQ7zP7mub/8UuyK7/oxjWi6hU2F40FdYhiq1yyjycb8hccCiMYn1AgPukJd4z/2Q+cC3TJgz7L
        xZwI36/AD9Ht7bFSY7mfLDu48zd4nZuj1vReD63RTtS991rA8kPzuQBjaJpuLDKN1PG5ZDKtTnr2W
        zcocJCHj7whWx2Z9arLHdvzfEXm6/Zb83Cs1LMnRl3Dtrvo18Cq3S0owmHXXWSyzZJsm9m8fmC/ZP
        l0hYVzdA==;
Received: from p4fdb0aaa.dip0.t-ipconnect.de ([79.219.10.170] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1je0SE-00051H-77; Wed, 27 May 2020 18:07:02 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/8] blk-mq: open code __blk_mq_alloc_request in blk_mq_alloc_request_hctx
Date:   Wed, 27 May 2020 20:06:42 +0200
Message-Id: <20200527180644.514302-7-hch@lst.de>
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

blk_mq_alloc_request_hctx is only used for NVMeoF connect commands, so
tailor it to the specific requirements, and don't bother the general
fast path code with its special twinkles.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de
---
 block/blk-mq.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index cde2aec558ac5..898400452b1cf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -351,21 +351,13 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 {
 	struct request_queue *q = data->q;
 	struct elevator_queue *e = q->elevator;
-	unsigned int tag;
-	bool clear_ctx_on_error = false;
 	u64 alloc_time_ns = 0;
+	unsigned int tag;
 
 	/* alloc_time includes depth and tag waits */
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
 
@@ -381,17 +373,16 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 		    e->type->ops.limit_depth &&
 		    !(data->flags & BLK_MQ_REQ_RESERVED))
 			e->type->ops.limit_depth(data->cmd_flags, data);
-	} else {
-		blk_mq_tag_busy(data->hctx);
 	}
 
+	data->ctx = blk_mq_get_ctx(q);
+	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
+	if (!(data->flags & BLK_MQ_REQ_INTERNAL))
+		blk_mq_tag_busy(data->hctx);
+
 	tag = blk_mq_get_tag(data);
-	if (tag == BLK_MQ_NO_TAG) {
-		if (clear_ctx_on_error)
-			data->ctx = NULL;
+	if (tag == BLK_MQ_NO_TAG)
 		return NULL;
-	}
-
 	return blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
 }
 
@@ -431,17 +422,22 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		.flags		= flags,
 		.cmd_flags	= op,
 	};
-	struct request *rq;
+	u64 alloc_time_ns = 0;
 	unsigned int cpu;
+	unsigned int tag;
 	int ret;
 
+	/* alloc_time includes depth and tag waits */
+	if (blk_queue_rq_alloc_time(q))
+		alloc_time_ns = ktime_get_ns();
+
 	/*
 	 * If the tag allocator sleeps we could get an allocation for a
 	 * different hardware context.  No need to complicate the low level
 	 * allocator for this for the rare use case of a command tied to
 	 * a specific queue.
 	 */
-	if (WARN_ON_ONCE(!(flags & BLK_MQ_REQ_NOWAIT)))
+	if (WARN_ON_ONCE(!(flags & (BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED))))
 		return ERR_PTR(-EINVAL);
 
 	if (hctx_idx >= q->nr_hw_queues)
@@ -462,11 +458,17 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
+	if (q->elevator)
+		data.flags |= BLK_MQ_REQ_INTERNAL;
+	else
+		blk_mq_tag_busy(data.hctx);
+
 	ret = -EWOULDBLOCK;
-	rq = __blk_mq_alloc_request(&data);
-	if (!rq)
+	tag = blk_mq_get_tag(&data);
+	if (tag == BLK_MQ_NO_TAG)
 		goto out_queue_exit;
-	return rq;
+	return blk_mq_rq_ctx_init(&data, tag, alloc_time_ns);
+
 out_queue_exit:
 	blk_queue_exit(q);
 	return ERR_PTR(ret);
-- 
2.26.2

