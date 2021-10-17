Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA3FC433EF
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 365E0611F0
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244807AbhJQBkK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244809AbhJQBkI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:40:08 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063DFC06176F
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:59 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z69so9063363iof.9
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fDQGjF9l9l0KYntZqRHf0xcHh6lv2lU7jnlOIiiayCM=;
        b=PVWHBAgo5ll8rF+CBQwGPMKuKwtS1TJuGUy7VbyXEtpa7ot6hkzia1rDA1O8wPOP8M
         xUgKHCsunkosNoLeDqrZ/uJIe7voMGvIWHoqHVpvFlUg0aqgw9314RKK5RtYtwQpum/4
         MPnSEyHQ+5VOXSqIpsjOLLoV0l8CIeooWc4PH3VFTTwEoEV4lRrcsXZ4owWUpPy4s49i
         fseZtIbh94gGhIypiBdlJ9ndFI6rCd462GryrfcHguFEzfuD2tEHMMDel6gp5ZYzolKf
         rD/Bvm4tqsckUscBvMk133Z24w8fCGy/MfGz6d6kTVd112o82cobK93s+05QwZxAdl1K
         uDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDQGjF9l9l0KYntZqRHf0xcHh6lv2lU7jnlOIiiayCM=;
        b=PfCo4yf6UEVR2adInSYB1hRB32Mv3yQHp+U7kDe9Hzimjmn9bfuEjqWKpjR+AkUmmX
         1v+UTquUYKdpBbpvJ7Ag46bXX/IYymDaQueZPuZk2r3pMPTRWwB4JYiBjQupStEPv+NV
         L4wjHZ6wwbUL2iIf0PKeC+CoOZKByoA+fbpJJX3JI8bgG8eAE/mrgxvR0se/AqUBlc+S
         vmu5wlfbcuOUC7VhxS9zYRPwBLDBn+ohnbE7HEu+nJyVh7HFlTZC63fbEnabF9GppHWZ
         n/th0IPGMVVq9Gkej839qIyWNuoYcbrkl5c8OBBHgU96cAMnASbgX8xloiGnzuTNcutv
         n3iA==
X-Gm-Message-State: AOAM533CSWYj+xzTPxk2zHgy7kko4eWo2f8DG3tj3oHTWQUpVbY2JmGt
        POx0+F5t1jI25DAFHhvUb0iEbB0pkCPObQ==
X-Google-Smtp-Source: ABdhPJyHJidWNIxE+LzL/gQnjGGnoN13lsvpTuLAcKijxVWRL8huaMIhoHfcJYE8sAJwHuGcOlChjw==
X-Received: by 2002:a05:6602:2c02:: with SMTP id w2mr9419923iov.45.1634434679196;
        Sat, 16 Oct 2021 18:37:59 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j17sm4934383ilq.1.2021.10.16.18.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 18:37:58 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/14] block: optimize blk_mq_rq_ctx_init()
Date:   Sat, 16 Oct 2021 19:37:45 -0600
Message-Id: <20211017013748.76461-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017013748.76461-1-axboe@kernel.dk>
References: <20211017013748.76461-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This takes ~4.7% on a peak performance run, with this patch it brings it
down to ~3.7%.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
[axboe: rebase and move queuelist init]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 64 ++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 064fdeeb1be5..0d05ac4a3b50 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -304,63 +304,62 @@ static inline bool blk_mq_need_time_stamp(struct request *rq)
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		unsigned int tag, u64 alloc_time_ns)
 {
+	struct blk_mq_ctx *ctx = data->ctx;
+	struct blk_mq_hw_ctx *hctx = data->hctx;
+	struct request_queue *q = data->q;
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct request *rq = tags->static_rqs[tag];
+	unsigned int cmd_flags = data->cmd_flags;
+	u64 start_time_ns = 0;
 
-	if (data->q->elevator) {
-		rq->rq_flags = RQF_ELV;
-		rq->tag = BLK_MQ_NO_TAG;
-		rq->internal_tag = tag;
-	} else {
+	rq->q = q;
+	rq->mq_ctx = ctx;
+	rq->mq_hctx = hctx;
+	rq->cmd_flags = cmd_flags;
+	data->ctx->rq_dispatched[op_is_sync(data->cmd_flags)]++;
+	data->hctx->queued++;
+	if (!q->elevator) {
 		rq->rq_flags = 0;
 		rq->tag = tag;
 		rq->internal_tag = BLK_MQ_NO_TAG;
+	} else {
+		rq->rq_flags = RQF_ELV;
+		rq->tag = BLK_MQ_NO_TAG;
+		rq->internal_tag = tag;
 	}
-
-	/* csd/requeue_work/fifo_time is initialized before use */
-	rq->q = data->q;
-	rq->mq_ctx = data->ctx;
-	rq->mq_hctx = data->hctx;
-	rq->cmd_flags = data->cmd_flags;
-	if (data->flags & BLK_MQ_REQ_PM)
-		rq->rq_flags |= RQF_PM;
-	if (blk_queue_io_stat(data->q))
-		rq->rq_flags |= RQF_IO_STAT;
+	rq->timeout = 0;
 	INIT_LIST_HEAD(&rq->queuelist);
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
-	rq->timeout = 0;
-
 	rq->end_io = NULL;
 	rq->end_io_data = NULL;
-
-	data->ctx->rq_dispatched[op_is_sync(data->cmd_flags)]++;
+	if (data->flags & BLK_MQ_REQ_PM)
+		rq->rq_flags |= RQF_PM;
+	if (blk_queue_io_stat(data->q))
+		rq->rq_flags |= RQF_IO_STAT;
+	if (blk_mq_need_time_stamp(rq))
+		start_time_ns = ktime_get_ns();
+	rq->start_time_ns = start_time_ns;
+	blk_crypto_rq_set_defaults(rq);
 	refcount_set(&rq->ref, 1);
+	WRITE_ONCE(rq->deadline, 0);
 
-	if (!op_is_flush(data->cmd_flags) && (rq->rq_flags & RQF_ELV)) {
-		struct elevator_queue *e = data->q->elevator;
+	if (rq->rq_flags & RQF_ELV) {
+		struct elevator_queue *e = q->elevator;
 
 		rq->elv.icq = NULL;
-		if (e->type->ops.prepare_request) {
+		RB_CLEAR_NODE(&rq->rb_node);
+		INIT_HLIST_NODE(&rq->hash);
+		if (!op_is_flush(cmd_flags) && e->type->ops.prepare_request) {
 			if (e->type->icq_cache)
 				blk_mq_sched_assign_ioc(rq);
 
@@ -369,7 +368,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		}
 	}
 
-	data->hctx->queued++;
 	return rq;
 }
 
-- 
2.33.1

