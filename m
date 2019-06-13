Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EF3C31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375A320B7C
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UZPmMnmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbfFMPFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:05:16 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51275 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732459AbfFMOQl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 10:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560435423; x=1591971423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mGupDbl0fHFGTfmQmhr/DVZ3FbdxDJtk461gnkiVpK0=;
  b=UZPmMnmY+JEfn/dmj8MBaTrKz8/IPBaxtphon9BvFdKfJIrQrr+MTGnK
   +HtvvCMZQyJ0/jgdtzq5J1U2LVpXccOJ4jw6RozAJ5N+cb86GNHRWge73
   AuyzB21lHgMjVarUYmGVvWG/Mqnr98BqzOiUMDkeRy5ld9ReoHGROosiD
   d3KT+vqXojK8z1247iMcy97eEYTWscmqnRK/ifHrD92s7N2wGA7qgAE1V
   v88YUdN05u6nKh+2HPQFzx/2ftdZza7pCgWXpgNl9s/p7cIdpz4vV3mnB
   QBYNSAB5nIKid0ySFAjtMcE6fLurgd0ICXK8cGLIIm8qLlemp5xalYjFO
   w==;
X-IronPort-AV: E=Sophos;i="5.63,369,1557158400"; 
   d="scan'208";a="210177624"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2019 22:17:03 +0800
IronPort-SDR: kbya/j09KJfbd5c5+XnZJAQYZkp0utyzyP2VZ4BLwIYv1M+aQMc6OmRXXEiPNYBDYpqCOA5/WI
 9CLHNMZ12HNSLy2GgymTBrsnhW+KAgDNXQqwVjulEhK/wsLr+KVRj6EnD4iO112B00T1UGSYOt
 kaB0iyvY5lMD5lbGxonsQsvlmSe8M+9DK1rrg4ohDseCdsq8hom5JuBca9r3T+U6gMtJ4CtVY8
 ewNqresCQfaJplM0X8NkWfz/DuLHuTq5389XxmU0bU+I6LhVgWu+aBtKrXeGVPu52lUZ1pi49i
 Z/teqYzzlRNdJ/sSfm8DOnjQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 13 Jun 2019 07:16:24 -0700
IronPort-SDR: cexlRMxtSVAshlTKkdiv/p8D76NQtpnWTC+8T8eydpeg32/vj1vpfOXzQdID73/Qbc2QVU5YbY
 j6gk6T0rkJOWD5RNPWwXTX+npBaGTVjkjilFXV9hqPpbdMkQjDZk8Ou/6Ma+H355OkzNNcSTeb
 rwfza7G7PA3vAA7nWiyuBPX5b22b/AKbqKoEkvP4hHPFXaVbgV1su2LmFtQqGS33UqbLvHfmxM
 pZF1I2GBCdG3uuYCzeS8MaeABeTo3Qhtxwd2dmMmphw6Kggi8PuxEoe8ZZgehkwAVHqFxUm3rL
 mds=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Jun 2019 07:16:40 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, hare@suse.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 2/2] block: add more debug data to print_req_err
Date:   Thu, 13 Jun 2019 07:16:29 -0700
Message-Id: <20190613141629.2893-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190613141629.2893-1-chaitanya.kulkarni@wdc.com>
References: <20190613141629.2893-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds more debug data on the top of the existing
print_req_error() where we enhance the print message with the printing
request operations in string format and other request fields.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d1a227cfb72e..6a8a808309f0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -144,6 +144,32 @@ static const struct {
 	[BLK_STS_IOERR]		= { -EIO,	"I/O" },
 };
 
+#define REQ_OP_NAME(name) [REQ_OP_##name] = #name
+static const char *const op_name[] = {
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
+
+static inline const char *op_str(int op)
+{
+	const char *op_str = "REQ_OP_UNKNOWN";
+
+	if (op < ARRAY_SIZE(op_name) && op_name[op])
+		op_str = op_name[op];
+
+	return op_str;
+}
+
 blk_status_t errno_to_blk_status(int errno)
 {
 	int i;
@@ -176,11 +202,14 @@ static void print_req_error(struct request *req, blk_status_t status,
 		return;
 
 	printk_ratelimited(KERN_ERR
-		"%s: %s error, dev %s, sector %llu op 0x%x flags 0x%x\n",
+		"%s: %s error, dev %s, sector %llu op 0x%x:(%s) flags 0x%x "
+		"phys_seg %u prio class %u\n",
 		caller, blk_errors[idx].name,
 		req->rq_disk ?  req->rq_disk->disk_name : "?",
-		blk_rq_pos(req), req_op(req),
-		req->cmd_flags & ~REQ_OP_MASK);
+		blk_rq_pos(req), req_op(req), op_str(req_op(req)),
+		req->cmd_flags & ~REQ_OP_MASK,
+		req->nr_phys_segments,
+		IOPRIO_PRIO_CLASS(req->ioprio));
 }
 
 static void req_bio_endio(struct request *rq, struct bio *bio,
-- 
2.19.1

