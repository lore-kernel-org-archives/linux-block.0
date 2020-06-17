Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651EFC433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 14:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D5B20776
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 14:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgFQODL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:03:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:59274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgFQODK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 10:03:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DF3BBAC2E;
        Wed, 17 Jun 2020 14:03:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 613071E128D; Wed, 17 Jun 2020 16:03:08 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] blktrace: Provide event for request merging
Date:   Wed, 17 Jun 2020 15:58:23 +0200
Message-Id: <20200617135823.980-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently blk-mq does not report any event when two requests get merged
in the elevator. This then results in difficult to understand sequence
of events like:

...
  8,0   34     1579     0.608765271  2718  I  WS 215023504 + 40 [dbench]
  8,0   34     1584     0.609184613  2719  A  WS 215023544 + 56 <- (8,4) 2160568
  8,0   34     1585     0.609184850  2719  Q  WS 215023544 + 56 [dbench]
  8,0   34     1586     0.609188524  2719  G  WS 215023544 + 56 [dbench]
  8,0    3      602     0.609684162   773  D  WS 215023504 + 96 [kworker/3:1H]
  8,0   34     1591     0.609843593     0  C  WS 215023504 + 96 [0]

and you can only guess (after quite some headscratching since the above
excerpt is intermixed with a lot of other IO) that request 215023544+56
got merged to request 215023504+40. Provide proper event for request
merging like we used to do in the legacy block layer.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-merge.c            |  2 ++
 include/trace/events/block.h | 15 +++++++++++++++
 kernel/trace/blktrace.c      | 10 ++++++++++
 3 files changed, 27 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index f0b0bae075a0..9c9fb21584b6 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -793,6 +793,8 @@ static struct request *attempt_merge(struct request_queue *q,
 	 */
 	blk_account_io_merge_request(next);
 
+	trace_block_rq_merge(q, next);
+
 	/*
 	 * ownership of bio passed from next to req, return 'next' for
 	 * the caller to free
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 81b43f5bdf23..b81205560782 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -211,6 +211,21 @@ DEFINE_EVENT(block_rq, block_rq_issue,
 	TP_ARGS(q, rq)
 );
 
+/**
+ * block_rq_merge - merge request with another one in the elevator
+ * @q: queue holding operation
+ * @rq: block IO operation operation request
+ *
+ * Called when block operation request @rq from queue @q is merged to another
+ * request queued in the elevator.
+ */
+DEFINE_EVENT(block_rq, block_rq_merge,
+
+	TP_PROTO(struct request_queue *q, struct request *rq),
+
+	TP_ARGS(q, rq)
+);
+
 /**
  * block_bio_bounce - used bounce buffer when processing block operation
  * @q: queue holding the block operation
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ea47f2084087..41521216d3eb 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -834,6 +834,13 @@ static void blk_add_trace_rq_issue(void *ignore,
 			 blk_trace_request_get_cgid(q, rq));
 }
 
+static void blk_add_trace_rq_merge(void *ignore,
+				   struct request_queue *q, struct request *rq)
+{
+	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_BACKMERGE,
+			 blk_trace_request_get_cgid(q, rq));
+}
+
 static void blk_add_trace_rq_requeue(void *ignore,
 				     struct request_queue *q,
 				     struct request *rq)
@@ -1115,6 +1122,8 @@ static void blk_register_tracepoints(void)
 	WARN_ON(ret);
 	ret = register_trace_block_rq_issue(blk_add_trace_rq_issue, NULL);
 	WARN_ON(ret);
+	ret = register_trace_block_rq_merge(blk_add_trace_rq_merge, NULL);
+	WARN_ON(ret);
 	ret = register_trace_block_rq_requeue(blk_add_trace_rq_requeue, NULL);
 	WARN_ON(ret);
 	ret = register_trace_block_rq_complete(blk_add_trace_rq_complete, NULL);
@@ -1161,6 +1170,7 @@ static void blk_unregister_tracepoints(void)
 	unregister_trace_block_bio_bounce(blk_add_trace_bio_bounce, NULL);
 	unregister_trace_block_rq_complete(blk_add_trace_rq_complete, NULL);
 	unregister_trace_block_rq_requeue(blk_add_trace_rq_requeue, NULL);
+	unregister_trace_block_rq_merge(blk_add_trace_rq_merge, NULL);
 	unregister_trace_block_rq_issue(blk_add_trace_rq_issue, NULL);
 	unregister_trace_block_rq_insert(blk_add_trace_rq_insert, NULL);
 
-- 
2.16.4

