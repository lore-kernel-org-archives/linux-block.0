Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3964AC43217
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 15:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D9961074
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 15:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhJSPf1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbhJSPfS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 11:35:18 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACE0C061769
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 08:33:04 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id d125so20847080iof.5
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 08:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Tlo+tdHfOcf4wSgEKYr3aWD1rF/BFu8f44oFe46Gs0=;
        b=iS3nrpREIfnOUifwe7Hp1JmLhgchstOJnqehbNP6KxscDqfb4HjqP1PCWCTg7ngNJ9
         c799Pk94yTMtHod48RkeXuqTzRXMYgRZttdU+uMoAJWMwefHbSV2XB0X7j+2LZhOOX6N
         PphRjVJavky7SL4Yi1NXr6aoEbwTfylKBVadPSqjKsPKQAYev2K/s/AZYuxtTUNA6AVQ
         hl1xoa7AHtrtQ8B5F6YG3GpGaIu8IBHOOMHz6NJDuD7IbkVZAxq3Fr6weHapta5Oxr5G
         yGevrsP9doX7E7UQO7rbhcCAKFS68LPphl9tA1v2zqvPjEOxnNnQA5NBfGyytZzdNi0t
         ET+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Tlo+tdHfOcf4wSgEKYr3aWD1rF/BFu8f44oFe46Gs0=;
        b=mtNv/6o9cz+Umjp/ni023AzMXNLoK04fnLGxm0SxR80EbLW+fEHo/U38QzAzp02p2F
         f2KJf3sxhshngzRfnxc7BZe8lEgUwcoUnq1FxeYz0VXifmGFgcHYz7Yazk6myq5O49vC
         yQUPE82262m181Mf4QcTJwb2tm6NcYpmjOWD2H+bZhyFagRP4DZ/MQs4RiNXEP4LHWVP
         4o9YO7vW43e3N+U5LB3+lUMm0yuMZvLgsfVPx/C6trUNhhFK7qeWJcv1AflcWAaWqGBD
         f65vPlk4LY/3evgF1HuUwGq1YgjukiLpQMHJ7CHoui3SqAqJEjeNqX5AjW7W4xclx8JH
         EPBQ==
X-Gm-Message-State: AOAM532G+RGe7UwPfsU8poESX5K/aF3zu7jfVlvUtdJJs0AxjWS76OEv
        vm1vyHMivjZxRi/f5aBOQd1Jgp2Zg810Ww==
X-Google-Smtp-Source: ABdhPJxiDDMqrQsVCfYsky0tj0Kl2aQQAbI5YY5kMYWhKUnTI+X87bJyy+5bAPIe9MifBHeSfCZeXQ==
X-Received: by 2002:a5d:8d08:: with SMTP id p8mr1295145ioj.169.1634657583787;
        Tue, 19 Oct 2021 08:33:03 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t12sm8409555ilp.43.2021.10.19.08.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:33:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] block: add rq_flags to struct blk_mq_alloc_data
Date:   Tue, 19 Oct 2021 09:32:57 -0600
Message-Id: <20211019153300.623322-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019153300.623322-1-axboe@kernel.dk>
References: <20211019153300.623322-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There's a hole here we can use, and it's faster to set this earlier
rather than need to check q->elevator multiple times.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 20 ++++++++++----------
 block/blk-mq.h |  8 ++++----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d0fe86b46d1b..93b6912768ff 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -305,25 +305,22 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	struct blk_mq_ctx *ctx = data->ctx;
 	struct blk_mq_hw_ctx *hctx = data->hctx;
 	struct request_queue *q = data->q;
-	struct elevator_queue *e = q->elevator;
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct request *rq = tags->static_rqs[tag];
-	unsigned int rq_flags = 0;
 
-	if (e) {
-		rq_flags = RQF_ELV;
-		rq->tag = BLK_MQ_NO_TAG;
-		rq->internal_tag = tag;
-	} else {
+	if (!(data->rq_flags & RQF_ELV)) {
 		rq->tag = tag;
 		rq->internal_tag = BLK_MQ_NO_TAG;
+	} else {
+		rq->tag = BLK_MQ_NO_TAG;
+		rq->internal_tag = tag;
 	}
 
 	if (data->flags & BLK_MQ_REQ_PM)
-		rq_flags |= RQF_PM;
+		data->rq_flags |= RQF_PM;
 	if (blk_queue_io_stat(q))
-		rq_flags |= RQF_IO_STAT;
-	rq->rq_flags = rq_flags;
+		data->rq_flags |= RQF_IO_STAT;
+	rq->rq_flags = data->rq_flags;
 
 	if (blk_mq_need_time_stamp(rq))
 		rq->start_time_ns = ktime_get_ns();
@@ -474,6 +471,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 		.q		= q,
 		.flags		= flags,
 		.cmd_flags	= op,
+		.rq_flags	= q->elevator ? RQF_ELV : 0,
 		.nr_tags	= 1,
 	};
 	struct request *rq;
@@ -503,6 +501,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		.q		= q,
 		.flags		= flags,
 		.cmd_flags	= op,
+		.rq_flags	= q->elevator ? RQF_ELV : 0,
 		.nr_tags	= 1,
 	};
 	u64 alloc_time_ns = 0;
@@ -2500,6 +2499,7 @@ void blk_mq_submit_bio(struct bio *bio)
 			.q		= q,
 			.nr_tags	= 1,
 			.cmd_flags	= bio->bi_opf,
+			.rq_flags	= q->elevator ? RQF_ELV : 0,
 		};
 
 		if (plug) {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d8ccb341e82e..10be317c1c13 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -148,6 +148,7 @@ struct blk_mq_alloc_data {
 	blk_mq_req_flags_t flags;
 	unsigned int shallow_depth;
 	unsigned int cmd_flags;
+	unsigned int rq_flags;
 
 	/* allocate multiple requests/tags in one go */
 	unsigned int nr_tags;
@@ -165,10 +166,9 @@ static inline bool blk_mq_is_shared_tags(unsigned int flags)
 
 static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data *data)
 {
-	if (data->q->elevator)
-		return data->hctx->sched_tags;
-
-	return data->hctx->tags;
+	if (!(data->rq_flags & RQF_ELV))
+		return data->hctx->tags;
+	return data->hctx->sched_tags;
 }
 
 static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
-- 
2.33.1

