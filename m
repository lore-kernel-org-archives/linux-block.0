Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA9BC43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 18:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596DF20665
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 18:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T6qqjBc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfFTSbY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:31:24 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35454 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfFTR7s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 13:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561053587; x=1592589587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UIxmCrioBaC0pFlPN4Qnln/402T9GIjVBNu2yOteD8U=;
  b=T6qqjBc2vM6tfJlve9XT74CeG/j/9pY6dQEGMOPvA4TQ8aOk4e1Ul/3t
   NBNZnC83ywsBy8si+fYJwQB2iYezN5122w8R7AWzL7cuPYpdKSOxki66s
   hh3U1wZAO3Ak6vD07smM4q5vHZfU/ScrpwLHgcFtLtXzMxbkYq7WQxDp1
   JKTae0Z3o4LUq8LVYXiuMKOR6IFl/WTgZXAsKnRtMGNFMfI/zhDxP8/hq
   uuxlnNp1F0EcndR50oeLUJALSxVZNiId0HbGroAmYV7fPtAcRETQlH770
   CcVP9oCooq64w2JvFf0/u0F5TSPfVimsUs4ssxXMJANgTXRKTnrYjfM6Y
   A==;
X-IronPort-AV: E=Sophos;i="5.63,397,1557158400"; 
   d="scan'208";a="217443489"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2019 01:59:47 +0800
IronPort-SDR: nSPF8C5eUWn4pXk3tCcmwGgh08LactMcH0T0rE5SgBF/E7m2auJkz/iWq0g1OAZjtzUGoWIibo
 V3p8oOd1WkqMI7tKz/21nPeNW4CKRpeidsDmjwyvBQyhi8MJ5pHomzPcGr7N/78nhcqAp6B6sH
 EaZ2xUI5ZnvA7P1V2ZFcAs5WwUq+8Bf17N/n/KwoT0dZomCTFme19iTyk1puC9jGBxxfbPq3VA
 IdQkRV6Q8wBexNlbpRr0El10q5W3IDWlTzmdrOQg03U9O54IUKNnvCU9V3yuVMunFAa4aahFZS
 LBE+cSLlL2LxXU3U0b1yDBUd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 20 Jun 2019 10:59:06 -0700
IronPort-SDR: x0m3rKhsDcOTIcfjBX2a/YGS6Hpmirl8MY5ikoMbHaJA27SSfyyj1+CR6kxIWfQl5EKKdQWJJ2
 GdIl+duoKwXIijzVZq0qrYvPZK2lxKL2Y++DF3o5URmJFL43uTUXGPD5a2UQq81cq8Z4PZpj6q
 zQfHvZFbtHlflh0WVOPFXKDz17f4r5BZE1SDM55U/A7j0TriwBrzWp39kuVfUo8DNpBE8rEzZZ
 gvV0g3cWBA/OWsUU+Dhz3XUE67rdtljbfTlKxxn4eHH5QTUmE7mnXUPTDK1y5YhAXu1agLwWoD
 Qcg=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Jun 2019 10:59:47 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V5 3/5] block: use blk_op_str() in blk-mq-debugfs.c
Date:   Thu, 20 Jun 2019 10:59:17 -0700
Message-Id: <20190620175919.3273-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190620175919.3273-1-chaitanya.kulkarni@wdc.com>
References: <20190620175919.3273-1-chaitanya.kulkarni@wdc.com>
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

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-mq-debugfs.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index a8376cc06a39..748164f4e8b1 100644
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
 	const unsigned int op = req_op(rq);
+	const char *op_str = blk_op_str(op);
 
 	seq_printf(m, "%p {.op=", rq);
-	if (op < ARRAY_SIZE(op_name) && op_name[op])
-		seq_printf(m, "%s", op_name[op]);
-	else
+	if (strcmp(op_str, "UNKNOWN") == 0)
 		seq_printf(m, "%u", op);
+	else
+		seq_printf(m, "%s", op_str);
 	seq_puts(m, ", .cmd_flags=");
 	blk_flags_show(m, rq->cmd_flags & ~REQ_OP_MASK, cmd_flag_name,
 		       ARRAY_SIZE(cmd_flag_name));
-- 
2.19.1

