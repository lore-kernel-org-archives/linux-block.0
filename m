Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963B2C43214
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 02:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C98B6105A
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 02:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhHLCoi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 22:44:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60797 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhHLCog (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 22:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628736251; x=1660272251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jcGiBKGqL/HTpWqdCz+a8CS+BImWhuMqxWT6s2+gBR8=;
  b=NZV9hIcxgIYa6nD8gIADujBe5AKcSHt/vUd2yY97Wdb8lExVamG+JUt0
   GBcP1a/dJom+JATwQlac1ajN8EI/A9OD2I6eP9E2FOSYpJqTt8fy6TI+c
   /qbqoikUDIrstvdH0bAATLck7CuUGA8XAfPuszaR1G2MRADskLoawk/OU
   HhMKgihh5sLHPUPM/VV7QUIpfiXOJc0fcQ6qbln2DyQsm2t7Z+5LiCYKe
   M+y5B9mTeYluQuy5hCILi5FhkxA2+k9gfxHW4cj2ApBKZxx8KC2uzrx+o
   qxYlR9ZZMsI5Fdq0jtBR31tqqHz/vg5ne5H8eGi1JMss/X2GzwYsjALdh
   w==;
X-IronPort-AV: E=Sophos;i="5.84,314,1620662400"; 
   d="scan'208";a="176999898"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2021 10:44:11 +0800
IronPort-SDR: TAtPXhLURTxFM3L6KixGPGoguZ+ewGD61Bzs4ZKu0/k8abvJRnfMVOlvvpkY2SuNxmp2UTr84y
 BL1aS0qeulzXomy+mU1pEkLjPE1AUtW+b3CNbUeL4CMqPxmR+MkrFW1um/gguuBbbNFpM+fgcU
 D366k1qnBt/yMXtocBXR3Fw+1VMLxvxP2zZGk2pOq3H8Ug+sE7UbRIDprsuTCHr4bgkePtrYjt
 SJdJroIP43wVUXOdt5gfx+od368Idk0cK1hPvkGjJmiyqdeSVyf2HSajvm6k7GHBWGrlCj7fYg
 1s16pYuRe4Cbx4bqMeYh+/Jb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 19:19:41 -0700
IronPort-SDR: 9X2GZz6IaDEPTh/rF4NrK68seHSaSWY+ioZUKYTGxPjU04czXybSakmPEDhHDpCYut8EP6OBCD
 eASKHEOo1XEmjq6A8HziKWhuqa71JXfzHdX9NkXtBaHIogxgugOX+WhUtvMAHVxEQGMs8ftGg0
 qk1muaKPfDYEBHWgWPycx6R9zgae1ll+KNS84zoDeLsxPeU+Fn1lsZ3wmiOwEvsnH8mtK0ZPgT
 IDthMs35S4AE4OH8eUSvTGDvzW2FUI/vPWx0miASB8tp7b5BtjoYSeFlnTQ5tqrZfIkItRw1Ld
 TYI=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2021 19:44:11 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v6 7/9] libata: fix ata_read_log_page() warning
Date:   Thu, 12 Aug 2021 11:44:01 +0900
Message-Id: <20210812024403.765819-8-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210812024403.765819-1-damien.lemoal@wdc.com>
References: <20210812024403.765819-1-damien.lemoal@wdc.com>
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

