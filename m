Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378B6C4320E
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E0746140D
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhHPBpm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:45:42 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37272 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhHPBpg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Aug 2021 21:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629078304; x=1660614304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jcGiBKGqL/HTpWqdCz+a8CS+BImWhuMqxWT6s2+gBR8=;
  b=QhondoGIxJOvXVncVY9s/XK45eEEZ3FjLa8Swz3qbVDdlALKyBcWJKOc
   3cM70OfZLkFoFHZDDkZOU/NVHZtg587Ks/Q9Jdc3zJkdzSXj7prM4wB0O
   KIEPbDrAdY850wMmHR/obQZGcj0Kb/ozRERAkX4mVgpSzF+H9m/+DSzTL
   l6ZbKMHy2ywsGqgY06YkD7oPcMtqw3NfaG/TdgvYSx6eodEJLNMi2vWPG
   hKpB7ADcdT7qbODEmF/bF5oBYDyCFyMXOUvKjFgUdcQBA/0UDJ1dEqb4/
   vOqTvQJ1bVOUaFc5L8Btf8H7OG2ndjZyFUBnPAT1yjG3hCaRc7hv9OOpl
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="177326710"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 09:45:04 +0800
IronPort-SDR: 7TfjoICoJDFNqRWyik+3OguRhFRzITvJ0U1s8oPTXletICWh2M2XV2xI5dUAoeQiANlTtnRANz
 80dOCmj4KyAHmMlNATovtN/P5cIvwIT6QS39Wm+TzPTSKci2e129TwMQJQFNOYwBddp0x51C2f
 mI+NTAvoWETM1yrIi1cImGgLttDUAqzW8eX/68YwbfH3Z877nYNPya7HROXNDQ1FwjuAaHpjSo
 UIQGeOArNW6w37yxzTYTTweoAuIogfXjVmbUCEZhRtWYrnV3Bs/P9x3F9d8A+nRbQSRPYUzG1t
 1AINcQkrUiHVVGNQIWbTI3oS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 18:20:31 -0700
IronPort-SDR: cZK7uPJBcoDGpxaFHFWSeAKZR/t2ZS8dtdfXTGl1vYAL3R5zzswpNCuH2IOopliwMUliuUGVvu
 rPPapHz0jGPJ1Gz+xyrJv4x6kriElrRNE90srhb5H4YZN+7ReuoW0OtyvzJ3Qb4q9OFPgMKQ92
 txLWYA1ru5bP1eKmiNYsVAXhywb7rMVBqcE5QDlwI8SEhof5RmuQg+C59uLPjWFa7zlFeEIu0L
 Q3fL1SW9YAwdvl5WFSO2e7uAiTmXMRgpC86CoJ7gD4YRfwhHhpeC2Izdc4ZIpYWGaCAJ06h3rZ
 oig=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2021 18:45:05 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v7 07/11] libata: fix ata_read_log_page() warning
Date:   Mon, 16 Aug 2021 10:44:52 +0900
Message-Id: <20210816014456.2191776-8-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816014456.2191776-1-damien.lemoal@wdc.com>
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Support for the READ LOG PAGE DMA EXT command is indicated by words 119
and 120 of a device identify data. This is tested in
ata_read_log_page() with ata_id_has_read_log_dma_ext() and the
READ LOG PAGE DMA command used if the device reports supports for it.

However, some devices lie about this support and using the DMA version
of the command fails, generating the warning message "READ LOG DMA EXT
failed, trying PIO". Since READ LOG PAGE DMA EXT is an optional command,
this warning is not at all important but may be scary for the user.
Change ata_read_log_page() to suppres this warning and to print an
error message if both DMA and PIO attempts failed.

With this change, there is no need to print again an error message when
ata_read_log_page() returns an error. So simplify the users of this
function.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 47 +++++++++++----------------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a845a2b8d899..bad577dbbc0d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2026,13 +2026,15 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
 				     buf, sectors * ATA_SECT_SIZE, 0);
 
