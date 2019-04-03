Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C320C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 10:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A6E2147C
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 10:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfDCK0V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:26:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfDCK0V (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Apr 2019 06:26:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 098C93091747;
        Wed,  3 Apr 2019 10:26:21 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11C21608AA;
        Wed,  3 Apr 2019 10:26:19 +0000 (UTC)
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
Subject: [PATCH V3 1/6] blk-mq: grab .q_usage_counter when queuing request from plug code path
Date:   Wed,  3 Apr 2019 18:26:04 +0800
Message-Id: <20190403102609.18707-2-ming.lei@redhat.com>
In-Reply-To: <20190403102609.18707-1-ming.lei@redhat.com>
References: <20190403102609.18707-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 03 Apr 2019 10:26:21 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just like aio/io_uring, we need to grab 2 refcount for queuing one
request, one is for submission, another is for completion.

If the request isn't queued from plug code path, the refcount grabbed
in generic_make_request() serves for submission. In theroy, this
refcount should have been released after the sumission(async run queue)
is done. But blk_freeze_queue() is working with blk_sync_queue() together
for canceling async run queue work activities if hctx->run_work is scheduled
with holding the refcount.

However, if request is staggered into plug list, and finally queued
from plug code path, the refcount in submission side is actually missed.
And we may start to run queue after queue is removed, then kernel oops
is triggered.

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

