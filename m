Return-Path: <SRS0=kuF4=CO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75523C43461
	for <linux-block@archiver.kernel.org>; Sat,  5 Sep 2020 09:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A1320757
	for <linux-block@archiver.kernel.org>; Sat,  5 Sep 2020 09:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgIEJnB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Sep 2020 05:43:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10823 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbgIEJnA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Sep 2020 05:43:00 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 07431ADF868BD8A01525;
        Sat,  5 Sep 2020 17:42:58 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Sat, 5 Sep 2020
 17:42:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] block: Fix various comments
Date:   Sat, 5 Sep 2020 05:41:39 -0400
Message-ID: <20200905094139.3119-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix various comments including wrong function names, global variable name
and so on.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 block/bio.c          | 2 +-
 block/blk-cgroup.c   | 2 +-
 block/blk-mq.c       | 4 ++--
 block/blk-throttle.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a323a5446221..8c16a6744c72 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -174,7 +174,7 @@ struct bio_vec *bvec_alloc(gfp_t gfp_mask, int nr, unsigned long *idx,
 	struct bio_vec *bvl;
 
 	/*
-	 * see comment near bvec_array define!
+	 * see comment near bvec_slabs define!
 	 */
 	switch (nr) {
 	case 1:
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c195365c9817..58c57ada3b79 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1816,7 +1816,7 @@ EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
  * @bio: target bio
  *
  * Associate @bio with the blkg found from the bio's css and request_queue.
- * If one is not found, bio_lookup_blkg() creates the blkg.  If a blkg is
+ * If one is not found, blkg_lookup_create() creates the blkg.  If a blkg is
  * already associated, the css is reused and association redone as the
  * request_queue may have changed.
  */
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d089825f9cd1..a6e0a360b5f1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1650,7 +1650,7 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	/*
 	 * When queue is quiesced, we may be switching io scheduler, or
 	 * updating nr_hw_queues, or other things, and we can't run queue
-	 * any more, even __blk_mq_hctx_has_pending() can't be called safely.
+	 * any more, even blk_mq_hctx_has_pending() can't be called safely.
 	 *
 	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
 	 * quiesced.
@@ -1666,7 +1666,7 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 EXPORT_SYMBOL(blk_mq_run_hw_queue);
 
 /**
- * blk_mq_run_hw_queue - Run all hardware queues in a request queue.
+ * blk_mq_run_hw_queues - Run all hardware queues in a request queue.
  * @q: Pointer to the request queue to run.
  * @async: If we want to run the queue asynchronously.
  */
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index fee3325edf27..207c9a477165 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -182,7 +182,7 @@ struct throtl_grp {
 	struct blkg_rwstat stat_ios;
 };
 
-/* We measure latency for request size from <= 4k to >= 1M */
+/* We measure latency for request size from >= 4k to <= 1M */
 #define LATENCY_BUCKET_SIZE 9
 
 struct latency_bucket {
-- 
2.19.1