-	if (err_mask && dma) {
-		dev->horkage |= ATA_HORKAGE_NO_DMA_LOG;
-		ata_dev_warn(dev, "READ LOG DMA EXT failed, trying PIO\n");
-		goto retry;
+	if (err_mask) {
+		if (dma) {
+			dev->horkage |= ATA_HORKAGE_NO_DMA_LOG;
+			goto retry;
+		}
+		ata_dev_err(dev, "Read log page 0x%02x failed, Emask 0x%x\n",
+			    (unsigned int)page, err_mask);
 	}
 
-	DPRINTK("EXIT, err_mask=%x\n", err_mask);
 	return err_mask;
 }
 
@@ -2061,12 +2063,8 @@ static bool ata_identify_page_supported(struct ata_device *dev, u8 page)
 	 */
 	err = ata_read_log_page(dev, ATA_LOG_IDENTIFY_DEVICE, 0, ap->sector_buf,
 				1);
-	if (err) {
-		ata_dev_info(dev,
-			     "failed to get Device Identify Log Emask 0x%x\n",
-			     err);
+	if (err)
 		return false;
-	}
 
 	for (i = 0; i < ap->sector_buf[8]; i++) {
 		if (ap->sector_buf[9 + i] == page)
@@ -2130,11 +2128,7 @@ static void ata_dev_config_ncq_send_recv(struct ata_device *dev)
 	}
 	err_mask = ata_read_log_page(dev, ATA_LOG_NCQ_SEND_RECV,
 				     0, ap->sector_buf, 1);
-	if (err_mask) {
-		ata_dev_dbg(dev,
-			    "failed to get NCQ Send/Recv Log Emask 0x%x\n",
-			    err_mask);
-	} else {
+	if (!err_mask) {
 		u8 *cmds = dev->ncq_send_recv_cmds;
 
 		dev->flags |= ATA_DFLAG_NCQ_SEND_RECV;
@@ -2160,11 +2154,7 @@ static void ata_dev_config_ncq_non_data(struct ata_device *dev)
 	}
 	err_mask = ata_read_log_page(dev, ATA_LOG_NCQ_NON_DATA,
 				     0, ap->sector_buf, 1);
-	if (err_mask) {
-		ata_dev_dbg(dev,
-			    "failed to get NCQ Non-Data Log Emask 0x%x\n",
-			    err_mask);
-	} else {
+	if (!err_mask) {
 		u8 *cmds = dev->ncq_non_data_cmds;
 
 		memcpy(cmds, ap->sector_buf, ATA_LOG_NCQ_NON_DATA_SIZE);
@@ -2181,12 +2171,8 @@ static void ata_dev_config_ncq_prio(struct ata_device *dev)
 				     ATA_LOG_SATA_SETTINGS,
 				     ap->sector_buf,
 				     1);
-	if (err_mask) {
-		ata_dev_dbg(dev,
-			    "failed to get SATA settings log, Emask 0x%x\n",
-			    err_mask);
+	if (err_mask)
 		goto not_supported;
-	}
 
 	if (!(ap->sector_buf[ATA_LOG_NCQ_PRIO_OFFSET] & BIT(3)))
 		goto not_supported;
@@ -2347,11 +2333,8 @@ static void ata_dev_config_trusted(struct ata_device *dev)
 
 	err = ata_read_log_page(dev, ATA_LOG_IDENTIFY_DEVICE, ATA_LOG_SECURITY,
 			ap->sector_buf, 1);
-	if (err) {
-		ata_dev_dbg(dev,
-			    "failed to read Security Log, Emask 0x%x\n", err);
+	if (err)
 		return;
-	}
 
 	trusted_cap = get_unaligned_le64(&ap->sector_buf[40]);
 	if (!(trusted_cap & (1ULL << 63))) {
@@ -2440,12 +2423,8 @@ static void ata_dev_config_devslp(struct ata_device *dev)
 				     ATA_LOG_IDENTIFY_DEVICE,
 				     ATA_LOG_SATA_SETTINGS,
 				     sata_setting, 1);
-	if (err_mask) {
-		ata_dev_dbg(dev,
-			    "failed to get SATA Settings Log, Emask 0x%x\n",
-			    err_mask);
+	if (err_mask)
 		return;
-	}
 
 	dev->flags |= ATA_DFLAG_DEVSLP;
 	for (i = 0; i < ATA_LOG_DEVSLP_SIZE; i++) {
-- 
2.31.1

