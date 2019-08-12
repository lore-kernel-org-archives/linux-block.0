Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154D2C31E40
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 12:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E407721855
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 12:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfHLMal (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:30:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4233 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728486AbfHLMal (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 08:30:41 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 919A4BCCFD97871DE850;
        Mon, 12 Aug 2019 20:30:36 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 12 Aug 2019
 20:30:26 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <axboe@kernel.dk>, <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <ming.lei@redhat.com>,
        <linux-block@vger.kernel.org>
CC:     <houtao1@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] blk-mq: move cancel of requeue_work to the front of blk_exit_queue
Date:   Mon, 12 Aug 2019 20:36:55 +0800
Message-ID: <1565613415-24807-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_exit_queue will free elevator_data, while blk_mq_requeue_work
will access it. Move cancel of requeue_work to the front of
blk_exit_queue to avoid use-after-free.

blk_exit_queue                blk_mq_requeue_work
  __elevator_exit               blk_mq_run_hw_queues
    blk_mq_exit_sched             blk_mq_run_hw_queue
      dd_exit_queue                 blk_mq_hctx_has_pending
        kfree(elevator_data)          blk_mq_sched_has_work
                                        dd_has_work

Fixes: fbc2a15e3433 ("blk-mq: move cancel of requeue_work into blk_mq_release")
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 block/blk-mq.c    | 2 --
 block/blk-sysfs.c | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f78d328..a8e6a58 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2666,8 +2666,6 @@ void blk_mq_release(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx, *next;
 	int i;

-	cancel_delayed_work_sync(&q->requeue_work);
-
 	queue_for_each_hw_ctx(q, hctx, i)
 		WARN_ON_ONCE(hctx && list_empty(&hctx->hctx_list));

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 977c659..9bfa3ea 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -892,6 +892,9 @@ static void __blk_release_queue(struct work_struct *work)

 	blk_free_queue_stats(q->stats);

+	if (queue_is_mq(q))
+		cancel_delayed_work_sync(&q->requeue_work);
+
 	blk_exit_queue(q);

 	blk_queue_free_zone_bitmaps(q);
--
2.7.4

