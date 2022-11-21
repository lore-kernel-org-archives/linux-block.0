Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1433AC4332F
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 15:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKUP5t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Nov 2022 10:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKUP5t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 10:57:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD00ACFB8E
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 07:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669046220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DhpkkZl5aEqLFEHm7V5EYpzIW066FUkw2UjfwCuCjoQ=;
        b=Um6IsxjEbdLHeLucX4r++GijWBMmwXzT/deKINgDFf/TemfIf4ta5FmbH+0EJ9KW/OliKF
        iznJ8jUvSLDaXEW8bk4z/GbkWB6X2sXuZSu/fDS0Pja+hwmJiGrAD2iZysQZsL/2burYCX
        V4Zch+Laho7C3m3ARhvjPeTvTgrMQHU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-9qeLsTO8MaGT_4GLHaj4Rw-1; Mon, 21 Nov 2022 10:56:56 -0500
X-MC-Unique: 9qeLsTO8MaGT_4GLHaj4Rw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30515101AA47;
        Mon, 21 Nov 2022 15:56:56 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30ED51400C3A;
        Mon, 21 Nov 2022 15:56:54 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Andreas Hindborg <andreas.hindborg@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH] ublk_drv: don't forward io commands in reserve order
Date:   Mon, 21 Nov 2022 23:56:45 +0800
Message-Id: <20221121155645.396272-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Either ublk_can_use_task_work() is true or not, io commands are
forwarded to ublk server in reverse order, since llist_add() is
always to add one element to the head of the list.

Even though block layer doesn't guarantee request dispatch order,
requests should be sent to hardware in the sequence order generated
from io scheduler, which usually considers the request's LBA, and
order is often important for HDD.

So forward io commands in the sequence made from io scheduler by
aligning task work with current io_uring command's batch handling,
and it has been observed that both can get similar performance data
if IORING_SETUP_COOP_TASKRUN is set from ublk server.

Reported-by: Andreas Hindborg <andreas.hindborg@wdc.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 82 +++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 44 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f96cb01e9604..e9de9d846b73 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -57,10 +57,8 @@
 #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
 
 struct ublk_rq_data {
-	union {
-		struct callback_head work;
-		struct llist_node node;
-	};
+	struct llist_node node;
+	struct callback_head work;
 };
 
 struct ublk_uring_cmd_pdu {
@@ -766,15 +764,31 @@ static inline void __ublk_rq_task_work(struct request *req)
 	ubq_complete_io_cmd(io, UBLK_IO_RES_OK);
 }
 
+static inline void ublk_forward_io_cmds(struct ublk_queue *ubq)
+{
+	struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
+	struct ublk_rq_data *data, *tmp;
+
+	io_cmds = llist_reverse_order(io_cmds);
+	llist_for_each_entry_safe(data, tmp, io_cmds, node)
+		__ublk_rq_task_work(blk_mq_rq_from_pdu(data));
+}
+
+static inline void ublk_abort_io_cmds(struct ublk_queue *ubq)
+{
+	struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
+	struct ublk_rq_data *data, *tmp;
+
+	llist_for_each_entry_safe(data, tmp, io_cmds, node)
+		__ublk_abort_rq(ubq, blk_mq_rq_from_pdu(data));
+}
+
 static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd)
 {
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
-	struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
-	struct ublk_rq_data *data;
 
-	llist_for_each_entry(data, io_cmds, node)
-		__ublk_rq_task_work(blk_mq_rq_from_pdu(data));
+	ublk_forward_io_cmds(ubq);
 }
 
 static void ublk_rq_task_work_fn(struct callback_head *work)
@@ -782,14 +796,20 @@ static void ublk_rq_task_work_fn(struct callback_head *work)
 	struct ublk_rq_data *data = container_of(work,
 			struct ublk_rq_data, work);
 	struct request *req = blk_mq_rq_from_pdu(data);
+	struct ublk_queue *ubq = req->mq_hctx->driver_data;
 
-	__ublk_rq_task_work(req);
+	ublk_forward_io_cmds(ubq);
 }
 
-static void ublk_submit_cmd(struct ublk_queue *ubq, const struct request *rq)
+static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 {
-	struct ublk_io *io = &ubq->ios[rq->tag];
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
+	struct ublk_io *io;
 
+	if (!llist_add(&data->node, &ubq->io_cmds))
+		return;
+
+	io = &ubq->ios[rq->tag];
 	/*
 	 * If the check pass, we know that this is a re-issued request aborted
 	 * previously in monitor_work because the ubq_daemon(cmd's task) is
@@ -803,11 +823,11 @@ static void ublk_submit_cmd(struct ublk_queue *ubq, const struct request *rq)
 	 * guarantees that here is a re-issued request aborted previously.
 	 */
 	if (unlikely(io->flags & UBLK_IO_FLAG_ABORTED)) {
-		struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
-		struct ublk_rq_data *data;
-
-		llist_for_each_entry(data, io_cmds, node)
-			__ublk_abort_rq(ubq, blk_mq_rq_from_pdu(data));
+		ublk_abort_io_cmds(ubq);
+	} else if (ublk_can_use_task_work(ubq)) {
+		if (task_work_add(ubq->ubq_daemon, &data->work,
+					TWA_SIGNAL_NO_IPI))
+			ublk_abort_io_cmds(ubq);
 	} else {
 		struct io_uring_cmd *cmd = io->cmd;
 		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
@@ -817,23 +837,6 @@ static void ublk_submit_cmd(struct ublk_queue *ubq, const struct request *rq)
 	}
 }
 
-static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq,
-		bool last)
-{
-	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
-
-	if (ublk_can_use_task_work(ubq)) {
-		enum task_work_notify_mode notify_mode = last ?
-			TWA_SIGNAL_NO_IPI : TWA_NONE;
-
-		if (task_work_add(ubq->ubq_daemon, &data->work, notify_mode))
-			__ublk_abort_rq(ubq, rq);
-	} else {
-		if (llist_add(&data->node, &ubq->io_cmds))
-			ublk_submit_cmd(ubq, rq);
-	}
-}
-
 static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
@@ -865,19 +868,11 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return BLK_STS_OK;
 	}
 
-	ublk_queue_cmd(ubq, rq, bd->last);
+	ublk_queue_cmd(ubq, rq);
 
 	return BLK_STS_OK;
 }
 
-static void ublk_commit_rqs(struct blk_mq_hw_ctx *hctx)
-{
-	struct ublk_queue *ubq = hctx->driver_data;
-
-	if (ublk_can_use_task_work(ubq))
-		__set_notify_signal(ubq->ubq_daemon);
-}
-
 static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
 		unsigned int hctx_idx)
 {
@@ -899,7 +894,6 @@ static int ublk_init_rq(struct blk_mq_tag_set *set, struct request *req,
 
 static const struct blk_mq_ops ublk_mq_ops = {
 	.queue_rq       = ublk_queue_rq,
-	.commit_rqs     = ublk_commit_rqs,
 	.init_hctx	= ublk_init_hctx,
 	.init_request   = ublk_init_rq,
 };
@@ -1197,7 +1191,7 @@ static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
 	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
 
-	ublk_queue_cmd(ubq, req, true);
+	ublk_queue_cmd(ubq, req);
 }
 
 static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
-- 
2.31.1

