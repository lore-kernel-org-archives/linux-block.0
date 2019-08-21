Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70C6C3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A4922D6D
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cqCfIFZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfHUGNs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 02:13:48 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34430 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfHUGNr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 02:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566368027; x=1597904027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=DU4k6VI5I7oPvhvZ5H9K91YXdlSPmCDk4v0vyPEDUU4=;
  b=cqCfIFZi+1vycb9oOcXpRGz6oypilVzf8mORjHIMCExlHKYm91k0iLT3
   VyzXYaCHZexMq+tW5+wIejQ9AuFDt9uy32g0jmwx3xXo9ccmIke3Apw86
   kR3d68dK/qYj6l7XSncL0W2ZeIoI81paYiK1YlErqK5YZM+hN6p18UI29
   vDimGR7RxBeO0TKO0wRVstKjeURohwmHvkfHIDC+sp7Y9TKuFW9NL7KkD
   BZFhcY+8l5saHW7PiUWzUYM/gLXrp/BhPtnDNurt1ExrfYK6Rfov18gFX
   GEm0aJU2EeGfc9a6muitfPGPH/5rlzdI/Tlh+hSVXh4GKe6TfQTzohaW8
   w==;
IronPort-SDR: 9g6UQxs/HZrSA2wGK2OBn4luSvvD4qHOodowsrcj1slpqZJjFxJJuMgrngGBnBC1MgqY9y8nsb
 qnAm2lAEfm3UM8PBisRBq3nezzx92rs2Xqu0+pLcqu3AQn34cP7lYV8nINTsLPnHB/5hEmzJxP
 H5WYefafev76kuB9FbUe3mMHSFTdGoLIXqGNrPvhA6EreUVAycrmkCXWONnkkcRivkOCQ2J0Tx
 gDt/dlNk1WlEs4V9bMxiddwxUbHHMYuR4HTBv+br3zYoS8JrXXBCXkZZy4aRM8tG0a8WJvDmgw
 HI4=
X-IronPort-AV: E=Sophos;i="5.64,411,1559491200"; 
   d="scan'208";a="117904606"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 14:13:47 +0800
IronPort-SDR: QO7bya6mDTBAjzzs2k2qafBTHWIWH62BJHwkwMaK4dG5dqzKKvxc12BnH1chL9J9cwAk9c6Yw2
 ydY69R+tfSGgYuktnHTu8gNgumb/N3eV+vwJAhDHx9vuicHw0QIyWda1Fi81PYehu84htk5cYV
 XXOaMsfdzRT9L7lPCKVslRgMWgp+qvf7smLQWL6FKIoRserMJ21NNtrSFL5t54V2MEEd/NtTt4
 wJ1+NCFPK2QkEc1S66emZIsWWVJG4zZ6LaDOeNDJYrCLSoKQdLGEkFTdkZOdKNOGjwqxWHf3w7
 o6gvkKg4YwH7KpGMhlndOAXi
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 23:11:09 -0700
IronPort-SDR: 7jhNKrkiQ3mVz4a0eUmd+n40/8oKL40k7bvec9sEhI/gwFd5SLTyrHnWQJu/iEhuer0LwUH2Sg
 Lwu183LD9c2ycQBWKLzOHZ8co1+1PcuoPr/5y1klcc9ipYWfIIet1lSAde3myb/9TpaqzRie39
 rctOc6zWmSS6xO4fOT+0siqLza08liEMaX9pU7na/nG6BIln9vFoGbQNjfOqdChosZOPdPCmjJ
 Be3IenkkgjkNvhu8wlk4GQ67NXmyQqHXwDoyCW5QHu3Jwzs+lhPMfhrEMzZJdaYnjz0KnJfHAl
 zrI=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Aug 2019 23:13:47 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 4/6] null_blk: create a helper for mem-backed ops
Date:   Tue, 20 Aug 2019 23:13:12 -0700
Message-Id: <20190821061314.3262-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com>
References: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch creates a helper for handling requests when null_blk is
memory backed in the null_handle_cmd(). Although the helper is very
simple right now, it makes the code flow consistent with the rest of
code in the null_handle_cmd() and provides a uniform code structure
for future code.

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

