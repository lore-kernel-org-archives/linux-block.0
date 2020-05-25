Return-Path: <SRS0=kLuB=7H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFA2C433E0
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 09:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FE02078B
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 09:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X10QZ3Ma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389605AbgEYJic (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 May 2020 05:38:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52960 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388182AbgEYJib (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 05:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590399509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYNkXLQvUPzz8HYrQ5AKnwKxqwqDAqPm4Fy6h2SdqBg=;
        b=X10QZ3MaveyUfHSsPpIS/f+y4FpQGCAOZcFNciYZonuW7M4iAoRannEMeeFcws0nISu+cy
        vpaIyu0wsF0AT7GcNnsTv1kqGEXul1oq/+0HtfMUaQ8DbApPfjtFxkrSdyw3b8XLIU8VYh
        TpnptJJNgMiDpWwrn5tIvOBrBNHoJoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-K17OCQNROmqq1bb9DBpZwQ-1; Mon, 25 May 2020 05:38:25 -0400
X-MC-Unique: K17OCQNROmqq1bb9DBpZwQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC9B18010FA;
        Mon, 25 May 2020 09:38:23 +0000 (UTC)
Received: from localhost (ovpn-12-137.pek2.redhat.com [10.72.12.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D37AC53E02;
        Mon, 25 May 2020 09:38:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 1/6] blk-mq: pass request queue into get/put budget callback
Date:   Mon, 25 May 2020 17:38:02 +0800
Message-Id: <20200525093807.805155-2-ming.lei@redhat.com>
In-Reply-To: <20200525093807.805155-1-ming.lei@redhat.com>
References: <20200525093807.805155-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk-mq budget is abstract from scsi's device queue depth, and it is
always per-request-queue instead of hctx.

It can be quite absurd to get a budget from one hctx, then dequeue a
request from scheduler queue, and this request may not belong to this
hctx, at least for bfq and deadline.

So fix the mess and always pass request queue to get/put budget
callback.

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c    |  8 ++++----
 block/blk-mq.c          |  8 ++++----
 block/blk-mq.h          | 12 ++++--------
 drivers/scsi/scsi_lib.c |  8 +++-----
 include/linux/blk-mq.h  |  4 ++--
 5 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index fdcc2c1dd178..a31e281e9d31 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -108,12 +108,12 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 			break;
 		}
 
-		if (!blk_mq_get_dispatch_budget(hctx))
+		if (!blk_mq_get_dispatch_budget(q))
 			break;
 
 		rq = e->type->ops.dispatch_request(hctx);
 		if (!rq) {
-			blk_mq_put_dispatch_budget(hctx);
+			blk_mq_put_dispatch_budget(q);
 			/*
 			 * We're releasing without dispatching. Holding the
 			 * budget could have blocked any "hctx"s with the
@@ -173,12 +173,12 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 		if (!sbitmap_any_bit_set(&hctx->ctx_map))
 			break;
 
-		if (!blk_mq_get_dispatch_budget(hctx))
+		if (!blk_mq_get_dispatch_budget(q))
 			break;
 
 		rq = blk_mq_dequeue_from_ctx(hctx, ctx);
 		if (!rq) {
-			blk_mq_put_dispatch_budget(hctx);
+			blk_mq_put_dispatch_budget(q);
 			/*
 			 * We're releasing without dispatching. Holding the
 			 * budget could have blocked any "hctx"s with the
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b15509bbf9d8..63f71ec09326 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1259,7 +1259,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		rq = list_first_entry(list, struct request, queuelist);
 
 		hctx = rq->mq_hctx;
-		if (!got_budget && !blk_mq_get_dispatch_budget(hctx)) {
+		if (!got_budget && !blk_mq_get_dispatch_budget(q)) {
 			blk_mq_put_driver_tag(rq);
 			no_budget_avail = true;
 			break;
@@ -1274,7 +1274,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 			 * we'll re-run it below.
 			 */
 			if (!blk_mq_mark_tag_wait(hctx, rq)) {
-				blk_mq_put_dispatch_budget(hctx);
+				blk_mq_put_dispatch_budget(q);
 				/*
 				 * For non-shared tags, the RESTART check
 				 * will suffice.
@@ -1922,11 +1922,11 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	if (q->elevator && !bypass_insert)
 		goto insert;
 
-	if (!blk_mq_get_dispatch_budget(hctx))
+	if (!blk_mq_get_dispatch_budget(q))
 		goto insert;
 
 	if (!blk_mq_get_driver_tag(rq)) {
-		blk_mq_put_dispatch_budget(hctx);
+		blk_mq_put_dispatch_budget(q);
 		goto insert;
 	}
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 10bfdfb494fa..9540770de9dc 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -180,20 +180,16 @@ unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part);
 void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 			 unsigned int inflight[2]);
 
-static inline void blk_mq_put_dispatch_budget(struct blk_mq_hw_ctx *hctx)
+static inline void blk_mq_put_dispatch_budget(struct request_queue *q)
 {
-	struct request_queue *q = hctx->queue;
-
 	if (q->mq_ops->put_budget)
-		q->mq_ops->put_budget(hctx);
+		q->mq_ops->put_budget(q);
 }
 
-static inline bool blk_mq_get_dispatch_budget(struct blk_mq_hw_ctx *hctx)
+static inline bool blk_mq_get_dispatch_budget(struct request_queue *q)
 {
-	struct request_queue *q = hctx->queue;
-
 	if (q->mq_ops->get_budget)
-		return q->mq_ops->get_budget(hctx);
+		return q->mq_ops->get_budget(q);
 	return true;
 }
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 82ad0244b3d0..b9adee0a9266 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1624,17 +1624,15 @@ static void scsi_mq_done(struct scsi_cmnd *cmd)
 		clear_bit(SCMD_STATE_COMPLETE, &cmd->state);
 }
 
-static void scsi_mq_put_budget(struct blk_mq_hw_ctx *hctx)
+static void scsi_mq_put_budget(struct request_queue *q)
 {
-	struct request_queue *q = hctx->queue;
 	struct scsi_device *sdev = q->queuedata;
 
 	atomic_dec(&sdev->device_busy);
 }
 
-static bool scsi_mq_get_budget(struct blk_mq_hw_ctx *hctx)
+static bool scsi_mq_get_budget(struct request_queue *q)
 {
-	struct request_queue *q = hctx->queue;
 	struct scsi_device *sdev = q->queuedata;
 
 	return scsi_dev_queue_ready(q, sdev);
@@ -1701,7 +1699,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (scsi_target(sdev)->can_queue > 0)
 		atomic_dec(&scsi_target(sdev)->target_busy);
 out_put_budget:
-	scsi_mq_put_budget(hctx);
+	scsi_mq_put_budget(q);
 	switch (ret) {
 	case BLK_STS_OK:
 		break;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 94c1318e4c1f..95bb54fde713 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -270,8 +270,8 @@ struct blk_mq_queue_data {
 typedef blk_status_t (queue_rq_fn)(struct blk_mq_hw_ctx *,
 		const struct blk_mq_queue_data *);
 typedef void (commit_rqs_fn)(struct blk_mq_hw_ctx *);
-typedef bool (get_budget_fn)(struct blk_mq_hw_ctx *);
-typedef void (put_budget_fn)(struct blk_mq_hw_ctx *);
+typedef bool (get_budget_fn)(struct request_queue *);
+typedef void (put_budget_fn)(struct request_queue *);
 typedef enum blk_eh_timer_return (timeout_fn)(struct request *, bool);
 typedef int (init_hctx_fn)(struct blk_mq_hw_ctx *, void *, unsigned int);
 typedef void (exit_hctx_fn)(struct blk_mq_hw_ctx *, unsigned int);
-- 
2.25.2

