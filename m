Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99DFC4332F
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 12:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345350AbiC3MrJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 08:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344477AbiC3Mqy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 08:46:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49667DE20
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 05:43:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6A9E71F86B;
        Wed, 30 Mar 2022 12:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648644181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D0gEdYTa/yJbd0ZyukRrmN7O+j86ffHtuBFY+SM0WwI=;
        b=GTHj6LWA63+xcxZwQbEr7WyYf16sdZSrelfX1nuieyACZmiigF9ky7PcBLaJMfeOLuyiWb
        NPeFM2yEJUipWWsVS9f2tRhdg2dxMkw5W0s7QjOaYlNIUbFBF/C3X6E6WtkOBNzH7p8H5r
        66qu7NGXBVd1FgT+G4QKK0zjg/BW+7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648644181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D0gEdYTa/yJbd0ZyukRrmN7O+j86ffHtuBFY+SM0WwI=;
        b=xWDYqRvNceO3kCyl1p/PLywWkGOugdAlJq0yVDVwTmXkOl3kYZmK/GqTOanis5v7qeKLr3
        zY7RZtu4t6W3WXDg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5DDABA3B9C;
        Wed, 30 Mar 2022 12:43:01 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8405DA061C; Wed, 30 Mar 2022 14:42:56 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        "yukuai (C)" <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 6/9] bfq: Remove pointless bfq_init_rq() calls
Date:   Wed, 30 Mar 2022 14:42:49 +0200
Message-Id: <20220330124255.24581-6-jack@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330123438.32719-1-jack@suse.cz>
References: <20220330123438.32719-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791; h=from:subject; bh=mjvmO64jJM0oJc8VwoSswmN8LpOszo38y6MW0wyqdfg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiRFBI/vYa3lEKQ4OeboocQVXJE+Fp+23HDiwaV1Qe IMcTThKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYkRQSAAKCRCcnaoHP2RA2dBKB/ 9mp8XB4oQmDnsC5abQSPglR6a6qHTl9FT91xItezHd4qKmljznJ8OSahGVdLh96chO4Td6WchmmTjZ 8fyqEesfjRc64as55V+fb3BBEZO2OU6b3OJqgWfQIuIhGAZNCqHiOutWzMAKFpwXYhGRkrV72RCznK zUxNwV3O3TaemKW6ArYtgAMWmOauvAo3ZjoVow4oMn3A3JTgvR4PnWNL0VvavkAimlrhckYsl4Cs23 o1kHgEtLlYlEpLBCH5/vk/sth5wr8XMEZVdpaBhzFoZ4VjkSGQMsP8Pi18oD7JgYVXfxQu8QAbMt79 wrfTsg3UwRBR0aDC7jp2wqnxa/Qzgu
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We call bfq_init_rq() from request merging functions where requests we
get should have already gone through bfq_init_rq() during insert and
anyway we want to do anything only if the request is already tracked by
BFQ. So replace calls to bfq_init_rq() with RQ_BFQQ() instead to simply
skip requests untracked by BFQ. We move bfq_init_rq() call in
bfq_insert_request() a bit earlier to cover request merging and thus
can transfer FIFO position in case of a merge.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 19082e14f3c1..d7cf930b47bb 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2497,8 +2497,6 @@ static int bfq_request_merge(struct request_queue *q, struct request **req,
 	return ELEVATOR_NO_MERGE;
 }
 
-static struct bfq_queue *bfq_init_rq(struct request *rq);
-
 static void bfq_request_merged(struct request_queue *q, struct request *req,
 			       enum elv_merge type)
 {
@@ -2507,7 +2505,7 @@ static void bfq_request_merged(struct request_queue *q, struct request *req,
 	    blk_rq_pos(req) <
 	    blk_rq_pos(container_of(rb_prev(&req->rb_node),
 				    struct request, rb_node))) {
-		struct bfq_queue *bfqq = bfq_init_rq(req);
+		struct bfq_queue *bfqq = RQ_BFQQ(req);
 		struct bfq_data *bfqd;
 		struct request *prev, *next_rq;
 
@@ -2559,8 +2557,8 @@ static void bfq_request_merged(struct request_queue *q, struct request *req,
 static void bfq_requests_merged(struct request_queue *q, struct request *rq,
 				struct request *next)
 {
-	struct bfq_queue *bfqq = bfq_init_rq(rq),
-		*next_bfqq = bfq_init_rq(next);
+	struct bfq_queue *bfqq = RQ_BFQQ(rq),
+		*next_bfqq = RQ_BFQQ(next);
 
 	if (!bfqq)
 		goto remove;
@@ -6129,6 +6127,8 @@ static inline void bfq_update_insert_stats(struct request_queue *q,
 					   unsigned int cmd_flags) {}
 #endif /* CONFIG_BFQ_CGROUP_DEBUG */
 
+static struct bfq_queue *bfq_init_rq(struct request *rq);
+
 static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 			       bool at_head)
 {
@@ -6144,6 +6144,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		bfqg_stats_update_legacy_io(q, rq);
 #endif
 	spin_lock_irq(&bfqd->lock);
+	bfqq = bfq_init_rq(rq);
 	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
 		spin_unlock_irq(&bfqd->lock);
 		blk_mq_free_requests(&free);
@@ -6152,7 +6153,6 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	trace_block_rq_insert(rq);
 
-	bfqq = bfq_init_rq(rq);
 	if (!bfqq || at_head) {
 		if (at_head)
 			list_add(&rq->queuelist, &bfqd->dispatch);
-- 
2.34.1

