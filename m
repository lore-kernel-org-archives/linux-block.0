Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2528C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 15:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA62761359
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 15:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhJSPf2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbhJSPfT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 11:35:19 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90A6C06176D
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 08:33:06 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id g2so18838712ild.1
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 08:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qeu82vYBLQXlzOtMT5aPndqu6ga8SYpNApWs9nnrqk=;
        b=Deg9163jN1UtlJh+JMMBurOmBFlUv+KRXNJGyMM8SUVZCpfFDOZbu5J4d8lXKSer7F
         g36ByBt5aijV3gE5OEq0FcWZZlVAlGUR+EuwKSGIbUQG/HOcIi22NHjJyKLx1pPVK7eq
         hKCuNdkUlS4N3Y4XeaMewWxyfPfDRIIIGPK1Ell2AHLOo/GMRr7S3q/kNMDPipsR7VqC
         K+Qb49pRUFi600spxG+XDCWXUTB2lVu+5Kznnu0E8c6gjXppqt6iXrhzY4C9xn+iMlXM
         tEaelLqj/A48OTtNeFJLu4mtcAhVhAurJPDVGG/eKqPgxvLbT1q1qiCCX2vJGGscUdv7
         Z/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qeu82vYBLQXlzOtMT5aPndqu6ga8SYpNApWs9nnrqk=;
        b=zmlAuy/dkHkGnKjC39DWLkcAHmGFIwJI0wDLZ1fOZ07qtW6k9X45Dm2kve2D273TZ1
         gyRBgeBSJuEVOhjG1Zip1cYUSEYu61+LKyfrwY4bNlW5HKQHG7jm+K7Ufq0ZwP3YKM2y
         F6lLRKIL307laFJKktdT8MkQvq6PVm2nnkFHK2wlD1S+xBrJQ4RMTTKteDexrGEaXtMF
         InbivXsplk81dvSlsJceLvoFZHl51kgLJ2noQu7ZQW9gzk+BbgdAkVXpGkJykpO75Xk7
         P9scfYyBRhpHWXzUcuP9CN4XyZ42Hc+6htI9YLALEg/MxcDdGw2ZdA1mSLLE3Gj+wdSt
         oXSQ==
X-Gm-Message-State: AOAM533LmOtoo7agpI+xAc+mVfTPyfcnwG7khDo4KsoxI6KKaQpm3piT
        GHWTnXBPK3vQdBb7jKy9/N2ZKD8F/EjJcA==
X-Google-Smtp-Source: ABdhPJwSGpYV41Zv+opF/OrK9bjyF0BoWEvwjm5DjnXgRsT4joDaalJqXh48i9HFeHGE5/mKzM+F3w==
X-Received: by 2002:a92:d60b:: with SMTP id w11mr17530594ilm.250.1634657585637;
        Tue, 19 Oct 2021 08:33:05 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t12sm8409555ilp.43.2021.10.19.08.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:33:05 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] block: re-flow blk_mq_rq_ctx_init()
Date:   Tue, 19 Oct 2021 09:33:00 -0600
Message-Id: <20211019153300.623322-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019153300.623322-1-axboe@kernel.dk>
References: <20211019153300.623322-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that we have flags passed in, we can do a final re-arrange of the
flow of blk_mq_rq_ctx_init() so we're always writing request in the
order in which it is laid out.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 77c2c3220128..4a671d1d47ac 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -307,6 +307,17 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	struct request_queue *q = data->q;
 	struct request *rq = tags->static_rqs[tag];
 
+	rq->q = q;
+	rq->mq_ctx = ctx;
+	rq->mq_hctx = hctx;
+	rq->cmd_flags = data->cmd_flags;
+
+	if (data->flags & BLK_MQ_REQ_PM)
+		data->rq_flags |= RQF_PM;
+	if (blk_queue_io_stat(q))
+		data->rq_flags |= RQF_IO_STAT;
+	rq->rq_flags = data->rq_flags;
+
 	if (!(data->rq_flags & RQF_ELV)) {
 		rq->tag = tag;
 		rq->internal_tag = BLK_MQ_NO_TAG;
@@ -314,22 +325,12 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		rq->tag = BLK_MQ_NO_TAG;
 		rq->internal_tag = tag;
 	}
-
-	if (data->flags & BLK_MQ_REQ_PM)
-		data->rq_flags |= RQF_PM;
-	if (blk_queue_io_stat(q))
-		data->rq_flags |= RQF_IO_STAT;
-	rq->rq_flags = data->rq_flags;
+	rq->timeout = 0;
 
 	if (blk_mq_need_time_stamp(rq))
 		rq->start_time_ns = ktime_get_ns();
 	else
 		rq->start_time_ns = 0;
-	/* csd/requeue_work/fifo_time is initialized before use */
-	rq->q = q;
-	rq->mq_ctx = ctx;
-	rq->mq_hctx = hctx;
-	rq->cmd_flags = data->cmd_flags;
 	rq->rq_disk = NULL;
 	rq->part = NULL;
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
@@ -341,7 +342,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
 	rq->nr_integrity_segments = 0;
 #endif
-	rq->timeout = 0;
 	rq->end_io = NULL;
 	rq->end_io_data = NULL;
 
-- 
2.33.1

