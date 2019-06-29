Return-Path: <SRS0=xgQW=U4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C252C4321A
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 05:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A77214AF
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 05:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f41KO5Fp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfF2FFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jun 2019 01:05:16 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44385 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfF2FFQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 01:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561784716; x=1593320716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8beiedFNEl66Grrik8fsXyOBB6jB+54HNF4jxVfcR8o=;
  b=f41KO5FpeebOqQ/UzWA4W53AESx/UqSk3afSi6gg2d6aGjrfjimQcsUs
   rv06JMomFSyYRKya/fgQofclUl07UhF8ltyR5lvPxiPfOZAO39Tel2AtJ
   MSc4PvAjskqx5NNlTTrcy4zl0bGIQ4Z+uXZI3fEj61mvPOO4lGunXJe1I
   3FUHtQjQeu7aM/fEmh3nmwYrK/pgs6zDwV3NPSQn+qvoilYTGLHig6Kx5
   GpQ1iutsSui4nPxqkaoIedHUktwPzv/QzqaSRU0ASPWR4ODbEEKWDpDB6
   X9f1C74fr7r8GDbAPlQCdLSpZI0O9+Z+UwTa8W/3yD5S8ZC4KqqqWPezT
   w==;
X-IronPort-AV: E=Sophos;i="5.63,430,1557158400"; 
   d="scan'208";a="113462922"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2019 13:05:16 +0800
IronPort-SDR: 4T2sc0xPQigzQij+9rP4BiCR/IX2FO6BwfhW+IyPcHko3GOVuCAeqXVVP4enzYnzXoI4Z42jKF
 471ovHQX+xlUTdipWn6iR9ACEHBws706YJuNl7nckd9JT8Gei0U/N0jhYgDNQ25Z4GIYVV/aky
 gq3Esxrk6l5/ABLbUcGSEmSrQwt9Lg/PZPqXfrSkjEhPmVg+J9+Ha2N438Vr8h6ydT+wve1ree
 E3Tl3Mz3Ltrpn/O6J92S9m8LBoD7UEgFXsDEg/7qVktiUq2FKmpRr6mLBCOW+jsso3KWuuhU/h
 ZQ21eoFn/k/YG0uDmhHUAPEg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 28 Jun 2019 22:04:26 -0700
IronPort-SDR: 7RHhqmj8iahaaEtvxRBSUSDL10h/BGd9hUqFnuCwOfmxQ7zUXedxKtZSA0ueFo0h/On/h4VgzQ
 OVXCYbjWl+eKatfXf/JRRS4TsfqwLoJrbAacE9YLl69z28HWlsb9khlKVKlvAYAnKca1fwlCMk
 Sz0R6GjEVFI8X7ijHBfS229YbwmNrNly1lFH5nPpvnfI/oFnsSCRyImbe+XaQc5mGzVQ/nH3uO
 NUKHo3QxQw9TUAx++BSEliRqL2pEi7gyUUIUTLsQrvccKS4BVKg1oaioOO1jVLdL45xp2OV0CK
 oVA=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Jun 2019 22:05:15 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, bvanassche@acm.org, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/5] null_blk: create a helper for mem-backed ops
Date:   Fri, 28 Jun 2019 22:04:40 -0700
Message-Id: <20190629050442.8459-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190629050442.8459-1-chaitanya.kulkarni@wdc.com>
References: <20190629050442.8459-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch creates a helper for handling requests when null_blk is
memory backed in the null_handle_cmd().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 80c30bcf024f..e75d187c7393 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1194,10 +1194,29 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd)
 	return sts;
 }
 
+static inline int nullb_handle_memory_backed(struct nullb_cmd *cmd)
+{
+	struct nullb_device *dev = cmd->nq->dev;
+
+	if (!dev->memory_backed)
+		return 0;
+
+	if (dev->queue_mode == NULL_Q_BIO) {
+		if (bio_op(cmd->bio) == REQ_OP_FLUSH)
+			return null_handle_flush(dev->nullb);
+
+		return null_handle_bio(cmd);
+	}
+
+	if (req_op(cmd->rq) == REQ_OP_FLUSH)
+		return null_handle_flush(dev->nullb);
+
+	return null_handle_rq(cmd);
+}
+
 static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 {
 	struct nullb_device *dev = cmd->nq->dev;
-	struct nullb *nullb = dev->nullb;
 	blk_status_t sts;
 	int err = 0;
 
@@ -1209,19 +1228,7 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 	if (sts != BLK_STS_OK)
 		goto out;
 
-	if (dev->memory_backed) {
-		if (dev->queue_mode == NULL_Q_BIO) {
-			if (bio_op(cmd->bio) == REQ_OP_FLUSH)
-				err = null_handle_flush(nullb);
-			else
-				err = null_handle_bio(cmd);
-		} else {
-			if (req_op(cmd->rq) == REQ_OP_FLUSH)
-				err = null_handle_flush(nullb);
-			else
-				err = null_handle_rq(cmd);
-		}
-	}
+	err = nullb_handle_memory_backed(cmd);
 	cmd->error = errno_to_blk_status(err);
 
 	if (!cmd->error && dev->zoned) {
-- 
2.21.0

