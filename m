Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A61C38A02
	for <linux-block@archiver.kernel.org>; Sat, 29 Oct 2022 01:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJ2BGG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 21:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJ2BGE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 21:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3384B40E25
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 18:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667005503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YSi7Fu9NwmUwXmmX5Gy4LvlLpTkKaSGvQYmzrlhOcaY=;
        b=aI4cKtUMUNHQG6q7l02MDehpaxfcFAnjgOee0lLT3qN836lYK2nZNMEXAZxVsGFd9iH98J
        V61dybppzUL2/gI71VTk/HLJJx6TOhAnfail7WEW1XsCWMg5hPZLpzLSGF/G2EEkh6XlRR
        4p7TXS4Zn31DLbiom41EwYPtnM3lLb8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-j8JcPrdJOTK8UdAO8WFkJw-1; Fri, 28 Oct 2022 21:05:00 -0400
X-MC-Unique: j8JcPrdJOTK8UdAO8WFkJw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45C4B1C05129;
        Sat, 29 Oct 2022 01:05:00 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA82F483EFB;
        Sat, 29 Oct 2022 01:04:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/4] ublk_drv: avoid to touch io_uring cmd in blk_mq io path
Date:   Sat, 29 Oct 2022 09:04:31 +0800
Message-Id: <20221029010432.598367-4-ming.lei@redhat.com>
In-Reply-To: <20221029010432.598367-1-ming.lei@redhat.com>
References: <20221029010432.598367-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

io_uring cmd is supposed to be used in ubq daemon context mainly,
and we should try to avoid to touch it in ublk io submission context,
otherwise this data could become shared between the two contexts,
and performance is hurt.

So link request into one per-queue list, and use same batching policy
of io_uring command, just avoid to touch ucmd in blk-mq io context.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 83 +++++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 30 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6b2f214f0d5c..3a59271dafe4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -57,11 +57,14 @@
 #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
 
 struct ublk_rq_data {
-	struct callback_head work;
+	union {
+		struct callback_head work;
+		struct llist_node node;
+	};
 };
 
 struct ublk_uring_cmd_pdu {
-	struct request *req;
+	struct ublk_queue *ubq;
 };
 
 /*
@@ -119,6 +122,8 @@ struct ublk_queue {
 	struct task_struct	*ubq_daemon;
 	char *io_cmd_buf;
 
+	struct llist_head	io_cmds;
+
 	unsigned long io_addr;	/* mapped vm address */
 	unsigned int max_io_sz;
 	bool force_abort;
@@ -764,8 +769,12 @@ static inline void __ublk_rq_task_work(struct request *req)
 static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd)
 {
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+	struct ublk_queue *ubq = pdu->ubq;
+	struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
+	struct ublk_rq_data *data;
 
-	__ublk_rq_task_work(pdu->req);
+	llist_for_each_entry(data, io_cmds, node)
+		__ublk_rq_task_work(blk_mq_rq_from_pdu(data));
 }
 
 static void ublk_rq_task_work_fn(struct callback_head *work)
@@ -777,17 +786,50 @@ static void ublk_rq_task_work_fn(struct callback_head *work)
 	__ublk_rq_task_work(req);
 }
 
+static void ublk_submit_cmd(struct ublk_queue *ubq, const struct request *rq)
+{
+	struct ublk_io *io = &ubq->ios[rq->tag];
+
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
+	if (unlikely(io->flags & UBLK_IO_FLAG_ABORTED)) {
+		struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
+		struct ublk_rq_data *data;
+
+		llist_for_each_entry(data, io_cmds, node)
+			__ublk_abort_rq(ubq, blk_mq_rq_from_pdu(data));
+	} else {
+		struct io_uring_cmd *cmd = io->cmd;
+		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+
+		pdu->ubq = ubq;
+		io_uring_cmd_complete_in_task(cmd, ublk_rq_task_work_cb);
+	}
+}
+
 static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
 	struct ublk_queue *ubq = hctx->driver_data;
 	struct request *rq = bd->rq;
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
 	blk_status_t res;
 
 	/* fill iod to slot in io cmd buffer */
 	res = ublk_setup_iod(ubq, rq);
 	if (unlikely(res != BLK_STS_OK))
 		return BLK_STS_IOERR;
+
 	/* With recovery feature enabled, force_abort is set in
 	 * ublk_stop_dev() before calling del_gendisk(). We have to
 	 * abort all requeued and new rqs here to let del_gendisk()
@@ -809,36 +851,15 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	if (ublk_can_use_task_work(ubq)) {
-		struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
 		enum task_work_notify_mode notify_mode = bd->last ?
 			TWA_SIGNAL_NO_IPI : TWA_NONE;
 
 		if (task_work_add(ubq->ubq_daemon, &data->work, notify_mode))
 			goto fail;
 	} else {
-		struct ublk_io *io = &ubq->ios[rq->tag];
-		struct io_uring_cmd *cmd = io->cmd;
-		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
-
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
+		if (llist_add(&data->node, &ubq->io_cmds))
+			ublk_submit_cmd(ubq, rq);
 	}
-
 	return BLK_STS_OK;
 }
 
@@ -1168,17 +1189,19 @@ static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
 {
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
 	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
 	if (ublk_can_use_task_work(ubq)) {
-		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
-
 		/* should not fail since we call it just in ubq->ubq_daemon */
 		task_work_add(ubq->ubq_daemon, &data->work, TWA_SIGNAL_NO_IPI);
 	} else {
 		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 
-		pdu->req = req;
-		io_uring_cmd_complete_in_task(cmd, ublk_rq_task_work_cb);
+		if (llist_add(&data->node, &ubq->io_cmds)) {
+			pdu->ubq = ubq;
+			io_uring_cmd_complete_in_task(cmd,
+					ublk_rq_task_work_cb);
+		}
 	}
 }
 
-- 
2.31.1

