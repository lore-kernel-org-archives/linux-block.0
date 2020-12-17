Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7DCC2BB48
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 11:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 909662389E
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 11:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgLQLMh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 06:12:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9224 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgLQLMh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 06:12:37 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CxTnh2jcBzkrjb;
        Thu, 17 Dec 2020 19:11:04 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Thu, 17 Dec 2020 19:11:44 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>, <hare@suse.de>, <ppvk@codeaurora.org>,
        <bvanassche@acm.org>, <kashyap.desai@broadcom.com>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH v2 1/2] blk-mq: Clean up references to old requests when freeing rqs
Date:   Thu, 17 Dec 2020 19:07:52 +0800
Message-ID: <1608203273-170555-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
References: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
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

The issue is that when we switch IO scheduler or change queue depth,
there may be references in the driver tagset to the stale requests; and
since getting a tag and setting the request pointer is not atomic, a
tagset iter may see a stale request for a tag recently allocated.

As a solution, clean up any references to those requests in the driver
tagset. This is done with a cmpxchg to make safe any race with setting the
driver tagset request from another queue.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/blk-mq-sched.c |  2 +-
 block/blk-mq-tag.c   |  2 +-
 block/blk-mq.c       | 20 ++++++++++++++++++--
 block/blk-mq.h       |  2 ++
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index deff4e826e23..fa1035e1ac6e 100644
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
index 6cfd6bb00ede..a6df2d5df88a 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -580,7 +580,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 			return -ENOMEM;
 		}
 
-		blk_mq_free_rqs(set, *tagsptr, hctx->queue_num);
+		blk_mq_free_rqs_ext(set, *tagsptr, hctx->queue_num, hctx->tags);
 		blk_mq_free_rq_map(*tagsptr, flags);
 		*tagsptr = new;
 	} else {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6f207ec9ef83..8465d7c5ebf0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2278,8 +2278,8 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	return BLK_QC_T_NONE;
 }
 
-void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
-		     unsigned int hctx_idx)
+void __blk_mq_free_rqs_ext(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
+		     unsigned int hctx_idx, struct blk_mq_tags *ref_tags)
 {
 	struct page *page;
 
@@ -2288,10 +2288,14 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 
 		for (i = 0; i < tags->nr_tags; i++) {
 			struct request *rq = tags->static_rqs[i];
+			int j;
 
 			if (!rq)
 				continue;
 			set->ops->exit_request(set, rq, hctx_idx);
+			/* clean up any references which occur in @ref_tags */
+			for (j = 0; ref_tags && j < ref_tags->nr_tags; j++)
+				cmpxchg(&ref_tags->rqs[j], rq, 0);
 			tags->static_rqs[i] = NULL;
 		}
 	}
@@ -2308,6 +2312,18 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	}
 }
 
+void blk_mq_free_rqs_ext(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
+		     unsigned int hctx_idx, struct blk_mq_tags *ref_tags)
+{
+	__blk_mq_free_rqs_ext(set, tags, hctx_idx, ref_tags);
+}
+			 
+void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
+		     unsigned int hctx_idx)
+{
+	__blk_mq_free_rqs_ext(set, tags, hctx_idx, NULL);
+}
+
 void blk_mq_free_rq_map(struct blk_mq_tags *tags, unsigned int flags)
 {
 	kfree(tags->rqs);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index c1458d9502f1..487ca30a6509 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -53,6 +53,8 @@ struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
  */
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx);
+void blk_mq_free_rqs_ext(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
+		     unsigned int hctx_idx, struct blk_mq_tags *references);
 void blk_mq_free_rq_map(struct blk_mq_tags *tags, unsigned int flags);
 struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 					unsigned int hctx_idx,
-- 
2.26.2

