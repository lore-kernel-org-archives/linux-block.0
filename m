Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5BFECAAD4
	for <linux-block@archiver.kernel.org>; Wed, 31 Aug 2022 15:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiHaPw7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiHaPws (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 11:52:48 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F20AB4C7;
        Wed, 31 Aug 2022 08:52:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VNrdnqz_1661961149;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VNrdnqz_1661961149)
          by smtp.aliyun-inc.com;
          Wed, 31 Aug 2022 23:52:41 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RFC PATCH V2 1/6] ublk_drv: check 'current' instead of 'ubq_daemon'
Date:   Wed, 31 Aug 2022 23:51:31 +0800
Message-Id: <20220831155136.23434-2-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220831155136.23434-1-ZiyangZhang@linux.alibaba.com>
References: <20220831155136.23434-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This check is not atomic. So with recovery feature, ubq_daemon may be
modified simultaneously by recovery task. Instead, check 'current' is
safe here because 'current' never changes.

Also add comment explaining this check, which is really important for
understanding recovery feature.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6a4a94b4cdf4..c39b67d7133d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -645,14 +645,22 @@ static inline void __ublk_rq_task_work(struct request *req)
 	struct ublk_device *ub = ubq->dev;
 	int tag = req->tag;
 	struct ublk_io *io = &ubq->ios[tag];
-	bool task_exiting = current != ubq->ubq_daemon || ubq_daemon_is_dying(ubq);
 	unsigned int mapped_bytes;
 
 	pr_devel("%s: complete: op %d, qid %d tag %d io_flags %x addr %llx\n",
 			__func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags,
 			ublk_get_iod(ubq, req->tag)->addr);
 
-	if (unlikely(task_exiting)) {
+	/*
+	 * Task is exiting if either:
+	 *
+	 * (1) current != ubq_daemon.
+	 * io_uring_cmd_complete_in_task() tries to run task_work
+	 * in a workqueue if ubq_daemon(cmd's task) is PF_EXITING.
+	 *
+	 * (2) current->flags & PF_EXITING.
+	 */
+	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
 		blk_mq_end_request(req, BLK_STS_IOERR);
 		mod_delayed_work(system_wq, &ub->monitor_work, 0);
 		return;
-- 
2.27.0

