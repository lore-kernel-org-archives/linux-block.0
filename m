Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FF2C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 11:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B77C218D3
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 11:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfDXLDI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:03:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDXLDI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 07:03:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC13430BCE5F;
        Wed, 24 Apr 2019 11:03:07 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0A54600C4;
        Wed, 24 Apr 2019 11:03:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: [PATCH V7 7/9] blk-mq: move cancel of hctx->run_work into blk_mq_hw_sysfs_release
Date:   Wed, 24 Apr 2019 19:02:19 +0800
Message-Id: <20190424110221.17435-8-ming.lei@redhat.com>
In-Reply-To: <20190424110221.17435-1-ming.lei@redhat.com>
References: <20190424110221.17435-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 24 Apr 2019 11:03:07 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hctx is always released after requeue is freed.

With holding queue's kobject refcount, it is safe for driver to run queue,
so one run queue might be scheduled after blk_sync_queue() is done.

So moving the cancel of hctx->run_work into blk_mq_hw_sysfs_release()
for avoiding run released queue.

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Tested-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c     | 8 --------
 block/blk-mq-sysfs.c | 2 ++
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2dd94b3e9ece..f5b5f21ae4fd 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -232,14 +232,6 @@ void blk_sync_queue(struct request_queue *q)
 {
 	del_timer_sync(&q->timeout);
 	cancel_work_sync(&q->timeout_work);
-
-	if (queue_is_mq(q)) {
-		struct blk_mq_hw_ctx *hctx;
-		int i;
-
-		queue_for_each_hw_ctx(q, hctx, i)
-			cancel_delayed_work_sync(&hctx->run_work);
-	}
 }
 EXPORT_SYMBOL(blk_sync_queue);
 
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 4040e62c3737..25c0d0a6a556 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -35,6 +35,8 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
 	struct blk_mq_hw_ctx *hctx = container_of(kobj, struct blk_mq_hw_ctx,
 						  kobj);
 
+	cancel_delayed_work_sync(&hctx->run_work);
+
 	if (hctx->flags & BLK_MQ_F_BLOCKING)
 		cleanup_srcu_struct(hctx->srcu);
 	blk_free_flush_queue(hctx->fq);
-- 
2.9.5

