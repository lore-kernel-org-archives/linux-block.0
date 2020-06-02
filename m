Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BEFC433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77775206C3
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRigs3DR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFBJP0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:15:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45994 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726174AbgFBJPZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jun 2020 05:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591089323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vQxeFBBL6Iqwv4tdiCIh6KvIs4mo8XCWf3P5jM2SPOc=;
        b=KRigs3DRQb4R+S6wrVZKfkZA5uQHyKnL/zrEoWKJsPTtAebxtw9C6bFaAKsFqMHc4BVdVQ
        0TYRG5hYlzz3lvc4tdFc3YflO7rhiqa/xen9KVFuqr8xYYvmmv+4Tvk6o2XJX8/ZBHtm60
        UWweIiQqmndOaT9nhLqYkYGcfLTldbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-vVstX5PSNYaxZ9j8pQLWyg-1; Tue, 02 Jun 2020 05:15:22 -0400
X-MC-Unique: vVstX5PSNYaxZ9j8pQLWyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1B7F80058E;
        Tue,  2 Jun 2020 09:15:20 +0000 (UTC)
Received: from localhost (ovpn-12-167.pek2.redhat.com [10.72.12.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC47C10013C1;
        Tue,  2 Jun 2020 09:15:16 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V4 1/6] blk-mq: pass request queue into get/put budget callback
Date:   Tue,  2 Jun 2020 17:14:57 +0800
Message-Id: <20200602091502.1822499-2-ming.lei@redhat.com>
In-Reply-To: <20200602091502.1822499-1-ming.lei@redhat.com>
References: <20200602091502.1822499-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Tested-by: Baolin Wang <baolin.wang7@gmail.com>
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
index 9a36ac1c1fa1..bcbf49bd7ebe 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1262,7 +1262,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		rq = list_first_entry(list, struct request, queuelist);
 
 		hctx = rq->mq_hctx;
-		if (!got_budget && !blk_mq_get_dispatch_budget(hctx)) {
+		if (!got_budget && !blk_mq_get_dispatch_budget(q)) {
 			blk_mq_put_driver_tag(rq);
 			no_budget_avail = true;
 			break;
@@ -1277,7 +1277,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 			 * we'll re-run it below.
 			 */
 			if (!blk_mq_mark_tag_wait(hctx, rq)) {
-				blk_mq_put_dispatch_budget(hctx);
+				blk_mq_put_dispatch_budget(q);
 				/*
 				 * For non-shared tags, the RESTART check
 				 * will suffice.
@@ -1925,11 +1925,11 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
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
index a139b0631817..21d877105224 100644
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
index d6fcae17da5a..416d8609253b 100644
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

