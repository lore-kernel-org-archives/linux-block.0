Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD03BC433FE
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 20:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD34F61206
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 20:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhJRUjz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 16:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhJRUjx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 16:39:53 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB75C061745
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 13:37:41 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t16so4129355eds.9
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QpyFRvxguVaC0e9bZkL9vF7ywKvCl3IKbPcL26yVMxA=;
        b=UP99eXOCIzfGHt9H6QpBbMPemO52t4H/iBZrzXk7dKT/YALHOPo9FlN+x30omXWCFj
         qklW1YkASiuYB0jqLJ9WN6VDLt32cFFPCrM54jTw+NDcJ+L8M8BPOpMAQ9asWw/45fKo
         JaobDCtdYEHDdXykBTdvc38j4vLIGMk7tM38TwrlD7TzmHvLZpvUWtVUJmJdFTvUuxJK
         uSpgVpmfyGFl+501EzPmCaqqZKxF9yviLtkhnKbCGgbODoSBv/IMS7zFpaflJIcpBGAQ
         0+TzA1AHzJpyu690uV08/FxK2Sl7SJ0yUrLFXLVfjFr5PRIGNmSQ6+zvhBTe4PcHgmH7
         F/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QpyFRvxguVaC0e9bZkL9vF7ywKvCl3IKbPcL26yVMxA=;
        b=0iAM2h86GG47edjeVRoNW5YjVe3/+ZAxJ64F8ayny2AiOdrt/O+n+z8wJb/afrG7U5
         2g2woyMWpULMMfuXjOF7CWKHZYWP4sro4mGM9/CvUVBzRqeAnV4hlGNEBSVRvCaagu6n
         OvLaImIJvKYtD4gvR9PUgueG9wOg8x/f1vlk4D6A0DjIHJT7KEmbogotGiK0pYcS1/qO
         TTIvLLiZJ9P6iePi2MKrk9EDK0tsv93g2qKw33052tgdpw/lXd/CHF9uN1a8nV6vizw4
         g0S+/qv1Po0JFoAnwZE9Zaf9VIsNvaAnSR+yorFLU2jVlEUJpJwa7NqJ9IokflBeoUke
         qBZw==
X-Gm-Message-State: AOAM5339aNGxa4g1CB8E6o0ri/HR9UR7S+KWHmj4NCsslQrFM0t495tj
        lN7k9J3iRtkO5ViVCnx4ytq1XwVSvnLmyg==
X-Google-Smtp-Source: ABdhPJz7h41vVFN5OjJ9EeSUWNE8CNmL1cQLm2JyuQQhPst65UFhALKhuOxEqTrWVf/Xwed9DshTLQ==
X-Received: by 2002:aa7:c883:: with SMTP id p3mr16782969eds.279.1634589460363;
        Mon, 18 Oct 2021 13:37:40 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.213])
        by smtp.gmail.com with ESMTPSA id y19sm11124889edd.39.2021.10.18.13.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 13:37:40 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/3] block: skip elevator fields init for non-elv queue
Date:   Mon, 18 Oct 2021 21:37:27 +0100
Message-Id: <3a6960482d175ade61333cfc0e3780f92b388197.1634589262.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634589262.git.asml.silence@gmail.com>
References: <cover.1634589262.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't init rq->hash and rq->rb_node in blk_mq_rq_ctx_init() if there is
no elevator. Also, move some other initialisers that imply barriers to
the end, so the compiler is free to rearrange and optimise other the
rest of them.

note: fold in a change from Jens leaving queue_list unconditional, as
it might lead to problems otherwise.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 28eb1f3c6f76..1d2e2fd4043e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -325,6 +325,10 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		rq->internal_tag = BLK_MQ_NO_TAG;
 	}
 
+	if (blk_mq_need_time_stamp(rq))
+		rq->start_time_ns = ktime_get_ns();
+	else
+		rq->start_time_ns = 0;
 	/* csd/requeue_work/fifo_time is initialized before use */
 	rq->q = data->q;
 	rq->mq_ctx = data->ctx;
@@ -334,41 +338,37 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		rq->rq_flags |= RQF_PM;
 	if (blk_queue_io_stat(data->q))
 		rq->rq_flags |= RQF_IO_STAT;
-	INIT_LIST_HEAD(&rq->queuelist);
-	INIT_HLIST_NODE(&rq->hash);
-	RB_CLEAR_NODE(&rq->rb_node);
 	rq->rq_disk = NULL;
 	rq->part = NULL;
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
 	rq->alloc_time_ns = alloc_time_ns;
 #endif
-	if (blk_mq_need_time_stamp(rq))
-		rq->start_time_ns = ktime_get_ns();
-	else
-		rq->start_time_ns = 0;
 	rq->io_start_time_ns = 0;
 	rq->stats_sectors = 0;
 	rq->nr_phys_segments = 0;
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
 	rq->nr_integrity_segments = 0;
 #endif
-	blk_crypto_rq_set_defaults(rq);
-	/* tag was already set */
-	WRITE_ONCE(rq->deadline, 0);
-
 	rq->timeout = 0;
-
 	rq->end_io = NULL;
 	rq->end_io_data = NULL;
 
 	data->ctx->rq_dispatched[op_is_sync(data->cmd_flags)]++;
+	blk_crypto_rq_set_defaults(rq);
+	INIT_LIST_HEAD(&rq->queuelist);
+	/* tag was already set */
+	WRITE_ONCE(rq->deadline, 0);
 	refcount_set(&rq->ref, 1);
 
-	if (!op_is_flush(data->cmd_flags) && (rq->rq_flags & RQF_ELV)) {
+	if (rq->rq_flags & RQF_ELV) {
 		struct elevator_queue *e = data->q->elevator;
 
 		rq->elv.icq = NULL;
-		if (e->type->ops.prepare_request) {
+		INIT_HLIST_NODE(&rq->hash);
+		RB_CLEAR_NODE(&rq->rb_node);
+
+		if (!op_is_flush(data->cmd_flags) &&
+		    e->type->ops.prepare_request) {
 			if (e->type->icq_cache)
 				blk_mq_sched_assign_ioc(rq);
 
-- 
2.33.1

