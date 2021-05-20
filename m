Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C93C433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 11:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C6E613AF
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 11:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbhETL3y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 07:29:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:33894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240724AbhETL1D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 07:27:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87DFBAC5B;
        Thu, 20 May 2021 11:25:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 517A81F2C9C; Thu, 20 May 2021 13:25:40 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        <linux-block@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] block: Do not pull requests from the scheduler when we cannot dispatch them
Date:   Thu, 20 May 2021 13:25:28 +0200
Message-Id: <20210520112528.16250-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Provided the device driver does not implement dispatch budget accounting
(which only SCSI does) the loop in __blk_mq_do_dispatch_sched() pulls
requests from the IO scheduler as long as it is willing to give out any.
That defeats scheduling heuristics inside the scheduler by creating
false impression that the device can take more IO when it in fact
cannot.

For example with BFQ IO scheduler on top of virtio-blk device setting
blkio cgroup weight has barely any impact on observed throughput of
async IO because __blk_mq_do_dispatch_sched() always sucks out all the
IO queued in BFQ. BFQ first submits IO from higher weight cgroups but
when that is all dispatched, it will give out IO of lower weight cgroups
as well. And then we have to wait for all this IO to be dispatched to
the disk (which means lot of it actually has to complete) before the
IO scheduler is queried again for dispatching more requests. This
completely destroys any service differentiation.

So grab request tag for a request pulled out of the IO scheduler already
in __blk_mq_do_dispatch_sched() and do not pull any more requests if we
cannot get it because we are unlikely to be able to dispatch it. That
way only single request is going to wait in the dispatch list for some
tag to free.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-mq-sched.c | 12 +++++++++++-
 block/blk-mq.c       |  2 +-
 block/blk-mq.h       |  2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 996a4b2f73aa..714e678f516a 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -168,9 +168,19 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 * in blk_mq_dispatch_rq_list().
 		 */
 		list_add_tail(&rq->queuelist, &rq_list);
+		count++;
 		if (rq->mq_hctx != hctx)
 			multi_hctxs = true;
-	} while (++count < max_dispatch);
+
+		/*
+		 * If we cannot get tag for the request, stop dequeueing
+		 * requests from the IO scheduler. We are unlikely to be able
+		 * to submit them anyway and it creates false impression for
+		 * scheduling heuristics that the device can take more IO.
+		 */
+		if (!blk_mq_get_driver_tag(rq))
+			break;
+	} while (count < max_dispatch);
 
 	if (!count) {
 		if (run_queue)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c86c01bfecdb..bc2cf80d2c3b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1100,7 +1100,7 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
 	return true;
 }
 
-static bool blk_mq_get_driver_tag(struct request *rq)
+bool blk_mq_get_driver_tag(struct request *rq)
 {
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9ce64bc4a6c8..81a775171be7 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -259,6 +259,8 @@ static inline void blk_mq_put_driver_tag(struct request *rq)
 	__blk_mq_put_driver_tag(rq->mq_hctx, rq);
 }
 
+bool blk_mq_get_driver_tag(struct request *rq);
+
 static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 {
 	int cpu;
-- 
2.26.2

