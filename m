Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA42C433FE
	for <linux-block@archiver.kernel.org>; Sun, 23 Oct 2022 09:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJWJi7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Oct 2022 05:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJWJi6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Oct 2022 05:38:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E6B30F58
        for <linux-block@vger.kernel.org>; Sun, 23 Oct 2022 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666517936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X4b7xGXiO5YaRMzzbyhJxgfM8Q4a5rOtmNhIMn7+Lqw=;
        b=J8UZ38gdPHe7XLGRwyA4maiuW4rhUCBHO6Mcji5FMUWhevuPU35KOX9rDRyo6DFfSZ5ABs
        wUcI7O8CsvbdJvuQGP0T0o0zhUyPL+c+NFfGuyl7YzMAydn44+rNrw6rNe1YfcAq/BwYld
        yUbP4H5LpEsRVaiplQFX7+WmGT9Tx6c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-cUuur_9YOJOEi1LTrc533w-1; Sun, 23 Oct 2022 05:38:54 -0400
X-MC-Unique: cUuur_9YOJOEi1LTrc533w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD931185A79C;
        Sun, 23 Oct 2022 09:38:43 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C10F4A9255;
        Sun, 23 Oct 2022 09:38:24 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk_drv: don't call task_work_add for queueing io commands
Date:   Sun, 23 Oct 2022 17:38:07 +0800
Message-Id: <20221023093807.201946-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

task_work_add() is used for waking ubq daemon task with one batch
of io requests/commands queued. However, task_work_add() isn't
exported for module code, and it is still debatable if the symbol
should be exported.

Fortunately we still have io_uring_cmd_complete_in_task() which just
can't handle batched wakeup for us.

Add one one llist into ublk_queue and call io_uring_cmd_complete_in_task()
via current command for running them via task work.

This way cleans up current code a lot, meantime allow us to wakeup
ubq daemon task after queueing batched requests/io commands.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 130 ++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 78 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5afce6ffaadf..7963fba66dd1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -41,7 +41,7 @@
 #include <linux/delay.h>
 #include <linux/mm.h>
 #include <asm/page.h>
-#include <linux/task_work.h>
+#include <linux/llist.h>
 #include <uapi/linux/ublk_cmd.h>
 
 #define UBLK_MINORS		(1U << MINORBITS)
@@ -56,12 +56,9 @@
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
 
-struct ublk_rq_data {
-	struct callback_head work;
-};
-
 struct ublk_uring_cmd_pdu {
 	struct request *req;
+	struct llist_node node;
 };
 
 /*
@@ -119,6 +116,8 @@ struct ublk_queue {
 	struct task_struct	*ubq_daemon;
 	char *io_cmd_buf;
 
+	struct llist_head	io_cmds;
+
 	unsigned long io_addr;	/* mapped vm address */
 	unsigned int max_io_sz;
 	bool force_abort;
@@ -268,14 +267,6 @@ static int ublk_apply_params(struct ublk_device *ub)
 	return 0;
 }
 
-static inline bool ublk_can_use_task_work(const struct ublk_queue *ubq)
-{
-	if (IS_BUILTIN(CONFIG_BLK_DEV_UBLK) &&
-			!(ubq->flags & UBLK_F_URING_CMD_COMP_IN_TASK))
-		return true;
-	return false;
-}
-
 static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
 {
 	if (ubq->flags & UBLK_F_NEED_GET_DATA)
@@ -761,20 +752,16 @@ static inline void __ublk_rq_task_work(struct request *req)
 	ubq_complete_io_cmd(io, UBLK_IO_RES_OK);
 }
 
-static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd)
+static void ublk_rqs_task_work_cb(struct io_uring_cmd *cmd)
 {
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+	struct ublk_queue *ubq = pdu->req->mq_hctx->driver_data;
+	struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
 
 	__ublk_rq_task_work(pdu->req);
-}
 
