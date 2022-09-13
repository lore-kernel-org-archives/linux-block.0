Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3214BC6FA86
	for <linux-block@archiver.kernel.org>; Tue, 13 Sep 2022 04:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiIMETL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Sep 2022 00:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiIMES6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Sep 2022 00:18:58 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515EB50054;
        Mon, 12 Sep 2022 21:18:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VPccyG5_1663042730;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VPccyG5_1663042730)
          by smtp.aliyun-inc.com;
          Tue, 13 Sep 2022 12:18:54 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V3 4/7] ublk_drv: requeue rqs with recovery feature enabled
Date:   Tue, 13 Sep 2022 12:17:04 +0800
Message-Id: <20220913041707.197334-5-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
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
 drivers/block/ublk_drv.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 23337bd7c105..b067f33a1913 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -682,6 +682,21 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res)
 
 #define UBLK_REQUEUE_DELAY_MS	3
 
+static inline void __ublk_abort_rq_in_task_work(struct ublk_queue *ubq,
+		struct request *rq)
+{
+	pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
+			(ublk_queue_can_use_recovery(ubq)) ? "requeue" : "abort",
+			ubq->q_id, rq->tag, ubq->ios[rq->tag].flags);
+	/* We cannot process this rq so just requeue it. */
+	if (ublk_queue_can_use_recovery(ubq)) {
+		blk_mq_requeue_request(rq, false);
+		blk_mq_delay_kick_requeue_list(rq->q, UBLK_REQUEUE_DELAY_MS);
+	} else {
+		blk_mq_end_request(rq, BLK_STS_IOERR);
+	}
+}
+
 static inline void __ublk_rq_task_work(struct request *req)
 {
 	struct ublk_queue *ubq = req->mq_hctx->driver_data;
@@ -704,7 +719,7 @@ static inline void __ublk_rq_task_work(struct request *req)
 	 * (2) current->flags & PF_EXITING.
 	 */
 	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
-		blk_mq_end_request(req, BLK_STS_IOERR);
+		__ublk_abort_rq_in_task_work(ubq, req);
 		mod_delayed_work(system_wq, &ub->monitor_work, 0);
 		return;
 	}
@@ -779,6 +794,21 @@ static void ublk_rq_task_work_fn(struct callback_head *work)
 	__ublk_rq_task_work(req);
 }
 
+static inline blk_status_t __ublk_abort_rq(struct ublk_queue *ubq,
+		struct request *rq)
+{
+	pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
+			(ublk_queue_can_use_recovery(ubq)) ? "requeue" : "abort",
+			ubq->q_id, rq->tag, ubq->ios[rq->tag].flags);
+	/* We cannot process this rq so just requeue it. */
+	if (ublk_queue_can_use_recovery(ubq)) {
+		blk_mq_requeue_request(rq, false);
+		blk_mq_delay_kick_requeue_list(rq->q, UBLK_REQUEUE_DELAY_MS);
+		return BLK_STS_OK;
+	}
+	return BLK_STS_IOERR;
+}
+
 static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
@@ -796,7 +826,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(ubq_daemon_is_dying(ubq))) {
  fail:
 		mod_delayed_work(system_wq, &ubq->dev->monitor_work, 0);
-		return BLK_STS_IOERR;
+		return __ublk_abort_rq(ubq, rq);
 	}
 
 	if (ublk_can_use_task_work(ubq)) {
-- 
2.27.0

