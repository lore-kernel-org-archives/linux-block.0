Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ADAC433E1
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 581E620771
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="foGWa1ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgGBJZX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgGBJZW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 05:25:22 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264CDC08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 02:25:22 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dg28so22871753edb.3
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2020 02:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=seRLkTJ1ew4YebKz5kRgT9SUY7OCSuZACxJCKoWfuZU=;
        b=foGWa1dsgrf7XlkYun30ylm+oVae2e0vGCrDEY5d+yLiehK3nXxUKrq94J0D6UZGfO
         A5IkWYJ2ie2kUDHv1jyVIP0NklwVMJS0vBb3CXHU04K73WGCo1sCGKcNNW56WNUZNqHq
         cUQskNEhasm+hFP0VQamaDobvqMr9h5sotB6Hf3Zliy2TEvCpKuhSuYk75BjKFBl0pWX
         SPGh5qLgn95pKj4hFpPVZEvSoYSJUAEl9Vi07OFZMY7cmH+Dmgdb7NuGq52/DPyLdUQ4
         xpwmH7dU3ghroDzNRO1uGM5Nq66F9ncYt/yFDSLwP5LTwNglE1tuga8v2buo9OuZRQ9g
         wg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=seRLkTJ1ew4YebKz5kRgT9SUY7OCSuZACxJCKoWfuZU=;
        b=iOAk0x8UJ1/osw8W4e0U1YmiLjIbXH2mVBtffMeytdXEOigZQJBLmduQUw/hFyjOSc
         wfGBh7S2if2J/EtJZoHt7Ql5P0COfMvzO+25IaxRi6y5YgQk1F2wWbecPENS5koLleNi
         N2/u1MvrtUNrwgwtJp9QoUJU1lW7aPoimqL7bomxbWFGeU5GfHP8mwIHZRNAaLXIcA4P
         AS5AzCZeovfdUCoDae+gTDzn7FDoccYr6HJIpRPYzUmtjb5K+8aLGjBQ19eCvLCv0DDy
         UZDwHCYhwE2GkBlruwSb0zloxRbPJWp26GICerSaXarXzKatunRBEKALY8YTUAWkYWLo
         uUFw==
X-Gm-Message-State: AOAM532jjl027loTNclBr8FhkiN9EDGBsCCl90tMkwZiCO8/G6wIpu3L
        xI5ltmFLQTacsrv42FYXn2KdeA==
X-Google-Smtp-Source: ABdhPJxTEh6o6QgeknmvbHZn321/KVXjaNE5zNnvEz1twZV4AdY5tcuAThmt+lLBqhFL79C5Yj0YuA==
X-Received: by 2002:a05:6402:1d18:: with SMTP id dg24mr34180761edb.33.1593681920863;
        Thu, 02 Jul 2020 02:25:20 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id b18sm6569464ejl.52.2020.07.02.02.25.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 02:25:20 -0700 (PDT)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, Damien.LeMoal@wdc.com,
        mb@lightnvm.io, Johannes.Thumshirn@wdc.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH v3 4/4] block: add attributes to zone report
Date:   Thu,  2 Jul 2020 11:24:38 +0200
Message-Id: <20200702092438.63717-5-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702092438.63717-1-javier@javigon.com>
References: <20200702092438.63717-1-javier@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

Add zone attributes field to the blk_zone structure. Use ZNS attributes
as base for zoned block devices and add the current atributes in
ZAC/ZBC.

Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/nvme/host/zns.c       |  3 ++-
 drivers/scsi/sd.c             |  2 +-
 drivers/scsi/sd_zbc.c         |  8 ++++++--
 include/uapi/linux/blkzoned.h | 26 +++++++++++++++++++++++++-
 4 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index daf0d91bcdf6..926904d1827b 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -118,7 +118,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
 	}
 
 	q->limits.zoned = BLK_ZONED_HM;
-	q->zone_flags = BLK_ZONE_REP_CAPACITY | BLK_ZONE_SUP_OFFLINE;
+	q->zone_flags = BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_CAPACITY | BLK_ZONE_SUP_OFFLINE;
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 free_data:
 	kfree(id);
