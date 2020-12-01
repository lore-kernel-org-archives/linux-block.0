Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216F0C64E7A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 13:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD032076C
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 13:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgLANGw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 08:06:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8546 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgLANGw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 08:06:52 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Clj5L2nB4zhkCY;
        Tue,  1 Dec 2020 21:05:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Dec 2020 21:05:58 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <hch@lst.de>, <hare@suse.de>,
        <ppvk@codeaurora.org>, <bvanassche@acm.org>,
        <kashyap.desai@broadcom.com>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH] blk-mq: Clean up references when freeing rqs
Date:   Tue, 1 Dec 2020 21:02:18 +0800
Message-ID: <1606827738-238646-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It has been reported many times that a use-after-free can be intermittently
found when iterating busy requests:

- https://lore.kernel.org/linux-block/8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com/
- https://lore.kernel.org/linux-block/5c3ac5af-ed81-11e4-fee3-f92175f14daf@acm.org/T/#m6c1ac11540522716f645d004e2a5a13c9f218908
- https://lore.kernel.org/linux-block/04e2f9e8-79fa-f1cb-ab23-4a15bf3f64cc@kernel.dk/

The issue is that when we switch scheduler or change queue nr_requests,
the driver tagset may keep references to the stale requests.

As a solution, clean up any references to those requests in the driver
tagset when freeing. This is done with a cmpxchg to make safe any race
with setting the driver tagset request from another queue.

Signed-off-by: John Garry <john.garry@huawei.com>
--
Set as RFC as I need to test more. And not sure on solution method, as
Bart had another idea.

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index d1eafe2c045c..9b042c7036b3 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -621,7 +621,7 @@ void blk_mq_sched_free_requests(struct request_queue *q)
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->sched_tags)
-			blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i);
+			blk_mq_free_rqs_ext(q->tag_set, hctx->sched_tags, i, hctx->tags);
 	}
 }
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9c92053e704d..562db72e7d79 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -576,7 +576,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 			return -ENOMEM;
 		}
 
-		blk_mq_free_rqs(set, *tagsptr, hctx->queue_num);
+		blk_mq_free_rqs_ext(set, *tagsptr, hctx->queue_num, hctx->tags);
 		blk_mq_free_rq_map(*tagsptr, flags);
 		*tagsptr = new;
 	} else {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55bcee5dc032..f3aad695cd25 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2271,8 +2271,8 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	return BLK_QC_T_NONE;
 }
 
-void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
-		     unsigned int hctx_idx)
+void blk_mq_free_rqs_ext(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
+		     unsigned int hctx_idx, struct blk_mq_tags *references)
 {
 	struct page *page;
 
@@ -2281,10 +2281,13 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 
 		for (i = 0; i < tags->nr_tags; i++) {
 			struct request *rq = tags->static_rqs[i];
+			int j;
 
 			if (!rq)
 				continue;
 			set->ops->exit_request(set, rq, hctx_idx);
+			for (j = 0; references && j < references->nr_tags; j++)
+				cmpxchg(&references->rqs[j], rq, 0);
 			tags->static_rqs[i] = NULL;
 		}
 	}
diff --git a/block/blk-mq.h b/block/blk-mq.h
index a52703c98b77..53074844e733 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -51,8 +51,10 @@ struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 /*
  * Internal helpers for allocating/freeing the request map
  */
-void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
-		     unsigned int hctx_idx);
+#define blk_mq_free_rqs(set, tags, hctx_idx) \
+	blk_mq_free_rqs_ext(set, tags, hctx_idx, NULL)
+void blk_mq_free_rqs_ext(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
+		     unsigned int hctx_idx, struct blk_mq_tags *references);
 void blk_mq_free_rq_map(struct blk_mq_tags *tags, unsigned int flags);
 struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 					unsigned int hctx_idx,
-- 
2.26.2

