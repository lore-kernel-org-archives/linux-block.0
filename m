Return-Path: <SRS0=BuC1=RE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA44C43381
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 01:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B9020842
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 01:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732828AbfCABYq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:24:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4747 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfCABYq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 20:24:46 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 295BEC8325EE75AF9755;
        Fri,  1 Mar 2019 09:24:44 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Mar 2019
 09:24:40 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <Damien.LeMoal@wdc.com>,
        <marcos.souza.org@gmail.com>, <linux-block@vger.kernel.org>
Subject: [PATCH v2] block: add a new flag BLK_MQ_POLL_CLASSIC for hybrid poll
Date:   Fri, 1 Mar 2019 09:28:55 +0800
Message-ID: <20190301012855.137660-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For q->poll_nsec == -1, means doing classic poll, not hybrid poll.
We introduce a new flag BLK_MQ_POLL_CLASSIC to replace -1, which
may make code much easier to read.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-mq.c         | 4 ++--
 block/blk-sysfs.c      | 4 ++--
 include/linux/blkdev.h | 3 +++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9437a5eb07cf..e70202e3b378 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2857,7 +2857,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	/*
 	 * Default to classic polling
 	 */
-	q->poll_nsec = -1;
+	q->poll_nsec = BLK_MQ_POLL_CLASSIC;
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
 	blk_mq_add_queue_tag_set(set, q);
@@ -3389,7 +3389,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 {
 	struct request *rq;
 
-	if (q->poll_nsec == -1)
+	if (q->poll_nsec == BLK_MQ_POLL_CLASSIC)
 		return false;
 
 	if (!blk_qc_t_is_internal(cookie))
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 590d1ef2f961..8639e135687e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -360,7 +360,7 @@ static ssize_t queue_poll_delay_show(struct request_queue *q, char *page)
 {
 	int val;
 
-	if (q->poll_nsec == -1)
+	if (q->poll_nsec == BLK_MQ_POLL_CLASSIC)
 		val = -1;
 	else
 		val = q->poll_nsec / 1000;
@@ -381,7 +381,7 @@ static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
 		return err;
 
 	if (val == -1)
-		q->poll_nsec = -1;
+		q->poll_nsec = BLK_MQ_POLL_CLASSIC;
 	else
 		q->poll_nsec = val * 1000;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 338604dff7d0..f9c2ebf5e621 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -50,6 +50,9 @@ struct blk_stat_callback;
 /* Must be consistent with blk_mq_poll_stats_bkt() */
 #define BLK_MQ_POLL_STATS_BKTS 16
 
+/* Doing classic polling */
+#define BLK_MQ_POLL_CLASSIC -1
+
 /*
  * Maximum number of blkcg policies allowed to be registered concurrently.
  * Defined here to simplify include dependency.
-- 
2.16.2.dirty