-static void ublk_rq_task_work_fn(struct callback_head *work)
-{
-	struct ublk_rq_data *data = container_of(work,
-			struct ublk_rq_data, work);
-	struct request *req = blk_mq_rq_from_pdu(data);
-
-	__ublk_rq_task_work(req);
+	llist_for_each_entry(pdu, io_cmds, node)
+		__ublk_rq_task_work(pdu->req);
 }
 
 static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -782,12 +769,16 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 {
 	struct ublk_queue *ubq = hctx->driver_data;
 	struct request *rq = bd->rq;
+	struct ublk_io *io = &ubq->ios[rq->tag];
+	struct io_uring_cmd *cmd = io->cmd;
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	blk_status_t res;
 
 	/* fill iod to slot in io cmd buffer */
 	res = ublk_setup_iod(ubq, rq);
 	if (unlikely(res != BLK_STS_OK))
 		return BLK_STS_IOERR;
+
 	/* With recovery feature enabled, force_abort is set in
 	 * ublk_stop_dev() before calling del_gendisk(). We have to
 	 * abort all requeued and new rqs here to let del_gendisk()
@@ -802,42 +793,38 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(bd->rq);
 
-	if (unlikely(ubq_daemon_is_dying(ubq))) {
- fail:
+	/*
+	 * If the check pass, we know that this is a re-issued request aborted
+	 * previously in monitor_work because the ubq_daemon(cmd's task) is
+	 * PF_EXITING. We cannot call io_uring_cmd_complete_in_task() anymore
+	 * because this ioucmd's io_uring context may be freed now if no inflight
+	 * ioucmd exists. Otherwise we may cause null-deref in ctx->fallback_work.
+	 *
+	 * Note: monitor_work sets UBLK_IO_FLAG_ABORTED and ends this request(releasing
+	 * the tag). Then the request is re-started(allocating the tag) and we are here.
+	 * Since releasing/allocating a tag implies smp_mb(), finding UBLK_IO_FLAG_ABORTED
+	 * guarantees that here is a re-issued request aborted previously.
+	 */
+	if (unlikely(ubq_daemon_is_dying(ubq) ||
+				(io->flags & UBLK_IO_FLAG_ABORTED))) {
 		__ublk_abort_rq(ubq, rq);
 		return BLK_STS_OK;
 	}
 
-	if (ublk_can_use_task_work(ubq)) {
-		struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
-		enum task_work_notify_mode notify_mode = bd->last ?
-			TWA_SIGNAL_NO_IPI : TWA_NONE;
-
-		if (task_work_add(ubq->ubq_daemon, &data->work, notify_mode))
-			goto fail;
-	} else {
-		struct ublk_io *io = &ubq->ios[rq->tag];
-		struct io_uring_cmd *cmd = io->cmd;
-		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+	pdu->req = rq;
 
-		/*
-		 * If the check pass, we know that this is a re-issued request aborted
-		 * previously in monitor_work because the ubq_daemon(cmd's task) is
-		 * PF_EXITING. We cannot call io_uring_cmd_complete_in_task() anymore
-		 * because this ioucmd's io_uring context may be freed now if no inflight
-		 * ioucmd exists. Otherwise we may cause null-deref in ctx->fallback_work.
-		 *
-		 * Note: monitor_work sets UBLK_IO_FLAG_ABORTED and ends this request(releasing
-		 * the tag). Then the request is re-started(allocating the tag) and we are here.
-		 * Since releasing/allocating a tag implies smp_mb(), finding UBLK_IO_FLAG_ABORTED
-		 * guarantees that here is a re-issued request aborted previously.
-		 */
-		if ((io->flags & UBLK_IO_FLAG_ABORTED))
-			goto fail;
-
-		pdu->req = rq;
-		io_uring_cmd_complete_in_task(cmd, ublk_rq_task_work_cb);
-	}
+	/*
+	 * Typical multiple producers and single consumer, it is just fine
+	 * to use llist_add() in producer side and llist_del_all() in
+	 * consumer side.
+	 *
+	 * The last command can't be added into list, otherwise it could
+	 * be handled twice
+	 */
+	if (bd->last)
+		io_uring_cmd_complete_in_task(cmd, ublk_rqs_task_work_cb);
+	else
+		llist_add(&pdu->node, &ubq->io_cmds);
 
 	return BLK_STS_OK;
 }
@@ -846,8 +833,8 @@ static void ublk_commit_rqs(struct blk_mq_hw_ctx *hctx)
 {
 	struct ublk_queue *ubq = hctx->driver_data;
 
-	if (ublk_can_use_task_work(ubq))
-		__set_notify_signal(ubq->ubq_daemon);
+	if (!test_and_set_tsk_thread_flag(ubq->ubq_daemon, TIF_NOTIFY_SIGNAL))
+		wake_up_process(ubq->ubq_daemon);
 }
 
 static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
@@ -860,20 +847,10 @@ static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
 	return 0;
 }
 
-static int ublk_init_rq(struct blk_mq_tag_set *set, struct request *req,
-		unsigned int hctx_idx, unsigned int numa_node)
-{
-	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
-
-	init_task_work(&data->work, ublk_rq_task_work_fn);
-	return 0;
-}
-
 static const struct blk_mq_ops ublk_mq_ops = {
 	.queue_rq       = ublk_queue_rq,
 	.commit_rqs     = ublk_commit_rqs,
 	.init_hctx	= ublk_init_hctx,
-	.init_request   = ublk_init_rq,
 };
 
 static int ublk_ch_open(struct inode *inode, struct file *filp)
@@ -1163,23 +1140,21 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	mutex_unlock(&ub->mutex);
 }
 
+static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd)
+{
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+
+	__ublk_rq_task_work(pdu->req);
+}
+
 static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
 		int tag, struct io_uring_cmd *cmd)
 {
-	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
 	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 
-	if (ublk_can_use_task_work(ubq)) {
-		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
-
-		/* should not fail since we call it just in ubq->ubq_daemon */
-		task_work_add(ubq->ubq_daemon, &data->work, TWA_SIGNAL_NO_IPI);
-	} else {
-		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
-
-		pdu->req = req;
-		io_uring_cmd_complete_in_task(cmd, ublk_rq_task_work_cb);
-	}
+	pdu->req = req;
+	io_uring_cmd_complete_in_task(cmd, ublk_rq_task_work_cb);
 }
 
 static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
@@ -1450,7 +1425,6 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 	ub->tag_set.nr_hw_queues = ub->dev_info.nr_hw_queues;
 	ub->tag_set.queue_depth = ub->dev_info.queue_depth;
 	ub->tag_set.numa_node = NUMA_NO_NODE;
-	ub->tag_set.cmd_size = sizeof(struct ublk_rq_data);
 	ub->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ub->tag_set.driver_data = ub;
 	return blk_mq_alloc_tag_set(&ub->tag_set);
-- 
2.31.1

