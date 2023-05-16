Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C39CC77B7A
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 22:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjEPWdn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 18:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjEPWdl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 18:33:41 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB056A65
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:38 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1aaea43def7so1537475ad.2
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276418; x=1686868418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWu1E1H6Cpdlf2SWVyhyPtFI9G5HnS2JOK38qbcbgYY=;
        b=ex+BpXksq0QY1ruGhKGgJTWymOBq8soCZvbTakCUVGV1WScmUrMaZYaqnYfbgxG4Sr
         vJiyQpuVi3x8Fso+ocR74KnQQEjQorZ9rfixdKGgJipDxxq7nGxL/+8S67uSTBp4Jex2
         utDm7GmgglrFYlf2B7VZ81OK4RJCGHOrJNkApO89giDQOzADFHofjC6w1kvLbYcyHCG+
         puDq/D3GJ1qzrnB5BX8YwuKZtnAqVFwftVm+Ug/HFyO8rDqlMbPZWSkrZzkmj0bxPlFF
         bU408ZYGHBvJHPhGpEUvoMleS8W3LsBE1LhvrR3peMVnM4U5qbiAxoQOJKxKEWSPvmlD
         UtKg==
X-Gm-Message-State: AC+VfDzuOt6GV5I6oENyvJ4x92+XFvbMM1vRmsqV7WUx9xPVRiWIidTw
        UltoGRz3BWimaZAARgqD/1Y=
X-Google-Smtp-Source: ACHHUZ7Oh30UsGrpN3NnHKeJJtybQz++TD/j54NVFPNAviNpaYUvGgRMCgHNl7NERedEgR1UOz08jw==
X-Received: by 2002:a17:902:bf4b:b0:1ae:29a8:d6d0 with SMTP id u11-20020a170902bf4b00b001ae29a8d6d0mr4984037pls.59.1684276417952;
        Tue, 16 May 2023 15:33:37 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:baed:ee38:35e4:f97d])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b001ae48d441desm839255pln.148.2023.05.16.15.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:33:37 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v5 08/11] block: mq-deadline: Reduce lock contention
Date:   Tue, 16 May 2023 15:33:17 -0700
Message-ID: <20230516223323.1383342-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230516223323.1383342-1-bvanassche@acm.org>
References: <20230516223323.1383342-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_free_requests() calls dd_finish_request() indirectly. Prevent
nested locking of dd->lock and dd->zone_lock by moving the code for
freeing requests.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index dbc0feca963e..06af9c28a3bf 100644
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
