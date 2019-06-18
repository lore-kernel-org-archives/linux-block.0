Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F147C31E5D
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 07:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2849920673
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 07:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VLaXN9c+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfFRHEL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:04:11 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7917 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfFRHEL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 03:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560841451; x=1592377451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2x8H+F+wWnz/8z9MIEDVkVlyQPehgZ4esjqKHNd3FQA=;
  b=VLaXN9c+7+cm5EoV5i1y5BtZ6ETJnCgo32vkpyg6mjmZruTTaRLmXbKI
   F+GAY1udlfj2M4rvQOtQNHQ1Jo92cyz6HH4fF9b6APtwRp3a4HXFQR5a8
   LFkhBWtDQZoST+1v6bMBvR60hehim09IUMqIgbhEGyzlg/sx/vrqZtF4X
   vltJ3Gdis7QxbIBiuDpvKjP9vFmGX9bWyfSbXwQh//xEATakNyDUSypBs
   K7SXXfmOmVMmKbTsUcxjNQueAgHo+ipHXdDytmtUGwN5NKtK6ft0Qe8Fa
   hgj0uqIuagIwLZlJBGhNQf1IKnkUC+0ZlmlmX+I0788MrhEXubqkgWdiP
   w==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="115733428"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 13:42:34 +0800
IronPort-SDR: JSwhdaQtP/Ru9kbShkQ21WGP+b/IcM2clvSv7s3DOStixdyBejd6ngaS3MT/RievUyd1v3gJ6w
 MByht2G1tnh5mxEFrcunNdso1YbOHfy/Ns8Dw7dClKICm2iR2PYad9dv2HnFb/kMEADvKJpMrt
 Q8NPLsomac4i/jpUVl9//SWFbTP8gZHJuOlz9U3bGrRfAn99PdHU1Go9P8qLB+afbvF+bxJdIU
 L6wVnSevPFtDAkS3XhdA+CiE9vRoOohCWunyU44naxIwustyUo3Ce6dNDMraS+NnWkAshYg6aP
 RyJ0nVTD+N0hkNB8u6VM7xgf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 17 Jun 2019 22:42:04 -0700
IronPort-SDR: /8xoOnj+ple2vDEd5ED/SFyMWOjFvxkICOQ8pT3Qyoyc6zUIxWgXxV2WOlAYhT9SqAo1omOLl4
 zEKbxBbm5M+wV2pQEs1LiyKS/6HBLkt9uCmWyWx2yhLVQIiZUWvpnIYqrAwOGmm26Cf0EG38cH
 in6FqPfzU+tewK7RgOGYhofIw6UntdafqPkvrTQ4kp0yT1kfKtZ32gAlzpwu57kz5qYzhNHJlo
 306lrnl+5zvYzew3ti0IAJQ8iZ5CRO6Ou7GsgJnHTRsFEEYyonZ6CbfkFJ1w/UfJLYBz6hYuV/
 mZY=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2019 22:42:34 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 2/6] block: add centralize REQ_OP_XXX to string helper
Date:   Mon, 17 Jun 2019 22:42:20 -0700
Message-Id: <20190618054224.25985-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
References: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
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
CONFIG_BLK_DEBUG_FS which can be disabled when block layer debugging
is not needed by the user.

Next patch adjusts the code in the blk-mq-debugfs.c with newly
introduced helper.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c       | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  3 +++
 2 files changed, 39 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6753231b529b..c92b5a16a27a 100644
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
+inline const char *blk_op_str(int op)
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
index 592669bcc536..077a77a4a91c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -867,6 +867,9 @@ extern void blk_execute_rq(struct request_queue *, struct gendisk *,
 extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
 				  struct request *, int, rq_end_io_fn *);
 
+/* Helper to convert REQ_OP_XXX to its string format XXX */
+extern const char *blk_op_str(int op);
+
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
 
-- 
2.19.1

