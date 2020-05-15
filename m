Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB1AC433E0
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 01:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D6420671
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 01:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRQjymLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgEOBmU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 21:42:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52099 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbgEOBmU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 21:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589506939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XuCBGIjo67UBFve8rOecNvLhpZIx66jHmZquKR+/3r0=;
        b=VRQjymLR6R7dPthT5S8fyflxWYJU3nt8nGKISZPEM6ZgXavNRIjQaSgcXhcnL/JCeafF+f
        hYTcUiW5VDgImaredfCHsTR1gefeSTeCQ5UcAh4G4SIb7yCohfO4AGok2uNmGkgjHYrwei
        jMSNEbzchw/osWLhlonu2Z8gmFobXfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-Vo6wDFsvPRSl1j5ImSg6SA-1; Thu, 14 May 2020 21:42:13 -0400
X-MC-Unique: Vo6wDFsvPRSl1j5ImSg6SA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B50D8107B266;
        Fri, 15 May 2020 01:42:11 +0000 (UTC)
Received: from localhost (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 366435C1D3;
        Fri, 15 May 2020 01:42:07 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/6] blk-mq: allocate request on cpu in hctx->cpumask for blk_mq_alloc_request_hctx
Date:   Fri, 15 May 2020 09:41:48 +0800
Message-Id: <20200515014153.2403464-2-ming.lei@redhat.com>
In-Reply-To: <20200515014153.2403464-1-ming.lei@redhat.com>
References: <20200515014153.2403464-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_alloc_request_hctx() asks blk-mq to allocate request from
specified hctx, which is usually bound with fixed cpu mapping, and
request is supposed to be allocated on CPU in hctx->cpumask.

So use smp_call_function_any() to allocate request on the cpu in
hctx->cpumask for blk_mq_alloc_request_hctx().

Dedclare blk_mq_get_request() beforehand because the following patches
reuses __blk_mq_alloc_request for blk_mq_get_request().

Prepare for improving cpu hotplug support.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9ee695bdf873..e2e1b6808b32 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -40,6 +40,10 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
+static struct request *blk_mq_get_request(struct request_queue *q,
+					  struct bio *bio,
+					  struct blk_mq_alloc_data *data);
+
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
@@ -330,6 +334,19 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	return rq;
 }
 
+struct blk_mq_smp_call_info {
+	struct request_queue *q;
+	struct blk_mq_alloc_data *data;
+	struct request *rq;
+};
+
+static void __blk_mq_alloc_request(void *alloc_info)
+{
+	struct blk_mq_smp_call_info *info = alloc_info;
+
+	info->rq = blk_mq_get_request(info->q, NULL, info->data);
+}
+
 static struct request *blk_mq_get_request(struct request_queue *q,
 					  struct bio *bio,
 					  struct blk_mq_alloc_data *data)
@@ -424,8 +441,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	unsigned int op, blk_mq_req_flags_t flags, unsigned int hctx_idx)
 {
 	struct blk_mq_alloc_data alloc_data = { .flags = flags, .cmd_flags = op };
-	struct request *rq;
-	unsigned int cpu;
+	struct blk_mq_smp_call_info info = {.q = q, .data = &alloc_data};
 	int ret;
 
 	/*
@@ -448,21 +464,22 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	 * Check if the hardware context is actually mapped to anything.
 	 * If not tell the caller that it should skip this queue.
 	 */
-	alloc_data.hctx = q->queue_hw_ctx[hctx_idx];
-	if (!blk_mq_hw_queue_mapped(alloc_data.hctx)) {
+	if (!blk_mq_hw_queue_mapped(q->queue_hw_ctx[hctx_idx])) {
 		blk_queue_exit(q);
 		return ERR_PTR(-EXDEV);
 	}
-	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
-	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
 
-	rq = blk_mq_get_request(q, NULL, &alloc_data);
+	ret = smp_call_function_any(alloc_data.hctx->cpumask,
+			__blk_mq_alloc_request, &info, 1);
 	blk_queue_exit(q);
 
-	if (!rq)
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!info.rq)
 		return ERR_PTR(-EWOULDBLOCK);
 
-	return rq;
+	return info.rq;
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
-- 
2.25.2

