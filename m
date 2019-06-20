Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D80C43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 18:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A7420665
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 18:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d3+OplwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfFTSb2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:31:28 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35454 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfFTR7n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 13:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561053583; x=1592589583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tkfuDcjVsH4cbJnqt6hs3NIgWxeSUr2uI5ZruO+U66k=;
  b=d3+OplwCcp1mUVOLt8OO5rgih7wXtT4803R17EPoD9dQ2Z3NLbK79Z5Z
   NFc48Qu/oP8Ybki3IuiYDwLZncxvLt3zLBEkl1OIZEdzNqxcb2luqqoPc
   H9Yq5r6MFXCEZ/Waa0B/euUmXB9l4qtVjyDVBs16sII7uOIRmUDR8lCgd
   gvANCOpNZTYF29QI3viDJPO2GTE2LoQ91LkB2C4pn30SikaFieL5xygO4
   kuwwEmPAb70kSoMAMjS46X9QZ8N/Fnr8FF+/lDg0XGj8SazCy3jdKz2Xa
   aDWl4a1FjlqLAxFKsYFr7ZoYF/evXKzmGEh4OCZLH8ec6X2gX50MJpvRU
   w==;
X-IronPort-AV: E=Sophos;i="5.63,397,1557158400"; 
   d="scan'208";a="217443483"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2019 01:59:43 +0800
IronPort-SDR: ZoiLFoQ1pFYKIpQCvJZ0aFAq1G4rw4fK3KLGKtRJgNVGXck2mMyQl55t/9qFOAd8WF2UjoWU7F
 bEfuJCUuemrlrqhcvDbXb4o/TqCZgMmUmFiW8pauFfhyQtEtp6aqvQoWNqxDSDMSYJdR55KG/O
 4tdaunFXwGABZxRB1EO00ZWyZEjPYEFsX8/5mwZbAb5SvZSNb7ktR5JdsigTRBJolv8BY5XuLW
 fgHPoHG8D1UXkRFu49LCxmFO2fuAZ1D3Cc9jMkcpS52Qm0XpcGV6INvRinkluRJoW7LSixhpb4
 QkLE2V9uZ/babzdoUkclXtEN
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 20 Jun 2019 10:59:02 -0700
IronPort-SDR: zgsjiC+jNLq1dOi6AKdwpoIw3ZLFaOSxD9AqhttKGLTEKTxF1XINcU+Njd0zR4o10VmiZSN7zs
 mI4rWAB5ucQ5nTAZLQ1u9w4yLO69Ym58IGgNvFRIHI3uOGLNl4X+F6JQDjnK2dztNSFjrqJeUe
 aWenooipaYQhalSSYtGt8jxrm6vEQiCeq8gDHgKtviI1o95MuLtOSj+KfXoMJ/iKp0bKL7nhoG
 3H5l8RB29XmanSMrT9PZvD6os9WqzVnpZl4pdfZ6ebeKgkaBcawzf4sZj9WV4BjjnORSDECiqC
 CkI=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Jun 2019 10:59:43 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V5 2/5] block: add centralize REQ_OP_XXX to string helper
Date:   Thu, 20 Jun 2019 10:59:16 -0700
Message-Id: <20190620175919.3273-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190620175919.3273-1-chaitanya.kulkarni@wdc.com>
References: <20190620175919.3273-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In order to centralize the REQ_OP_XXX to string conversion which can be
used in the block layer and different places in the kernel like f2fs,
this patch adds a new helper function along with an array similar to the
one present in the blk-mq-debugfs.c.

We keep this helper functionality centralize under blk-core.c instead of
blk-mq-debugfs.c since blk-core.c is configured using CONFIG_BLOCK and
it will not be dependent on blk-mq-debugfs.c which is configured using
CONFIG_BLK_DEBUG_FS.

Next patch adjusts the code in the blk-mq-debugfs.c with newly
introduced helper.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c       | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  3 +++
 2 files changed, 39 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 77623cdf2e5a..190aba04da3e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -120,6 +120,42 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 }
 EXPORT_SYMBOL(blk_rq_init);
 
+#define REQ_OP_NAME(name) [REQ_OP_##name] = #name
+static const char *const blk_op_name[] = {
+	REQ_OP_NAME(READ),
+	REQ_OP_NAME(WRITE),
+	REQ_OP_NAME(FLUSH),
+	REQ_OP_NAME(DISCARD),
+	REQ_OP_NAME(SECURE_ERASE),
+	REQ_OP_NAME(ZONE_RESET),
+	REQ_OP_NAME(WRITE_SAME),
+	REQ_OP_NAME(WRITE_ZEROES),
+	REQ_OP_NAME(SCSI_IN),
+	REQ_OP_NAME(SCSI_OUT),
+	REQ_OP_NAME(DRV_IN),
+	REQ_OP_NAME(DRV_OUT),
+};
+#undef REQ_OP_NAME
+
+/**
+ * blk_op_str - Return string XXX in the REQ_OP_XXX.
+ * @op: REQ_OP_XXX.
+ *
+ * Description: Centralize block layer function to convert REQ_OP_XXX into
+ * string format. Useful in the debugging and tracing bio or request. For
+ * invalid REQ_OP_XXX it returns string "UNKNOWN".
+ */
+inline const char *blk_op_str(unsigned int op)
+{
+	const char *op_str = "UNKNOWN";
+
+	if (op < ARRAY_SIZE(blk_op_name) && blk_op_name[op])
+		op_str = blk_op_name[op];
+
+	return op_str;
+}
+EXPORT_SYMBOL_GPL(blk_op_str);
+
 static const struct {
 	int		errno;
 	const char	*name;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ad49a775c54f..7d52c18b6fe2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -867,6 +867,9 @@ extern void blk_execute_rq(struct request_queue *, struct gendisk *,
 extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
 				  struct request *, int, rq_end_io_fn *);
 
+/* Helper to convert REQ_OP_XXX to its string format XXX */
+extern const char *blk_op_str(unsigned int op);
+
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
 
-- 
2.19.1

