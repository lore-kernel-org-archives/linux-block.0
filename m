Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAF7C433E1
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FCB720C56
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WwLi4Do2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388737AbgE0SGy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 14:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388952AbgE0SGy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:06:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EA2C08C5C2
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 11:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hVLoK50S7Z+zdYaGyGPKyOFSm/U4jWBdrmqXM6awnh8=; b=WwLi4Do21UprXFU/M6ZneNiU6l
        vxPKpGyWrleYSTuM0i8BWH4oDbYPjpNJ5I8eF7rFAf0IOlfbB2SsLoM5seretEiB8or4mpBs/zfue
        4T6Jup5E/1/HOt1Xx+L0OJ70lsIfOu/AtlNA7IIgcPpdp1e8wbUDHDj9Ub7mPm2GEszV+W7OaxLQ9
        5gwDaxDVpSN4bcmOplJP4oFvVMuzotG5ItFWILNS7sl2xTM8b5Ef6cr+3PlMyJcgEhLphYCLOb0yX
        qT3eYfKCve/uNxuYQTf0xisxDr8ZPBDODcds09vj8k8gkVtDHalCzFALAhuIStWxnG94PKB7esxFI
        9G3WtEFA==;
Received: from p4fdb0aaa.dip0.t-ipconnect.de ([79.219.10.170] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1je0S4-00050Y-Je; Wed, 27 May 2020 18:06:52 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 2/8] blk-mq: simplify the blk_mq_get_request calling convention
Date:   Wed, 27 May 2020 20:06:38 +0200
Message-Id: <20200527180644.514302-3-hch@lst.de>
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

The bio argument is entirely unused, and the request_queue can be passed
through the alloc_data, given that it needs to be filled out for the
low-level tag allocation anyway.  Also rename the function to
__blk_mq_alloc_request as the switch between get and alloc in the call
chains is rather confusing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 block/blk-mq.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 850e3642efc40..2250e6397559b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -332,10 +332,9 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	return rq;
 }
 
-static struct request *blk_mq_get_request(struct request_queue *q,
-					  struct bio *bio,
-					  struct blk_mq_alloc_data *data)
+static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 {
+	struct request_queue *q = data->q;
 	struct elevator_queue *e = q->elevator;
 	struct request *rq;
 	unsigned int tag;
@@ -346,7 +345,6 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	if (blk_queue_rq_alloc_time(q))
 		alloc_time_ns = ktime_get_ns();
 
-	data->q = q;
 	if (likely(!data->ctx)) {
 		data->ctx = blk_mq_get_ctx(q);
 		clear_ctx_on_error = true;
@@ -398,7 +396,11 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 		blk_mq_req_flags_t flags)
 {
-	struct blk_mq_alloc_data alloc_data = { .flags = flags, .cmd_flags = op };
+	struct blk_mq_alloc_data data = {
+		.q		= q,
+		.flags		= flags,
+		.cmd_flags	= op,
+	};
 	struct request *rq;
 	int ret;
 
@@ -406,7 +408,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 	if (ret)
 		return ERR_PTR(ret);
 
-	rq = blk_mq_get_request(q, NULL, &alloc_data);
+	rq = __blk_mq_alloc_request(&data);
 	if (!rq)
 		goto out_queue_exit;
 	rq->__data_len = 0;
@@ -422,7 +424,11 @@ EXPORT_SYMBOL(blk_mq_alloc_request);
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	unsigned int op, blk_mq_req_flags_t flags, unsigned int hctx_idx)
 {
-	struct blk_mq_alloc_data alloc_data = { .flags = flags, .cmd_flags = op };
+	struct blk_mq_alloc_data data = {
+		.q		= q,
+		.flags		= flags,
+		.cmd_flags	= op,
+	};
 	struct request *rq;
 	unsigned int cpu;
 	int ret;
@@ -448,14 +454,14 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	 * If not tell the caller that it should skip this queue.
 	 */
 	ret = -EXDEV;
-	alloc_data.hctx = q->queue_hw_ctx[hctx_idx];
-	if (!blk_mq_hw_queue_mapped(alloc_data.hctx))
+	data.hctx = q->queue_hw_ctx[hctx_idx];
+	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
-	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
-	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
+	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
+	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	ret = -EWOULDBLOCK;
-	rq = blk_mq_get_request(q, NULL, &alloc_data);
+	rq = __blk_mq_alloc_request(&data);
 	if (!rq)
 		goto out_queue_exit;
 	return rq;
@@ -2016,7 +2022,9 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 {
 	const int is_sync = op_is_sync(bio->bi_opf);
 	const int is_flush_fua = op_is_flush(bio->bi_opf);
-	struct blk_mq_alloc_data data = { .flags = 0};
+	struct blk_mq_alloc_data data = {
+		.q		= q,
+	};
 	struct request *rq;
 	struct blk_plug *plug;
 	struct request *same_queue_rq = NULL;
@@ -2040,7 +2048,7 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	rq_qos_throttle(q, bio);
 
 	data.cmd_flags = bio->bi_opf;
-	rq = blk_mq_get_request(q, bio, &data);
+	rq = __blk_mq_alloc_request(&data);
 	if (unlikely(!rq)) {
 		rq_qos_cleanup(q, bio);
 		if (bio->bi_opf & REQ_NOWAIT)
-- 
2.26.2

