Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37D7C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 20:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB143610FB
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 20:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhJRUj4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 16:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhJRUjy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 16:39:54 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA66C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 13:37:42 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d9so4209319edh.5
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2sE+Xnz4QcqtJUSXnRXCKjmjoQEip/P7dXQFhIdUm5A=;
        b=YdwHkzL/rXWwseP28cn/vgjfg3f26Myoq3aPdpJnHcNY7rvMexlQ2lvS7y5vc5Brfp
         okjtDsz76CNIvK/A+4XzqfNI5WzdVxLKYRzcJnbhS+y7yFPWsunzuyreCBU8vm8sLwMU
         0OapSHwxiogbYALiMSZ3cRIRFcUqe0Z4usmceV9cDWRxGq7wboWwkfUYH9AYArWH+Wmx
         8lx80d5gstSrfPSGcpLge0DjYZe2lCFHt6py0TQJiEvQkKaT93KRkkx0f/v3t1SEY8BG
         nWIFVOiWOCuK9CdIqHaVsb67RwRHPCnLSlDpQu/Jz3jSFf8Oh1WlD2AZ2E8zs+yQhdrx
         1DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2sE+Xnz4QcqtJUSXnRXCKjmjoQEip/P7dXQFhIdUm5A=;
        b=rLJ58jURu6QOx8hYzwGHUw2yJbYWpqHUwaDTsX4tv7E7+J6hDiVhdLJqX15c/wi3+1
         6EvBPFNWJQbq6zf1N96VOIq27SC+gFlVbX8P+7wzDntOj13htE/SNO32ndlTYDNR0Rub
         gVW8TcPXOZU7PAjPtk/231gH2yCbWrJwZb9ZNlKI50VD7GKECkejBBu5PApze2yiaXx4
         CYChPiEAGdqHnmpAV/vHOhbWvCkU6EkZXSMHvzQnuDcIAQg7XXRdp34SW67cvnGd3Hnb
         nfHIM7m67j/DyKVh6U8EdRMg3qEyOU2zMIXO3Juq+WFRLvHYgRW4mCLhTQ8WZ8rRQUzJ
         VxVw==
X-Gm-Message-State: AOAM533iuHPjw5BYwJP19TtcBT6WbBeuknoVOE7vgk15x96N9xkFkITQ
        exiR9WWdas4IwWqVxbj51kMjZ0JL1j8VFA==
X-Google-Smtp-Source: ABdhPJz8YB/MOnNMk0g5tQToxieNM7/Rd6qiaOTsuJSXnUXhSgdqv7eAAHGsTPT8nbjfSfmn3I9PBg==
X-Received: by 2002:a05:6402:2022:: with SMTP id ay2mr49202236edb.344.1634589461094;
        Mon, 18 Oct 2021 13:37:41 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.213])
        by smtp.gmail.com with ESMTPSA id y19sm11124889edd.39.2021.10.18.13.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 13:37:40 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 2/3] block: blk_mq_rq_ctx_init cache ctx/q/hctx
Date:   Mon, 18 Oct 2021 21:37:28 +0100
Message-Id: <06a05d0b16a6504461502140c3d1e9c8cd91b862.1634589262.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634589262.git.asml.silence@gmail.com>
References: <cover.1634589262.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We should have enough of registers in blk_mq_rq_ctx_init(), store them
in local vars, so we don't keep reloading them.

note: keeping q->elevator may look unnecessary, but it's also used
inside inlined blk_mq_tags_from_data().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1d2e2fd4043e..fa4de25c3bcb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -312,10 +312,14 @@ static inline bool blk_mq_need_time_stamp(struct request *rq)
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		unsigned int tag, u64 alloc_time_ns)
 {
+	struct blk_mq_ctx *ctx = data->ctx;
+	struct blk_mq_hw_ctx *hctx = data->hctx;
+	struct request_queue *q = data->q;
+	struct elevator_queue *e = q->elevator;
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct request *rq = tags->static_rqs[tag];
 
-	if (data->q->elevator) {
+	if (e) {
 		rq->rq_flags = RQF_ELV;
 		rq->tag = BLK_MQ_NO_TAG;
 		rq->internal_tag = tag;
@@ -330,13 +334,13 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	else
 		rq->start_time_ns = 0;
 	/* csd/requeue_work/fifo_time is initialized before use */
-	rq->q = data->q;
-	rq->mq_ctx = data->ctx;
-	rq->mq_hctx = data->hctx;
+	rq->q = q;
+	rq->mq_ctx = ctx;
+	rq->mq_hctx = hctx;
 	rq->cmd_flags = data->cmd_flags;
 	if (data->flags & BLK_MQ_REQ_PM)
 		rq->rq_flags |= RQF_PM;
-	if (blk_queue_io_stat(data->q))
+	if (blk_queue_io_stat(q))
 		rq->rq_flags |= RQF_IO_STAT;
 	rq->rq_disk = NULL;
 	rq->part = NULL;
-- 
2.33.1

