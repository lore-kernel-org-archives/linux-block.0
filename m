Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2F6CCA47A
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 17:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbiFNR5j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 13:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344840AbiFNR5h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 13:57:37 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21A127CE7
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:57:34 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso9750859pjh.4
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgyIsgZIB/Nb3z+q0C1xKjiewOnlAX+W3eIjBQD8wF0=;
        b=jA7E2sEeZ3NXUUuzWfQA8npRpMFLaPfPQQBF9TgeLEr+Ijshi5/48z/f2M/EF1aHrn
         N7nswpCrYS752OGLyPNu1MH8WG9HlEUAKgypVHFHoa1acFHNC2tuMdCEUrT36KD5FlMS
         w2x+3HWyRDl5FdyxCf6i0cCN3gM85JOBWYfSR5WIy2NqN0SbSl7QHU5bLUF87FNNDci+
         wzoKJ3Pp6zxabHAl664uY+wHbwE6wXywPTMute8jA7liuxzUQisY8K09hlPidqG9Zvtl
         Ono9mY5XnJWr7/vaDwCGa2xEu5PVwA2mbzeERyvY8LkGMbmHx2oDpGGVJ7tCFc8zL6nO
         rW/Q==
X-Gm-Message-State: AJIora/Gt24uEJRvJ0dnwsuo2pVcUHYQjvqo+l+H0l7J8amD9pOGMfm2
        ef6bzkKKYIChgyn+lMtgjbfXIIaKJ8U=
X-Google-Smtp-Source: AGRyM1vxIc3Un/gBeyslfkyjFZqNDMmWnLnGefg7cQ1MnlQjYF45sm2+vdu5mfR3v0mWBewEQNXRmA==
X-Received: by 2002:a17:90a:c7d7:b0:1e8:3d2d:dd67 with SMTP id gf23-20020a17090ac7d700b001e83d2ddd67mr5776093pjb.89.1655229454210;
        Tue, 14 Jun 2022 10:57:34 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b0015e8d4eb1f7sm7519666plb.65.2022.06.14.10.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 10:57:33 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/3] block: Rename a blk_mq_map_queue() argument
Date:   Tue, 14 Jun 2022 10:57:24 -0700
Message-Id: <20220614175725.612878-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220614175725.612878-1-bvanassche@acm.org>
References: <20220614175725.612878-1-bvanassche@acm.org>
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
