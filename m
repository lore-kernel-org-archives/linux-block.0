Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA696C46477
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 07:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DE020665
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 07:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nE5mMTn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfFRHEM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:04:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7915 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRHEL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 03:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560841452; x=1592377452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jcHDm4jZNbyc5j1/ToWU/7RDcyYbgsu6A2aVzgajouY=;
  b=nE5mMTn6N2Xvc22xTizgoe2ml7qGQSvurrOvZn0vg+bpwL5UtTCBm9Qg
   vW8fxG5DgY/0NgDk1dhdmjUjP+C3sdIiq6A4CKKYHB6+F/LxKSkWj0m0P
   adGpOyylTwp/ATyXnD7634knUqMDokQGMnerqjaHxTWvTLCpDkeN6yWG7
   9ftgDdvtPUQo1YdGTnuv0nRrjEx/jcsZeLwjugr040ZZaoy+L11cnIWvK
   ZsWfnbW4dbWAS3PGn0y57faQ0T+S3b49Qyu6e1ETBnGNoiniam/RZ3QQ/
   KYzPnRBqUp/IC79q5Ujh4tod/KDDX5ebkpN+FnZOAgKlzBvX05rU1CH81
   A==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="115733432"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 13:42:39 +0800
IronPort-SDR: G2N1gh+s2t89ytQ6WLnNOV+5YUzMskKQUFuGc8tXDelepIIiwXE2mJ/vZRjDUO1nqIjePcZ/LX
 n8SvVyzvY+ddNYHB9O/n2+/iFxjoBAKBRWCol+xKv695qm3OObGLMa9vBTq64DiwTt1lO/Bo0g
 6d2+gV/qBUK3XQvJRzyaWPV6J9QKWcKof4kp2jY8SBnPzfZLKM1h7ZW/7fpE4S0A/rTzleOxKL
 doyPJ5W8jY/1UopyDwDu0XUqSDLefTtxaBLgk5C0EmjHtYRKHm84J8ehXJACoWdA7A/zerxC9f
 nYia3UoZqCZTq5D09rU0j+aa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 17 Jun 2019 22:42:08 -0700
IronPort-SDR: pHJ5L3YcV0wtQkeSwUTxqGdw7Jj/otOGXWJwv4RKBt0ApOpkUMVHSB7xwb1A/X9PWVw+Xu9z+X
 d/Hk7Beqtyr3yT8gsK7RzxZpTDSCBV+eeumjQikJwkwlK4Rgh8hIrSpIE4h6OBeLyEXCT2OimY
 J8RCDF8nlu0fZOnoZEWASuCuC4QSqA4PXV7pWA1hgupzfr6qupv3khtfLpInJ89/5QCM9D74TI
 SeJE7RKPA7xbnVI5gooIj76MX9ZpyHRU2MAbM41lruRGJsS56qzye+MmjXNzY8OU+v02qCbf/m
 vyw=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2019 22:42:38 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 3/6] block: use blk_op_str() in blk-mq-debugfs.c
Date:   Mon, 17 Jun 2019 22:42:21 -0700
Message-Id: <20190618054224.25985-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
References: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
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

