Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239B9C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 22:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349710AbiFOW4B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 18:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347483AbiFOW4A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 18:56:00 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E7BE93
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 15:55:58 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id c196so12739524pfb.1
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 15:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVeILHo/zjiFSEXMBzjhqHFosgjFC+lhya61qoAKjlQ=;
        b=ttUy3U6CX6vLeetTGWZ9eVlqZlQat7nNGry5HDIkf9L/a/bkHHUbk57lhpiNcrVQDY
         oOOE4SkZT009CjtR9qVFvYOdV+FhBDFsvVGg4tqpnPeuTo0yLRiwEWhK4JpMZChM6f1r
         X3KPwseUscZ9OBs9OudtbH26yAYV8gpvYFZcesfkCMBjfmW+CoUKlQDKa9wLj4xAETYz
         AdHvWkaT5c8W8lNw7Hp3+x5oO/auu2Ff1xYjHdWYM3IGLQ8EdLH81eOUY4VviGQ4Nc/1
         ydJaraWxpOY7prUKp1IHhNY4fj+kpSuSXaNNLBVvgOXP9FCZPXhCnRYwJJ7VVZ8B9nGN
         PJ6Q==
X-Gm-Message-State: AJIora9IYqLnVjQZmJ3mwyNdpiQ/Vb5MFRcSXQcKJN48LbkuF/r/hWIZ
        k7kvl9RmuhYg7ltZIbroC2A=
X-Google-Smtp-Source: AGRyM1s9OyB6fwiET6PGOp0xPt7uss92vWVDf3r2THpf/kD6QwPnpQdInZuJcTe+fSWCB8p2ganeyg==
X-Received: by 2002:a63:8ac3:0:b0:3fc:948b:a1d9 with SMTP id y186-20020a638ac3000000b003fc948ba1d9mr1800283pgd.50.1655333758067;
        Wed, 15 Jun 2022 15:55:58 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:36ac:cabd:84b2:80f6])
        by smtp.gmail.com with ESMTPSA id f62-20020a17090a704400b001eae95c381fsm158611pjk.10.2022.06.15.15.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:55:57 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 2/3] block: Rename a blk_mq_map_queue() argument
Date:   Wed, 15 Jun 2022 15:55:48 -0700
Message-Id: <20220615225549.1054905-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615225549.1054905-1-bvanassche@acm.org>
References: <20220615225549.1054905-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before the introduction of blk_mq_get_hctx_type(), blk_mq_map_queue()
only used the flags from its second argument. Since the introduction of
blk_mq_get_hctx_type(), blk_mq_map_queue() uses both the operation and
the flags encoded in that argument. Rename the second argument of
blk_mq_map_queue() to make this clear.

Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 2615bd58bad3..e4c6fe2c8ac8 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -86,16 +86,16 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
 	return xa_load(&q->hctx_table, q->tag_set->map[type].mq_map[cpu]);
 }
 
-static inline enum hctx_type blk_mq_get_hctx_type(unsigned int flags)
+static inline enum hctx_type blk_mq_get_hctx_type(unsigned int opf)
 {
 	enum hctx_type type = HCTX_TYPE_DEFAULT;
 
 	/*
 	 * The caller ensure that if REQ_POLLED, poll must be enabled.
 	 */
-	if (flags & REQ_POLLED)
+	if (opf & REQ_POLLED)
 		type = HCTX_TYPE_POLL;
-	else if ((flags & REQ_OP_MASK) == REQ_OP_READ)
+	else if ((opf & REQ_OP_MASK) == REQ_OP_READ)
 		type = HCTX_TYPE_READ;
 	return type;
 }
@@ -103,14 +103,14 @@ static inline enum hctx_type blk_mq_get_hctx_type(unsigned int flags)
 /*
  * blk_mq_map_queue() - map (cmd_flags,type) to hardware queue
  * @q: request queue
- * @flags: request command flags
+ * @opf: operation type (REQ_OP_*) and flags (e.g. REQ_POLLED).
  * @ctx: software queue cpu ctx
  */
 static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
-						     unsigned int flags,
+						     unsigned int opf,
 						     struct blk_mq_ctx *ctx)
 {
-	return ctx->hctxs[blk_mq_get_hctx_type(flags)];
+	return ctx->hctxs[blk_mq_get_hctx_type(opf)];
 }
 
 /*
