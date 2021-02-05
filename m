Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37AAC433DB
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 03:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F30E64FA3
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 03:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhBEDwe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 22:52:34 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:59516 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhBEDwc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 22:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612497152; x=1644033152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sYaZwm67j1G5Z1/af70UAoZcllAxqQnu7anijwrmnBY=;
  b=Y5yuF/9u4Wt24xbBaycwd6Mn4eN8k52MggOxqqimdUoXXYVteHoV9aXT
   xmkuvqHX/JTHoYCUGFQwSdCMVC5b1MSSoxXB7e5YTJwAaUXn5yjSQEL6f
   uPm5neg1+/BagMe7Ux5MVIowoDicZpttee6UvUrKELwLOOBYUBChkrTYp
   TemZVyQvi6WSEzMc3XfV6e0FNm/fGKvsn4P6w+To4bWgxF5auBIhGh6A5
   gHbU1inuNQLgJIXcp2u0KfHReX1oz261GpNC0uOCUcGxiCOpQezw0lrdF
   WEalWrt7ElrxR0YQ6IpPcCb5jALWLCtfYxGJZqBRKxPiY0kGpTVkBYE9v
   Q==;
IronPort-SDR: eHRV2VMGYMFZPStG5yDQwRE3vcs+44tP2Y+JYDxPBrWDfkLmS3EVwReceDk+iu2t9i2hITkpt5
 nrTP16ODH7vgjaCKSeBvj+sakWDdxQcPPe0jNi/koo2+tl8gFn/K7XdcRmK/uLwm0Tnrmhfw3T
 gd3yywekrih6P8KIBvB9SLkLQaxp7HoSkkaL0P7CWLqTI5C5s8cKs1WTV5Sx0URaEt/cyXOxAn
 +Y7mEMpBzNhjqdI88/jicU19ZOszPsfF9y69wpylqKAvsL7e8DSbBREpoo8tDzrh1CopxHUI46
 pf8=
X-IronPort-AV: E=Sophos;i="5.81,154,1610380800"; 
   d="scan'208";a="160386852"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2021 11:51:26 +0800
IronPort-SDR: Faiy03YVrFyIKWjaAxxHbRA1wgOL62rFjCCUr0ryKW4ffAaYZG8YvKX+6whAi0pxWEBLPNRapy
 BdzBIIga/WKuihWQ1+8DOjY+ZNwnebxVmX9xf96Lpo4P2QaiRESBusltbMJlQOBt/zkEJ9iP/X
 YuBWgr9oKvvaWTxG0GiRmj1wzJCkhUuBPc6z24+E/l2IwjujoPauhmE3dUqZULMF9q/0IiUD7h
 XU1smEcgO3eim5KRzCtf0FnKRXn0k4PnpFfTEmrvEKNatgHRr3h9iN+Z75U+yvEAVV+GzcNn+L
 q1ELejU4Zn8eWjW40jqc+y7H
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 19:35:24 -0800
IronPort-SDR: 4OCN2LYDjgEVxXIUlJwvyKMNng2kxL2bPSLivk53CMZp3ak/Vvb4w3xpk8Loo8fo3VNlyqZji6
 i8fQp27Wi2iBH3d/kFzDOYdvuab76gxrIXDeXowCs4+hg7K6Al+ZFB7YpPwlZuj1LtvT2fvRt7
 g/7bxXvDJJZyUWESXT0rNhjc0GGM2OMdhvlTo/yt9iWXz53uPJn+AIoP0s371u7gSTPpEOJMVH
 F4gQDezdWoO2G7U/uBJw1hNAH/wyW6pfaWf4Pwd5QKNTDST8RDCrs6YhYbnlRKYe8J31fvToz1
 Jfw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 19:51:26 -0800
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
Subject: [PATCH V2 5/5] block: get rid of the trace rq insert wrapper
Date:   Thu,  4 Feb 2021 19:50:44 -0800
Message-Id: <20210205035044.5645-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210205035044.5645-1-chaitanya.kulkarni@wdc.com>
References: <20210205035044.5645-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Get rid of the wrapper for trace_block_rq_insert() and call the function
directly.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-iosched.c   | 4 +++-
 block/blk-core.c      | 1 +
 block/blk-mq-sched.c  | 6 ------
 block/blk-mq-sched.h  | 1 -
 block/kyber-iosched.c | 4 +++-
 block/mq-deadline.c   | 4 +++-
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
diff --git a/block/blk-core.c b/block/blk-core.c
index 5e752840b41a..fc60ff208497 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -59,6 +59,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_complete);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_split);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_unplug);
+EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_insert);
 
 DEFINE_IDA(blk_queue_ida);
 
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
-- 
2.22.1

