Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF4EC07E95
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 06:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1E560FF4
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 06:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbhGTFn3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jul 2021 01:43:29 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7401 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237912AbhGTFnL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jul 2021 01:43:11 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GTT8j0yPJz7x5q;
        Tue, 20 Jul 2021 14:20:05 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 20 Jul 2021 14:23:36 +0800
Received: from localhost.localdomain (10.175.127.227) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 20 Jul 2021 14:23:35 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>
Subject: [RFC PATCH] block: stop wait rcu once we can ensure no io while elevator init
Date:   Tue, 20 Jul 2021 14:31:47 +0800
Message-ID: <20210720063147.966670-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

'commit 737eb78e82d5 ("block: Delay default elevator initialization")'
delay elevator init to fix some problem for special device like SMR.
Also, the commit add the logic to ensure no IO can happened while
blk_mq_init_sched. However, blk_mq_freeze_queue/blk_mq_quiesce_queue
will add RCU Grace period which can lead some overhead(about 36 loop
device try to mount which each Grace period around 20ms).

For loop device, no io can happened while add_disk, so it's safe to skip
this step. Add flag QUEUE_FLAG_NO_INIT_IO to identify this case.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 block/elevator.c       | 14 ++++++++++----
 drivers/block/loop.c   |  5 +++++
 include/linux/blkdev.h |  2 ++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 52ada14cfe45..ddf24afb999e 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -672,6 +672,7 @@ void elevator_init_mq(struct request_queue *q)
 {
 	struct elevator_type *e;
 	int err;
+	bool no_init_io;
 
 	if (!elv_support_iosched(q))
 		return;
@@ -688,13 +689,18 @@ void elevator_init_mq(struct request_queue *q)
 	if (!e)
 		return;
 
-	blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue(q);
+	no_init_io = blk_queue_no_init_io(q);
+	if (!no_init_io) {
+		blk_mq_freeze_queue(q);
+		blk_mq_quiesce_queue(q);
+	}
 
 	err = blk_mq_init_sched(q, e);
 
-	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
+	if (!no_init_io) {
+		blk_mq_unquiesce_queue(q);
+		blk_mq_unfreeze_queue(q);
+	}
 
 	if (err) {
 		pr_warn("\"%s\" elevator initialization failed, "
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f37b9e3d833c..4667273bf071 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2326,6 +2326,11 @@ static int loop_add(int i)
 	disk->private_data	= lo;
 	disk->queue		= lo->lo_queue;
 	sprintf(disk->disk_name, "loop%d", i);
+	/*
+	 * There won't be io before add_disk, QUEUE_FLAG_NO_INIT_IO can help
+	 * to save time while elevator_init_mq.
+	 */
+	blk_queue_flag_set(QUEUE_FLAG_NO_INIT_IO, lo->lo_queue);
 	add_disk(disk);
 	mutex_unlock(&loop_ctl_mutex);
 	return i;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3177181c4326..b070c902d8c9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -603,6 +603,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_NO_INIT_IO	30	/* no IO can happen while elevator_init_mq */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -649,6 +650,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
+#define blk_queue_no_init_io(q)	test_bit(QUEUE_FLAG_NO_INIT_IO, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.31.1

