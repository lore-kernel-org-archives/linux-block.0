Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B6FC4320A
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7845C61058
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbhHJFuV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 01:50:21 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9548 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237696AbhHJFuQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 01:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628574595; x=1660110595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jcGiBKGqL/HTpWqdCz+a8CS+BImWhuMqxWT6s2+gBR8=;
  b=Pxgz5q3ClJCAtUDOTNJujUWkF7V8dIX0cVBiXgcFgixZ1ZLy2Uzk36bz
   Y42M0JRwyPH0I9zZN0ltOagEvBrxbd2l/VYgtlqEckshxsNJ8YjKxn5SY
   MDmyQlHztEdL/2hPqpkYy8P0xrCv4hGQLuEPHLVnijgxDE8JrTVnCRQZe
   4OzBa+Xnn8dvmwGhhRvaCCBe59hUBGTQGkPSHuZbg0WyKQXA7brYTG93A
   UNu/URc+bkxcx5XgX3/Q8g0zwzs2YWUVNnNIeTLIhWHODQ6T19RG7S7kT
   MGcoUSy8Tuwf7K7WoUsXmINdMRz4wfkszfssXNHp8Hb0R5l4zI7lpN9ps
   A==;
X-IronPort-AV: E=Sophos;i="5.84,309,1620662400"; 
   d="scan'208";a="288340197"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2021 13:49:53 +0800
IronPort-SDR: UFtwUHUZA3+2gRK67RYKYGEt2ELnr2zPBOelTJCG5UTy2d4JrfQ3P11AiQPJA0xqoWBbaLzGpE
 ak3QJriPlnKDGipvccwUn/s7OgUlQe0MDzpq0lalvHvykKQL8bVkX/C3MAMXcC6ihb1AAjABWP
 b7cHF8Z/EBTMfgGSqgArxSHjGI5b+qSgVuhd0Uv7FfUrUNnLkGTwbCn+VcRqfPaKhom+7x8cgZ
 OU2goVF80wsB5rc+8aU88VZjSar3z3DYQcD6NXS8lTFm1BwcG4XWlPTUkNt0OIEDF+vMaNJOtH
 6yy3kU2jmgEtORKu1ZwPfpMe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 22:27:16 -0700
IronPort-SDR: ayusnq6glrtnSYQAQPqC3XfRwzD6z9xbssj5tUiy4EGsAjk0U5Kq30Y1sAXc8oQTBDXUdSqZ5z
 aH7ScC27YvCLd0xurCZFVGCieKSbg6qjz8yap111a5afIIQNlgRdCx4lFRs/SyuOv+n4cwVKi9
 HjGmqG3iz0a9vYuoPxQOSWgfuaJsFVf2Q3zklvOMTeqwXeHveCWE+nwI8rxWp41nG2C+RbJPz3
 exM38edsoa+1DzllHPUMwG75PQSzwtqHaY8tvN0gSd2v1t8LIb2J+SpQhdeg2B46DpH5U3kMGA
 JwI=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Aug 2021 22:49:53 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v5 7/9] libata: fix ata_read_log_page() warning
Date:   Tue, 10 Aug 2021 14:49:37 +0900
Message-Id: <20210810054939.30760-8-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810054939.30760-1-damien.lemoal@wdc.com>
References: <20210810054939.30760-1-damien.lemoal@wdc.com>
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

