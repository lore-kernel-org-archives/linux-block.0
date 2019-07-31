Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C989CC32751
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 21:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A434F2064A
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 21:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pii71/Qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfGaVBz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 17:01:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:56740 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfGaVBy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 17:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564606913; x=1596142913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=pQBm1c2isaDkQpGZVuJLwH7GcVWpg75894VS20D5BE8=;
  b=pii71/Qcnd17LSVr1zMCeKwBJTwSyFibbWX+twuHMBaQcNxkc0w7P2u5
   Xlscvau2PkitG9ZTa+8ec5vQk6suN89HG/5kiubcxwTYqhOzkebKOoz+J
   8q8OwVAa+KbIYXnG3muojJWAI0W+KJOKIEqAGfI81tJPS3uINreyKAEtY
   vunz+um4USk6C32RiA3Ktqkec9CJ3dOrxtX2oE3lUGLuUtyKDHfz+xVI4
   /lWLCuZB7+PK4HAXtuaYRXTf2RU+2mGN4uU8NQYtmqzVSKumo3atxlcCs
   XaaRZIoc7nhT0s0lCS8Yf89cwDhBi9hvMZVZeEzm56h57HyIDTYjxm2l+
   w==;
IronPort-SDR: i9Fbjs8tijzZk7rdNqh4wv4tHPfLa4ewEBL3Evh+6v8Ki5PlDHsArO0uQPWv6Q3l3/HT1t/pD1
 6O1FQqYIJOolAMLSqI6UGqhEP+QNx1V3hBu8xhhwe8h5L6Pxh+o09SsoHsD5Y98OzNzWYGburz
 GSQBJbVI3yDnminXykclLTP2flxAt1y9BY0XDjgwdeKcCkSTaDlCmu95eiC89SsMVozgczVXOc
 fhagV66u/qvgU0X38MLgvNcu7PT1KBWdhoojuC5AVxDbAszO2E18ZxoIg1M21OSOX/zbi7wGoW
 ysw=
X-IronPort-AV: E=Sophos;i="5.64,331,1559491200"; 
   d="scan'208";a="114637466"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 05:01:53 +0800
IronPort-SDR: M26nqZN3lX1hMwr1YnexKxLfEiu+gLU2FfFuarniex0SAdS+hXYIY1rJo8Y6HRKTg0IqmRpJfa
 UKzAvsxVE6hStsNhT7bAaEEhmtcwLGCzWEK1gEzg+u/knhrWG9ZSLjVzdQuJMWozHdf3uEsT1y
 BXTUh5uF6oQp8qxhEqdwDr7xblHAFuFD0vnR6qqyolLXPPgjiISutIjKiSMR0vDjsGs96rniUT
 DoLmIr8kgQJtVKr6+i5yX0u2tN5e6x94XMpC3BJRfNd/Fr0Z9sv67x4lVgd83uJzT7v4sQoXFk
 mYu08GLZLgK6z47+uXK/jxAF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 13:59:53 -0700
IronPort-SDR: U+NZCvs3trVgxAdGAS9nxoOFfSwLdUdcP2Qys0wlo20YU5wxF755qmE33357NatlxhcER91FHd
 8YMO0iREoAUifpbccIgL/xNj7XeQFVCeCBMJEyjBLR1WY4dVarYUPPVR2ASB+oplL7SPaRrglS
 XHCQVFv96htt1nrPuEL5zcnBZXiFOEaao++LOXJi3/MEkLOGKDLM0kDevb7av6rLEuui+KO8KI
 1oErFLvBD5Izoc4bJ63n8Q1cDtchPsZntx57dOP81XGItVEaFlYsVx8nAIwwI66XsfPM/AC0pY
 P5U=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2019 14:01:52 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, dennis@kernel.org,
        hare@suse.com, damien.lemoal@wdc.com, sagi@grimberg.me,
        dennisszhou@gmail.com, jthumshirn@suse.de, osandov@fb.com,
        ming.lei@redhat.com, tj@kernel.org, bvanassche@acm.org,
        martin.petersen@oracle.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/4] scsi: implement REQ_OP_ZONE_RESET_ALL
