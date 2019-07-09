Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C841C73C46
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 19:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1BC2073D
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 19:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZOZpfIp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfGITVz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:21:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:64981 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGITVy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 15:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562700114; x=1594236114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=qXxaN3EnOKWt+mVXH2Ti5lEftO4p56AMv4vb1RapLbM=;
  b=ZOZpfIp7sXVlqMfUg1p2p5En5j0KOfTJXUfY+Uf8npWMzA96WmYQ148U
   sSQW25c+8sT6O1n9X63CnFwPqmRb3YwMkfSNKLMl4mUGb/fgjFpOwZvI6
   ruf7N1xhB0U0HxnH7CFlYFXjExvwZ7R2Musij3Oj+EFFkGFJLcTEMVmiY
   XgXgMzqrWhnr9t0uRDWtW+odiveEnoS4/PEAqNmkvfwuc+GPZWtcHLhUF
   te2pchg33P1bt3bnxigyepo2MHonl2h/oMHYfIRdtPZInFvqbWKVMjhpN
   PXFNbVw9g7QmwiCOWx0jWuoUn/dDmw5ct2kkVal6lZRBXVvPbAHjfM1FK
   A==;
IronPort-SDR: Nnb6mH+gPNN8pWC0JVq8DHP1QZIL4gh8tPn3sp385DVn809tfSmtfQCo4rpKoLTITrDJFybQEx
 FTC3WXLEvJZXXuLQHrBE3ydG4mS2T+b0IPFe6cTqe9q5W0ac6POT17LbKZjrqR9fVplBfr8DJ8
 rqxi4+jSLWBFD1xLQD6COQzW9lYQQYsshwl40t4rS4s0q8AuptFsR3TEtER9k4ebKp8Xvm7avT
 BhC4Ekqz41EptPSB733c3H+XdUJFV048DWpW81vNw6cRxEz3xjPMQDyf5WKzW5Kzce6NMEO1fG
 ETM=
X-IronPort-AV: E=Sophos;i="5.63,471,1557158400"; 
   d="scan'208";a="218988593"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 03:21:54 +0800
IronPort-SDR: cE6ZdB2y9pY1fFR/ESmhFAZEXiIH1bWspuBeqy9Sr+bHFkNEb7tD+Gh0XG05bPu265mxJGPRST
 VWHMrXQQYpozongJ5wF0RkD+bdGK6j7knuH8xtn2TxmzRSra7n3pdrqYXMd27t5UTWQ1F2Cqu/
 4mX1bDkrveJniHSZMMrPWEKWNrfE8S7V5ELGM4zJ2Ph06brrXuCfldwBEjgJvgu9pIcGgFialV
 sUbEL1Y/lU3ZjmAMeUMikYmBWy9uiFwI6XryspC4Vc/MKCHqHo0z4+B+LInqDv8NQDCRud3TBV
 fsKXfErfGVJH2gBc3LO5U1lW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 09 Jul 2019 12:20:40 -0700
IronPort-SDR: cpPWiYVd9DeURlfFXUIgrvPznauuXn/2DqSeyanRG8SIqBHmtPeHW4B+V8ctcHeeEPI6I6yMlV
 LkPrPqtO2tn+BEUUyiCtknSHdb57L0g1OrEx1XTKRgmKERzfcNYYzyr11MKUD7oOCc5QGSwWav
 KeSRIGUQ3Qvhzp02ZZ/wNTVzAwpeRbGPV+lAbthwqvVPrJNRhxxg+eG3zn34WCH7YHFlc+NMzf
 1TxxC60f39TLJc12nHL6MaBSYFCPsdy0ARsdU3u+PsbDWcYlUbkMNSHsRGCf4FE0gK17GZcQlS
 T7k=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2019 12:21:54 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 3/6] null_blk: create a helper for badblocks
Date:   Tue,  9 Jul 2019 12:21:29 -0700
Message-Id: <20190709192132.24723-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190709192132.24723-1-chaitanya.kulkarni@wdc.com>
References: <20190709192132.24723-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch creates a helper for handling badblocks code in the
null_handle_cmd().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 4447c9729827..51ddd8d3a6ff 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1154,6 +1154,20 @@ static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
 	return sts;
 }
 
+static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
+						 sector_t sector,
+						 sector_t nr_sectors)
+{
+	struct badblocks *bb = &cmd->nq->dev->badblocks;
+	sector_t first_bad;
+	int bad_sectors;
+
+	if (badblocks_check(bb, sector, nr_sectors, &first_bad, &bad_sectors))
+		return BLK_STS_IOERR;
+
+	return BLK_STS_OK;
+}
+
 static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 				    sector_t nr_sectors, enum req_opf op)
 {
@@ -1172,15 +1186,11 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 		cmd->error = errno_to_blk_status(null_handle_flush(nullb));
 		goto out;
 	}
-	if (nullb->dev->badblocks.shift != -1) {
-		int bad_sectors;
-		sector_t first_bad;
 
-		if (badblocks_check(&nullb->dev->badblocks, sector, nr_sectors,
-				&first_bad, &bad_sectors)) {
-			cmd->error = BLK_STS_IOERR;
+	if (nullb->dev->badblocks.shift != -1) {
+		cmd->error = null_handle_badblocks(cmd, sector, nr_sectors);
+		if (cmd->error != BLK_STS_OK)
 			goto out;
-		}
 	}
 
 	if (dev->memory_backed) {
-- 
2.17.0

