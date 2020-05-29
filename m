Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AC1C433DF
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 13:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57AB21475
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 13:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T3ONzzck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgE2NxZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 09:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2NxY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 09:53:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EA0C03E969
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2+7ZhCufvcazTn7dZjCyfaRAo4mAoxabPyTHUY2qfLE=; b=T3ONzzckYzDuXR5Xobk+qmrCjE
        AdsrAdk/02Y7pn3UOglUTZYKRsJuRKgYyjsh5odkFYS8Arp3Wx4EvCZawUJHg9hk6UJGiCjU/NA4Y
        QV4EwEV11Ii9AIF1MOJwAcc36mbirCoda4Jk3XsZPvVHdbJyxQxS/YWEyNcrg/TsiTie2VKNXPjnw
        FN+EsehyHg1tVk4DgQxq1WLRqlzSt6iziwHL83xMDt25TZS3/aIagR2S80Plfcrc3nOQcWDnB+/Zn
        d/bKTk9K9FYUchsQ+AzvfkzjJgaIxnxcYXZwoMFYwvWbOCjVrPH8usrSKj6AIm6grtkPn8rbhrsbf
        sLhPVqmQ==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jefRr-0000nh-84; Fri, 29 May 2020 13:53:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 2/8] blk-mq: simplify the blk_mq_get_request calling convention
Date:   Fri, 29 May 2020 15:53:09 +0200
Message-Id: <20200529135315.199230-3-hch@lst.de>
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

The bio argument is entirely unused, and the request_queue can be passed
through the alloc_data, given that it needs to be filled out for the
low-level tag allocation anyway.  Also rename the function to
__blk_mq_alloc_request as the switch between get and alloc in the call
chains is rather confusing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 block/blk-mq.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c697017588c12..c1e66c014be1d 100644
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

