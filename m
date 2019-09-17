Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B587C4CECD
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 12:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4649C2171F
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 12:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfIQM4m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:56:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfIQM4m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 08:56:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5384E369AC;
        Tue, 17 Sep 2019 12:56:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.70.39.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E282860BE1;
        Tue, 17 Sep 2019 12:56:34 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [RFC PATCH] blk-mq: set the default elevator type to none if nr_hw_queues > 1
Date:   Tue, 17 Sep 2019 18:26:31 +0530
Message-Id: <20190917125631.11161-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 17 Sep 2019 12:56:42 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

For the nbd device, firstly it will be initialized as single hardware
queue, and then in add_disk() the elevator will set to mq-deadline.

But if there more than one socket connections, then the hardware
queus will be increased and will equal to the socket connection
numners. In this case shouldn't we set it back to none as default ?

If the user space daemon has changed the elevator type or the drivers
has specified the elevator feature, we will set it back anyway.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 block/blk-mq.c         | 19 +++++++++++++++++--
 block/blk.h            |  1 +
 block/elevator.c       |  6 ++++--
 include/linux/blkdev.h |  2 ++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8cdc747d5c4d..1be9e416bfd8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3242,7 +3242,7 @@ static void blk_mq_elv_switch_back(struct list_head *head,
 		struct request_queue *q)
 {
 	struct blk_mq_qe_pair *qe;
-	struct elevator_type *t = NULL;
+	struct elevator_type *t = NULL, *e;
 
 	list_for_each_entry(qe, head, node)
 		if (qe->q == q) {
@@ -3257,7 +3257,22 @@ static void blk_mq_elv_switch_back(struct list_head *head,
 	kfree(qe);
 
 	mutex_lock(&q->sysfs_lock);
-	elevator_switch_mq(q, t);
+	/*
+	 * If the elevator type has been touched by user space daemon
+	 * we will switch it back to the previous one anyway.
+	 *
+	 * Or will set it as default depending on the new hw queue number,
+	 * if will keep the elv type to none then we need to put the moudle.
+	 */
+	if (q->elv_user_touched || q->required_elevator_features) {
+		elevator_switch_mq(q, t);
+	} else {
+		e = elevator_get_default(q);
+		if (e)
+			elevator_switch_mq(q, e);
+		else
+			module_put(t->elevator_owner);
+	}
 	mutex_unlock(&q->sysfs_lock);
 }
 
diff --git a/block/blk.h b/block/blk.h
index ed347f7a97b1..43021b87b953 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -190,6 +190,7 @@ int elevator_switch_mq(struct request_queue *q,
 void __elevator_exit(struct request_queue *, struct elevator_queue *);
 int elv_register_queue(struct request_queue *q, bool uevent);
 void elv_unregister_queue(struct request_queue *q);
+struct elevator_type *elevator_get_default(struct request_queue *q);
 
 static inline void elevator_exit(struct request_queue *q,
 		struct elevator_queue *e)
diff --git a/block/elevator.c b/block/elevator.c
index bba10e83478a..14bfcb1b19b3 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -654,7 +654,7 @@ static inline bool elv_support_iosched(struct request_queue *q)
  * For single queue devices, default to using mq-deadline. If we have multiple
  * queues or mq-deadline is not available, default to "none".
  */
-static struct elevator_type *elevator_get_default(struct request_queue *q)
+struct elevator_type *elevator_get_default(struct request_queue *q)
 {
 	if (q->nr_hw_queues != 1)
 		return NULL;
@@ -796,8 +796,10 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 		return count;
 
 	ret = __elevator_change(q, name);
-	if (!ret)
+	if (!ret) {
+		q->elv_user_touched = true;
 		return count;
+	}
 
 	return ret;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b196124e3240..a03b8ea5916d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -587,6 +587,8 @@ struct request_queue {
 
 #define BLK_MAX_WRITE_HINTS	5
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
+
+	bool			elv_user_touched;
 };
 
 #define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
-- 
2.21.0

