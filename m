Return-Path: <SRS0=VMX8=US=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2855CC31E5B
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021D120657
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k5peIfSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfFSRNz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:13:55 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10796 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbfFSRNz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 13:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560964436; x=1592500436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H8J5LM2HZ9hya29SBi1L7Jdn0d5QYTA8HA4pnyfj1Tc=;
  b=k5peIfSxfzjrrYNQBmpQugzQcy1F9uENgzOBkY3TDmfke7xTmPoFj3iq
   3WUIK7GUKGN4T60ssPJ8N2H8tTEkYrtXT16+XOQZZ4SfQ5FSjm7X1g8QD
   6MNDxhCocWiLkcF7J5EuPum9IxTHxEh13gHDyAt69dosbj1daQ5qcwgFM
   6GDE3A805YovpZK6zZZb1mfD8HfdxZ01aGhs6tYA5pFAn2WnjeMjZ3ppx
   cIY5y8PLBcrOs+NJw0Oj0ZZwaRydk5L6VjDyB/hFXcqOud44/A51Tf0yH
   /LYcEUpucfTaf4egL80whnmaOHp8Tt9AXj8hQSpJbOlLnhSukKwQw4qC0
   g==;
X-IronPort-AV: E=Sophos;i="5.63,393,1557158400"; 
   d="scan'208";a="115883803"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2019 01:13:55 +0800
IronPort-SDR: 93XIaITpsnUOoadeBlqKxbDxUlODsx1uQfJfd+boSFCVFOvwbVogIvoK6rSO/FKFHhKEVCJSrq
 DaMqUC1a4OjSyBLlSxcg9ymp20TXswCw7C6Y+4ixTNHkELCu9xNRQKQbQpwMp69KmuPlM63wNy
 BrZC481rLFxwaa29JThPmoh/jSN+/GnraxaCHv7512Dc1qbeqtMgGIBLtFSsSQZsHcCEa1XDRG
 ujrzokYGEvSFk7rZjcIG6G2PnfRJC2VFCUdg3KgLj0u+a64uUs/ZvhUNxtTbfs1ynUDkSC/QDO
 WOECqkO4XKImNhk4vO1jJ3jv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Jun 2019 10:13:21 -0700
IronPort-SDR: 3tETrA0kuJ//P6gZE3SFWrQwnvFw/r4ANdiN/qt2uwRSE5+WuwupzBteup2f/3zGaOarPzEYcJ
 nM2rj/6m43352/zC75Y6PwqD5+WDbQewtUFcMmu0rhDLi+/0lekfIMAU4srpR2LVdoOfXjDVO8
 1VIVGKhLMwzLsJd4ESkOqaL6wWBFq9ydSTyiuQTVHVx8pNZ6yUrn0ZFOZ4p0RNzYbZnGGfIDgT
 9Dql8z9ZwsS7FAonROL1C3B3Q3jWbWyIVNmKaA50ReUXJjZP4mZsXFCF5tJ5MBD9NGCtAV52mL
 TYw=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jun 2019 10:13:54 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 2/5] block: add centralize REQ_OP_XXX to string helper
Date:   Wed, 19 Jun 2019 10:12:59 -0700
Message-Id: <20190619171302.10146-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
References: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
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
index 592669bcc536..077a77a4a91c 100644
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

