Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5877AC46CA1
	for <linux-block@archiver.kernel.org>; Mon, 18 Sep 2023 04:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbjIREN3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Sep 2023 00:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbjIRENE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Sep 2023 00:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21D312B
        for <linux-block@vger.kernel.org>; Sun, 17 Sep 2023 21:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695010309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YlbJwv7tXUgE/3jOxnqej4cCUaduO2XvxGilksrAig=;
        b=AWmG7BJvtAY5sX+/XNFfXlF+MZTG1dvJ0goRr/B3kJoh1ThdljtX3zq1J7+jJNIvdzyh2W
        lms6N5JDyYtm70jHKxE0cPZP7sysDOnYf/y6nf5Jez03R5IPX7xfqLmva8y+nWU1finPK7
        L7UMMEks2cTrXD6ckshAV2mSP0dcotI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-22Vb2Q6dMM2L7W6lowtD_g-1; Mon, 18 Sep 2023 00:11:45 -0400
X-MC-Unique: 22Vb2Q6dMM2L7W6lowtD_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E03F3185A790;
        Mon, 18 Sep 2023 04:11:44 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F118B40C6EA8;
        Mon, 18 Sep 2023 04:11:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        io-uring@vger.kernel.org
Cc:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 06/10] ublk: make sure that uring cmd aiming at same queue won't cross io_uring contexts
Date:   Mon, 18 Sep 2023 12:11:02 +0800
Message-Id: <20230918041106.2134250-7-ming.lei@redhat.com>
In-Reply-To: <20230918041106.2134250-1-ming.lei@redhat.com>
References: <20230918041106.2134250-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make sure that all commands aiming at same ublk queue are from same io_uring
context. This way is one very reasonable requirement, and not see any
reason userspace may send uring cmd to same queue by multiple io_uring
contexts.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 46d499d96ca3..52dd53662ffb 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -131,6 +131,7 @@ struct ublk_queue {
 	unsigned long flags;
 	struct task_struct	*ubq_daemon;
 	char *io_cmd_buf;
+	unsigned int ctx_id;
 
 	struct llist_head	io_cmds;
 
@@ -1410,6 +1411,11 @@ static void ublk_commit_completion(struct ublk_device *ub,
 		ublk_put_req_ref(ubq, req);
 }
 
+static inline bool ublk_ctx_id_is_valid(unsigned int ctx_id)
+{
+	return ctx_id != IO_URING_INVALID_CTX_ID;
+}
+
 /*
  * When ->ubq_daemon is exiting, either new request is ended immediately,
  * or any queued io command is drained, so it is safe to abort queue
@@ -1609,11 +1615,13 @@ static void ublk_stop_dev(struct ublk_device *ub)
 }
 
 /* device can only be started after all IOs are ready */
-static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
+static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq,
+		unsigned int ctx_id)
 {
 	mutex_lock(&ub->mutex);
 	ubq->nr_io_ready++;
 	if (ublk_queue_ready(ubq)) {
+		ubq->ctx_id = ctx_id;
 		ubq->ubq_daemon = current;
 		get_task_struct(ubq->ubq_daemon);
 		ub->nr_queues_ready++;
@@ -1682,6 +1690,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	if (ubq->ubq_daemon && ubq->ubq_daemon != current)
 		goto out;
 
+	if (ublk_ctx_id_is_valid(ubq->ctx_id) && cmd->ctx_id != ubq->ctx_id)
+		goto out;
+
 	if (tag >= ubq->q_depth)
 		goto out;
 
@@ -1734,7 +1745,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		}
 
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ublk_mark_io_ready(ub, ubq);
+		ublk_mark_io_ready(ub, ubq, cmd->ctx_id);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
@@ -1989,6 +2000,7 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 
 	ubq->io_cmd_buf = ptr;
 	ubq->dev = ub;
+	ubq->ctx_id = IO_URING_INVALID_CTX_ID;
 	return 0;
 }
 
@@ -2593,6 +2605,8 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 	ubq->ubq_daemon = NULL;
 	ubq->timeout = false;
 
+	ubq->ctx_id = IO_URING_INVALID_CTX_ID;
+
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
 
-- 
2.40.1

