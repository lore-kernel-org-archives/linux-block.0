Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70BDC4CEC9
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 00:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8868021873
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 00:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FuswSBjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfIRAzd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 20:55:33 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5292 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfIRAzc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 20:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568768132; x=1600304132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=OEmP9GaXJcQVa8bzGETy7pVcgw5kRv1rp3o00EY/jII=;
  b=FuswSBjrPFP0qL5ylfh/9KBhGPwS6R75f63JT7qDUvCfebzw4Vbnu+52
   2hdLA9uqiXeloiajlBhOay6h8tHsPf9lqa61/Jl1TyIzgD2E0BinrSpC6
   rLxPgYH0L6PvlmVyKsPV2hHVnBwRbL/sjUDFe4POJ2MBDzNWlIFUNOz14
   0YYtwiSm9jDn/uv1WeCdjyiVdEc6+avWRAYIeIbOqHTAUX9XWQRmoHrQX
   tLppUtQqGrLETf/eaY2k4L/YCPw5f+TsUGkp2i1CyHt3cHGWU2IrTvz29
   Z8w/I9R60cTkSNyKWp5Y950P5SHO6/kBNtJNXIeq6usDDRjfaJFVWb/Vp
   A==;
IronPort-SDR: ZdJgBuAhC5JggPCZgkM5lSGd9MIWH+Ujq1FlcIcTM1dHhfktS3g3H4vConcJUscXcj5WB5qfhh
 JEgnX/rfPI7VktpSdsSXw2R/985s31M6mlxCjZIN9QmWydEVafT12SGNolrYTAYmFzOXn4L/Be
 67SnZIRIwEktC+/5KODqp6LjmUUXwVR3pS+D0jkhMSCKsNGTkmMOR1AwO2SZG0qdQOVMApKqP1
 Cxce7I9EtV3mx2kqqMsoti2wgmSPYjXclnRG39QJ0fOuo2QfB5E6jEMThNf8jbeo+Pirt5HrUM
 k4I=
X-IronPort-AV: E=Sophos;i="5.64,518,1559491200"; 
   d="scan'208";a="118486241"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2019 08:55:32 +0800
IronPort-SDR: lqiKFWCPnsKXxnazuMKX1sWtQ9slzuZci7/5noWHRWdSNU0GGpInQITlANVN2abqrGk303DuMt
 9hA6aKjojsqxYpMf3pt3axNEuweKxIj7tkwTxM/eXwfLvhHFlXGYiXsuwwpkLsG7cdDpjFyWpD
 LokbITjXUy7g59QkAm0y2TX/77Ae7ytyMg89ccedU8EWglxZeZvPB6IrTJUzpnR2K+Vzwh+g+d
 rmzNlqyuZ47/8wouoiKuzpDWXdCDZ7cLoZ8oY3zUTgURQZ5GzN3Vqpjdmjn8wIGGqD2oVidt6Q
 VDFGniwkudHBTRP28j2rfd4E
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 17:52:02 -0700
IronPort-SDR: C1q6kF3qhlEn9rPK7G13UeRGaO4gxPpDFUx2WaIp7mQ5u+f6Ic7ciYLzA5rUohtIaIZTC/xHRZ
 IBDIm2SmGHcOw1fXaSBx2YE4mTF/x6YOJjsDiHXR4DLlNry4bF+gbwOyD5tiEf2QAUzcM7QjN2
 zkm8QUg4oVQFiyMtEU/vtXtrYyeHJPgJQ+ylt253IbuwozXGT7HP8MjGa3c5vH/VqiSaPjMcV3
 qs+tK2hJjIzdeTxdSxxLb7AwveNNVBneflHVfO3ClXbI0cxtW3DcmDhE4Dm5kxKW/fPhmonKHb
 MOc=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Sep 2019 17:55:32 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, osandov@fb.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 2/2] block: track per requests type merged count
Date:   Tue, 17 Sep 2019 17:54:54 -0700
Message-Id: <20190918005454.6872-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190918005454.6872-1-chaitanya.kulkarni@wdc.com>
References: <20190918005454.6872-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With current debugfs block layer infrastructure, we only get the total
merge count which includes all the requests types, but we don't get
the per request type merge count.

This patch replaces the rq_merged variable into the rq_merged array
so that we can track the per request type merged stats.

Instead of having one number for all the requests which are merged,
with this patch we can get the detailed number of the merged requests
per request type which is mergeable.

This is helpful in the understanding merging of the requests under
different workloads and for the special requests such as discard which
implements request specific merging mechanism.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-mq-debugfs.c | 12 ++++++++++--
 block/blk-mq-sched.c   |  2 +-
 block/blk-mq.h         |  2 +-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b3f2ba483992..6eb7ac9c6a02 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -679,8 +679,16 @@ static ssize_t ctx_dispatched_write(void *data, const char __user *buf,
 static int ctx_merged_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_ctx *ctx = data;
+	unsigned long *rm = ctx->rq_merged;
+	unsigned int i;
 
-	seq_printf(m, "%lu\n", ctx->rq_merged);
+	for (i = 0; i < REQ_OP_LAST; i++) {
+		const char *op_str = blk_op_str(i);
+
+		if (!rq_mergeable_op(i) || strcmp(op_str, "UNKNOWN") == 0)
+			continue;
+		seq_printf(m, "%-20s    %8lu\n", op_str, rm[i]);
+	}
 	return 0;
 }
 
@@ -689,7 +697,7 @@ static ssize_t ctx_merged_write(void *data, const char __user *buf,
 {
 	struct blk_mq_ctx *ctx = data;
 
-	ctx->rq_merged = 0;
+	memset(ctx->rq_merged, 0, sizeof(ctx->rq_merged));
 	return count;
 }
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index c9d183d6c499..664f8a056e96 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -314,7 +314,7 @@ static bool blk_mq_attempt_merge(struct request_queue *q,
 	lockdep_assert_held(&ctx->lock);
 
 	if (blk_mq_bio_list_merge(q, &ctx->rq_lists[type], bio, nr_segs)) {
-		ctx->rq_merged++;
+		ctx->rq_merged[bio_op(bio)]++;
 		return true;
 	}
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 32c62c64e6c2..d485dde6e090 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -27,7 +27,7 @@ struct blk_mq_ctx {
 
 	/* incremented at dispatch time */
 	unsigned long		rq_dispatched[2];
-	unsigned long		rq_merged;
+	unsigned long		rq_merged[REQ_OP_LAST];
 
 	/* incremented at completion time */
 	unsigned long		____cacheline_aligned_in_smp rq_completed[2];
-- 
2.17.0

