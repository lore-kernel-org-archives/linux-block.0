Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1E3C433E0
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E9720781
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yoxa5+ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgF2XoH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:44:07 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29213 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgF2XoG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 19:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593474246; x=1625010246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GiUEElx2QbqINHaUk6iKGLQxFnfSxd4GlrHiez/uEUc=;
  b=Yoxa5+adGIzV4n7VITtzLTxbAOSL+iaFwfWkKJkzKaY1q9xk7AGHDAeY
   vtYmVLTjOUFsl+p9C1dtJUq0YgrFPhMbrDd4Gj8m7IkOPEPkiwLq0QxkD
   bOTc0oE3n5VGKDczYWmo2ImhGoonEuIqJzKxlGKi7karjMM0WAyzivKfw
   fE/R8FYemK6St5bQwI7E0JhYPauVfKc1mZTT0D2hD+R2D5qoppTjEquX5
   Xt4uPvm5QoVY8FRgNGg2snZBTtNgVD0WJZwofkHZB57Jh4H4V07ZIOC07
   pgosc93tPAumAN1nNbVBs96IdqqrWBqUofauZpmgqKJrLy26hGCbzW94I
   g==;
IronPort-SDR: o/4KzG0O6DkaE9NcN+lDJw2707uW6WGDETMrhHogvRi9Tg7IjZrcaHUBNziPgv9N4tGNam4Eok
 3oab6JsO7muCik8jm1xZxF4aKGJARfnca046qJCCKjgOXwNwLFuVYwAqeqk7IawejhpcXoTnNf
 YpMS2QgeizOhmhN2IFxNM9JyED/JUI+BIUlfJ71XUHxeIY01DaQbtrq8JOZWnSDBddZfrc7kMX
 AvWxao4WePp2/sRzle+ML5oxLU0Y+JcY83TJ+66SjTavtB0hYjK8viXNMpixdwO3M9YSApfooN
 J+A=
X-IronPort-AV: E=Sophos;i="5.75,296,1589212800"; 
   d="scan'208";a="141431414"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 07:44:06 +0800
IronPort-SDR: jAwvjdCdFlVL5Ybf3+kKFjif1ZlvN6/NxKuhCsBTaCQpblutUh/3soykVPpMuvLJmdw63UVn6x
 m4YSDTUkDr6g97s0V6mBSN8V1TICubbLk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:32:25 -0700
IronPort-SDR: yn+fTkYzKIONWd/yKRpIXTVlm4kdhQsPPaJj0Ll+2fNjLbgmv5tqXRTu4wtwdEXU91DTXuFxG3
 CVJwlbT8xd2Q==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jun 2020 16:44:05 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, dm-devel@redhat.com
Cc:     jack@suse.czi, rdunlap@infradead.org, sagi@grimberg.me,
        mingo@redhat.com, rostedt@goodmis.org, snitzer@redhat.com,
        agk@redhat.com, axboe@kernel.dk, paolo.valente@linaro.org,
        ming.lei@redhat.com, bvanassche@acm.org, fangguoju@gmail.com,
        colyli@suse.de, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 05/11] block: get rid of the trace rq insert wrapper
Date:   Mon, 29 Jun 2020 16:43:08 -0700
Message-Id: <20200629234314.10509-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Get rid of the wrapper for trace_block_rq_insert() and call the function
directly.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/bfq-iosched.c   | 4 +++-
 block/blk-mq-sched.c  | 6 ------
 block/blk-mq-sched.h  | 1 -
 block/kyber-iosched.c | 4 +++-
 block/mq-deadline.c   | 4 +++-
 5 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 50c8f034c01c..e2b9b700ed34 100644
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
@@ -5507,7 +5509,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	spin_unlock_irq(&bfqd->lock);
 
-	blk_mq_sched_request_inserted(rq);
+	trace_block_rq_insert(rq);
 
 	spin_lock_irq(&bfqd->lock);
 	bfqq = bfq_init_rq(rq);
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index a3cade16ef80..20b6a59fbd5a 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -407,12 +407,6 @@ bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq)
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
index 126021fc3a11..04c40c695bf0 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -10,7 +10,6 @@ void blk_mq_sched_free_hctx_data(struct request_queue *q,
 
 void blk_mq_sched_assign_ioc(struct request *rq);
 
-void blk_mq_sched_request_inserted(struct request *rq);
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **merged_request);
 bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index a38c5ab103d1..e42d78deee90 100644
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
2.26.0

