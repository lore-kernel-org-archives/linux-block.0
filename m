Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B72C3A589
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 04:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA766233FD
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 04:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JXACSk8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391767AbfHWEqP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 00:46:15 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42062 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389942AbfHWEqP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 00:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566535578; x=1598071578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=228D0TMcq1JnDODJR+r8qowd7y4I2oLhKI5/sn4kpFA=;
  b=JXACSk8bVatEurOosxtX5AnQ0MKyeh30+mYJLu0VQKcblGOjvm6VT9YN
   oBurmD0ViVFdSNCJJ2VYh6xWzL3jZFBSICJXVs/nfOeo/N2j0D8NgVzPf
   0x50A+5vn5pwwsXBaTim+Ymj1m2YesAklKRpikOG6vy5pglBUi9sDod6E
   Fr07pmQB9Zy6vgXu3yG09K8etOGyuaNo929skvAmLvuoIYYlkzaHcbFS2
   rIcS7M4oQaMVXlzHGFRmW9bBSKYrBFNhnJGM1noEiucSUiCR9TWNHvUcW
   wR6zC+VaMMQG2PvE0UiRs7Yx09sYmd4ogFe1Sv4Kj50gvIPuPDRmCfCc2
   A==;
IronPort-SDR: WGrhMV5UXK9VrLEV9haSQTefhuy69/G3+rT+IZOs6vCdphQXHU4MnEhgj+NlYFaAw8ZtdCF3F8
 KTKlL+s8ReJf/w+0S4xdVF9fgi87gTvAuoHtBMspV38yDe9HMmle4iFSYmya96iI6H5ocCwyJr
 sfQ2B4pyvRd7sjPInbnB7mtqrvxYdZMY7kkoPRBKY4Wo5b/aEa2Y154lJxmyYbaXSm5Q/HfUbl
 o99N0uKl97PimJ7uXfGJLpXsrx8fd6Xwc5YNu9krWuCFj/TK2LAnhgdupzRreXCYGtCFMCNlW7
 lUQ=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="216934515"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 12:46:18 +0800
IronPort-SDR: hfNfDnkUFVVCiD6ERIAbG2Oi8o9/ZxN3jsqe5b5SBlUyjPqar0ZxZLyr7yphdRjzyTxihmFvuy
 BpQcC3Rd4Uh9iuebj9Fvf326erp79wEB/Y7KacANs/71wz3RKqiS7tvvHRWWPzVGnQmVjf5t/W
 03jjcBI4WAh+YN8A5vXLGJ8dKChZPg8AxgpwJbHLKA7cKOmDIg6J52IeFtc+UHmW4nePD6MKN/
 y92uJdLcMt2eCa12UHHYFcI8UIPIAuU4TsLub3yP7Wx6EBSCD9UnKDCWTXWxUGWZu3XsmNo2vk
 pbpMGjxxQusUfTXTlN2cITh1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 21:43:32 -0700
IronPort-SDR: s6MCs/14089iKFRVIUeLEjbSlxxjncfkPZ2XGP61vUwdTGJcI69T21i1eof879tPPGGTqxyFBX
 5jPw2MP7osAEpgcdmmYqloHR5/tX69kHBjCM3Gtcid06KMoio7uMymCKC70JbL0ChM3wgfagML
 GdZ2JPRrSE/06BuD9mPP0WSWhFvtQ5OD+1Lki5Zn5KqEJlXNvgpOmCyc2W2TgmCuyv06NO7zC0
 EBKhEd3RIpGP07HKQR9SaQxwAMCZWu8S1EwzTxdY+wjat0mk7fUgu0bDVTbL0r1+VR3s+704/N
 tww=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Aug 2019 21:46:14 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 6/6] null_blk: create a helper for req completion
Date:   Thu, 22 Aug 2019 21:45:19 -0700
Message-Id: <20190823044519.3939-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190823044519.3939-1-chaitanya.kulkarni@wdc.com>
References: <20190823044519.3939-1-chaitanya.kulkarni@wdc.com>
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
index bf40c3115bb9..b26a178d064d 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1182,6 +1182,32 @@ static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
 	return errno_to_blk_status(err);
 }
 
+static inline void nullb_complete_cmd(struct nullb_cmd *cmd)
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
@@ -1213,28 +1239,7 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
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
+	nullb_complete_cmd(cmd);
 	return BLK_STS_OK;
 }
 
-- 
2.17.0

