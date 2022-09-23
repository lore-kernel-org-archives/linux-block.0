Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471A8ECAAD8
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 06:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiIWGQf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 02:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiIWGQY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 02:16:24 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A73212578A;
        Thu, 22 Sep 2022 23:16:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQVS0lX_1663913761;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQVS0lX_1663913761)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 14:16:15 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RESEND PATCH V5 3/7] ublk_drv: requeue rqs with recovery feature enabled
Date:   Fri, 23 Sep 2022 14:15:01 +0800
Message-Id: <20220923061505.52007-4-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220923061505.52007-1-ZiyangZhang@linux.alibaba.com>
References: <20220923061505.52007-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With recovery feature enabled, in ublk_queue_rq or task work
(in exit_task_work or fallback wq), we requeue rqs instead of
ending(aborting) them. Besides, No matter recovery feature is enabled
or disabled, we schedule monitor_work immediately.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 05bfbaa49696..3ae13e46ece6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -655,6 +655,16 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res)
 
 #define UBLK_REQUEUE_DELAY_MS	3
 
+static inline void __ublk_abort_rq(struct ublk_queue *ubq,
+		struct request *rq)
+{
+	/* We cannot process this rq so just requeue it. */
+	if (ublk_queue_can_use_recovery(ubq))
+		blk_mq_requeue_request(rq, false);
+	else
+		blk_mq_end_request(rq, BLK_STS_IOERR);
+}
+
 static inline void __ublk_rq_task_work(struct request *req)
 {
 	struct ublk_queue *ubq = req->mq_hctx->driver_data;
@@ -677,7 +687,7 @@ static inline void __ublk_rq_task_work(struct request *req)
 	 * (2) current->flags & PF_EXITING.
 	 */
 	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
-		blk_mq_end_request(req, BLK_STS_IOERR);
+		__ublk_abort_rq(ubq, req);
 		mod_delayed_work(system_wq, &ub->monitor_work, 0);
 		return;
 	}
@@ -769,7 +779,8 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(ubq_daemon_is_dying(ubq))) {
  fail:
 		mod_delayed_work(system_wq, &ubq->dev->monitor_work, 0);
-		return BLK_STS_IOERR;
+		__ublk_abort_rq(ubq, rq);
+		return BLK_STS_OK;
 	}
 
 	if (ublk_can_use_task_work(ubq)) {
-- 
2.27.0

