Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28534C10F0B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 10:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006EB2147C
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 10:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfDCK0b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:26:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfDCK0b (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Apr 2019 06:26:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74CCC3086203;
        Wed,  3 Apr 2019 10:26:30 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85A601018A38;
        Wed,  3 Apr 2019 10:26:27 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH V3 3/6] blk-mq: free hw queue's resource in hctx's release handler
Date:   Wed,  3 Apr 2019 18:26:06 +0800
Message-Id: <20190403102609.18707-4-ming.lei@redhat.com>
In-Reply-To: <20190403102609.18707-1-ming.lei@redhat.com>
References: <20190403102609.18707-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 03 Apr 2019 10:26:30 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Once blk_cleanup_queue() returns, tags shouldn't be used any more,
because blk_mq_free_tag_set() may be called. Commit 45a9c9d909b2
("blk-mq: Fix a use-after-free") fixes this issue exactly.

However, that commit introduces another issue. Before 45a9c9d909b2,
we are allowed to run queue during cleaning up queue if the queue's
kobj refcount is held. After that commit, queue can't be run during
queue cleaning up, otherwise oops can be triggered easily because
some fields of hctx are freed by blk_mq_free_queue() in blk_cleanup_queue().

We have invented ways for addressing this kind of issue before, such as:

	8dc765d438f1 ("SCSI: fix queue cleanup race before queue initialization is done")
	c2856ae2f315 ("blk-mq: quiesce queue before freeing queue")

But still can't cover all cases, recently James reports another such
kind of issue:

	https://marc.info/?l=linux-scsi&m=155389088124782&w=2

This issue can be quite hard to address by previous way, given
scsi_run_queue() may run requeues for other LUNs.

Fixes the above issue by freeing hctx's resources in its release handler, and this
way is safe becasue tags isn't needed for freeing such hctx resource.

This approach follows typical design pattern wrt. kobject's release handler.

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Cc: jianchao wang <jianchao.w.wang@oracle.com>
Reported-by: James Smart <james.smart@broadcom.com>
Fixes: 45a9c9d909b2 ("blk-mq: Fix a use-after-free")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c     | 2 +-
 block/blk-mq-sysfs.c | 6 ++++++
 block/blk-mq.c       | 8 ++------
 block/blk-mq.h       | 2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6583d67f3e34..20298aa5a77c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -374,7 +374,7 @@ void blk_cleanup_queue(struct request_queue *q)
 	blk_exit_queue(q);
 
 	if (queue_is_mq(q))
-		blk_mq_free_queue(q);
+		blk_mq_exit_queue(q);
 
 	percpu_ref_exit(&q->q_usage_counter);
 
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 3f9c3f4ac44c..4040e62c3737 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -10,6 +10,7 @@
 #include <linux/smp.h>
 
 #include <linux/blk-mq.h>
+#include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
 
@@ -33,6 +34,11 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
 {
 	struct blk_mq_hw_ctx *hctx = container_of(kobj, struct blk_mq_hw_ctx,
 						  kobj);
+
+	if (hctx->flags & BLK_MQ_F_BLOCKING)
+		cleanup_srcu_struct(hctx->srcu);
+	blk_free_flush_queue(hctx->fq);
+	sbitmap_free(&hctx->ctx_map);
 	free_cpumask_var(hctx->cpumask);
 	kfree(hctx->ctxs);
 	kfree(hctx);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b512ba0cb359..afc9912e2e42 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2259,12 +2259,7 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
 
-	if (hctx->flags & BLK_MQ_F_BLOCKING)
-		cleanup_srcu_struct(hctx->srcu);
-
 	blk_mq_remove_cpuhp(hctx);
-	blk_free_flush_queue(hctx->fq);
-	sbitmap_free(&hctx->ctx_map);
 }
 
 static void blk_mq_exit_hw_queues(struct request_queue *q,
@@ -2899,7 +2894,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 }
 EXPORT_SYMBOL(blk_mq_init_allocated_queue);
 
-void blk_mq_free_queue(struct request_queue *q)
+/* tags can _not_ be used after returning from blk_mq_exit_queue */
+void blk_mq_exit_queue(struct request_queue *q)
 {
 	struct blk_mq_tag_set	*set = q->tag_set;
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d704fc7766f4..c421e3a16e36 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -37,7 +37,7 @@ struct blk_mq_ctx {
 	struct kobject		kobj;
 } ____cacheline_aligned_in_smp;
 
-void blk_mq_free_queue(struct request_queue *q);
+void blk_mq_exit_queue(struct request_queue *q);
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
 bool blk_mq_dispatch_rq_list(struct request_queue *, struct list_head *, bool);
-- 
2.9.5

