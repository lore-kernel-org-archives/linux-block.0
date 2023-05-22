Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245A8C7EE23
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 18:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjEVSjV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 14:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjEVSjU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 14:39:20 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FF7C4
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 11:39:14 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2553663f71eso1645777a91.3
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 11:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684780753; x=1687372753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNCmejf6JPwfcImSjjVgOFVBnYuTd/JvzAczO1w5Ois=;
        b=VxJ1b61aK5UGwOa3laMCJTZwZhwUuSlXWul3a6YNxbmKzVi2TgP90RojoZxh61aWSP
         d+8dW4htm2WjL9dD0jKLClAU3bpaLPrVhhdqxS5wO20DNcaBEttmLEu4bPEZFn0wjohS
         n+yBDe/ISQZDaetzOSOYy9gKRGtOjyZN38nTqv7eueYosP/zUHBdQkFygyvQc5KZibDB
         MT5WV9HMpZRaSuwxIrfDUuNAxrXm+wAAMqThdaYMEAmO+6o7AP9Ia8S5obl0oOKoc4nw
         tGV2UNyx42y15QPoHTvirwlxwiHUzCjYWNUcrTu3KLFn3eJcVLv0S5bqA+22X2vzY0Bl
         vgxQ==
X-Gm-Message-State: AC+VfDy8kT0P4JXmrPGH/HHRZqRkczHnXvde/cc6lOBq9DwQJoMjMGUy
        LdxPy6k0x1yNCz8u+IbppcM=
X-Google-Smtp-Source: ACHHUZ4v9OdmaqGd9NJ8ws9OFXIyiWDYMJ9mwe+X2TnBwGScMtD5TO98Hrbs2YYnCjffv8S0ZjV8TA==
X-Received: by 2002:a17:90a:8b92:b0:252:7114:b37a with SMTP id z18-20020a17090a8b9200b002527114b37amr11278415pjn.47.1684780753441;
        Mon, 22 May 2023 11:39:13 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:642f:e57f:85fb:3794])
        by smtp.gmail.com with ESMTPSA id d61-20020a17090a6f4300b0024dfbac9e2fsm6710335pjk.21.2023.05.22.11.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 11:39:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 4/7] block: Make it easier to debug zoned write reordering
Date:   Mon, 22 May 2023 11:38:39 -0700
Message-ID: <20230522183845.354920-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230522183845.354920-1-bvanassche@acm.org>
References: <20230522183845.354920-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Issue a kernel warning if a zoned write is passed directly to the block
driver instead of to the I/O scheduler because passing a zoned write
directly to the block driver may cause zoned write reordering.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index bc52a57641e2..9ef6fa5d7471 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2429,6 +2429,9 @@ static void blk_mq_request_bypass_insert(struct request *rq, blk_insert_t flags)
 {
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
+	WARN_ON_ONCE(rq->rq_flags & RQF_USE_SCHED &&
+		     blk_rq_is_seq_zoned_write(rq));
+
 	spin_lock(&hctx->lock);
 	if (flags & BLK_MQ_INSERT_AT_HEAD)
 		list_add(&rq->queuelist, &hctx->dispatch);
@@ -2562,6 +2565,9 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	};
 	blk_status_t ret;
 
+	WARN_ON_ONCE(rq->rq_flags & RQF_USE_SCHED &&
+		     blk_rq_is_seq_zoned_write(rq));
+
 	/*
 	 * For OK queue, we are done. For error, caller may kill it.
 	 * Any other error (busy), just add it to our list as we
