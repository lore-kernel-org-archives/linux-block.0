Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA61C49ED7
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 00:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A925A216C8
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 00:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JSar1sGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbfIQAfY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 20:35:24 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:58995 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfIQAfY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 20:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568680521; x=1600216521;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dDesPlwTfRYJsPYxEDQmgHBtvBQy1Z+ScJltpVbUiqw=;
  b=JSar1sGxSy8cNbq5rkM3d9cHDPt8ZoJidtYWs/kXNCxBi6QqNyLVWb7N
   nklGHHOjhdZZkILtoEmCcI4EL7YPeJGkOKX1N0JNQ6CJ3ED2U6SF/Cxqw
   TXJBusoJRVeLKQv5BYvAiyqTbfjGeRChCeuCdpxzybEHOhXmTF3FckYvX
   vf/RbGfybztx7xpyutjKWB0jCbXyjcB0y/CfnSMGMUoN98s/tIOwwmSNg
   3EufzM2uvyf1FzUSMSTiuMDh8GA7gQt4WsqnpD2/QoVtiILBT90Bxa137
   cb30esHG55S0MYfd2rJfNdAFgs700fy6F801/BN0k6VwUYNf7h8tZVh71
   A==;
IronPort-SDR: orTmeoT2fvjWA0HcOp1a6z/L6Ly9d9C6rgml1Udi5kqQud7p2xWDdukY1C9HJJAnqtUf8Kvr9Y
 GKdUQ2dRabBuBkdY8Wy209tChSyDHIMNrlG+KLGlt5Uo33yND4ZecAobP1GSnDBGRXUDchEEgX
 fIzn2pEafisKAPzYT5abVsJwMSEUJsJByaBl/zS012yrrZuT+nn8Cxt/LkQ8UCsjh50e/E+5A/
 89tWft9J7j5OvS689ZAyqUz8CUFGXCVhdHBOcLQz4dxvzMY/nkzqU2e/cZzxfsv5/ANyENGsHy
 B3U=
X-IronPort-AV: E=Sophos;i="5.64,514,1559491200"; 
   d="scan'208";a="225207181"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2019 08:35:21 +0800
IronPort-SDR: KrnrE1YGqS0XhjotXq/d6pHiFev4Vdb50kRLXRdrS/wcwYqu5lcj16/4/jslNSxLkhP+HWRhHd
 PdbcSaEKKgglXXGFmuBqTHEzNlRM258JIZ3YEKYH/UsXkojFOjT7c+w5BLvbtYuHunKfLoAD2B
 H4xbJujQEYQNvNHDOg/7ZViRmligf8N8J29BHQNoGTgdxO0+HJgtoj2XVTXR1Nn5qZalP6iHe0
 ZRnNKtH+zz6ziTqsTyssWMwnlZDSpoEp/4chhyL5OBXfQ1+xLpCdwuc1brKyxgWAphSGkV04mY
 I1X3p0jC/B6ZdRpvmry9Uu7c
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 17:31:58 -0700
IronPort-SDR: lEIey1wfRnBInkbgvZZsYy13E6BOGxGJ4S23ZJpFFv4Wn5CXxqB8B0OyEkNXhc8k6iKnnohOzU
 FlWJLDDBQbmG5ZMYuRIedg7JJ55c5XRE9CWMHIz9Ri7bfXSuu+Cwt1k+T9rOb0TBznOISNPrKx
 JAC/p9doEKCapt529BSUJRC+b/xih1fMQESdB7cnx1TrQStVQ/aGI26TlOz+ZaqxsaAarvWX32
 eOj/HDgiHeczan2AA1MYxmnMZEbbjk29wIDWiOkNJKFZpVwjyqVi7nDePxOAK0It5zS65x+1Es
 5kQ=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Sep 2019 17:35:22 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, osandov@fb.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] block: track per requests type merged count
Date:   Mon, 16 Sep 2019 17:35:18 -0700
Message-Id: <20190917003518.6219-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
per request type:-

READ                    0  
WRITE                   0  
FLUSH                   0  
DISCARD                 0  
SECURE_ERASE            0  
ZONE_RESET              0  
ZONE_RESET_ALL          0  
WRITE_ZEROES            0  
SCSI_IN                 0  
SCSI_OUT                0  
DRV_IN                  0  
DRV_OUT                 0  

This is helpful in the understanding merging of the requests under
different workloads and for the special requests such as discard which
implements request specific merging mechanism.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-mq-debugfs.c | 17 +++++++++++++++--
 block/blk-mq-sched.c   |  2 +-
 block/blk-mq.h         |  2 +-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b3f2ba483992..1e46f2cbf84e 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -679,8 +679,21 @@ static ssize_t ctx_dispatched_write(void *data, const char __user *buf,
 static int ctx_merged_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_ctx *ctx = data;
+	unsigned long *rm = ctx->rq_merged;
+
+	seq_printf(m, "READ             %8lu\n", rm[REQ_OP_READ]);
+	seq_printf(m, "WRITE            %8lu\n", rm[REQ_OP_WRITE]);
+	seq_printf(m, "FLUSH            %8lu\n", rm[REQ_OP_FLUSH]);
+	seq_printf(m, "DISCARD          %8lu\n", rm[REQ_OP_DISCARD]);
+	seq_printf(m, "SECURE_ERASE     %8lu\n", rm[REQ_OP_SECURE_ERASE]);
+	seq_printf(m, "ZONE_RESET       %8lu\n", rm[REQ_OP_ZONE_RESET]);
+	seq_printf(m, "ZONE_RESET_ALL   %8lu\n", rm[REQ_OP_ZONE_RESET_ALL]);
+	seq_printf(m, "WRITE_ZEROES     %8lu\n", rm[REQ_OP_WRITE_ZEROES]);
+	seq_printf(m, "SCSI_IN          %8lu\n", rm[REQ_OP_SCSI_IN]);
+	seq_printf(m, "SCSI_OUT         %8lu\n", rm[REQ_OP_SCSI_OUT]);
+	seq_printf(m, "DRV_IN           %8lu\n", rm[REQ_OP_DRV_IN]);
+	seq_printf(m, "DRV_OUT          %8lu\n", rm[REQ_OP_DRV_OUT]);
 
-	seq_printf(m, "%lu\n", ctx->rq_merged);
 	return 0;
 }
 
@@ -689,7 +702,7 @@ static ssize_t ctx_merged_write(void *data, const char __user *buf,
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

