Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F34BC43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 22:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347483AbiFOW4B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 18:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348865AbiFOW4A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 18:56:00 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6DAE9C
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 15:56:00 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 31so11054904pgv.11
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 15:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D0iTTMQMQJ+C/1Ot+ZUcpq31mZl+d5hkJIQ4cfjmUiU=;
        b=6MUh1t7r7By3tc5Ml87I2nkkY+/Kmh7OaV/7ZjZZux7ZzIgkT9DP+8s29zYtH98Pbj
         1r0AYYBz5ZlTnvffxIWF/SvVx5GwfbBbvHCAU1J54tjfb1nmNESxJ6E+3Bz2oo/ACBVa
         3KasmBFziv6WCFW+d7Xbd1TcJIHSmeshLk/N40cEijD4TgstD72a6yUBOPLb2AeEEgm9
         LXNX/7vf4w5BVqvSsg7a0bhhrSvBUinfUWSIXgc12sU6U/0Dn29X3/oQdnDGUpDth5XF
         vyusdZRNeWR6ZGQoZOFcKUy5yP9ohKrvX4VRpxJIdK/rjNGTG+qvUcmFGXAJ/raGAbRc
         yHnw==
X-Gm-Message-State: AJIora8ykFyWYIPjU5Lk4OmRSTb+C+MPWOsy7W5fSYucm9rQpGZuFr4K
        NIq2I6ncAAekk6S3JMytqYk=
X-Google-Smtp-Source: AGRyM1vhrOJrgCJWzDEOFSLw9To7RARwaGwW52qYlgx1o/s+Mlob6+qEOEJ5tMqvz2TJ+g8M3Vdqsw==
X-Received: by 2002:a62:1687:0:b0:50d:3364:46d4 with SMTP id 129-20020a621687000000b0050d336446d4mr1860539pfw.74.1655333759776;
        Wed, 15 Jun 2022 15:55:59 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:36ac:cabd:84b2:80f6])
        by smtp.gmail.com with ESMTPSA id f62-20020a17090a704400b001eae95c381fsm158611pjk.10.2022.06.15.15.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:55:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 3/3] block: Make blk_mq_get_sq_hctx() select the proper hardware queue type
Date:   Wed, 15 Jun 2022 15:55:49 -0700
Message-Id: <20220615225549.1054905-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615225549.1054905-1-bvanassche@acm.org>
References: <20220615225549.1054905-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the introduction of blk_mq_get_hctx_type() the operation type in
the second argument of blk_mq_get_hctx_type() matters. The introduction
of blk_mq_get_hctx_type() caused blk_mq_get_sq_hctx() to select a
hardware queue of type HCTX_TYPE_READ instead of HCTX_TYPE_DEFAULT.
Switch to hardware queue type HCTX_TYPE_DEFAULT since HCTX_TYPE_READ
should only be used for read requests.

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
