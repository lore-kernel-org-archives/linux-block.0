Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A66CCA47A
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 17:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiFNRuE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 13:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345084AbiFNRuC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 13:50:02 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E353B55E
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:50:00 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id z17so9200785pff.7
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sRWa2//WsFdDDYOSrmbkMGJxakZajyhRiR2bK8n/pGo=;
        b=skcWJ71GM6y1xxkgNsYDSI743nhYFDrcFnR6u8NrUWxaF91FgkgUgn0V6wRfo9DXap
         tn2UXU3h+gmmIYmW/h9psXmMa0GLO+bIw1fcwHb8Jg2UYp+MfSxmf/O6VukvwD50fMLy
         E1GcGMttCFuovL7MoTrp3f0EqRwmZO/jlV5BLh6d4G/Q7mGzGOESRSIMGYkMBSIEBtqd
         ba01ckCRZm/27Fuyooo8xez3lrtFhCDnVEOlAx3KN0NMjXizBI7L+gmTHF3X9n0l2Gg0
         phB0e2UMmoS+OqWCeOwLV4x2/E6TZh+flcC1vQwCiEntPfuoMc6coxcmTyj+74l0tapp
         UvoA==
X-Gm-Message-State: AOAM532T58musBAyzh5S0WphnIeumzGI9e5Io+TRkdMl8gMMTU4cU6w8
        SYZQE8g21KOjjzSyi5/HffE=
X-Google-Smtp-Source: ABdhPJyScae+X8QVfN7yCGVItpmah7e6/llGNtdp5bkS/3oKgwod00Bj6C7hGqPZtxWlxiCaVU2bjA==
X-Received: by 2002:a65:6713:0:b0:3fd:af26:a799 with SMTP id u19-20020a656713000000b003fdaf26a799mr5452404pgf.68.1655229000056;
        Tue, 14 Jun 2022 10:50:00 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id gd3-20020a17090b0fc300b001e2da6766ecsm9866922pjb.31.2022.06.14.10.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 10:49:59 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 5/5] block/mq-deadline: Remove zone locking
Date:   Tue, 14 Jun 2022 10:49:43 -0700
Message-Id: <20220614174943.611369-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220614174943.611369-1-bvanassche@acm.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Measurements have shown that limiting the queue depth to one has a
significant negative performance impact on zoned UFS devices. Hence this
patch that removes zone locking from the mq-deadline scheduler. This
patch is based on the following assumptions:
- Applications submit write requests to sequential write required zones
  in order.
- If such write requests get reordered by the software or hardware queue
  mechanism, nr_hw_queues * nr_requests - 1 retries are sufficient to
  reorder the write requests.
- It happens infrequently that zoned write requests are reordered by the
  block layer.
- Either no I/O scheduler is used or an I/O scheduler is used that
  submits write requests per zone in LBA order.

DD_BE_PRIO is selected for sequential writes to preserve the LBA order.

See also commit 5700f69178e9 ("mq-deadline: Introduce zone locking
support").

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 74 ++++-----------------------------------------
 1 file changed, 6 insertions(+), 68 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 6ed602b2f80a..e168fc9a980a 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -104,7 +104,6 @@ struct deadline_data {
 	int prio_aging_expire;
 
 	spinlock_t lock;
-	spinlock_t zone_lock;
 };
 
 /* Maps an I/O priority class to a deadline scheduler priority. */
@@ -285,30 +284,10 @@ static struct request *
 deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 		      enum dd_data_dir data_dir)
 {
-	struct request *rq;
-	unsigned long flags;
-
 	if (list_empty(&per_prio->fifo_list[data_dir]))
 		return NULL;
 
-	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
-		return rq;
-
-	/*
-	 * Look for a write request that can be dispatched, that is one with
-	 * an unlocked target zone.
-	 */
-	spin_lock_irqsave(&dd->zone_lock, flags);
-	list_for_each_entry(rq, &per_prio->fifo_list[DD_WRITE], queuelist) {
-		if (blk_req_can_dispatch_to_zone(rq))
-			goto out;
-	}
-	rq = NULL;
-out:
-	spin_unlock_irqrestore(&dd->zone_lock, flags);
-
-	return rq;
+	return rq_entry_fifo(per_prio->fifo_list[data_dir].next);
 }
 
 /*
@@ -319,29 +298,7 @@ static struct request *
 deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 		      enum dd_data_dir data_dir)
 {
-	struct request *rq;
-	unsigned long flags;
-
-	rq = per_prio->next_rq[data_dir];
-	if (!rq)
-		return NULL;
-
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
-		return rq;
-
-	/*
-	 * Look for a write request that can be dispatched, that is one with
-	 * an unlocked target zone.
-	 */
-	spin_lock_irqsave(&dd->zone_lock, flags);
-	while (rq) {
-		if (blk_req_can_dispatch_to_zone(rq))
-			break;
-		rq = deadline_latter_request(rq);
-	}
-	spin_unlock_irqrestore(&dd->zone_lock, flags);
-
-	return rq;
+	return per_prio->next_rq[data_dir];
 }
 
 /*
@@ -467,10 +424,6 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	ioprio_class = dd_rq_ioclass(rq);
 	prio = ioprio_class_to_prio[ioprio_class];
 	dd->per_prio[prio].stats.dispatched++;
-	/*
-	 * If the request needs its target zone locked, do it.
-	 */
-	blk_req_zone_write_lock(rq);
 	rq->rq_flags |= RQF_STARTED;
 	return rq;
 }
@@ -640,7 +593,6 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	dd->fifo_batch = fifo_batch;
 	dd->prio_aging_expire = prio_aging_expire;
 	spin_lock_init(&dd->lock);
-	spin_lock_init(&dd->zone_lock);
 
 	q->elevator = eq;
 	return 0;
@@ -716,17 +668,13 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
 	struct dd_per_prio *per_prio;
 	enum dd_prio prio;
+	bool seq_write = blk_rq_is_seq_write(rq);
 	LIST_HEAD(free);
 
 	lockdep_assert_held(&dd->lock);
 
-	/*
-	 * This may be a requeue of a write request that has locked its
-	 * target zone. If it is the case, this releases the zone lock.
-	 */
-	blk_req_zone_write_unlock(rq);
-
-	prio = ioprio_class_to_prio[ioprio_class];
+	prio = seq_write ? DD_BE_PRIO :
+		ioprio_class_to_prio[ioprio_class];
 	per_prio = &dd->per_prio[prio];
 	if (!rq->elv.priv[0]) {
 		per_prio->stats.inserted++;
@@ -740,7 +688,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	trace_block_rq_insert(rq);
 
-	if (at_head) {
+	if (at_head && !seq_write) {
 		list_add(&rq->queuelist, &per_prio->dispatch);
 		rq->fifo_time = jiffies;
 	} else {
@@ -819,16 +767,6 @@ static void dd_finish_request(struct request *rq)
 		return;
 
 	atomic_inc(&per_prio->stats.completed);
-
-	if (blk_queue_is_zoned(q)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&dd->zone_lock, flags);
-		blk_req_zone_write_unlock(rq);
-		if (!list_empty(&per_prio->fifo_list[DD_WRITE]))
-			blk_mq_sched_mark_restart_hctx(rq->mq_hctx);
-		spin_unlock_irqrestore(&dd->zone_lock, flags);
-	}
 }
 
 static bool dd_has_work_for_prio(struct dd_per_prio *per_prio)
