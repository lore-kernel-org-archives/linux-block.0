Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E83C43216
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0016140B
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhHPBpe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:45:34 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37260 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhHPBpd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Aug 2021 21:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629078300; x=1660614300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+WWKZF/7COHNQFSxWKyzuz9m7BPKJUtEUV2VtAma0Ug=;
  b=V7HoUfHDC5/rJqS6Vq52ttD5Fq7dfrdVbdFWvAZt8zyeo4wrdv+T02T8
   WIJ5oKcDadoR++s88Uloxqo/UlteNXlxN6xVX1tkKrHRu+roTXPKRtbOL
   cEqzL6vVD/0DDV8mSU4ZDTj4en2Ly9YfOqqFmhiDdaYfGPEKRpn1LZ7Z+
   l+erE6nwYeyuYolOXFMCmToLHPQEIaoyYFLS3nK5I/fP9GBz335WFvo9Z
   KNSDvoTqxORSMrirXrB2tEgvXB4NW0JUaQcPkoZWPCW2w5ppHOkVdpHD4
   Kg4FnRXzUNWOjGnNgA5lqP7nP7+PfQe1CYM0JWzvcljOc6BHT61wPK2Kd
   A==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="177326694"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 09:45:00 +0800
IronPort-SDR: UQjtw+97dvPvzJR3fYRxeymvB9P5lcg3l+qRdLTPCnHZpqKvs+IyBFLV7JoItE3iPFC4cHWaHW
 OsXoNbN3T6ZT//EgjwFfdhkODo019LbolU1S0VFJ5hy0Win4cSlIIxuIixbT/ofSoeIifqUH47
 WG0CVJR8oNG4oI9sQEFdnoVleJhDkM8qhCki9dwXeOnuZ9DpzG0m/J0xi5z3R//ysxV+za8/l3
 MVTAqjqDH5CZylvR1ixMz40AxOJG0L7R9CoXhSpSLmN8jLRVRxD0iqWjUU01fmFLnYNXMgvPk4
 0D7cqwGge6ihIMnxMzXhxs7g
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 18:20:27 -0700
IronPort-SDR: 6XfCTop1binbtyU7Z9JGIJvmsYJu0NXzctNwtvOoFhcHVf3CTbCADovS+C6jjA8Vvvnd91A0ii
 /Cj6kqUInqxYAmZtyMG8YF4O8kTw9W/uBMmGc1ZKjuM0NR7G/J/jHjNi+ahXMKA/e5mo8WlAEk
 AVh0wc1poRJKzomnFwiCrA4cosNndDR3S9WizGV1cMgwc2fNPso/DJikRN8zk6nilsOdxCQuqg
 3U7jCXKqMjcoqN0pROiqJqkJ7Q1G9Aqhk/rmdYDok0YgzD/pYrkA6Z/4lu6fGlKemnxki9+s7n
 lLk=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2021 18:45:01 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v7 03/11] libata: simplify ata_scsi_rbuf_fill()
Date:   Mon, 16 Aug 2021 10:44:48 +0900
Message-Id: <20210816014456.2191776-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816014456.2191776-1-damien.lemoal@wdc.com>
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
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

