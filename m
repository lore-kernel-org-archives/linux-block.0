Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C218C3A589
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 04:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA02233FD
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 04:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q85FeK5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391750AbfHWEp7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 00:45:59 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42048 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389942AbfHWEp6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 00:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566535686; x=1598071686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=zebTP9IMn+hrY1Oa6d1BDNvg/2muaBtnn4zOjwe7pkQ=;
  b=q85FeK5pcDnjoNtSyVGxPcTiG+MLmzFcTDONwdD9GpIiU53cTEXa20e3
   K3rzvHNNqbSIgYPXH8lVyyzHZwvYZu9hxGRXcri04wtfh3XtMyYUJ9YL0
   wMtTBG/PSB6zJEPHwYkB9GHDy2mcgXtGziwxy6Im/quyT6yGaJJ3oR4mr
   j5jAdpBLXQgMZulpB3v/aljQkoROoFPLYS8Bk1Vb4CeilCApdNtFFDF9l
   Nu/uh+73YCJ+WuxnkKvZyTmEmxj9gsc3ImeHZq6Z2c50ClFU5bTdXgstl
   0DNXPv2IKOOUgruhg2GxUAkM4BhCS2dt8BfAxBYXIRtZ0n3HP7bhGYuUW
   Q==;
IronPort-SDR: v44rH2l57GOSvB0AhHyins/lyzmD/bnf/pWkRzfKqpFDBLPSbv1ToUJAKxS9IO9LNd5O2Cd2ap
 HGPltWCn8QPv5sUlDFbKnpzrpTH2rdGeWyLHcYLeiuHOR+p/cDKKBb91lbQY734kiVxS71KWqE
 G97Dk6Bem67X74vIkLu4kmx4XhURocYC37HFF2OACbxYLj6Kds+6N9Mu90lR4Hhg+B01SWp2/9
 AdN1C+NZaXie7eZV0Y0embuOWA5mB10t7xlD3qiNVOCV3/oXWCztpqkHSLR+YYWRNlixDFPdKW
 VAI=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="216934501"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 12:48:05 +0800
IronPort-SDR: CKrsnjn23GxhDmn00PkBOuk9ERZrviik5fWRs0jedQiYdi82Csmnxq7YDOO00qlcOOmZSZ+2tg
 9yWt/5I2MQqJyygPT47/PPpD1qet00uTtWEPTVs9wgdMBbRtQOSd0KWQIjuPl7mOUTRT86O/TS
 +xDTHmv0DqPSyf7gPoQi5wm69LN19zFlxxEWQ+ZAruptU0fpZJp6f14UU3uct6oVulLgL0qa9J
 qrM7Vk7TBmfn81ix9MFTYrz6DuYNnkYdp5lgBpugENOlJT/OdCQQgrGJV3hcKOWUABoeT+Zfsh
 Gr6dRuTaEAnbBIjZ3OJ+DAbZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 21:43:17 -0700
IronPort-SDR: 9sHsjcvYTR2HGRKWNllsHvoqHxCU+77q4FabX4GRMiClesDsP9bj43KIW6aDzpzIUKmHe0PZaJ
 wTYP2aqKCiqGL73iaSwxI3DAuQmU8Y3gRycBaDzOUqEsr/W/o7RT8ckGGBX3Ij4NkBAB0Ax/+8
 Dir0u8KaDabNt8QNY9DcK+HpD1auVz7D5O7vfISYfiefOCOSWreamctsJ5JDg8HGfIRr+EdLM7
 cVHDXzuJH0ebKY62j98v9NeemeTtRa9Isfhuchf9xzzVpYQroMPheipbn+d4CrV+qF6MNVrOEs
 Mwc=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Aug 2019 21:45:58 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 4/6] null_blk: create a helper for mem-backed ops
Date:   Thu, 22 Aug 2019 21:45:17 -0700
Message-Id: <20190823044519.3939-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190823044519.3939-1-chaitanya.kulkarni@wdc.com>
References: <20190823044519.3939-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch creates a helper for handling requests when null_blk is
memory backed in the null_handle_cmd(). Although the helper is very
simple right now, it makes the code flow consistent with the rest of
code in the null_handle_cmd() and provides a uniform code structure
for future code.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index eefaea1aaa45..4299274cccfb 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1168,13 +1168,26 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
 	return BLK_STS_OK;
 }
 
+static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
+						     enum req_opf op)
+{
+	struct nullb_device *dev = cmd->nq->dev;
+	int err;
+
+	if (dev->queue_mode == NULL_Q_BIO)
+		err = null_handle_bio(cmd);
+	else
+		err = null_handle_rq(cmd);
+
+	return errno_to_blk_status(err);
+}
+
 static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 				    sector_t nr_sectors, enum req_opf op)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	struct nullb *nullb = dev->nullb;
 	blk_status_t sts;
-	int err = 0;
 
 	if (test_bit(NULLB_DEV_FL_THROTTLED, &dev->flags)) {
 		sts = null_handle_throttled(cmd);
@@ -1193,14 +1206,8 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 			goto out;
 	}
 
-	if (dev->memory_backed) {
-		if (dev->queue_mode == NULL_Q_BIO)
-			err = null_handle_bio(cmd);
-		else
-			err = null_handle_rq(cmd);
-	}
-
-	cmd->error = errno_to_blk_status(err);
+	if (dev->memory_backed)
+		cmd->error = null_handle_memory_backed(cmd, op);
 
 	if (!cmd->error && dev->zoned) {
 		if (op == REQ_OP_WRITE)
-- 
2.17.0

