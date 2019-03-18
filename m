Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0310C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A22320835
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfCROkt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:40:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4703 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727134AbfCROkt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 10:40:49 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B7CDDB1966F951D122C3;
        Mon, 18 Mar 2019 22:40:43 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Mar 2019
 22:40:41 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <Damien.LeMoal@wdc.com>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v4] block: add BLK_MQ_POLL_CLASSIC for hybrid poll and return EINVAL for unexpected value
Date:   Mon, 18 Mar 2019 22:44:41 +0800
Message-ID: <20190318144441.133569-1-yuyufen@huawei.com>
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

Additionally, since val is an int obtained with kstrtoint(), val can be
a negative value other than -1, so return -EINVAL for that case.

Thanks to Damien Le Moal for some good suggestion.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-mq.c         |  4 ++--
 block/blk-sysfs.c      | 12 +++++++-----
 include/linux/blkdev.h |  3 +++
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a9c181603cbd..1c588e5c4a02 100644
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
@@ -3392,7 +3392,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 {
 	struct request *rq;
 
-	if (q->poll_nsec == -1)
+	if (q->poll_nsec == BLK_MQ_POLL_CLASSIC)
 		return false;
 
 	if (!blk_qc_t_is_internal(cookie))
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 59685918167e..422327089e0f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -360,8 +360,8 @@ static ssize_t queue_poll_delay_show(struct request_queue *q, char *page)
 {
 	int val;
 
-	if (q->poll_nsec == -1)
-		val = -1;
+	if (q->poll_nsec == BLK_MQ_POLL_CLASSIC)
+		val = BLK_MQ_POLL_CLASSIC;
 	else
 		val = q->poll_nsec / 1000;
 
@@ -380,10 +380,12 @@ static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
 	if (err < 0)
 		return err;
 
-	if (val == -1)
-		q->poll_nsec = -1;
-	else
+	if (val == BLK_MQ_POLL_CLASSIC)
+		q->poll_nsec = BLK_MQ_POLL_CLASSIC;
+	else if (val >= 0)
 		q->poll_nsec = val * 1000;
+	else
+		return -EINVAL;
 
 	return count;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0de92b29f589..5c58a3b2bf00 100644
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

