Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D12C43381
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C31B64EE4
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhBBFdb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:33:31 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:3786 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbhBBFdQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612243995; x=1643779995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yfp9aj/5CTvO1j61/h0dSyXCmGTMl9jVFfTSlsUW1j4=;
  b=fWumtGQIP+mZzl8gkGdFRDgoTtioERjwnXjuXhWNvzgbZLDMrv1a0fYr
   LY0SsK03xktuOQXzhCtSBhH7NYXbPL3voIJ3ApkV9jTzYBoNTiezTqpZH
   2S03pPd+abDzreKDGqAEOi3vO3NHrQq/A05Ufw39b9tgH/akeGzE1xLSi
   nJtj1/glpjsO0jWGTwfawq3Gpoq9symeP8N5JlMgQSrBYTeM0dYPWT7ql
   Hj5RxK7CEqAuulZ00QJ2GptVK/jD5XmuEjl3PKl5w9JI4VPsj8QS1sgd7
   pJa8XWlKPaFi06O7v32/j/eVvKdZNaV+SGt3ickey5MF7lZhRbJiKYXxO
   Q==;
IronPort-SDR: 1NxpUWKbSddQyHOC3R0sjAYJSb2uqlvXFoKsg+IcJIqgVKRh0NYKIV4etcH502QoNWaS9XGhB1
 zBJyvc8rzwEZgBV5OG/7APVYBvWpcoIl3XbhzybvLFfw6vbx27yyVuG2H47M4kD4DRKtlLOBXJ
 +7utu/BVs5+xFDC9g71N/GNyQnC+GD9ZO2NoNyZu+Id1dVfoGRdH7nGUTJlh5foiiasMKS9Xn0
 nVKyuvo99PIkYfGJgRDMP7648yTuBqGGsBaQAKgyhxPg5Xv4MkDT74oAAmM+Co5N4aOMkLu732
 PUg=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="160066376"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:26:36 +0800
IronPort-SDR: /d+0Z9/Gbq1sCc/ynMrBJr3Sk+Mf5GGL6HSpt/OjeW9M1Wsx9yuYKdHgyGcRhppORpdgb+Z3wa
 Z4RmZ4e/UaNa8NLmmlLjS0od1S03t5h1u/oSS6H/ZAWQaxNUFq2FiNskKImpaAnXWExDjdmQNf
 N6ih24CHMee3qwMu0pBknhNQjJGFt8t/7l8vDDL4q8b3lBx/2S3REJlvOpzmYHt6+bq2KIDHYt
 VXyFcNCkqmKDOZqzUVQmfd6aAQHwQW3ty2PDN/IqqwWuVbhDicKPnwi+Uk40MA2yZozQo7DKT2
 pWYoYJ99O354ZYt4aUo3gMLI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:10:45 -0800
IronPort-SDR: W91Ht6lWVMJYIOpMvPjqI5z4yl2vOcmfBWdskU+FV2+JqRX9RqZXUMgcBXqGtmqoGZNsoaEYA8
 /b4WBzXC1aRD304BtFfh+xwFlGXpeWqBFXJ1XAeFCh3MtkmZrwLYLHcv65FFCRlsU3EIrSxdHq
 UNaBZIOBQqjdJfjVkQwUp8VSsZVEA9EAKIy3Qt5wP1DQ7vjftqEM3ZKI3xX+oJn8pg5vIhE5DK
 Lj/klGpwqtnHcmFXJLBBOX2MinRC16BAMq/xW00zw7bBB6sPMBnO1Ca4AkpauELuZKoqOpbPJ1
 14M=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:26:35 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, aravind.ramesh@wdc.com,
        joshi.k@samsung.com, niklas.cassel@wdc.com, hare@suse.de,
        colyli@suse.de, tj@kernel.org, rdunlap@infradead.org, jack@suse.cz,
        hch@lst.de
Subject: [PATCH 5/7] block: get rid of the trace rq insert wrapper
Date:   Mon,  1 Feb 2021 21:25:34 -0800
Message-Id: <20210202052544.4108-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Get rid of the wrapper for trace_block_rq_insert() and call the function
directly.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/bfq-iosched.c     | 4 +++-
 block/blk-mq-sched.c    | 6 ------
 block/blk-mq-sched.h    | 1 -
 block/kyber-iosched.c   | 4 +++-
 block/mq-deadline.c     | 4 +++-
 kernel/trace/blktrace.c | 1 +
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index dfa87e360d71..da5e1f620625 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -125,6 +125,8 @@
 #include <linux/delay.h>
 #include <linux/backing-dev.h>
 
+#include <trace/events/block.h>
+
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
@@ -5621,7 +5623,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	spin_unlock_irq(&bfqd->lock);
 
-	blk_mq_sched_request_inserted(rq);
+	trace_block_rq_insert(rq);
 
 	spin_lock_irq(&bfqd->lock);
 	bfqq = bfq_init_rq(rq);
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index deff4e826e23..ddb65e9e6fd9 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -384,12 +384,6 @@ bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
 
-void blk_mq_sched_request_inserted(struct request *rq)
-{
-	trace_block_rq_insert(rq);
-}
-EXPORT_SYMBOL_GPL(blk_mq_sched_request_inserted);
-
 static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
 				       bool has_sched,
 				       struct request *rq)
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 0476360f05f1..5b18ab915c65 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -7,7 +7,6 @@
 
 void blk_mq_sched_assign_ioc(struct request *rq);
 
-void blk_mq_sched_request_inserted(struct request *rq);
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **merged_request);
 bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index c25c41d0d061..f13da10953bf 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -13,6 +13,8 @@
 #include <linux/module.h>
 #include <linux/sbitmap.h>
 
+#include <trace/events/block.h>
+
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
@@ -602,7 +604,7 @@ static void kyber_insert_requests(struct blk_mq_hw_ctx *hctx,
 			list_move_tail(&rq->queuelist, head);
 		sbitmap_set_bit(&khd->kcq_map[sched_domain],
 				rq->mq_ctx->index_hw[hctx->type]);
-		blk_mq_sched_request_inserted(rq);
+		trace_block_rq_insert(rq);
 		spin_unlock(&kcq->lock);
 	}
 }
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b57470e154c8..f3631a287466 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -18,6 +18,8 @@
 #include <linux/rbtree.h>
 #include <linux/sbitmap.h>
 
+#include <trace/events/block.h>
+
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
@@ -496,7 +498,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	if (blk_mq_sched_try_insert_merge(q, rq))
 		return;
 
-	blk_mq_sched_request_inserted(rq);
+	trace_block_rq_insert(rq);
 
 	if (at_head || blk_rq_is_passthrough(rq)) {
 		if (at_head)
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 1a931afcf5c4..259635217a53 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -852,6 +852,7 @@ static void blk_add_trace_rq_issue(void *ignore, struct request *rq)
 	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_ISSUE,
 			 blk_trace_request_get_cgid(rq));
 }
+EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_insert);
 
 static void blk_add_trace_rq_merge(void *ignore, struct request *rq)
 {
-- 
2.22.1

