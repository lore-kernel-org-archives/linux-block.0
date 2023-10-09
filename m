Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7905E95A96
	for <linux-block@archiver.kernel.org>; Mon,  9 Oct 2023 09:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345804AbjJIJgM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Oct 2023 05:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345875AbjJIJgL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Oct 2023 05:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2105BD6
        for <linux-block@vger.kernel.org>; Mon,  9 Oct 2023 02:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696844094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3kULn7XJW6r9/K5SsnJw6mRPX4XQ+SkNMJL3kPzdeUY=;
        b=FeJwaEGZe6v0dbdqE+Z1GPgK+w+NBssafeD0ADWraoKWNWGjNG8cZ3vTgV5oES+AsskyLl
        1HYaM4xTcWGxtk2FPPltbHZ7kbMmpeNUCxq3l3r9CKr9I2hOvsNNM+Amr0FHHyNqU69iDL
        k70TzkLWiyA5n9dHusfYFpNIux+lHDY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-xRrnsAbvMmatImXt8H0UXg-1; Mon, 09 Oct 2023 05:34:51 -0400
X-MC-Unique: xRrnsAbvMmatImXt8H0UXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A802A80CDA1;
        Mon,  9 Oct 2023 09:34:50 +0000 (UTC)
Received: from localhost (unknown [10.72.120.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C484E63F50;
        Mon,  9 Oct 2023 09:34:49 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>
Subject: [PATCH for-6.7/io_uring 7/7] ublk: simplify aborting request
Date:   Mon,  9 Oct 2023 17:33:22 +0800
Message-ID: <20231009093324.957829-8-ming.lei@redhat.com>
In-Reply-To: <20231009093324.957829-1-ming.lei@redhat.com>
References: <20231009093324.957829-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now ublk_abort_queue() is run exclusively with ublk_queue_rq() and the
ubq_daemon task, so simplify aborting request:

- set UBLK_IO_FLAG_ABORTED in ublk_abort_queue() just for aborting
this request

- abort request in ublk_queue_rq() if ubq->canceling is set

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 41 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 75ed7b87a844..20237b8f318a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1083,13 +1083,10 @@ static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
 {
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
 
-	if (!(io->flags & UBLK_IO_FLAG_ABORTED)) {
-		io->flags |= UBLK_IO_FLAG_ABORTED;
-		if (ublk_queue_can_use_recovery_reissue(ubq))
-			blk_mq_requeue_request(req, false);
-		else
-			ublk_put_req_ref(ubq, req);
-	}
+	if (ublk_queue_can_use_recovery_reissue(ubq))
+		blk_mq_requeue_request(req, false);
+	else
+		ublk_put_req_ref(ubq, req);
 }
 
 static void ubq_complete_io_cmd(struct ublk_io *io, int res,
@@ -1230,27 +1227,10 @@ static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd, unsigned issue_flags)
 static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 {
 	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
-	struct ublk_io *io;
 
-	if (!llist_add(&data->node, &ubq->io_cmds))
-		return;
+	if (llist_add(&data->node, &ubq->io_cmds)) {
+		struct ublk_io *io = &ubq->ios[rq->tag];
 
-	io = &ubq->ios[rq->tag];
-	/*
-	 * If the check pass, we know that this is a re-issued request aborted
-	 * previously in cancel fn because the ubq_daemon(cmd's task) is
-	 * PF_EXITING. We cannot call io_uring_cmd_complete_in_task() anymore
-	 * because this ioucmd's io_uring context may be freed now if no inflight
-	 * ioucmd exists. Otherwise we may cause null-deref in ctx->fallback_work.
-	 *
-	 * Note: cancel fn sets UBLK_IO_FLAG_ABORTED and ends this request(releasing
-	 * the tag). Then the request is re-started(allocating the tag) and we are here.
-	 * Since releasing/allocating a tag implies smp_mb(), finding UBLK_IO_FLAG_ABORTED
-	 * guarantees that here is a re-issued request aborted previously.
-	 */
-	if (unlikely(io->flags & UBLK_IO_FLAG_ABORTED)) {
-		ublk_abort_io_cmds(ubq);
-	} else {
 		io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
 	}
 }
@@ -1320,13 +1300,12 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ublk_queue_can_use_recovery(ubq) && unlikely(ubq->force_abort))
 		return BLK_STS_IOERR;
 
-	blk_mq_start_request(bd->rq);
-
 	if (unlikely(ubq->canceling)) {
 		__ublk_abort_rq(ubq, rq);
 		return BLK_STS_OK;
 	}
 
+	blk_mq_start_request(bd->rq);
 	ublk_queue_cmd(ubq, rq);
 
 	return BLK_STS_OK;
@@ -1449,8 +1428,10 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 			 * will do it
 			 */
 			rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
-			if (rq)
+			if (rq && blk_mq_request_started(rq)) {
+				io->flags |= UBLK_IO_FLAG_ABORTED;
 				__ublk_fail_req(ubq, io, rq);
+			}
 		}
 	}
 }
@@ -1534,7 +1515,7 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 
 	io = &ubq->ios[pdu->tag];
 	WARN_ON_ONCE(io->cmd != cmd);
-	ublk_cancel_cmd(ubq, &ubq->ios[pdu->tag], issue_flags);
+	ublk_cancel_cmd(ubq, io, issue_flags);
 
 	if (need_schedule) {
 		if (ublk_can_use_recovery(ub))
-- 
2.41.0

