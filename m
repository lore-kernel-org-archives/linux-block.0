Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23874C4320E
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 010AF60E52
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbhHJFuK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 01:50:10 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9545 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbhHJFuJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 01:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628574588; x=1660110588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+WWKZF/7COHNQFSxWKyzuz9m7BPKJUtEUV2VtAma0Ug=;
  b=V+QvPyZJGuq1/nYhTzHpWoAvZMs83PeB+lqCL/6FWaX3ywPqGbF5022R
   yUXzgQ/6Tk6xMbWE3leVhAXQKNlqd1wqyD0URjjmJIEe1ljsVYn8lWAoK
   E5h0xkOOgN99krOKc8AKlaJXerPHI/MczUkTAOkJEcBk76B9hLKZoUaD8
   QyQ6d1fj+H9eaFMU/1NB5GiHiJEFdBK9Y/MfT4kxo8vynxkXfKHadhcTf
   7VFLmg8nJX/JoYBsbYc2Anmu08gw2AsV1pt8wuhDMu8Yvh535VLvwGz5t
   3RqST4+RiNDECRcEF/yuFTwcz4pIrdlMcDsgv8Mc0sPbLL7TBnUFIq95R
   g==;
X-IronPort-AV: E=Sophos;i="5.84,309,1620662400"; 
   d="scan'208";a="288340187"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2021 13:49:47 +0800
IronPort-SDR: dECFMiOjfRiOnaB7t9lo4FwM1WexrQ5jGBiRSPBTJYsGHAvkuOcA5vKKpcdPkQFKA86NcBFB3U
 6K6Pvn7KQvCXwSPugyEAU1dxw/MbCfKumFL0WTonlgWVIf1KAR1duRF7kGtPVWfoffuiBIyKcS
 AWt524rc/nsz2tGxm48nhfELla3KB7DNb68uJX6nsdJkffyf33uevAgrDSA+rC+tMPzNUSILEw
 Ic7pX+ncGZSJpSOriFlrkln1f9YKuOsG7yR0JZLg+L+zY42afrDRARzdx9gZNy4QsMxuoqQB4y
 35TJzuSXEW25LwCu3atJSd96
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 22:27:10 -0700
IronPort-SDR: 6miro2Ao5VNffPUHj4pzEZIk5Qsqd/wrrhW9X2FS2tawqM9Vt2Dad31ad4f3hWAbUKXJun3Dhh
 aUZxsJi7PrJ7DxWu2snurkfj/MbiV4b7soVDpbW9BRCzGm0+LkfeEAX2Ya+ckZAd8QtXkDkMBr
 0lq8lRBZA474vexmOLcVHIuuTY95Vp28eKVTRRfNgIP73nHNCQR7clwScTO823tUM4AdMoKgqJ
 59HTUYR3HrxUc0IQIDIT1R5q/pPq6hpTwGZt7t3U1X+lKb176qMkimRUg/FUZ09E0gm7pRDAbm
 yFE=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Aug 2021 22:49:47 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v5 3/9] libata: simplify ata_scsi_rbuf_fill()
Date:   Tue, 10 Aug 2021 14:49:33 +0900
Message-Id: <20210810054939.30760-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810054939.30760-1-damien.lemoal@wdc.com>
References: <20210810054939.30760-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sparse complains about context imbalance in ata_scsi_rbuf_get() and
ata_scsi_rbuf_put() due to these functions respectively only taking
and releasing the ata_scsi_rbuf_lock spinlock. Since these functions are
only called from ata_scsi_rbuf_fill() with ata_scsi_rbuf_get() being
called with a copy_in argument always false, the code can be simplified
and ata_scsi_rbuf_{get|put} removed. This change both simplifies the
code and fixes the sparse warning.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-scsi.c | 60 ++++++---------------------------------
 1 file changed, 9 insertions(+), 51 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b9588c52815d..0b7b4624e4df 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1765,53 +1765,6 @@ struct ata_scsi_args {
 	struct scsi_cmnd	*cmd;
 };
 
-/**
- *	ata_scsi_rbuf_get - Map response buffer.
- *	@cmd: SCSI command containing buffer to be mapped.
- *	@flags: unsigned long variable to store irq enable status
- *	@copy_in: copy in from user buffer
- *
- *	Prepare buffer for simulated SCSI commands.
- *
- *	LOCKING:
- *	spin_lock_irqsave(ata_scsi_rbuf_lock) on success
- *
- *	RETURNS:
- *	Pointer to response buffer.
- */
-static void *ata_scsi_rbuf_get(struct scsi_cmnd *cmd, bool copy_in,
-			       unsigned long *flags)
-{
-	spin_lock_irqsave(&ata_scsi_rbuf_lock, *flags);
-
-	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
-	if (copy_in)
-		sg_copy_to_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
-				  ata_scsi_rbuf, ATA_SCSI_RBUF_SIZE);
-	return ata_scsi_rbuf;
-}
-
-/**
- *	ata_scsi_rbuf_put - Unmap response buffer.
- *	@cmd: SCSI command containing buffer to be unmapped.
- *	@copy_out: copy out result
- *	@flags: @flags passed to ata_scsi_rbuf_get()
- *
- *	Returns rbuf buffer.  The result is copied to @cmd's buffer if
- *	@copy_back is true.
- *
- *	LOCKING:
- *	Unlocks ata_scsi_rbuf_lock.
- */
-static inline void ata_scsi_rbuf_put(struct scsi_cmnd *cmd, bool copy_out,
-				     unsigned long *flags)
-{
-	if (copy_out)
-		sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
-				    ata_scsi_rbuf, ATA_SCSI_RBUF_SIZE);
-	spin_unlock_irqrestore(&ata_scsi_rbuf_lock, *flags);
-}
-
 /**
  *	ata_scsi_rbuf_fill - wrapper for SCSI command simulators
  *	@args: device IDENTIFY data / SCSI command of interest.
@@ -1830,14 +1783,19 @@ static inline void ata_scsi_rbuf_put(struct scsi_cmnd *cmd, bool copy_out,
 static void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
 		unsigned int (*actor)(struct ata_scsi_args *args, u8 *rbuf))
 {
-	u8 *rbuf;
 	unsigned int rc;
 	struct scsi_cmnd *cmd = args->cmd;
 	unsigned long flags;
 
-	rbuf = ata_scsi_rbuf_get(cmd, false, &flags);
-	rc = actor(args, rbuf);
-	ata_scsi_rbuf_put(cmd, rc == 0, &flags);
+	spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
+
+	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
+	rc = actor(args, ata_scsi_rbuf);
+	if (rc == 0)
+		sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
+				    ata_scsi_rbuf, ATA_SCSI_RBUF_SIZE);
+
+	spin_unlock_irqrestore(&ata_scsi_rbuf_lock, flags);
 
 	if (rc == 0)
 		cmd->result = SAM_STAT_GOOD;
-- 
2.31.1

