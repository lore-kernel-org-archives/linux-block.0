Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1EDC25B06
	for <linux-block@archiver.kernel.org>; Tue,  9 Aug 2022 09:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiHIJR6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Aug 2022 05:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237711AbiHIJRr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Aug 2022 05:17:47 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5852022B3F
        for <linux-block@vger.kernel.org>; Tue,  9 Aug 2022 02:17:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VLpL3gB_1660036660;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VLpL3gB_1660036660)
          by smtp.aliyun-inc.com;
          Tue, 09 Aug 2022 17:17:41 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, xiaoguang.wang@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH 3/3] ublk_drv: do not add a re-issued request aborted previously to ioucmd's task_work
Date:   Tue,  9 Aug 2022 17:16:29 +0800
Message-Id: <20220809091629.104682-4-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220809091629.104682-1-ZiyangZhang@linux.alibaba.com>
References: <20220809091629.104682-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In ublk_queue_rq(), Assume current request is a re-issued request aborted
previously in monitor_work because the ubq_daemon(ioucmd's task) is
PF_EXITING. For this request, we cannot call
io_uring_cmd_complete_in_task() anymore because at that moment io_uring
context may be freed in case that no inflight ioucmd exists. Otherwise,
we may cause null-deref in ctx->fallback_work.

Add a check on UBLK_IO_FLAG_ABORTED to prevent the above situation. This
check is safe and makes sense.

Note: monitor_work sets UBLK_IO_FLAG_ABORTED and ends this request
(releasing the tag). Then the request is restarted(allocating the tag)
and we are here. Since releasing/allocating a tag implies smp_mb(),
finding UBLK_IO_FLAG_ABORTED guarantees that here is a re-issued request
aborted previously.

Suggested-by: Ming Lei <ming.lei@redhat.com>

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index bedef46f6abf..0b9bd9e02b53 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -725,6 +725,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 {
 	struct ublk_queue *ubq = hctx->driver_data;
 	struct request *rq = bd->rq;
+	struct ublk_io *io = &ubq->ios[rq->tag];
 	blk_status_t res;
 
 	/* fill iod to slot in io cmd buffer */
@@ -748,9 +749,24 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 		if (task_work_add(ubq->ubq_daemon, &data->work, notify_mode))
 			goto fail;
 	} else {
-		struct io_uring_cmd *cmd = ubq->ios[rq->tag].cmd;
+		struct io_uring_cmd *cmd = io->cmd;
 		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 
+		/*
+		 * If the check passes, we know that this is a re-issued request aborted
+		 * previously in monitor_work because the ubq_daemon(cmd's task) is
+		 * PF_EXITING. We cannot call io_uring_cmd_complete_in_task() anymore
+		 * because this ioucmd's io_uring context may be freed now if no inflight
+		 * ioucmd exists. Otherwise we may cause null-deref in ctx->fallback_work.
+		 *
+		 * Note: monitor_work sets UBLK_IO_FLAG_ABORTED and ends this request(releasing
+		 * the tag). Then the request is re-started(allocating the tag) and we are here.
+		 * Since releasing/allocating a tag implies smp_mb(), finding UBLK_IO_FLAG_ABORTED
+		 * guarantees that here is a re-issued request aborted previously.
+		 */
+		if ((io->flags & UBLK_IO_FLAG_ABORTED))
+			goto fail;
+
 		pdu->req = rq;
 		io_uring_cmd_complete_in_task(cmd, ublk_rq_task_work_cb);
 	}
-- 
2.14.4.44.g2045bb6

