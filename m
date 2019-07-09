Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A444C73C53
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 19:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156D02073D
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 19:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qDGjfDnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfGITWL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:22:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:63366 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfGITWL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 15:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562700131; x=1594236131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gg1RQqZox7MSG1EY1vzn6USs2m3IemJZS3jkF39bG7g=;
  b=qDGjfDnO+kjJA9V7tv7VMxb8Llc8+K6m2JBsAwAk1ZT43Ngpn3kM0BES
   oFZtCE8m72y+n6ZQqYZVTyNPnCQUAcwr0QprdgcNDqn7NZNGzsFnZhdge
   giUctT7yitVc9dwSPogOZuAubjqFFEnsM7CKwjTdkBdbccCe+6F6JKU5N
   WTMqf+UX7FDSI1nPDRF4FFjrRMP/98jkwekt+0793fSkfGMKLXmJKucIz
   P9mQZDSDHpbgmPFykqukKIHf7Y41tK5lRHENA4tGadbBbEsuqiIc7UxyF
   ndVag+HaYTH/bP6SB3cI39kYnRfK4pksKKWAfTd4nyDxDJTpVfjmmr9L3
   g==;
IronPort-SDR: YpRHI6caJQwjWQoApXGBqaPwVvqTLfdOOd8hvRwROGqjja/waNnYpkpQLICCfbHZ/DSHGCQ2hs
 EkCEbgBOlvG2iYX8aOmI1zsInniegRTu0IOKkcgGsTnnpn5IHRc/NS96FkwdW8Fq1zpl8cM+6r
 YbTWff9FTc//Diu5fVGaepxt2qABWgDj/CemmOZaHgXDNlJ2Iw+TuSIHeb7Ixo5EJK/gKAGeNJ
 QEay38KVwRzF6Sl5HFt1aCgU8ZqdWVgIskF4sL1lmUTSbUzhM6zwgYhoKhMZi3XznG6KdPa75Z
 CaU=
X-IronPort-AV: E=Sophos;i="5.63,471,1557158400"; 
   d="scan'208";a="114198824"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 03:22:11 +0800
IronPort-SDR: 7Oc6RIRXmgSsvjDVDYkvv/7BeUxbI5734CqnE2bxxFeS2iw2xlfhtsI7CU90a3lc4XltG1JyaY
 quxfwdZHw8GyFt5MRVknA3hyu6X2n30gIbwj+dWH8Flh/G2Ig2farYArYh/lzJoEeIsJV8auic
 lP8/vo3adyFkY5Mv7kxOp7g9D9+kGmpibSdLQPj6hufG+JI61OsImWE/xBPcdcyzWWWi+giWRX
 d9JO6s/b2qcoaS2SQZH2QQ6R4B6WcUapIReQHdONjBRsQMuFBLyEKxTH0Zt3EJeU9DIsWzzn9D
 UEyb7Vk0SNkEsgK7T+F8GRmE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 09 Jul 2019 12:20:57 -0700
IronPort-SDR: h+XBQAHf1vBsdEeyLrebeAOjXI//MEA9hzO3EFKvl4sJe3uhdRiBy5mpgL/5PptdwxJ061qVw3
 C17b3qL2bBTQ73T3NKtzWGUK8xQJEu1igl+GIBDG13Oq/+GTVh2VQciUsYJwRfiTaHmXgGKt1S
 XOIPlHLQE9Pt/J09GTv6taJi8zC2Vfw+XZRYE4+UIY6K2wTao3OZxSeaVRG4I5aohMDl3Bw7OT
 FborN/hdx9nNMwrzSfuXlW1Xbz+BcbT3e/YUibPIBDmwpnCHKK6hbS4zaDEViGEgZF9Ty6nYGx
 ks0=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2019 12:22:11 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 6/6] null_blk: create a helper for req completion
Date:   Tue,  9 Jul 2019 12:21:32 -0700
Message-Id: <20190709192132.24723-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190709192132.24723-1-chaitanya.kulkarni@wdc.com>
References: <20190709192132.24723-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch creates a helper function for handling the request
completion in the null_handle_cmd().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 49 +++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 8ec3753aaf9b..e9bd599516cc 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1202,6 +1202,32 @@ static inline blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
 	return sts;
 }
 
+static inline void nullb_handle_cmd_completion(struct nullb_cmd *cmd)
+{
+	/* Complete IO by inline, softirq or timer */
+	switch (cmd->nq->dev->irqmode) {
+	case NULL_IRQ_SOFTIRQ:
+		switch (cmd->nq->dev->queue_mode) {
+		case NULL_Q_MQ:
+			blk_mq_complete_request(cmd->rq);
+			break;
+		case NULL_Q_BIO:
+			/*
+			 * XXX: no proper submitting cpu information available.
+			 */
+			end_cmd(cmd);
+			break;
+		}
+		break;
+	case NULL_IRQ_NONE:
+		end_cmd(cmd);
+		break;
+	case NULL_IRQ_TIMER:
+		null_cmd_end_timer(cmd);
+		break;
+	}
+}
+
 static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 				    sector_t nr_sectors, enum req_opf op)
 {
@@ -1233,28 +1259,7 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 		cmd->error = null_handle_zoned(cmd, op, sector, nr_sectors);
 
 out:
-	/* Complete IO by inline, softirq or timer */
-	switch (dev->irqmode) {
-	case NULL_IRQ_SOFTIRQ:
-		switch (dev->queue_mode)  {
-		case NULL_Q_MQ:
-			blk_mq_complete_request(cmd->rq);
-			break;
-		case NULL_Q_BIO:
-			/*
-			 * XXX: no proper submitting cpu information available.
-			 */
-			end_cmd(cmd);
-			break;
-		}
-		break;
-	case NULL_IRQ_NONE:
-		end_cmd(cmd);
-		break;
-	case NULL_IRQ_TIMER:
-		null_cmd_end_timer(cmd);
-		break;
-	}
+	nullb_handle_cmd_completion(cmd);
 	return BLK_STS_OK;
 }
 
-- 
2.17.0

