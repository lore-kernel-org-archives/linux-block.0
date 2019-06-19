Return-Path: <SRS0=VMX8=US=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D9FC31E5B
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E72620665
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gdj5k7nP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfFSRN6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:13:58 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10796 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbfFSRN6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 13:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560964439; x=1592500439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jcHDm4jZNbyc5j1/ToWU/7RDcyYbgsu6A2aVzgajouY=;
  b=gdj5k7nPcYAKRQbiyzYitKaBozQQ67MF8jZq6mNq7ZvaqiLIOB7666O5
   LY5y6eQc59FOxPiMDc1NMxknZj4fN5WjjLnuEPre5srtUaYt7enPJmbkt
   EMdZNUSHEiDo+SnFbmgRSWchDKQZzNoOBs2Oirvo9k2yCAZ4rCp8855ko
   pxWB/IxfUZTrL7sA32Mt3i4EnagDyUfxL5u6DIlfMyrZIrwOMrGek3RJS
   g1sJhg+7jLevzyHHe60bg8ze2SvGvWs3zW0uqutnixohlLCISVxW1mwca
   dHQRpjFn4zENAGkNI5A9g2oz9A9dRcg6T6yrdJyMHqXjWxBGtI1HP+poy
   A==;
X-IronPort-AV: E=Sophos;i="5.63,393,1557158400"; 
   d="scan'208";a="115883808"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2019 01:13:59 +0800
IronPort-SDR: Wq9034o6fOwq4iKuMnalD3P0zPkzaGglXan/NUJ1F74kjWA22JA4IXZGEwZBFIsaLUeeHrWvXk
 R0ZVPzEke5VPqZE3QRkSxj3TaSukHB/uxpk1Xfzk9Yd43b/pvZ3YtrpVzOcRX4iLE65+ts0zxH
 YzNazZ4uDsrskb2wdjGI3A0U4D3sviL6JxdDIQZVN8CG8tn2fZFI4sUga3gxvS6VJf3GgUgugj
 g7bxRmMVLGV15SQrmSmxJ56Esja1jiffabs/XH5ISYnCewn5XViXJQqb2ikrzM9eNNpCXCz++O
 8L+qCBLAQCZ1kPbv/W9ouT+s
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Jun 2019 10:13:24 -0700
IronPort-SDR: Qcd3GWDurLD8gepWwSeMYauJXGJmFVFAOOi5aFUMpw4y+HqS37JtcAEIlyqYwdat0KB0noWJp/
 cbouGxYfRY1UU0qoYRulzNpOXGAIKx96JwzqP7ZPO5JnKK3tkyqcZd9NgVPNYLsuIJhhU0GkIv
 wc54tg9/WgCFtz3XRkjcWila565O33Enn20V/4YUusaGn6fwWTd0LqQB81tiuxMHVXmUV/SriX
 iercuUaffG4rr4s5k6ct+QzcxCfPVpNErnh2bVWDXW2+06Rpu7/YJO6EnqbW9XfV2Sbi8JReF8
 68Q=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jun 2019 10:13:57 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 3/5] block: use blk_op_str() in blk-mq-debugfs.c
Date:   Wed, 19 Jun 2019 10:13:00 -0700
Message-Id: <20190619171302.10146-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
References: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that we've a helper function blk_op_str() to convert the
REQ_OP_XXX to string XXX, adjust the code to use that. Get rid of
the duplicate array op_name which is now present in the blk-core.c
which we renamed it to "blk_op_name" and open coding in the
blk-mq-debugfs.c.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-mq-debugfs.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index f0550be60824..68b602d4d1b8 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -261,23 +261,6 @@ static int hctx_flags_show(void *data, struct seq_file *m)
 	return 0;
 }
 
-#define REQ_OP_NAME(name) [REQ_OP_##name] = #name
-static const char *const op_name[] = {
-	REQ_OP_NAME(READ),
-	REQ_OP_NAME(WRITE),
-	REQ_OP_NAME(FLUSH),
-	REQ_OP_NAME(DISCARD),
-	REQ_OP_NAME(SECURE_ERASE),
-	REQ_OP_NAME(ZONE_RESET),
-	REQ_OP_NAME(WRITE_SAME),
-	REQ_OP_NAME(WRITE_ZEROES),
-	REQ_OP_NAME(SCSI_IN),
-	REQ_OP_NAME(SCSI_OUT),
-	REQ_OP_NAME(DRV_IN),
-	REQ_OP_NAME(DRV_OUT),
-};
-#undef REQ_OP_NAME
-
 #define CMD_FLAG_NAME(name) [__REQ_##name] = #name
 static const char *const cmd_flag_name[] = {
 	CMD_FLAG_NAME(FAILFAST_DEV),
@@ -342,12 +325,13 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 {
 	const struct blk_mq_ops *const mq_ops = rq->q->mq_ops;
 	const unsigned int op = rq->cmd_flags & REQ_OP_MASK;
+	const char *op_str = blk_op_str(op);
 
 	seq_printf(m, "%p {.op=", rq);
-	if (op < ARRAY_SIZE(op_name) && op_name[op])
-		seq_printf(m, "%s", op_name[op]);
-	else
+	if (strcmp(op_str, "UNKNOWN") == 0)
 		seq_printf(m, "%d", op);
+	else
+		seq_printf(m, "%s", op_str);
 	seq_puts(m, ", .cmd_flags=");
 	blk_flags_show(m, rq->cmd_flags & ~REQ_OP_MASK, cmd_flag_name,
 		       ARRAY_SIZE(cmd_flag_name));
-- 
2.19.1

