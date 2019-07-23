Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC15EC7618B
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 14:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB953218DA
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 14:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbfGWOFC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:05:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2739 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727349AbfGWOFB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 10:05:01 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 33061AF08157AAA727AB;
        Tue, 23 Jul 2019 22:04:57 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Jul 2019
 22:04:49 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] blk-mq: Fix memory leak in blk_mq_init_allocated_queue error handling
Date:   Tue, 23 Jul 2019 22:10:42 +0800
Message-ID: <1563891042-25448-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If blk_mq_init_allocated_queue->elevator_init_mq fails, need to release
the previously requested resources.

Fixes: d34849913 ("blk-mq-sched: allow setting of default IO scheduler")
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 block/blk-mq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b038ec6..e001610 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2845,6 +2845,8 @@ static unsigned int nr_hw_queues(struct blk_mq_tag_set *set)
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q)
 {
+	int ret = -ENOMEM;
+
 	/* mark the queue as mq asap */
 	q->mq_ops = set->ops;

@@ -2906,17 +2908,18 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	blk_mq_map_swqueue(q);

 	if (!(set->flags & BLK_MQ_F_NO_SCHED)) {
-		int ret;
-
 		ret = elevator_init_mq(q);
 		if (ret)
-			return ERR_PTR(ret);
+			goto err_tag_set;
 	}

 	return q;

+err_tag_set:
+	blk_mq_del_queue_tag_set(q);
 err_hctxs:
 	kfree(q->queue_hw_ctx);
+	q->nr_hw_queues = 0;
 err_sys_init:
 	blk_mq_sysfs_deinit(q);
 err_poll:
--
2.7.4

