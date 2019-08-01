Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120DEC19759
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 17:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D600220838
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 17:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WXNy6Q3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbfHAR1a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:27:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47212 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfHAR1a (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 13:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564680449; x=1596216449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=kr6NBKZc2Ega07jdtV+71j11WhC8y6Z4/tAAftdTck8=;
  b=WXNy6Q3cCaJl51jmI7f/AezC0LDvBDRs11xa0MVcYeu5cjh6hKboWDtW
   WtFDGm4Vz7pzHHgUwHVQ8thaoIxwb8pn++6jKqw+vprwYjqgRse5Y5D5Y
   xYXwZ0SXyyUuIbiWNR3qHVvdt6DoEOlGxISAZOKulPz+DjHvauEVZL+Lv
   Zlf37lI48SoYzBlEq61cGxI1gQsLmWF1AluevW3XeTPb6FP0dLkQW/GE8
   1m6hpcA6AY3UcTQOpXHtn4dB/ix3Rb6zVnyw9ECNiepC1pu7K/iw5UOvT
   X0kXPSU91oNpESI0iKetHffsZ29lIFooNeFmHHeWstNRjKbwmG3t9RZkH
   Q==;
IronPort-SDR: n1+yLOBwnIswHmBGJ/TKox/2w8/mTWP5b9ybTFKGNlssLGFcwjumt9sTgRHDdhb4NN2vUUN/je
 /EPzfWMB0A67sec7XwVa7aawqXEdRJXESHhlE97XXf1nH8P11v7KeME/PkliEkcfB6CaC0WGpe
 kwK4VWOnWrJDG3QC4fKspJGvN50dOAVoOcRj1h1+nvThwIi7nD++75SjJ7w8N35XYlwfvZyGpE
 usNzZFl+u3FeTSe/OhIfWwx4/6mewKHhI/hGLw+p4o1UcESizyjGel+iTMH0TJCZimmo5iqnFs
 ZIY=
X-IronPort-AV: E=Sophos;i="5.64,334,1559491200"; 
   d="scan'208";a="119390154"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2019 01:27:29 +0800
IronPort-SDR: Bc/r0WdCmf1fRThNnsDlV5FfXBCpPm968cUwjiX4t2sQcMOIyqOaKU4Xaf9tTg0ejfcVnIAkHR
 SNAy0MUGSc9BJn24zFiIyC+qar4VDIcYKmLGjtD0+F0/8/QUR+F4Ln4anJiBG2QyOiYDM+PFNG
 npY3Fso17wDZ/wSPqMDGEGAgchDyDGNsh8x1X1sA3AHgtaaMCWAOSrRiEoTe8Kz8hxRtjJCdyl
 m8D2dIeYEveQHnt5tn2c7TJ2tDFSwh21blNdVOJM67jTW/GUeVeBN9wOXXjvUb+/tCDxM/EsNF
 vFdWQou96zWoIimLh/vhs1za
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 10:25:27 -0700
IronPort-SDR: IMKp/7ZpF14OtQ62xQVbuK9VKTOf7dS+g3q7Z19dEkpTbZigNp80zYX88Y2GUrkUMcQBJUJNdz
 4WM+kvsHKQyVAaLAD5zRfWM0BtLlTxnDazPT1qQpHiPfHfxGAF3f22p+/bZkLJx+rkqVwvTwR3
 l2MVZzRIeZvMbyDTwTaWWuoFmxA+SgppxfimSe9j4wyC/sAtzBjzsmNX81YToGNgihmz42xTzA
 XwuKVuS1KtvsfWmOCHd36c9Qusl961X6Dqsvy8fvVG4rUurT+P10zvD5BoFkARJbHAfOMlji9O
 r6k=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Aug 2019 10:27:29 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, dennis@kernel.org,
        hare@suse.com, damien.lemoal@wdc.com, sagi@grimberg.me,
        dennisszhou@gmail.com, jthumshirn@suse.de, osandov@fb.com,
        ming.lei@redhat.com, tj@kernel.org, bvanassche@acm.org,
        martin.petersen@oracle.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 3/4] scsi: implement REQ_OP_ZONE_RESET_ALL
Date:   Thu,  1 Aug 2019 10:26:37 -0700
Message-Id: <20190801172638.4060-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
References: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
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
 drivers/scsi/sd.c     |  5 ++++-
 drivers/scsi/sd.h     |  5 +++--
 drivers/scsi/sd_zbc.c | 10 ++++++++--
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a3406bd62391..42ef930c4df5 100644
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
index db16c19e05c4..c1c7140ea787 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -209,10 +209,11 @@ static inline sector_t sd_zbc_zone_sectors(struct scsi_disk *sdkp)
 /**
  * sd_zbc_setup_reset_cmnd - Prepare a RESET WRITE POINTER scsi command.
  * @cmd: the command to setup
+ * @all: Reset all zones control.
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
@@ -487,6 +492,7 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 	/* The drive satisfies the kernel restrictions: set it up */
 	blk_queue_chunk_sectors(sdkp->disk->queue,
 			logical_to_sectors(sdkp->device, zone_blocks));
+	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, sdkp->disk->queue);
 	nr_zones = round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks);
 
 	/* READ16/WRITE16 is mandatory for ZBC disks */
-- 
2.17.0

