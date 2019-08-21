Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BA4C3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A00922D6D
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DaD9OB1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfHUGN6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 02:13:58 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45763 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfHUGN5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 02:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566368037; x=1597904037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=azZDoPJ9i+Ak+dWcyy0BtIJhy96EbKkRr6W6u0sc/zQ=;
  b=DaD9OB1nyTTl6RVDMalXAnvzOB6sVQg9aj7+9gYktCHQerMx4XmSw48b
   gcOPvFcA4ywf+zrK/+YeCtEzecN3SjlndrRpxC6lhWQTX491zDV+BENK9
   XUPkZ8QL4xW/8bCtN3BnRArqwLcLHwggiC66Nq5RwVxjlOfVRlSCd8jJr
   bN3ePnkb3CfkZSDguDBhYp/FlQN9j/TjeUh1UGRPPCZniksM288mHCT7L
   d3uJCmUxzzIoIBFNXEsawhSSgQepnkGWuT7IAmZGRgTtALEWyp7/hIlYN
   wf1KJ01htOaLggQWZkGPzVkm/yXR7nqpD5AQHCWP2rFEQc5UKa9yk6DVL
   w==;
IronPort-SDR: L8px+SmLopy92/c8IFlhUQLsPiXbAxs1+yxHccGRNXdNlfhvX7QfyGqk7ABYJc7uauf/Kq1e96
 XnXaNVguSsMDZXp4907njtjELMe59uBGyZyxIO7MUKuUCdAkrc8jZdR9liP3Hy8Qb8gAELcPue
 EdzBSAP2sOdzQ5DJnISJlpEwTQWVcU6YdCs09Eq5T/cfc4CmH+s87GwbSVspRfmTP9a284ClVD
 B8mgT29gi89/qcDXmNY9Nex+XbjDTXTJ9n4zRVFGYfHAKMsAx6oR/e7a97p6ADSEWT95dCsoLV
 I0c=
X-IronPort-AV: E=Sophos;i="5.64,411,1559491200"; 
   d="scan'208";a="120898312"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 14:13:57 +0800
IronPort-SDR: 0NFKxJ4nFiePXE/q3kNaXyzTIdF1NUKePzVYZ5Bd30ORNSLxKcklqK1C2ZwRQLAzn+madpdEiN
 6YxKhH/6b73OiaDlymbKzXojJZnO2wtAFPO+i9XIL5Zpcf+DUTL3tfQy5/2SPnE94ue1Q/nAkP
 FaC7p8uC9K6sjUW8HTdQ/id2HebG+ELhRZ14jvyx3PqO8khDmeQC8e3abwkjz/8bd5fehZfrKa
 9fVVhehk7XP2dMOLDkRw3m7vkXrcaSu0bHPvxFycDhpRdmEuKPzbUyXETPpxR2m6vvLyV1K6ib
 ALMKfl1J1schX6EvX8ZoAWbh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 23:11:18 -0700
IronPort-SDR: ogp9yKyK0180MbK+Fl7+jMMdyTPBCn3oY7cDVJHT9j8n+YbP7k1CunSEZP8lStmAXViUdUYD37
 +akx/s4EXmvhYRZoFUrVGjnZfP+QeMr42F5+YPGbWxXrlzXKjivmBIeNUrQRdbIQWIN0Tmfl4b
 nXwc3sHq/6tJylKWDROohYjKChMWdoGr3V0Is9JgIHTihlAlMoB74yR8CZUNnXY0lukNSaiXpK
 QaWh60DLcg5C6WOCBKoFz4iC5GYOsQZm3YGgHejJW2Ed77tggzP1QcFpGgr3cX/4GqmwTUktfg
 IBA=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Aug 2019 23:13:57 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 6/6] null_blk: create a helper for req completion
Date:   Tue, 20 Aug 2019 23:13:14 -0700
Message-Id: <20190821061314.3262-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com>
References: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com>
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
index 501af79bffb2..fe12ec59b3a6 100644
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

