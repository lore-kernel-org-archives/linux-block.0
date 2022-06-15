Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2D9C43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 21:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344961AbiFOVBu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 17:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244905AbiFOVBt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 17:01:49 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD41B5523E
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 14:01:48 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id s135so12448681pgs.10
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 14:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4p0cxX/rZYC8fAm9zYjDWwNMUnRBs/tR8ubV1YfFzfY=;
        b=5uIFjqQ/9mICFbQUq1pWC/qMfcmT2n+2nqQJdPp3urINFUhb9U18hCv6YTPQTbl6sI
         /8KOcEAts9x6ISfpf7yv5qNCizgX5pKpT9eUZhRqYUYBm56Ep/X1VzOqWb1MY1jPofFH
         fdJgJRIrCpH6yB65syLw8cUMjCQepzXQBLPa7aypqiH2ObnnpH7eJHTuBJW979GeXntV
         pP5NqDFrOy8LoTjumRNN9bQWGBsel0jdlZvQDxTmCp5IWEz6gBPN6DyJqeU7a5dlSa/Y
         8iAtqB/XuYG/2eNBhULjjegEL6Yd9SSPv9xhJv8HcSXnp3Y77A0jfA0rtpxcZQjbGOdI
         DUNg==
X-Gm-Message-State: AJIora/A3RuNRmMqREtrjrcc5MPCRvV/ZVA0Ji97iUoXWC01i+Qc31p5
        pHViOcQgtOZSovG4veyjwcQ=
X-Google-Smtp-Source: AGRyM1s4MvWYG7RoIQQSMg6mXpAHymWGtSrtyOAfxFEUJ9hdvhowQbJC78l7ejLNc+e4EvmPND8pOA==
X-Received: by 2002:a63:6984:0:b0:405:3980:197e with SMTP id e126-20020a636984000000b004053980197emr1411142pgc.621.1655326908152;
        Wed, 15 Jun 2022 14:01:48 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:36ac:cabd:84b2:80f6])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b0015e8da1fb07sm68986plj.127.2022.06.15.14.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:01:47 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 3/3] block: Improve blk_mq_get_sq_hctx()
Date:   Wed, 15 Jun 2022 14:01:36 -0700
Message-Id: <20220615210136.1032199-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615210136.1032199-1-bvanassche@acm.org>
References: <20220615210136.1032199-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the introduction of blk_mq_get_hctx_type() the operation type in
the second argument of blk_mq_get_hctx_type() matters. Make sure that
blk_mq_get_sq_hctx() selects a hardware queue of type HCTX_TYPE_DEFAULT
instead of a hardware queue of type HCTX_TYPE_READ.

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e9bf950983c7..7a5558bbc7f6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2168,7 +2168,7 @@ static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
 	 * just causes lock contention inside the scheduler and pointless cache
 	 * bouncing.
 	 */
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, 0, ctx);
+	struct blk_mq_hw_ctx *hctx = ctx->hctxs[HCTX_TYPE_DEFAULT];
 
 	if (!blk_mq_hctx_stopped(hctx))
 		return hctx;
