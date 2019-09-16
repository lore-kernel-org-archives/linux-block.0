Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBD2C4CEC4
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 02:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A8C2077C
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 02:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfIPCQv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Sep 2019 22:16:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbfIPCQv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Sep 2019 22:16:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC5E258569;
        Mon, 16 Sep 2019 02:16:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.70.39.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A4E05C1D6;
        Mon, 16 Sep 2019 02:16:48 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCHv2 2/2] blk-mq: use BLK_MQ_GFP_FLAGS macro instead
Date:   Mon, 16 Sep 2019 07:46:31 +0530
Message-Id: <20190916021631.4327-3-xiubli@redhat.com>
In-Reply-To: <20190916021631.4327-1-xiubli@redhat.com>
References: <20190916021631.4327-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 16 Sep 2019 02:16:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

There at least 6 places are using the same combined GFP flags,
switch them to one macro instead to make the code get cleaner.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9c52e4dfe132..a5faad4690cf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -39,6 +39,8 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
+#define BLK_MQ_GFP_FLAGS (GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY)
+
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
@@ -2091,21 +2093,19 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 
 	tags = blk_mq_init_tags(nr_tags, reserved_tags, node,
 				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags),
-				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
+				BLK_MQ_GFP_FLAGS);
 	if (!tags)
 		return NULL;
 
 	tags->rqs = kcalloc_node(nr_tags, sizeof(struct request *),
-				 GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
-				 node);
+				 BLK_MQ_GFP_FLAGS, node);
 	if (!tags->rqs) {
 		blk_mq_free_tags(tags);
 		return NULL;
 	}
 
 	tags->static_rqs = kcalloc_node(nr_tags, sizeof(struct request *),
-					GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
-					node);
+					BLK_MQ_GFP_FLAGS, node);
 	if (!tags->static_rqs) {
 		kfree(tags->rqs);
 		blk_mq_free_tags(tags);
@@ -2167,7 +2167,7 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 
 		do {
 			page = alloc_pages_node(node,
-				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY | __GFP_ZERO,
+				BLK_MQ_GFP_FLAGS | __GFP_ZERO,
 				this_order);
 			if (page)
 				break;
@@ -2333,7 +2333,7 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 		int node)
 {
 	struct blk_mq_hw_ctx *hctx;
-	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
+	gfp_t gfp = BLK_MQ_GFP_FLAGS;
 
 	hctx = kzalloc_node(blk_mq_hw_ctx_size(set), gfp, node);
 	if (!hctx)
@@ -3194,7 +3194,7 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	if (!q->elevator)
 		return true;
 
-	qe = kmalloc(sizeof(*qe), GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
+	qe = kmalloc(sizeof(*qe), BLK_MQ_GFP_FLAGS);
 	if (!qe)
 		return false;
 
-- 
2.21.0

