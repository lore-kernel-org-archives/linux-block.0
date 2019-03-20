Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79828C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 07:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529682146E
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 07:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfCTH5w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:57:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfCTH5w (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 03:57:52 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B2E404FAF7B91349BC93;
        Wed, 20 Mar 2019 15:57:49 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Mar 2019
 15:57:39 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <hch@lst.de>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <houtao1@huawei.com>, <yanaijie@huawei.com>, <yuyufen@huawei.com>
Subject: [PATCH] blk-mq: fix a hung issue when set device state to blocked and restore running
Date:   Wed, 20 Mar 2019 16:02:01 +0800
Message-ID: <1553068921-6605-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When I use dd test a SCSI device which use blk-mq in the following steps:
1.echo "blocked" >/sys/block/sda/device/state
2.dd if=/dev/sda of=/mnt/t.log bs=1M count=10
3.echo "running" >/sys/block/sda/device/state
dd should finish this work after step 3, unfortunately, still hung.

After step2, the key code process is like this:
blk_mq_dispatch_rq_list-->scsi_queue_rq-->prep_to_mq
                       -->if ret is BLK_STS_RESOURCE, delay run hw queue

prep_to_mq will return BLK_STS_RESOURCE, and scsi_queue_rq will transter
it to BLK_STS_DEV_RESOURCE. In this situtation, we should delay run hw
queue. This patch fixes that.

Fixes: 86ff7c2a80cd ("blk-mq: introduce BLK_STS_DEV_RESOURCE")
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 block/blk-mq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a9c1816..556d606 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1309,15 +1309,17 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		 *   returning BLK_STS_RESOURCE. Two exceptions are scsi-mq
 		 *   and dm-rq.
 		 *
-		 * If driver returns BLK_STS_RESOURCE and SCHED_RESTART
-		 * bit is set, run queue after a delay to avoid IO stalls
-		 * that could otherwise occur if the queue is idle.
+		 * If driver returns BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE
+		 * and SCHED_RESTART bit is set, run queue after a delay to
+		 * avoid IO stalls that could otherwise occur if the queue
+		 * is idle.
 		 */
 		needs_restart = blk_mq_sched_needs_restart(hctx);
 		if (!needs_restart ||
 		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
 			blk_mq_run_hw_queue(hctx, true);
-		else if (needs_restart && (ret == BLK_STS_RESOURCE))
+		else if (needs_restart && ((ret == BLK_STS_RESOURCE) ||
+					   (ret == BLK_STS_DEV_RESOURCE)))
 			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);

 		blk_mq_update_dispatch_busy(hctx, true);
--
2.7.4

