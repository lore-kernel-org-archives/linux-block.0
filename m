Return-Path: <SRS0=iV0P=SO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B702CC10F0E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 03:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9113B20675
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 03:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfDLDar (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:30:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfDLDar (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 23:30:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 54F4858E4E;
        Fri, 12 Apr 2019 03:30:47 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 574351001DED;
        Fri, 12 Apr 2019 03:30:44 +0000 (UTC)
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
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: [PATCH V5 1/9] blk-mq: grab .q_usage_counter when queuing request from plug code path
Date:   Fri, 12 Apr 2019 11:30:24 +0800
Message-Id: <20190412033032.10418-2-ming.lei@redhat.com>
In-Reply-To: <20190412033032.10418-1-ming.lei@redhat.com>
References: <20190412033032.10418-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 12 Apr 2019 03:30:47 +0000 (UTC)
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
Cc: jianchao wang <jianchao.w.wang@oracle.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ff3d7b49969..5b586affee09 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1728,9 +1728,12 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		if (rq->mq_hctx != this_hctx || rq->mq_ctx != this_ctx) {
 			if (this_hctx) {
 				trace_block_unplug(this_q, depth, !from_schedule);
+
+				percpu_ref_get(&this_q->q_usage_counter);
 				blk_mq_sched_insert_requests(this_hctx, this_ctx,
 								&rq_list,
 								from_schedule);
+				percpu_ref_put(&this_q->q_usage_counter);
 			}
 
 			this_q = rq->q;
@@ -1749,8 +1752,11 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	 */
 	if (this_hctx) {
 		trace_block_unplug(this_q, depth, !from_schedule);
+
+		percpu_ref_get(&this_q->q_usage_counter);
 		blk_mq_sched_insert_requests(this_hctx, this_ctx, &rq_list,
 						from_schedule);
+		percpu_ref_put(&this_q->q_usage_counter);
 	}
 }
 
-- 
2.9.5

