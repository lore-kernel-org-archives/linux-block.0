Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B99C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 07:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiFWHs6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiFWHsp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 03:48:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EF12CE1E
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:48:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7075F1FD46;
        Thu, 23 Jun 2022 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655970521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jVIcdW2PgX9kFZqpfLo1/VhqYOEzcn49NbnMlqS0quQ=;
        b=xg+M8BljLFOZZb7yrSuymz4qh2EhGIZNiCAL+ozTmhuT3I9geRGIR57CtX0MMrrZJrhrEQ
        kiu1VzHH7grppqlC51J8bcmhYXOnVNMeJQNhIgUVTe1iZqT4RfDUOnxDY/kv3zE52fwKq7
        FtXXSrNCG9dldLSco4miuYo6BLx+kP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655970521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jVIcdW2PgX9kFZqpfLo1/VhqYOEzcn49NbnMlqS0quQ=;
        b=fOgLO2dkR16t4y9mSilot4IKNTI6NyqeYO1IsBg6ZRlwN2Y4BFWWcCCvXhB05ABSBwLT7u
        cR2eyn7nlObobPAg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B69122C16B;
        Thu, 23 Jun 2022 07:48:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DA3E7A063E; Thu, 23 Jun 2022 09:48:40 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 7/9] blk-ioprio: Convert from rqos policy to direct call
Date:   Thu, 23 Jun 2022 09:48:32 +0200
Message-Id: <20220623074840.5960-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220623074450.30550-1-jack@suse.cz>
References: <20220623074450.30550-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4671; h=from:subject; bh=afKJr3K/2dP9j/YLwXorGsPJY4Vd7kLwgJMBSi3SAcg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBitBrPArWTrlmfbi5gA9WW6HELzSuHMzAvpjf7634w wN9LO4SJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrQazwAKCRCcnaoHP2RA2YAxCA C9uyeXrmbeh6RXCW/h9FtXcLrd0NscBBvDgekndaWHudW6LUX0NsWFitKMgb0ck5Vdb/Oux5jWvxCl 9yOH3Uy94AwgoCWcM+q4eU/lGOoTAbobOn0EgwnUZrtzM6TtOimtadEzHgPH14z2iBcjGEwKIWQRyv ScPU2xo9NAP4FhFUImCi6mVBnWrwBNNZcFfzAnvAQ9HcJPU/uz+pcU2wYhCqpwNpxBLSJb1fLa8nxl 4loPby3Uyx81uKPIk0efnaIFsv+NqPEnfSTkLG80/gCilLZ5XynlFJqdXLfQi0M5hpHlXKeVqPORAE kcnqNsUdSp80vR8pBuHzDLaaQTCUxU
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Convert blk-ioprio handling from a rqos policy to a direct call from
blk_mq_submit_bio(). Firstly, blk-ioprio is not much of a rqos policy
anyway, it just needs a hook in bio submission path to set the bio's IO
priority. Secondly, the rqos .track hook gets actually called too late
for blk-ioprio purposes and introducing a special rqos hook just for
blk-ioprio looks even weirder.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-cgroup.c |  1 +
 block/blk-ioprio.c | 50 +++++-----------------------------------------
 block/blk-ioprio.h |  9 +++++++++
 block/blk-mq.c     |  8 ++++++++
 4 files changed, 23 insertions(+), 45 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 764e740b0c0f..6906981563f8 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1299,6 +1299,7 @@ int blkcg_init_queue(struct request_queue *q)
 	ret = blk_iolatency_init(q);
 	if (ret) {
 		blk_throtl_exit(q);
+		blk_ioprio_exit(q);
 		goto err_destroy_all;
 	}
 
diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 3f605583598b..c00060a02c6e 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -181,17 +181,12 @@ static struct blkcg_policy ioprio_policy = {
 	.pd_free_fn	= ioprio_free_pd,
 };
 
