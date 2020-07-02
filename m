Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052DDC433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 06:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D780C20899
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 06:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="iSI69gI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgGBGzK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbgGBGzJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 02:55:09 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6A5C08C5C1
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 23:55:09 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lx13so9276339ejb.4
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2020 23:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KE1I2nGLyS8CRjZ/jic6a8RSadPgihMjPPFDgHjzHMg=;
        b=iSI69gI878xIDoelv9gFlLnZhYRwvAVY9q1JBjG2Qjd8i71nqsGwzLotgrgunzDkox
         AnhhPvj1drlVlMWWh7QHjdSH/9DRhJvTJo7/nsVISDJX/mTllv+2gF13q9z/zjxcsxQr
         6iLwiKFBIsNkMcsTOA1Bz9DZQr/CLy7bSqd5/L7MSl7MprYvmVDOKDUFLJjqQf7fj8bB
         7Jl+a6Ms8XOf8rBjVkQotXVRRmjG7tQaXN51yNyemj8lXcYrvJbVzTcJLRUhGQ+wXI5d
         l30oBMN/s2kQsa8ZvShhwoRQ6RsYRUHJKJ8o9F42zv88xiol012lmWmBE68vYqImRbjm
         /D8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KE1I2nGLyS8CRjZ/jic6a8RSadPgihMjPPFDgHjzHMg=;
        b=M1Acov41SkMqoBSLv1vbHhW2EUL8i1yR+IsJ5A7ENKykhpb57Q+a6X7zHqDOBopr9P
         tzMm5ib2ZLyCBrZbZRh2BAulD1/Ny2uvBLkiSC/4vuQeRIpmqC+ELrArM4ADZd6Mtl2p
         4bj7CE47ua7HgwrgH2gsVR3BcMMiIuSCushHgr46q+MaD0X0p/JhGoG4uL1TIp0oXKnS
         yiIZWEJgkhqOrzdJpHbbULSViNzwsWR5+XGe+Mmidid6g2cLiSEYKwY7BGcsYNnvWPSy
         2erGNxg8M598cqp7FteUjj6Q4YwGe23AgvTAOwkJEliVUS8F/9gB6STLjXsoN4QxFbJn
         jVeQ==
X-Gm-Message-State: AOAM533evyTD1+Ab2l9Gg9yBbYHK//98L1YkgJ5PPEt+xYE/T7pg1sHy
        7Ti8cvE4Kv2k9FnEAoqYMm/CZQ==
X-Google-Smtp-Source: ABdhPJwJG3y7TU8m5PYTa437Kd8cPSYym48DCfQUbSzji2cGVF6r8In6Ka+RH/eoCSwz0o1tdjAZmA==
X-Received: by 2002:a17:906:3e13:: with SMTP id k19mr25715216eji.476.1593672907887;
        Wed, 01 Jul 2020 23:55:07 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id cz2sm7912769edb.82.2020.07.01.23.55.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 23:55:07 -0700 (PDT)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, Damien.LeMoal@wdc.com,
        mb@lightnvm.io,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH 4/4] block: add attributes to zone report
Date:   Thu,  2 Jul 2020 08:54:38 +0200
Message-Id: <20200702065438.46350-5-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702065438.46350-1-javier@javigon.com>
References: <20200702065438.46350-1-javier@javigon.com>
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
index d785d179a343..749382a14968 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -118,7 +118,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
 	}
 
 	q->limits.zoned = BLK_ZONED_HM;
-	q->zone_flags = BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_OFFLINE;
+	q->zone_flags = BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_OFFLINE;
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
index e5adf4a9f4b0..315617827acd 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -78,10 +78,33 @@ enum blk_zone_cond {
  *
  * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
  * @BLK_ZONE_REP_OFFLINE : Zone device supports offline transition.
+ * @BLK_ZONE_REP_ATTR: Zone attributes reported.
  */
 enum blk_zone_report_flags {
 	BLK_ZONE_REP_CAPACITY	= (1 << 0),
 	BLK_ZONE_REP_OFFLINE	= (1 << 1),
+	BLK_ZONE_REP_ATTR	= (1 << 2),
+};
+
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
 };
 
 /**
@@ -110,7 +133,8 @@ struct blk_zone {
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

