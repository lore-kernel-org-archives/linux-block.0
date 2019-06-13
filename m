Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9CFC31E4B
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B3B207E0
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H+G9OtYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbfFMPFe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:05:34 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40858 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732441AbfFMOO0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 10:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560435266; x=1591971266;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1FypgCGtJ65K5XzjTkv2SWzZMurbjJVCpa70W1QwkhQ=;
  b=H+G9OtYJfnvO9rBvi0EdohDB2htUxknWW4+kIL6Oom/wFCk2ZySfVQQo
   YJmTQjdk9PirOkBKJ1CXqqWQrm7P5Db0t5kQ+c15XfSH99DcJfUOF64NP
   8CoASSbw5NCCvqgsBUv5digeIbpOmYx2Gt3/A29etMd1Po7oNn4jsjcCA
   1zhX1wOOL5dwk/s91NCeb1hSkpG3JecPzPOhaL8ycmx114mdR7ASNtZ9x
   2YOSEMP1HtYGYUrkZYpGw09CfZzw7lZlSDxwLZd6QPykz8l39E2DFUR95
   FPS6z2t9aN7uaVykpPGbFk/+vsKGyvQqjA9tohn+pOKUrPmmt5+/2NSwk
   w==;
X-IronPort-AV: E=Sophos;i="5.63,369,1557158400"; 
   d="scan'208";a="111747747"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2019 22:14:23 +0800
IronPort-SDR: Uj+vKLqK7hxHyG/4HTYmjD20hZeVNd+No+34zxIaes7Vrvc9jHSVSfscEK0ivhKMxwmv8++wu/
 IcWwNqoxP38P3rTacHZwgJ87Bv8l+TwFN8fNf+H8mWBMA3EtiG5ux1FbfI15Vz1phn84l7jpqR
 vYkAmxWNdx9/mfPA+tLUwRAqXIhUIlZZaCWSDokHLbbsF/7TZ1XYGuq/Q5rU2hn/g3wv3yUbqA
 9WaLU8TPwlL0qwIsyuyFDB3lhAlmR8GT9sQfELnwA8PZ82ptwx4T+ZSbJnXqZsmr5VcT09kQ3K
 4V2+nVP8Bq8N0V6lUSQaE9ug
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 13 Jun 2019 07:14:07 -0700
IronPort-SDR: KfS3paupNszdW/LYObcjvLbRE00WnJqf6mJiagL1KAWKBbn3bzJ/+H1mrLO0fve1MlS1x7PDbm
 ZYU1BjjaB4hxBjgM7Pwb6OYcSGislbmaIeG3g0MZlp2bue71pXru5Fi7Ve0E97U4VEs8P+5TWM
 RidQNv7sNT2RLPBqJ1+gR9pldSsmLDY2f8A9rw/jZh1FRsIunXvBLae7x6VFSeFk4htv3f75ic
 WU3bTUp9K2Idd/getJ+sIcvB2yZLDW+hbkQc4UZltyAG+ERxL47DE7fxZougzap9X+KuUE/U82
 7r0=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Jun 2019 07:14:23 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] block: use req_op() to maintain consistency
Date:   Thu, 13 Jun 2019 07:14:21 -0700
Message-Id: <20190613141421.2698-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a pure code cleanup patch and doesn't change any functionality.
In block layer to identify the request operation req_op() macro is
used, so change the open coding the req_op() in the blk-mq-debugfs.c.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-mq-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 6aea0ebc3a73..c6c3c4f4128a 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -341,7 +341,7 @@ static const char *blk_mq_rq_state_name(enum mq_rq_state rq_state)
 int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 {
 	const struct blk_mq_ops *const mq_ops = rq->q->mq_ops;
-	const unsigned int op = rq->cmd_flags & REQ_OP_MASK;
+	const unsigned int op = req_op(rq);
 
 	seq_printf(m, "%p {.op=", rq);
 	if (op < ARRAY_SIZE(op_name) && op_name[op])
-- 
2.19.1