-struct blk_ioprio {
-	struct rq_qos rqos;
-};
-
-static void blkcg_ioprio_track(struct rq_qos *rqos, struct request *rq,
-			       struct bio *bio)
+void blkcg_set_ioprio(struct bio *bio)
 {
 	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_bio(bio);
 	u16 prio;
 
-	if (blkcg->prio_policy == POLICY_NO_CHANGE)
+	if (!blkcg || blkcg->prio_policy == POLICY_NO_CHANGE)
 		return;
 
 	/*
@@ -207,49 +202,14 @@ static void blkcg_ioprio_track(struct rq_qos *rqos, struct request *rq,
 		bio->bi_ioprio = prio;
 }
 
-static void blkcg_ioprio_exit(struct rq_qos *rqos)
+void blk_ioprio_exit(struct request_queue *q)
 {
-	struct blk_ioprio *blkioprio_blkg =
-		container_of(rqos, typeof(*blkioprio_blkg), rqos);
-
-	blkcg_deactivate_policy(rqos->q, &ioprio_policy);
-	kfree(blkioprio_blkg);
+	blkcg_deactivate_policy(q, &ioprio_policy);
 }
 
-static struct rq_qos_ops blkcg_ioprio_ops = {
-	.track	= blkcg_ioprio_track,
-	.exit	= blkcg_ioprio_exit,
-};
-
 int blk_ioprio_init(struct request_queue *q)
 {
-	struct blk_ioprio *blkioprio_blkg;
-	struct rq_qos *rqos;
-	int ret;
-
-	blkioprio_blkg = kzalloc(sizeof(*blkioprio_blkg), GFP_KERNEL);
-	if (!blkioprio_blkg)
-		return -ENOMEM;
-
-	ret = blkcg_activate_policy(q, &ioprio_policy);
-	if (ret) {
-		kfree(blkioprio_blkg);
-		return ret;
-	}
-
-	rqos = &blkioprio_blkg->rqos;
-	rqos->id = RQ_QOS_IOPRIO;
-	rqos->ops = &blkcg_ioprio_ops;
-	rqos->q = q;
-
-	/*
-	 * Registering the rq-qos policy after activating the blk-cgroup
-	 * policy guarantees that ioprio_blkcg_from_bio(bio) != NULL in the
-	 * rq-qos callbacks.
-	 */
-	rq_qos_add(q, rqos);
-
-	return 0;
+	return blkcg_activate_policy(q, &ioprio_policy);
 }
 
 static int __init ioprio_init(void)
diff --git a/block/blk-ioprio.h b/block/blk-ioprio.h
index a7785c2f1aea..5a1eb550e178 100644
--- a/block/blk-ioprio.h
+++ b/block/blk-ioprio.h
@@ -6,14 +6,23 @@
 #include <linux/kconfig.h>
 
 struct request_queue;
+struct bio;
 
 #ifdef CONFIG_BLK_CGROUP_IOPRIO
 int blk_ioprio_init(struct request_queue *q);
+void blk_ioprio_exit(struct request_queue *q);
+void blkcg_set_ioprio(struct bio *bio);
 #else
 static inline int blk_ioprio_init(struct request_queue *q)
 {
 	return 0;
 }
+static inline void blk_ioprio_exit(struct request_queue *q)
+{
+}
+static inline void blkcg_set_ioprio(struct bio *bio)
+{
+}
 #endif
 
 #endif /* _BLK_IOPRIO_H_ */
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e9bf950983c7..67a7bfa58b7c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -42,6 +42,7 @@
 #include "blk-stat.h"
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
+#include "blk-ioprio.h"
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 
@@ -2790,6 +2791,11 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	return rq;
 }
 
+static void bio_set_ioprio(struct bio *bio)
+{
+	blkcg_set_ioprio(bio);
+}
+
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
@@ -2830,6 +2836,8 @@ void blk_mq_submit_bio(struct bio *bio)
 
 	trace_block_getrq(bio);
 
+	bio_set_ioprio(bio);
+
 	rq_qos_track(q, rq, bio);
 
 	blk_mq_bio_to_request(rq, bio, nr_segs);
-- 
2.35.3

