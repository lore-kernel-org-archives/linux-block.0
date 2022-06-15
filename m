Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A917ECCA473
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 21:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbiFOVBs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 17:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344961AbiFOVBr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 17:01:47 -0400
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1A85523E
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 14:01:47 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id 184so12438028pga.12
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 14:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVeILHo/zjiFSEXMBzjhqHFosgjFC+lhya61qoAKjlQ=;
        b=V7VV6ruAhEtJfCV18VD3ML/I1jqwrD2Dx/Lw2rsBucrBIaAxK/ObYpHVhxE+D55zYe
         aBvWo+VAldpy2Y8O7xXiXJgqevkZ9ItolA/jrVEMjuzK0pL7ANI9KLi2DqJi67FmGJ6O
         QCTgA9c/cIermcgjCtkASzD8VXp5pfsY42/zJu/VcIhX0DthtGUafzI8APgayzpse71J
         0UtMIS0vtEozoAOX1ipfJTF8sSbihG1/0YEJjm6tNUOd6G2lW5PifgVru26VF5aiwpdU
         E35ugcc1gagu8hJC8+a0+PAmkIHOlLohcdPRQIxbyh9rKoVuH5P578sbRS+Cz32Gd6dm
         PNpw==
X-Gm-Message-State: AJIora/fRLdIFgT1CI85WCz2YD7LRlrY3X06bO9pPNlnkg4TRQL/P2M3
        +xLinjfArjvl+iEef18oCZI=
X-Google-Smtp-Source: AGRyM1uMd0UWgTKRTjEU+QuVGot2I1ZbjfRH+qJCuJGmB42RUVimenMDBpDzKOflfSIXkEPXlaWIrg==
X-Received: by 2002:a63:f253:0:b0:400:14af:760f with SMTP id d19-20020a63f253000000b0040014af760fmr1415515pgk.221.1655326906690;
        Wed, 15 Jun 2022 14:01:46 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:36ac:cabd:84b2:80f6])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b0015e8da1fb07sm68986plj.127.2022.06.15.14.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:01:45 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 2/3] block: Rename a blk_mq_map_queue() argument
Date:   Wed, 15 Jun 2022 14:01:35 -0700
Message-Id: <20220615210136.1032199-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615210136.1032199-1-bvanassche@acm.org>
References: <20220615210136.1032199-1-bvanassche@acm.org>
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
