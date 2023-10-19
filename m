Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B6DCDB47E
	for <linux-block@archiver.kernel.org>; Thu, 19 Oct 2023 03:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjJSDE7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Oct 2023 23:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjJSDE6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2023 23:04:58 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48528121;
        Wed, 18 Oct 2023 20:04:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VuSTilE_1697684685;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VuSTilE_1697684685)
          by smtp.aliyun-inc.com;
          Thu, 19 Oct 2023 11:04:53 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] block: ublk_drv: Remove unused function
Date:   Thu, 19 Oct 2023 11:04:44 +0800
Message-Id: <20231019030444.53680-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function are defined in the ublk_drv.c file, but not called
elsewhere, so delete the unused function.

drivers/block/ublk_drv.c:1211:20: warning: unused function 'ublk_abort_io_cmds'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6938
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c34474451908..83600b45e12a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1208,15 +1208,6 @@ static inline void ublk_forward_io_cmds(struct ublk_queue *ubq,
 		__ublk_rq_task_work(blk_mq_rq_from_pdu(data), issue_flags);
 }
 
-static inline void ublk_abort_io_cmds(struct ublk_queue *ubq)
-{
-	struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
-	struct ublk_rq_data *data, *tmp;
-
-	llist_for_each_entry_safe(data, tmp, io_cmds, node)
-		__ublk_abort_rq(ubq, blk_mq_rq_from_pdu(data));
-}
-
 static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd, unsigned issue_flags)
 {
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
-- 
2.20.1.7.g153144c

