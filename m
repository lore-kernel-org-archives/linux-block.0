Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DC2C43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CA020896
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PiY2ZWaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CA020896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbeKNBld (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:41:33 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39486 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733221AbeKNBlc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 20:41:32 -0500
Received: by mail-it1-f193.google.com with SMTP id m15so19048419itl.4
        for <linux-block@vger.kernel.org>; Tue, 13 Nov 2018 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EHx8l7IMdoDaN4dvTj41uPWQUtQjoAD8b6vGeSugKx4=;
        b=PiY2ZWaYMJtI/vujNb9OCNrjIbFvyHgJCYKoEUf31QZaag+IFwV+wF8yiJOZmYrE0h
         KaMcFCkCm2XosZw0/cK3DOG1BrLnefqi3ttlsY9lTjkMk3T8YpPMrDY40AER53kH4bsm
         R0CxKf0pj6Hu8aq4vSdDTar8ZqcvRqjJ4cpQn2m4yW3fsscLDaZpWWt27EXc20fMoqoZ
         wnNPBSeGbsOR32CYljAIoBnbRAFvtSzCDhpVhbEk1E292CnAuMCzGM2Zh6RGCVG8NFMa
         SDzAuth02ti+qqWPOpYO0DzdmYMGVbETMHjgea8WU5ITQEGbp8Yl4/Ftm4Xtwm2qsDVJ
         8q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EHx8l7IMdoDaN4dvTj41uPWQUtQjoAD8b6vGeSugKx4=;
        b=mNlQZVbxf2/iGAkYg3MChXtJfui71E1fTAluf8xYs3myL3NvnNSxYy906GAnRujF6q
         bjLzK6yHCsRqfblFMFH4qpUZikD+MUnoks/9YpFTC4WGJJsaPpbpSZ06Of+YJds9fg55
         xatWCHfzQ9FzcpSMabYNhFtMT24WIy2i1j0mgM1s74myV7+jI1nOO4LE2NBd+XI2XnVV
         et/cqfcaQ9DiBw/rhUR1pWwdAUGiKBmCjG9pPK9guZWC9M4y28dElXagEkk4CIWC5/ac
         WChIZhj5vc8QzciAnm0zAnTTLL4RL1TkDf+r+QG/DNPEzFdkxisSfsKhEbM3v31TCDJJ
         1jTA==
X-Gm-Message-State: AGRZ1gKur6CnCUCl020w51ODjdoInwl/J7lb0HNwmRmzoqhQf2jbAGlU
        TxxSsbScFPHZbE5kpEpuAYlL0I4rbS8=
X-Google-Smtp-Source: AJdET5e3SQmsEohHfHqIdQ4p/ynnyMnaUDcWtTKys55FqNXTZrfhRlGUbG04ff4Fmtslk/JkfIh/1g==
X-Received: by 2002:a24:fd09:: with SMTP id m9mr4036186ith.81.1542123772883;
        Tue, 13 Nov 2018 07:42:52 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o14-v6sm6721987ito.3.2018.11.13.07.42.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:42:51 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/11] blk-mq: when polling for IO, look for any completion
Date:   Tue, 13 Nov 2018 08:42:30 -0700
Message-Id: <20181113154233.15256-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113154233.15256-1-axboe@kernel.dk>
References: <20181113154233.15256-1-axboe@kernel.dk>
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
 drivers/nvme/host/pci.c | 32 +++++++++----------
 2 files changed, 54 insertions(+), 47 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f8c2e6544903..03b1af0151ca 100644
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
 
-		ret = q->mq_ops.poll(hctx, rq->tag);
+		ret = q->mq_ops.poll(hctx, -1U);
 		if (ret > 0) {
 			hctx->poll_success++;
 			set_current_state(TASK_RUNNING);
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
index bb22ae567208..adeb8f516bf9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -995,13 +995,18 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	nvme_end_request(req, cqe->status, cqe->result);
 }
 
-static void nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start, u16 end)
+static int nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start, u16 end)
 {
+	int nr = 0;
+
 	while (start != end) {
+		nr++;
 		nvme_handle_cqe(nvmeq, start);
 		if (++start == nvmeq->q_depth)
 			start = 0;
 	}
+
+	return nr;
 }
 
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
@@ -1012,22 +1017,17 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 	}
 }
 
-static inline bool nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
-		u16 *end, int tag)
+static inline void nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
+				   u16 *end)
 {
-	bool found = false;
-
 	*start = nvmeq->cq_head;
-	while (!found && nvme_cqe_pending(nvmeq)) {
-		if (nvmeq->cqes[nvmeq->cq_head].command_id == tag)
-			found = true;
+	while (nvme_cqe_pending(nvmeq))
 		nvme_update_cq_head(nvmeq);
-	}
+
 	*end = nvmeq->cq_head;
 
 	if (*start != *end)
 		nvme_ring_cq_doorbell(nvmeq);
-	return found;
 }
 
 static irqreturn_t nvme_irq(int irq, void *data)
@@ -1039,7 +1039,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	spin_lock(&nvmeq->cq_lock);
 	if (nvmeq->cq_head != nvmeq->last_cq_head)
 		ret = IRQ_HANDLED;
-	nvme_process_cq(nvmeq, &start, &end, -1);
+	nvme_process_cq(nvmeq, &start, &end);
 	nvmeq->last_cq_head = nvmeq->cq_head;
 	spin_unlock(&nvmeq->cq_lock);
 
@@ -1062,7 +1062,6 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 {
 	u16 start, end;
-	bool found;
 
 	if (!nvme_cqe_pending(nvmeq))
 		return 0;
@@ -1074,14 +1073,13 @@ static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 		local_irq_disable();
 
 	spin_lock(&nvmeq->cq_lock);
-	found = nvme_process_cq(nvmeq, &start, &end, tag);
+	nvme_process_cq(nvmeq, &start, &end);
 	spin_unlock(&nvmeq->cq_lock);
 
 	if (!nvmeq->polled)
 		local_irq_enable();
 
-	nvme_complete_cqes(nvmeq, start, end);
-	return found;
+	return nvme_complete_cqes(nvmeq, start, end);
 }
 
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
@@ -1414,7 +1412,7 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 		nvme_disable_ctrl(&dev->ctrl, dev->ctrl.cap);
 
 	spin_lock_irq(&nvmeq->cq_lock);
-	nvme_process_cq(nvmeq, &start, &end, -1);
+	nvme_process_cq(nvmeq, &start, &end);
 	spin_unlock_irq(&nvmeq->cq_lock);
 
 	nvme_complete_cqes(nvmeq, start, end);
@@ -2209,7 +2207,7 @@ static void nvme_del_cq_end(struct request *req, blk_status_t error)
 		unsigned long flags;
 
 		spin_lock_irqsave(&nvmeq->cq_lock, flags);
-		nvme_process_cq(nvmeq, &start, &end, -1);
+		nvme_process_cq(nvmeq, &start, &end);
 		spin_unlock_irqrestore(&nvmeq->cq_lock, flags);
 
 		nvme_complete_cqes(nvmeq, start, end);
-- 
2.17.1

