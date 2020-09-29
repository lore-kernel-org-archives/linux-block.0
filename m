Return-Path: <SRS0=YBZ7=DG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD082C4346E
	for <linux-block@archiver.kernel.org>; Tue, 29 Sep 2020 09:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 872232076B
	for <linux-block@archiver.kernel.org>; Tue, 29 Sep 2020 09:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgI2JJ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Sep 2020 05:09:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14767 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727740AbgI2JJ2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Sep 2020 05:09:28 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BD9716342F84CB9E7FC7;
        Tue, 29 Sep 2020 17:09:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 17:09:18 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linuxarm@huawei.com>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH] block:elevator:remove un-used input parameter request_queue in some functions
Date:   Tue, 29 Sep 2020 17:05:37 +0800
Message-ID: <1601370338-138592-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

In elevator.c, the input parameter request_queue is not used in function
elv_rqhash_del()/elv_rb_former_request()/elv_rb_latter_request(), so
remove it.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 block/bfq-iosched.c      |  2 +-
 block/elevator.c         | 12 +++++-------
 block/mq-deadline.c      |  2 +-
 include/linux/elevator.h | 10 +++++-----
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a4c0bec..78caf16 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2167,7 +2167,7 @@ static void bfq_remove_request(struct request_queue *q,
 	bfqd->queued--;
 	elv_rb_del(&bfqq->sort_list, rq);
 
-	elv_rqhash_del(q, rq);
+	elv_rqhash_del(rq);
 	if (q->last_merge == rq)
 		q->last_merge = NULL;
 
diff --git a/block/elevator.c b/block/elevator.c
index 90ed7a2..45efe94 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -204,7 +204,7 @@ static inline void __elv_rqhash_del(struct request *rq)
 	rq->rq_flags &= ~RQF_HASHED;
 }
 
-void elv_rqhash_del(struct request_queue *q, struct request *rq)
+void elv_rqhash_del(struct request *rq)
 {
 	if (ELV_ON_HASH(rq))
 		__elv_rqhash_del(rq);
@@ -418,7 +418,7 @@ struct request *elv_latter_request(struct request_queue *q, struct request *rq)
 	struct elevator_queue *e = q->elevator;
 
 	if (e->type->ops.next_request)
-		return e->type->ops.next_request(q, rq);
+		return e->type->ops.next_request(rq);
 
 	return NULL;
 }
@@ -428,7 +428,7 @@ struct request *elv_former_request(struct request_queue *q, struct request *rq)
 	struct elevator_queue *e = q->elevator;
 
 	if (e->type->ops.former_request)
-		return e->type->ops.former_request(q, rq);
+		return e->type->ops.former_request(rq);
 
 	return NULL;
 }
@@ -809,8 +809,7 @@ ssize_t elv_iosched_show(struct request_queue *q, char *name)
 	return len;
 }
 
-struct request *elv_rb_former_request(struct request_queue *q,
-				      struct request *rq)
+struct request *elv_rb_former_request(struct request *rq)
 {
 	struct rb_node *rbprev = rb_prev(&rq->rb_node);
 
@@ -821,8 +820,7 @@ struct request *elv_rb_former_request(struct request_queue *q,
 }
 EXPORT_SYMBOL(elv_rb_former_request);
 
-struct request *elv_rb_latter_request(struct request_queue *q,
-				      struct request *rq)
+struct request *elv_rb_latter_request(struct request *rq)
 {
 	struct rb_node *rbnext = rb_next(&rq->rb_node);
 
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b57470e..bf20044 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -118,7 +118,7 @@ static void deadline_remove_request(struct request_queue *q, struct request *rq)
 	if (!RB_EMPTY_NODE(&rq->rb_node))
 		deadline_del_rq_rb(dd, rq);
 
-	elv_rqhash_del(q, rq);
+	elv_rqhash_del(rq);
 	if (q->last_merge == rq)
 		q->last_merge = NULL;
 }
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index bacc40a..3821cc1 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -46,8 +46,8 @@ struct elevator_mq_ops {
 	bool (*has_work)(struct blk_mq_hw_ctx *);
 	void (*completed_request)(struct request *, u64);
 	void (*requeue_request)(struct request *);
-	struct request *(*former_request)(struct request_queue *, struct request *);
-	struct request *(*next_request)(struct request_queue *, struct request *);
+	struct request *(*former_request)(struct request *);
+	struct request *(*next_request)(struct request *);
 	void (*init_icq)(struct io_cq *);
 	void (*exit_icq)(struct io_cq *);
 };
@@ -90,7 +90,7 @@ struct elevator_type
 
 #define ELV_HASH_BITS 6
 
-void elv_rqhash_del(struct request_queue *q, struct request *rq);
+void elv_rqhash_del(struct request *rq);
 void elv_rqhash_add(struct request_queue *q, struct request *rq);
 void elv_rqhash_reposition(struct request_queue *q, struct request *rq);
 struct request *elv_rqhash_find(struct request_queue *q, sector_t offset);
@@ -140,8 +140,8 @@ extern struct elevator_queue *elevator_alloc(struct request_queue *,
 /*
  * Helper functions.
  */
-extern struct request *elv_rb_former_request(struct request_queue *, struct request *);
-extern struct request *elv_rb_latter_request(struct request_queue *, struct request *);
+extern struct request *elv_rb_former_request(struct request *);
+extern struct request *elv_rb_latter_request(struct request *);
 
 /*
  * rb support functions.
-- 
2.8.1

