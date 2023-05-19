Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C025BC77B7A
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 06:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjESGvp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 02:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjESGvo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 02:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE94E43
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684479050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zawUuKMJJJeqtoZ9ABLOcsvxRxGjkFWbyxEWB9sjv7Y=;
        b=H1RCept/UltrsgNbVU3NGE7nYbcRQOl5TwYA7/sHYt8qwoSgMSxIE11JG3KOY3/EhD0Y17
        moHIw48yZHf9ygOUZDEGPI6ZKjsm57WZGd6TKnIpRMqB2t+Z5IiDaLSM8uKX4y7cIwzoUQ
        YXjcY3o8vXDeIB54OkkdI1H0ow6kOlU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-3ps5GzSQNc6psX031uRXIA-1; Fri, 19 May 2023 02:50:48 -0400
X-MC-Unique: 3ps5GzSQNc6psX031uRXIA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7951388B76E;
        Fri, 19 May 2023 06:50:48 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E735C15BA0;
        Fri, 19 May 2023 06:50:47 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Harris James R <james.r.harris@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 1/7] ublk: kill queuing request by task_work_add
Date:   Fri, 19 May 2023 14:50:24 +0800
Message-Id: <20230519065030.351216-2-ming.lei@redhat.com>
In-Reply-To: <20230519065030.351216-1-ming.lei@redhat.com>
References: <20230519065030.351216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

task_work_add() is used from early ublk development stage for handling
request in batch. However, since commit 7d4a93176e01 ("ublk_drv: don't
forward io commands in reserve order"), we can get similar batch
processing with io_uring_cmd_complete_in_task(), and similar performance
data is observed between task_work_add() and
io_uring_cmd_complete_in_task().

Meantime we can kill one fast code path, which is actually seldom used
given it is common to build ublk driver as module.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 40 ++--------------------------------------
 1 file changed, 2 insertions(+), 38 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c7ed5d69e9ee..b00c5c210c7f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -62,7 +62,6 @@
 
 struct ublk_rq_data {
 	struct llist_node node;
-	struct callback_head work;
 };
 
 struct ublk_uring_cmd_pdu {
@@ -290,14 +289,6 @@ static int ublk_apply_params(struct ublk_device *ub)
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
 	return ubq->flags & UBLK_F_NEED_GET_DATA;
@@ -852,17 +843,6 @@ static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd, unsigned issue_flags)
 	ublk_forward_io_cmds(ubq, issue_flags);
 }
 
-static void ublk_rq_task_work_fn(struct callback_head *work)
-{
-	struct ublk_rq_data *data = container_of(work,
-			struct ublk_rq_data, work);
-	struct request *req = blk_mq_rq_from_pdu(data);
-	struct ublk_queue *ubq = req->mq_hctx->driver_data;
-	unsigned issue_flags = IO_URING_F_UNLOCKED;
-
-	ublk_forward_io_cmds(ubq, issue_flags);
-}
-
 static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 {
 	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
@@ -886,10 +866,6 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 	 */
 	if (unlikely(io->flags & UBLK_IO_FLAG_ABORTED)) {
 		ublk_abort_io_cmds(ubq);
-	} else if (ublk_can_use_task_work(ubq)) {
-		if (task_work_add(ubq->ubq_daemon, &data->work,
-					TWA_SIGNAL_NO_IPI))
-			ublk_abort_io_cmds(ubq);
 	} else {
 		struct io_uring_cmd *cmd = io->cmd;
 		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
@@ -961,19 +937,9 @@ static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
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
 	.init_hctx	= ublk_init_hctx,
-	.init_request   = ublk_init_rq,
 	.timeout	= ublk_timeout,
 };
 
@@ -1813,10 +1779,8 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	 */
 	ub->dev_info.flags &= UBLK_F_ALL;
 
-	if (!IS_BUILTIN(CONFIG_BLK_DEV_UBLK))
-		ub->dev_info.flags |= UBLK_F_URING_CMD_COMP_IN_TASK;
-
-	ub->dev_info.flags |= UBLK_F_CMD_IOCTL_ENCODE;
+	ub->dev_info.flags |= UBLK_F_CMD_IOCTL_ENCODE |
+		UBLK_F_URING_CMD_COMP_IN_TASK;
 
 	/* We are not ready to support zero copy */
 	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
-- 
2.40.1

