Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648A2C4338F
	for <linux-block@archiver.kernel.org>; Tue, 17 Aug 2021 02:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41832603E7
	for <linux-block@archiver.kernel.org>; Tue, 17 Aug 2021 02:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbhHQCNJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 22:13:09 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:14263 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbhHQCNJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 22:13:09 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GpZL42bvvz872T;
        Tue, 17 Aug 2021 10:12:28 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 10:12:34 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 17
 Aug 2021 10:12:33 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH RFC] blk_mq: clear rq mapping in driver tags before freeing rqs in sched tags
Date:   Tue, 17 Aug 2021 10:23:06 +0800
Message-ID: <20210817022306.1622027-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If ioscheduler is not none, hctx->tags->rq[tag] will point to
hctx->sched_tags->static_rq[internel_tag] in blk_mq_get_driver_tag().
However, static_rq of sched_tags might be freed through switching
elevator or increasing nr_requests. Thus leave a window for some drivers
to get the freed request through blk_mq_tag_to_rq(tags, tag).

It's difficult to fix this uaf from driver side, I'm thinking about
following solution:

a. clear rq mapping in driver tags before freeing rqs in sched tags
b. provide a new interface to replace blk_mq_tag_to_rq(), the new
interface will make sure it won't return freed rq.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-sched.c | 10 +++++++++-
 block/blk-mq.c       | 13 +++++++++++--
 block/blk-mq.h       |  2 ++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 0f006cabfd91..9f11f17b8380 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -662,8 +662,16 @@ void blk_mq_sched_free_requests(struct request_queue *q)
 	int i;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		if (hctx->sched_tags)
+		if (hctx->sched_tags) {
+			/*
+			 * We are about to free requests in 'sched_tags[]',
+			 * however, 'tags[]' may still point to these requests.
+			 * Thus we need to clear rq mapping in 'tags[]' before
+			 * freeing requests in sched_tags[].
+			 */
+			blk_mq_clear_rq_mapping(q->tag_set, hctx->tags, i);
 			blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i);
+		}
 	}
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d185be64c85f..b1e30464f87f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2314,8 +2314,8 @@ static size_t order_to_size(unsigned int order)
 }
 
 /* called before freeing request pool in @tags */
-static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
-		struct blk_mq_tags *tags, unsigned int hctx_idx)
+void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
+			     struct blk_mq_tags *tags, unsigned int hctx_idx)
 {
 	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
 	struct page *page;
@@ -3632,6 +3632,15 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 			if (!ret && blk_mq_is_sbitmap_shared(set->flags))
 				blk_mq_tag_resize_shared_sbitmap(set, nr);
 		} else {
+			/*
+			 * We are about to free requests in 'sched_tags[]',
+			 * however, 'tags[]' may still point to these requests.
+			 * Thus we need to clear rq mapping in 'tags[]' before
+			 * freeing requests in sched_tags[].
+			 */
+			if (nr > hctx->sched_tags->nr_tags)
+				blk_mq_clear_rq_mapping(set, hctx->tags, i);
+
 			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
 							nr, true);
 			if (blk_mq_is_sbitmap_shared(set->flags)) {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9e646ade81a8..d31f96eca71e 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -77,6 +77,8 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last);
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				    struct list_head *list);
+void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
+			     struct blk_mq_tags *tags, unsigned int hctx_idx);
 
 /*
  * CPU -> queue mappings
-- 
2.31.1

