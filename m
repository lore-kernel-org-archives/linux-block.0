Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605E7C433DF
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 06:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DC8207C4
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 06:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QQlDFFVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgERGjy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 02:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgERGjy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 02:39:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3EFC061A0C
        for <linux-block@vger.kernel.org>; Sun, 17 May 2020 23:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MrPU98BeY35Hj/3OWL1llgYMGl7mQNaUfrtO9cv5ku8=; b=QQlDFFVpbKtltvFcqsoHBV9tx3
        KV2gLjH2e/aqYa0cjwT2xLWylB94Jq2tCn4l1X2an2d5xMWELsfaevgE7CNIEaWPEoNhGGIayOXRC
        hxfDa9LTRrVF8FjpsbiQhFYKcR7UbVS/JvzvgIyrLSywfkWF8/Bx+8huy4UG5ZGAH5HPecxLMgpky
        DxsfKw57AkShXfGGrGNbT8HsRentl2O+GbiS3jjZHlReehsSbUFlLLHeFbwI1Sme9ZVZUG9XMtzO9
        XMR+2hqEEiQ54l3yGdu7C9ujsRg8QhGyczsg1GsAmOSK+w5UFDXeuiMgOxBaUHrEVnJ9uw0pmpEqW
        MMBgqq/Q==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaZRK-0001yf-1G; Mon, 18 May 2020 06:39:54 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/9] blk-mq: don't set data->ctx and data->hctx in blk_mq_alloc_request_hctx
Date:   Mon, 18 May 2020 08:39:33 +0200
Message-Id: <20200518063937.757218-6-hch@lst.de>
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

From: Ming Lei <ming.lei@redhat.com>

blk_mq_alloc_request_hctx() asks blk-mq to allocate request from a
specified hctx, which is usually bound with fixed cpu mapping, and
request is supposed to be allocated on CPU in hctx->cpumask.

Use smp_call_function_any() to allocate a request on a CPU that is set
in hctx->cpumask and return it in blk_mq_alloc_data instead to prepare
for better CPU hotplug support in blk-mq.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
[hch: reuse blk_mq_alloc_data for the smp_call_function_any argument]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 24 ++++++++++++++++++------
 block/blk-mq.h |  3 +++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index fcfce666457e2..540b5845cd1d3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -386,6 +386,20 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 	return rq;
 }
 
+static void __blk_mq_alloc_request_cb(void *__data)
+{
+	struct blk_mq_alloc_data *data = __data;
+
+	data->rq = __blk_mq_alloc_request(data);
+}
+
+static struct request *__blk_mq_alloc_request_on_cpumask(const cpumask_t *mask,
+		struct blk_mq_alloc_data *data)
+{
+	smp_call_function_any(mask, __blk_mq_alloc_request_cb, data, 1);
+	return data->rq;
+}
+
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 		blk_mq_req_flags_t flags)
 {
@@ -423,7 +437,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		.cmd_flags	= op,
 	};
 	struct request *rq;
-	unsigned int cpu;
+	struct blk_mq_hw_ctx *hctx;
 	int ret;
 
 	/*
@@ -447,14 +461,12 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	 * If not tell the caller that it should skip this queue.
 	 */
 	ret = -EXDEV;
-	data.hctx = q->queue_hw_ctx[hctx_idx];
-	if (!blk_mq_hw_queue_mapped(data.hctx))
+	hctx = q->queue_hw_ctx[hctx_idx];
+	if (!blk_mq_hw_queue_mapped(hctx))
 		goto out_queue_exit;
-	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
-	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	ret = -EWOULDBLOCK;
-	rq = __blk_mq_alloc_request(&data);
+	rq = __blk_mq_alloc_request_on_cpumask(hctx->cpumask, &data);
 	if (!rq)
 		goto out_queue_exit;
 	return rq;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e7d1da4b1f731..82921b30b6afa 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -155,6 +155,9 @@ struct blk_mq_alloc_data {
 	/* input & output parameter */
 	struct blk_mq_ctx *ctx;
 	struct blk_mq_hw_ctx *hctx;
+
+	/* output parameter for __blk_mq_alloc_request_cb */
+	struct request *rq;
 };
 
 static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data *data)
-- 
2.26.2

