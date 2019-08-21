Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139DEC3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91102339E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l18GxUaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfHUGNm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 02:13:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45737 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfHUGNm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 02:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566368021; x=1597904021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=QKl1WwrouL89tniEOxclQ9nFN5eD/4jUwLTCVUmL8qw=;
  b=l18GxUaQhFJ0TNtmy1VKozmW+ePiwR6cq92kMnQRTPvkUUZ8hBqA7w2u
   +Vipsc6q1dDpZXu7OYvXOZSRlMfnoXxpNixAMNjmY0kp6xUst8diStQS3
   OUAQY1lLZZs7hjxxgwSi74Tcrz302A7CGuDcHHumuhqjLbp7BskOKBSLZ
   64D41S8MRQTTlrQtosY/uBbpvqKFQsHfSFdLZCgknFH2jh7Ct/hlTp0Xh
   akNxXNJFFpVxooHjpsMngsG2W3cSx4u0c/YZN+UHYHhzLHS5cj0MzrBN1
   uzvd0+s9Q8vE+LqE56iqpucLSUDiqD79TN84bG+QbDr5yoPJp5XDA0HJc
   A==;
IronPort-SDR: Mn+tZsm9Gq5wslXPvJ565bLXkbhS/B7LZ/dfKX1d5ClT1ZVFDcoVw8pPx8ue03QCaqhZzolKL5
 NBrW0RLQgGdUp9nHrEZFmj4z8XX7/vVGer6jFUMak1pEE53Xej3vofGdJj1Y758Uto548BmMhX
 satGUi6nDxb9F8VnSJu6e9Rlg4hNQvRzx218s71XSuT0OQwQs5yc/St3llk5mhayZlJU1bbRUw
 FVc9zatGjyw1DbRAwEk/6FZvLi1CVnmDgsEzxjDXobUPMX2YhAJeHVpQr4seIjcDsGIyJIgkvg
 fMM=
X-IronPort-AV: E=Sophos;i="5.64,411,1559491200"; 
   d="scan'208";a="120898297"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 14:13:41 +0800
IronPort-SDR: 8IAG1ql0clkBrPEKU2JlVmGaOAIR4nBfHu7USNN5AdFm+qzIIZyPSK0jYn2pAdAzgxNnClsIq0
 33JKkbOyjEIdgAI5FViLyzpxfAvg7KrQWa1ul+SlvY1HwKHHfxejWoRtJzDVU3zgb1KGW7HruF
 x8bP+/74S68GA9PU+cYcUtTAkBbXEH+wyjcpjN4ej7aSq0cV+dR3pHOxWksE+wYck9FUazjPNn
 zV8qBBcvhF5h4tX2uzteZpGOB6iHXdp7Fa9NjYXJTrft6gwy5cdbdiNyJ2NZ0uOC3Qno8hJj0q
 aNLdvEmRc5Sry3OG4ZNlMQU4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 23:11:02 -0700
IronPort-SDR: wdOTENdpg6bLasCT6hpMb/JCHR1J31DjyfgZJAPwSL6nxST5sNzHt/oncdZQIzHN14z4T3h++z
 23A7rPC51/7eMmGjEc0YWEIBT17QQKY/swcptFxcBWM2bHZzi4WUsY/gMhkHyt3gfd3BjO63/7
 UayGTjxZTJMu2a0y8fXMBJuVXriMj4BfSWNUV22fjlZ9o/nnzr4Zsv9ts1NEAkHh/H9Jt86Fqr
 Is5Db0g6T2/gkvqstbehzi6nCJwNCw81ZCrGR+gAlTcXPQ7NBnRu23WNCWfB5GyRD5tI6zjWLf
 3iw=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Aug 2019 23:13:41 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 3/6] null_blk: create a helper for badblocks
Date:   Tue, 20 Aug 2019 23:13:11 -0700
Message-Id: <20190821061314.3262-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com>
References: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com>
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
index 751679fadc9d..eefaea1aaa45 100644
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

