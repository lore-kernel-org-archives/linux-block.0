Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5BBC25B07
	for <linux-block@archiver.kernel.org>; Tue,  9 Aug 2022 09:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiHIJR6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Aug 2022 05:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbiHIJRp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Aug 2022 05:17:45 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2584522B3E
        for <linux-block@vger.kernel.org>; Tue,  9 Aug 2022 02:17:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VLpL3fk_1660036659;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VLpL3fk_1660036659)
          by smtp.aliyun-inc.com;
          Tue, 09 Aug 2022 17:17:40 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, xiaoguang.wang@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH 1/3] ublk_drv: check ubq_daemon_is_dying() in __ublk_rq_task_work()
Date:   Tue,  9 Aug 2022 17:16:27 +0800
Message-Id: <20220809091629.104682-2-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220809091629.104682-1-ZiyangZhang@linux.alibaba.com>
References: <20220809091629.104682-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace direct check on PF_EXITING in __ublk_rq_task_work() by the
existing wrapper. Also inline ubq_daemon_is_dying().

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2b7d1db5c4a7..3797bd64c3c3 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -555,7 +555,7 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
 	return (struct ublk_uring_cmd_pdu *)&ioucmd->pdu;
 }
 
-static bool ubq_daemon_is_dying(struct ublk_queue *ubq)
+static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
 {
 	return ubq->ubq_daemon->flags & PF_EXITING;
 }
@@ -644,8 +644,7 @@ static inline void __ublk_rq_task_work(struct request *req)
 	struct ublk_device *ub = ubq->dev;
 	int tag = req->tag;
 	struct ublk_io *io = &ubq->ios[tag];
-	bool task_exiting = current != ubq->ubq_daemon ||
-		(current->flags & PF_EXITING);
+	bool task_exiting = current != ubq->ubq_daemon || ubq_daemon_is_dying(ubq);
 	unsigned int mapped_bytes;
 
 	pr_devel("%s: complete: op %d, qid %d tag %d io_flags %x addr %llx\n",
-- 
2.14.4.44.g2045bb6