@@ -197,6 +197,7 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
 	zone.capacity = nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
 	zone.start = nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
 	zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
+	zone.attr = entry->za;
 
 	return cb(&zone, idx, data);
 }
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index b9c920bace28..63270598aa76 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2967,7 +2967,7 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
 	if (sdkp->device->type == TYPE_ZBC) {
 		/* Host-managed */
 		q->limits.zoned = BLK_ZONED_HM;
-		q->zone_flags = BLK_ZONE_REP_CAPACITY;
+		q->zone_flags = BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_ATTR;
 	} else {
 		sdkp->zoned = (buffer[8] >> 4) & 3;
 		if (sdkp->zoned == 1 && !disk_has_partitions(sdkp->disk)) {
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 183a20720da9..51c7f82b59c5 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -53,10 +53,14 @@ static int sd_zbc_parse_report(struct scsi_disk *sdkp, u8 *buf,
 
 	zone.type = buf[0] & 0x0f;
 	zone.cond = (buf[1] >> 4) & 0xf;
-	if (buf[1] & 0x01)
+	if (buf[1] & 0x01) {
+		zone.attr |= BLK_ZONE_ATTR_NRW;
 		zone.reset = 1;
-	if (buf[1] & 0x02)
+	}
+	if (buf[1] & 0x02) {
+		zone.attr |= BLK_ZONE_ATTR_NSQ;
 		zone.non_seq = 1;
+	}
 
 	zone.len = logical_to_sectors(sdp, get_unaligned_be64(&buf[8]));
 	zone.capacity = zone.len;
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index 8b7c4705cef7..b48b8cb129a2 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -77,16 +77,39 @@ enum blk_zone_cond {
  * enum blk_zone_report_flags - Feature flags of reported zone descriptors.
  *
  * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
+ * @BLK_ZONE_REP_ATTR: Zone attributes reported.
  * @BLK_ZONE_SUP_OFFLINE : Zone device supports explicit offline transition.
  */
 enum blk_zone_report_flags {
 	/* Report feature flags */
 	BLK_ZONE_REP_CAPACITY	= (1 << 0),
+	BLK_ZONE_REP_ATTR	= (1 << 2),
 
 	/* Supported capabilities */
 	BLK_ZONE_SUP_OFFLINE	= (1 << 1),
 };
 
+/**
+ * enum blk_zone_attr - Zone Attributes
+ *
+ * Attributes of the zone. Reported in struct blk_zone -> attr
+ *
+ * @BLK_ZONE_ATTR_ZFC: Zone Finished by Controller due to a zone active excursion
+ * @BLK_ZONE_ATTR_FZR: Finish Zone Recommended required by controller
+ * @BLK_ZONE_ATTR_RZR: Reset Zone Recommended required by controller
+ * @BLK_ZONE_ATTR_NSQ: Non Sequential zone
+ * @BLK_ZONE_ATTR_NRW: Need Reset Write Pointer required by controller
+ * @BLK_ZONE_ATTR_ZDEV: Zone Descriptor Extension Valid in zone report
+ */
+enum blk_zone_attr {
+	BLK_ZONE_ATTR_ZFC	= 1 << 0,
+	BLK_ZONE_ATTR_FZR	= 1 << 1,
+	BLK_ZONE_ATTR_RZR	= 1 << 2,
+	BLK_ZONE_ATTR_NSQ	= 1 << 3,
+	BLK_ZONE_ATTR_NRW	= 1 << 4,
+	BLK_ZONE_ATTR_ZDEV	= 1 << 7,
+};
+
 /**
  * struct blk_zone - Zone descriptor for BLKREPORTZONE ioctl.
  *
@@ -113,7 +136,8 @@ struct blk_zone {
 	__u8	cond;		/* Zone condition */
 	__u8	non_seq;	/* Non-sequential write resources active */
 	__u8	reset;		/* Reset write pointer recommended */
-	__u8	resv[4];
+	__u8	attr;		/* Zone attributes */
+	__u8	resv[3];
 	__u64	capacity;	/* Zone capacity in number of sectors */
 	__u8	reserved[24];
 };
-- 
2.17.1

