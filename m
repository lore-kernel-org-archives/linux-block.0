Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0D8C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 01:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF7E2147A
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 01:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfD3Bwu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:52:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbfD3Bwu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Apr 2019 21:52:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B051308621B;
        Tue, 30 Apr 2019 01:52:50 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F38C70461;
        Tue, 30 Apr 2019 01:52:47 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: [PATCH V9 2/7] blk-mq: move cancel of requeue_work into blk_mq_release
Date:   Tue, 30 Apr 2019 09:52:24 +0800
Message-Id: <20190430015229.23141-3-ming.lei@redhat.com>
In-Reply-To: <20190430015229.23141-1-ming.lei@redhat.com>
References: <20190430015229.23141-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 30 Apr 2019 01:52:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With holding queue's kobject refcount, it is safe for driver
to schedule requeue. However, blk_mq_kick_requeue_list() may
be called after blk_sync_queue() is done because of concurrent
requeue activities, then requeue work may not be completed when
freeing queue, and kernel oops is triggered.

So moving the cancel of requeue_work into blk_mq_release() for
avoiding race between requeue and freeing queue.

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 1 -
 block/blk-mq.c   | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a55389ba8779..93dc588fabe2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -237,7 +237,6 @@ void blk_sync_queue(struct request_queue *q)
 		struct blk_mq_hw_ctx *hctx;
 		int i;
 
-		cancel_delayed_work_sync(&q->requeue_work);
 		queue_for_each_hw_ctx(q, hctx, i)
 			cancel_delayed_work_sync(&hctx->run_work);
 	}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index fc60ed7e940e..89781309a108 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2634,6 +2634,8 @@ void blk_mq_release(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 
+	cancel_delayed_work_sync(&q->requeue_work);
+
 	/* hctx kobj stays in hctx */
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx)
-- 
2.9.5

