Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC7FC25B06
	for <linux-block@archiver.kernel.org>; Mon, 15 Aug 2022 02:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiHOChf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Aug 2022 22:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiHOChf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Aug 2022 22:37:35 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BBC13D5C
        for <linux-block@vger.kernel.org>; Sun, 14 Aug 2022 19:37:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMCMo05_1660531048;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VMCMo05_1660531048)
          by smtp.aliyun-inc.com;
          Mon, 15 Aug 2022 10:37:31 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, xiaoguang.wang@linux.alibaba.com,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V2 3/3] ublk_drv: do not add a re-issued request aborted previously to ioucmd's task_work
Date:   Mon, 15 Aug 2022 10:36:33 +0800
Message-Id: <20220815023633.259825-4-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220815023633.259825-1-ZiyangZhang@linux.alibaba.com>
References: <20220815023633.259825-1-ZiyangZhang@linux.alibaba.com>
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
index 685a43b7ae6e..6a4a94b4cdf4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -756,9 +756,25 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 		if (task_work_add(ubq->ubq_daemon, &data->work, notify_mode))
 			goto fail;
 	} else {
-		struct io_uring_cmd *cmd = ubq->ios[rq->tag].cmd;
+		struct ublk_io *io = &ubq->ios[rq->tag];
+		struct io_uring_cmd *cmd = io->cmd;
 		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 
+		/*
+		 * If the check pass, we know that this is a re-issued request aborted
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
2.27.0

