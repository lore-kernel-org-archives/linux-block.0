Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AB2CCA47E
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 16:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345676AbiFOQTO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 12:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354888AbiFOQSR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 12:18:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840AE55485
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 09:16:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DD8721F981;
        Wed, 15 Jun 2022 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655309778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gEBpPJCz8/bsKbGbLSHxdhAcO0Jh7iiRRT/PkSSqJ5Q=;
        b=tPVDlTIIi/CpVRDKJkQBkQCPUV07HVFaknZvwbyQsUy7py+09SYsFpjw+0Tvkd+y7aiWi+
        YkqYH+eL14B8puwKCx+2OFYA8tKKYyBfMusgIz4Es+RFLWC3q5k0RBYzMQVtxcwVUNU4mt
        zAjFJWfEyKiALciUXlTHcjAEyxzorBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655309778;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gEBpPJCz8/bsKbGbLSHxdhAcO0Jh7iiRRT/PkSSqJ5Q=;
        b=qCLBmcaZ0RF+c/QYr6qwbgiBWyHcd1+UqUT1/NxH/YWxcsaFav+DLv+sIRyRWQ2rTOFAac
        QsDxKfRbAjSxxTAg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CA2622C14F;
        Wed, 15 Jun 2022 16:16:18 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EA636A063A; Wed, 15 Jun 2022 18:16:16 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 6/8] blk-ioprio: Convert from rqos policy to direct call
Date:   Wed, 15 Jun 2022 18:16:09 +0200
Message-Id: <20220615161616.5055-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220615160437.5478-1-jack@suse.cz>
References: <20220615160437.5478-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4547; h=from:subject; bh=ECoFLx4eh//cI4rGpxOBBAOY0ZfPr9sTKA2GSSz6C54=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiqgXJf6HOw5oGkoLu+DfDyVmCr1VTk4ceCf2I3wLl aQKq96qJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYqoFyQAKCRCcnaoHP2RA2XWXCA CnUKxaWxIdHhG4B7TP5VjICQtSrFY/1UKDAfMkdqNDOL1d3bySVzhO/r0u2ij5YE2rO+0Lmrc3vFHB aOzoexGxTJxEGxph2oKr4x7WIfODfvQDd2/Ji4SPGGuUM+uQiB0Y4LGNDPh9ZcIr0VavyjuEzqXUv/ NUZYJ7aMlE5L6IKbCCaL9v7GzZ38cYncwtI91xlGyCNd2pa4ywFCrrimE4jBXGUQRTQMB7rN+FWcra 4fpK+rdO+Gp5svChe7lwUDTKqTusm7hmVyzf+JWcmL3S3LE5Fr2vDXKDEJ243a8ncKwu8UIpVAuMqq IbDMDH9KPX9HVIWt52cE56cqTnR3F1
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Convert blk-ioprio handling from a rqos policy to a direct call from
blk_mq_submit_bio(). Firstly, blk-ioprio is not a much of a rqos policy
anyway, it just needs a hook in bio submission path to set the bio's IO
priority. Secondly, the rqos .track hook gets actually called too late
for blk-ioprio purposes and introducing a special rqos hook just for
blk-ioprio looks even weirder.

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