Date:   Wed, 31 Jul 2019 14:01:01 -0700
Message-Id: <20190731210102.3472-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190731210102.3472-1-chaitanya.kulkarni@wdc.com>
References: <20190731210102.3472-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch implements the zone reset all operation for sd_zbc.c. We add
a new boolean parameter for the sd_zbc_setup_reset_cmd() to indicate
REQ_OP_ZONE_RESET_ALL command setup. Along with that we add support in
the completion path for the zone reset all.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/scsi/sd.c     | 7 ++++++-
 drivers/scsi/sd.h     | 5 +++--
 drivers/scsi/sd_zbc.c | 9 +++++++--
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a3406bd62391..620a6d743952 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1292,7 +1292,9 @@ static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
 	case REQ_OP_WRITE:
 		return sd_setup_read_write_cmnd(cmd);
 	case REQ_OP_ZONE_RESET:
-		return sd_zbc_setup_reset_cmnd(cmd);
+		return sd_zbc_setup_reset_cmnd(cmd, false);
+	case REQ_OP_ZONE_RESET_ALL:
+		return sd_zbc_setup_reset_cmnd(cmd, true);
 	default:
 		WARN_ON_ONCE(1);
 		return BLK_STS_NOTSUPP;
@@ -1958,6 +1960,7 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE_SAME:
 	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_RESET_ALL:
 		if (!result) {
 			good_bytes = blk_rq_bytes(req);
 			scsi_set_resid(SCpnt, 0);
@@ -2948,6 +2951,8 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
 			 */
 			q->limits.zoned = BLK_ZONED_NONE;
 	}
+	if (q->limits.zoned != BLK_ZONED_NONE)
+		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	if (blk_queue_is_zoned(q) && sdkp->first_scan)
 		sd_printk(KERN_NOTICE, sdkp, "Host-%s zoned block device\n",
 		      q->limits.zoned == BLK_ZONED_HM ? "managed" : "aware");
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 38c50946fc42..1eab779f812b 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -209,7 +209,7 @@ static inline int sd_is_zoned(struct scsi_disk *sdkp)
 
 extern int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buffer);
 extern void sd_zbc_print_zones(struct scsi_disk *sdkp);
-extern blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd);
+extern blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd, bool all);
 extern void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
 			    struct scsi_sense_hdr *sshdr);
 extern int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
@@ -225,7 +225,8 @@ static inline int sd_zbc_read_zones(struct scsi_disk *sdkp,
 
 static inline void sd_zbc_print_zones(struct scsi_disk *sdkp) {}
 
-static inline blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd)
+static inline blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd,
+						   bool all)
 {
 	return BLK_STS_TARGET;
 }
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index db16c19e05c4..538216b9e1f4 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -209,10 +209,11 @@ static inline sector_t sd_zbc_zone_sectors(struct scsi_disk *sdkp)
 /**
  * sd_zbc_setup_reset_cmnd - Prepare a RESET WRITE POINTER scsi command.
  * @cmd: the command to setup
+ * @all: flag to prepare a RESET ALL WRITE POINTER scsi command.
  *
  * Called from sd_init_command() for a REQ_OP_ZONE_RESET request.
  */
-blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd)
+blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd, bool all)
 {
 	struct request *rq = cmd->request;
 	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
@@ -234,7 +235,10 @@ blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd)
 	memset(cmd->cmnd, 0, cmd->cmd_len);
 	cmd->cmnd[0] = ZBC_OUT;
 	cmd->cmnd[1] = ZO_RESET_WRITE_POINTER;
-	put_unaligned_be64(block, &cmd->cmnd[2]);
+	if (all)
+		cmd->cmnd[14] = 0x1;
+	else
+		put_unaligned_be64(block, &cmd->cmnd[2]);
 
 	rq->timeout = SD_TIMEOUT;
 	cmd->sc_data_direction = DMA_NONE;
@@ -261,6 +265,7 @@ void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
 
 	switch (req_op(rq)) {
 	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_RESET_ALL:
 
 		if (result &&
 		    sshdr->sense_key == ILLEGAL_REQUEST &&
-- 
2.17.0

