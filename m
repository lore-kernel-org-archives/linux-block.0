Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD994C4320A
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 02:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 930E46109E
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 02:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhHLCoc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 22:44:32 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60785 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhHLCoc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 22:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628736247; x=1660272247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+WWKZF/7COHNQFSxWKyzuz9m7BPKJUtEUV2VtAma0Ug=;
  b=nkHprQEKXRWra6e/8JBVBt7qsSfGTRINMQ8SLmEoMs333xvXIHKJ0TS7
   YQSNd4eminX4+/XxfbIdLg7J2BXdruuPJc1xfKs5sb6IaLbh4evlYB9ol
   9oly0wQLQjsQEiS9LPqGLAnhnCroCgLYEJlB8ss0ZecFkFW6d3rsBDwmS
   OVVAgmyBlp3iMCYvyFpkn9BYGBDBLl8+roV7MnUy2gmcXv5694T+KfKOz
   tR1BICk7Shk+PiMqOzMMWGMEUmdMqmvK1+8evnfJUvvqo1hkvS6j1CqYD
   sEH3LObIRwD1DEpEf9PMBmbcWif5qJV4+Wz307MfRf341XkLaBvlxwa2z
   w==;
X-IronPort-AV: E=Sophos;i="5.84,314,1620662400"; 
   d="scan'208";a="176999868"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2021 10:44:07 +0800
IronPort-SDR: NMyhAqPicNVrUGPtsjoz/1aL0dKkouwiC8gSewI59LpxYeZTAKfc2enrKgVJQRNdA6It0ATt8C
 2SENnc2r9AbR7VLYjTDiNUwDSpMHPlj7GFcthsnohDebU65WPTXiXcW0mPCjPgFVEw8dbVO5SP
 q8VDeEFSvR2kQn7lbkjDrjcCj1O3vylQoTXOzpiPVjRCVyxi27P0EttaaXBVIsqcl8xCWZHQdb
 YrxJOjvcwYnKe3j7rn6x9Cnjo+ubUkNpI1FgMZfHB72QtjZ/tjRngcVv6eeRdMqb0yTvkjV8DZ
 YUV9BNSfjL1r6uLBTW5mpuSh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 19:19:37 -0700
IronPort-SDR: qqDC4viKgi3Tm0iZwIeKhfPBrXnJP0Vrn+3ZUsFTLYx7emr7irsC/8oOsnzH1HPGkBV+6c5gvs
 29Js17VqCp9bS33yi/Qod4VUOykDrtcLMQ6oADv9Chhc/rBDJvB8g4W8evgsdPl45wijjPiHRV
 jB2FhYLytBooRJuImvnHPT4ypzCvfJuSaV5DGExc4sz94eEzvluE5Vnt8ThQs2+KgnUmtED3n0
 b8HOQeGj+0z1eGE5afW96HZwDDiQyM+p0g3BvrSds5SQQki9viMlGoW5CjcojYvx2hLSbDnvev
 820=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2021 19:44:07 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v6 3/9] libata: simplify ata_scsi_rbuf_fill()
Date:   Thu, 12 Aug 2021 11:43:57 +0900
Message-Id: <20210812024403.765819-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210812024403.765819-1-damien.lemoal@wdc.com>
References: <20210812024403.765819-1-damien.lemoal@wdc.com>
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

