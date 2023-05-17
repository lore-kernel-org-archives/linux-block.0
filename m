Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A644AC7EE2D
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 17:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjEQRpm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 13:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEQRph (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 13:45:37 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27133D2D9
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:08 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-643a1fed360so763052b3a.3
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345482; x=1686937482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtawUDGVkAQQgu3j8B80kzwNBVCXAkTme75c4XUrVi8=;
        b=CzEEUi5Bs+g1cDFaCgUPnOCxOPRwLu8BFuNj2GyduMAd9z2+Sjx3m9t83XPSydG1+3
         1C+FcTtj6Weu891cKnJaEoEm4pEnFWzU5xJfKFbe67YUyZ3FiGi/rtV2VeOemRH+dE7Q
         IEl0TpBjyYqEoq3ec/EXCi6JAdnl3tZv8V5KkU5QsroJYUOu2+fJAWI/lB4yt1gKlWVT
         yxDJQdw0OCzJvnwD8YX2lExyTqnKOoh6nTdVbaXyDBy59xBqeeN1okRLyYKUOPm1HznD
         AD1QyXrXe4WaF4xsCaVhPK6kT09dqzW1lgH/qC+QEA9kMA1dS65ePGBa7yBc2ri4GYjO
         Zt8Q==
X-Gm-Message-State: AC+VfDyJ7VIeu7y+71IHZ7QsdjnumQMplu+/fiav0DTtcfwqzLR+3G2P
        Kt0aSe+yfw3EyQc7l+ZaLrE=
X-Google-Smtp-Source: ACHHUZ6qPwa2ddHDgtreNJt0ieufZE3y3ID1L+uVL8azLa28s6s4BUWUGB9IwtRaXHZn3wTRwjpF+g==
X-Received: by 2002:a05:6a00:1a15:b0:64c:c842:5864 with SMTP id g21-20020a056a001a1500b0064cc8425864mr661984pfv.14.1684345481712;
        Wed, 17 May 2023 10:44:41 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78e56000000b00646e7d2b5a7sm15334410pfr.112.2023.05.17.10.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:44:41 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v6 08/11] block: mq-deadline: Reduce lock contention
Date:   Wed, 17 May 2023 10:42:26 -0700
Message-ID: <20230517174230.897144-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230517174230.897144-1-bvanassche@acm.org>
References: <20230517174230.897144-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_free_requests() calls dd_finish_request() indirectly. Prevent
nested locking of dd->lock and dd->zone_lock by moving the code for
freeing requests.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 56782ee93522..44222d18f6d4 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -757,7 +757,7 @@ static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
  * add rq to rbtree and fifo
  */
 static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
-			      blk_insert_t flags)
+			      blk_insert_t flags, struct list_head *free)
 {
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
@@ -766,7 +766,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
 	struct dd_per_prio *per_prio;
 	enum dd_prio prio;
-	LIST_HEAD(free);
 
 	lockdep_assert_held(&dd->lock);
 
@@ -783,10 +782,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		rq->elv.priv[0] = (void *)(uintptr_t)1;
 	}
 
-	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
-		blk_mq_free_requests(&free);
+	if (blk_mq_sched_try_insert_merge(q, rq, free))
 		return;
-	}
 
 	trace_block_rq_insert(rq);
 
@@ -819,6 +816,7 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 {
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
+	LIST_HEAD(free);
 
 	spin_lock(&dd->lock);
 	while (!list_empty(list)) {
@@ -826,9 +824,11 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 
 		rq = list_first_entry(list, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		dd_insert_request(hctx, rq, flags);
+		dd_insert_request(hctx, rq, flags, &free);
 	}
 	spin_unlock(&dd->lock);
+
+	blk_mq_free_requests(&free);
 }
 
 /* Callback from inside blk_mq_rq_ctx_init(). */
