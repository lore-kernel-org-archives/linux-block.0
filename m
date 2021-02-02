Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503AAC433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1784064EE1
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhBBFdq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:33:46 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:14051 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbhBBFdK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612243989; x=1643779989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yfp9aj/5CTvO1j61/h0dSyXCmGTMl9jVFfTSlsUW1j4=;
  b=ZDgKPYl+uY2yWQXorDfjuyVooo7emYAa0Tet3rorFBQZ03ZD2nMJLFHw
   P2S++0GtUhNRwsEk8T1XpM5aL785J6aP44eJBokyP7KOU+X8tzKOw6N2q
   FZPdtcxfdq/oS25PeqDDZAaIHmS8EYr+2g577GNNk3mw/8h/6ZLPOskni
   XWxNKndUlG0trKOyYp47G1KW2e/blLu7zzoLafxDRDxdrzIsSZ9TK7Mor
   /feEp4icFOdFTKvm0em4EAqWjaRTFfxGVmUyONFnTe10JphO2O9Wq98jJ
   vOQe/NzIqx+L1GFc65Pdrh/XUzcNxohFU3e0MptQSMj0uJ/phwWFUDqZi
   w==;
IronPort-SDR: ivAZpv4lAeXIZiWtTiApHP36JEnoMcbRz8/4RFTRK7naiDkWydjd1GImSPcTo93N7k1crvBhK9
 eJAOoPbEL0so/g0IKs+hZVbBtVILRr14usu/Z0wr9jZvMg25DkwJzBwOllD4K3jIeAxqtW8gz5
 NHdHbhFpcPEXF4F/zk4o8RIkKTQugmiSI4JlOoEmYGwN4zBBuUqIaDTriuXzE40k9AjYyEUgWT
 ILD0OKyPdPI3blR8JB6ISwtaLzg9Nlhez3T5hwdr5XqV+LqFbaoica30z+F5kv8oUHGtrXBOJG
 A+8=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158884452"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:27:49 +0800
IronPort-SDR: 5WUbJC56h6QoWKIDi1XsDaKH2UslCQ9AiZqnMCDbs/r/pAtgW+W3ytnOgh4SLZSaJjUIlSipD4
 frYaWO3oNINKe0RNK9deGj1t5Lk5E+fKuk4bDiStETOBpjhdGl/PfTKiBjVmbr4vyhRsW3SUHW
 Xe5EJe0e/4hDN2NKZ4rEhj0ZtlgJj3+mFuprg4Ldb1bo4Uuf3no43AmsMndcLKkRsG6DPQrGLu
 GQrhQHEuD5l+z2MuiBRVMeQl49C+n7kiZ1/FV8uRt5tnq94VGjM3rqoKDh7LbeqkZFtfROYy3d
 A0OdV8mPXlnjfo8pcO/zq+Tw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:11:59 -0800
IronPort-SDR: l+64xCsOSMwQxgP1YrzGDQcJfJ6iKzKpbVeao2TwrN2iUL5ev9i26+6SGUXVIBNJatY4jsqVNW
 OPvDIsbrHTd0YaJ5dr686uoPk8o/Lb1mpX10J3pPurZ0w5wBJfs2VcRNFvaaPt9R+FKw2C3bCT
 I8A8pEHQd/W6F4V7i1xoDrWj8ayDkYUJ/RNS/oUnTHr8X/zbZ1nCwpq5SglrNFvXZHcbO9ADU3
 k2cmWD+AV9MkYitju/6G+9yOztcluUG1Ocz7pJdkUvBw5zJxcVPHYoDJPTcm5R9CcvK2IgduFa
 oaI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:27:49 -0800
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
Date:   Mon,  1 Feb 2021 21:25:42 -0800
Message-Id: <20210202052544.4108-14-chaitanya.kulkarni@wdc.com>
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

