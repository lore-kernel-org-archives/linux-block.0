Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EBEC43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 01:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7762147A
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 01:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfD3Bwp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:52:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbfD3Bwp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Apr 2019 21:52:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A140530024D0;
        Tue, 30 Apr 2019 01:52:44 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9ADC84CE;
        Tue, 30 Apr 2019 01:52:41 +0000 (UTC)
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
Subject: [PATCH V9 1/7] blk-mq: grab .q_usage_counter when queuing request from plug code path
Date:   Tue, 30 Apr 2019 09:52:23 +0800
Message-Id: <20190430015229.23141-2-ming.lei@redhat.com>
In-Reply-To: <20190430015229.23141-1-ming.lei@redhat.com>
References: <20190430015229.23141-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 30 Apr 2019 01:52:44 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just like aio/io_uring, we need to grab 2 refcount for queuing one
request, one is for submission, another is for completion.

If the request isn't queued from plug code path, the refcount grabbed
in generic_make_request() serves for submission. In theroy, this
refcount should have been released after the sumission(async run queue)
is done. blk_freeze_queue() works with blk_sync_queue() together
for avoiding race between cleanup queue and IO submission, given async
run queue activities are canceled because hctx->run_work is scheduled with
the refcount held, so it is fine to not hold the refcount when
running the run queue work function for dispatch IO.

However, if request is staggered into plug list, and finally queued
from plug code path, the refcount in submission side is actually missed.
And we may start to run queue after queue is removed because the queue's
kobject refcount isn't guaranteed to be grabbed in flushing plug list
context, then kernel oops is triggered, see the following race:

blk_mq_flush_plug_list():
        blk_mq_sched_insert_requests()
                insert requests to sw queue or scheduler queue
                blk_mq_run_hw_queue

Because of concurrent run queue, all requests inserted above may be
completed before calling the above blk_mq_run_hw_queue. Then queue can
be freed during the above blk_mq_run_hw_queue().

Fixes the issue by grab .q_usage_counter before calling
blk_mq_sched_insert_requests() in blk_mq_flush_plug_list(). This way is
safe because the queue is absolutely alive before inserting request.

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Tested-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index aa6bc5c02643..c59babca6857 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -413,6 +413,14 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
 				  struct list_head *list, bool run_queue_async)
 {
 	struct elevator_queue *e;
+	struct request_queue *q = hctx->queue;
+
+	/*
+	 * blk_mq_sched_insert_requests() is called from flush plug
+	 * context only, and hold one usage counter to prevent queue
+	 * from being released.
+	 */
+	percpu_ref_get(&q->q_usage_counter);
 
 	e = hctx->queue->elevator;
 	if (e && e->type->ops.insert_requests)
@@ -426,12 +434,14 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
 		if (!hctx->dispatch_busy && !e && !run_queue_async) {
 			blk_mq_try_issue_list_directly(hctx, list);
 			if (list_empty(list))
-				return;
+				goto out;
 		}
 		blk_mq_insert_requests(hctx, ctx, list);
 	}
 
 	blk_mq_run_hw_queue(hctx, run_queue_async);
+ out:
+	percpu_ref_put(&q->q_usage_counter);
 }
 
 static void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
-- 
2.9.5

