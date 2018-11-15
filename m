Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1A3C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DBB2146D
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wlO24RLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DBB2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbeKPGBH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:01:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39914 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeKPGBH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 01:01:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so9974084pla.6
        for <linux-block@vger.kernel.org>; Thu, 15 Nov 2018 11:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tiaZa8WSa4N6JxUKx5nvzdX+JfaYEZWZ99+zxTGrJas=;
        b=wlO24RLQtEyMJExogq+QI6U0bCrb7WEWIynPYO8hC2LM7GuU8xDogNOBd3zukv+ybx
         mCpQud80cb8Ig6T3yvIJGY+kYZ2gJx4wV7jaQ1vY/BT4Gu46UTL9pe+yZCduoFRDx58a
         duhJpOFctRKDipC2fj1jT/+B/7IQS27Tl1oJNXX1wGdfhaWBU/xVRpI67/xnL2O/7P8/
         cVprf35LqVscNhL2nIkjzV0BVhWxhQ/dyrQrX97qEAM7A19uzQodOsqDKI9c2dNqWKyR
         zyTwIzprGzjq2IZXh1sQ7i6MdXGPDRz4mqD42dukkx6SQIq+lyKYhZCs1qrOJo7bvMCo
         BAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tiaZa8WSa4N6JxUKx5nvzdX+JfaYEZWZ99+zxTGrJas=;
        b=XRo+o0eGPLM5rKxKtnASPrOYC8eoyE4iK0rVWDe9ajEDuaQ/1UbWhluWOWRfMEbxuv
         dEIe4bzwv4Z4+y7vxO3LrW+axQXiiK1SBStLAYtStsYTBDvpZiMi1rcN5KSQkhjzo/4i
         0RCNVG6aKdyaT7nwRe3HD9e3cGv7rECvNuZxnzp+rAvzAOZAqsK04SDMY4ZsEVao7WNa
         b870rMhJkipBVR7c+YxgDQwUoVnXRGpGGD9arH7sqiSdTStVzh8Ntnn/eU2DXMCbSNCn
         egp6gxRBcCQBlnNDmcxgvAiTRvUSYhJjjmPLbJSA+r/IKxHF/IWMBN0vfKGAf3OCIdzY
         OsDw==
X-Gm-Message-State: AGRZ1gIeMXfEAVlwrPSx78S5PyowfjtgB0OeoPj3K78hR9FNGjIVUbUm
        Nyd6Z1FIwk5D0QXNuslkTk8OJP7oV5Y=
X-Google-Smtp-Source: AJdET5fO4UWyjNUaWm3RGR1J9ioLZtr1kpayeBIOmBpdi04AyJsQyI3NcjWeRoVHy88hyYBuLiV7Rw==
X-Received: by 2002:a17:902:33c1:: with SMTP id b59-v6mr7480679plc.71.1542311514481;
        Thu, 15 Nov 2018 11:51:54 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id d68-v6sm30670766pfa.80.2018.11.15.11.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:51:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/11] blk-mq: when polling for IO, look for any completion
Date:   Thu, 15 Nov 2018 12:51:31 -0700
Message-Id: <20181115195135.22812-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115195135.22812-1-axboe@kernel.dk>
References: <20181115195135.22812-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we want to support async IO polling, then we have to allow
finding completions that aren't just for the one we are
looking for. Always pass in -1 to the mq_ops->poll() helper,
and have that return how many events were found in this poll
loop.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c          | 69 +++++++++++++++++++++++------------------
 drivers/nvme/host/pci.c | 14 ++++-----
 2 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 52b1c97cd7c6..3ca00d712158 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3266,9 +3266,7 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	 *  0:	use half of prev avg
 	 * >0:	use this specific value
 	 */
-	if (q->poll_nsec == -1)
-		return false;
-	else if (q->poll_nsec > 0)
+	if (q->poll_nsec > 0)
 		nsecs = q->poll_nsec;
 	else
 		nsecs = blk_mq_poll_nsecs(q, hctx, rq);
@@ -3305,21 +3303,36 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	return true;
 }
 
-static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
+static bool blk_mq_poll_hybrid(struct request_queue *q,
+			       struct blk_mq_hw_ctx *hctx, blk_qc_t cookie)
+{
+	struct request *rq;
+
+	if (q->poll_nsec == -1)
+		return false;
+
+	if (!blk_qc_t_is_internal(cookie))
+		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
+	else {
+		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
+		/*
+		 * With scheduling, if the request has completed, we'll
+		 * get a NULL return here, as we clear the sched tag when
+		 * that happens. The request still remains valid, like always,
+		 * so we should be safe with just the NULL check.
+		 */
+		if (!rq)
+			return false;
+	}
+
+	return blk_mq_poll_hybrid_sleep(q, hctx, rq);
+}
+
+static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	long state;
 
-	/*
-	 * If we sleep, have the caller restart the poll loop to reset
-	 * the state. Like for the other success return cases, the
-	 * caller is responsible for checking if the IO completed. If
-	 * the IO isn't complete, we'll get called again and will go
-	 * straight to the busy poll loop.
-	 */
-	if (blk_mq_poll_hybrid_sleep(q, hctx, rq))
-		return 1;
-
 	hctx->poll_considered++;
 
 	state = current->state;
@@ -3328,7 +3341,7 @@ static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 
 		hctx->poll_invoked++;
 
-		ret = q->mq_ops->poll(hctx, rq->tag);
+		ret = q->mq_ops->poll(hctx, -1U);
 		if (ret > 0) {
 			hctx->poll_success++;
 			__set_current_state(TASK_RUNNING);
@@ -3352,27 +3365,23 @@ static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
 {
 	struct blk_mq_hw_ctx *hctx;
-	struct request *rq;
 
 	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
 
 	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
-	if (!blk_qc_t_is_internal(cookie))
-		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
-	else {
-		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
-		/*
-		 * With scheduling, if the request has completed, we'll
-		 * get a NULL return here, as we clear the sched tag when
-		 * that happens. The request still remains valid, like always,
-		 * so we should be safe with just the NULL check.
-		 */
-		if (!rq)
-			return 0;
-	}
 
-	return __blk_mq_poll(hctx, rq);
+	/*
+	 * If we sleep, have the caller restart the poll loop to reset
+	 * the state. Like for the other success return cases, the
+	 * caller is responsible for checking if the IO completed. If
+	 * the IO isn't complete, we'll get called again and will go
+	 * straight to the busy poll loop.
+	 */
+	if (blk_mq_poll_hybrid(q, hctx, cookie))
+		return 1;
+
+	return __blk_mq_poll(hctx);
 }
 
 unsigned int blk_mq_rq_cpu(struct request *rq)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fc7dd49f22fc..6c03461ad988 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1012,15 +1012,15 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 	}
 }
 
-static inline bool nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
-		u16 *end, int tag)
+static inline int nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
+				  u16 *end, unsigned int tag)
 {
-	bool found = false;
+	int found = 0;
 
 	*start = nvmeq->cq_head;
-	while (!found && nvme_cqe_pending(nvmeq)) {
-		if (nvmeq->cqes[nvmeq->cq_head].command_id == tag)
-			found = true;
+	while (nvme_cqe_pending(nvmeq)) {
+		if (tag == -1U || nvmeq->cqes[nvmeq->cq_head].command_id == tag)
+			found++;
 		nvme_update_cq_head(nvmeq);
 	}
 	*end = nvmeq->cq_head;
@@ -1062,7 +1062,7 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 {
 	u16 start, end;
-	bool found;
+	int found;
 
 	if (!nvme_cqe_pending(nvmeq))
 		return 0;
-- 
2.17.1

