Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C84C433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14AF720771
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Eiz0lbAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgGBJZT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgGBJZS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 05:25:18 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AED4C08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 02:25:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w6so28473418ejq.6
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2020 02:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RFQAZPjeEEYPnNvZUHiuMpATVhic2B+bZ8De7e+nmoI=;
        b=Eiz0lbAmK2GuapskPcLetUryfUEnrhbufhFxX+2rC0p89cws92fGcolnElsigE062O
         42STEJ0EaxP+HGZjgYn2sA2VXzKeQmaGDZly3yGtEfZx4rvPKrlSpLBCf0EejmGJLsx4
         bGhDx7WZz+Rz16H34AsqNZ+oX5ncXFR4IYAAhlxIwlNpWjmfUV3cYDvAJfLstA7wpBOy
         LTPx9bhOiQJ6Aeaw9g1fDQ8Ep3umS74Wkk6JbaMlrVeAm/BETjGAI7DhLJ2Btx+69X53
         cmoiMyYc3EiIiujXbnX5nnQ9A+MfagAg1Gq8R05I33L1gvBMrfc6spvnnWlMldiCqX1U
         VM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RFQAZPjeEEYPnNvZUHiuMpATVhic2B+bZ8De7e+nmoI=;
        b=LicTHTpyFGD1Sh4DJ0M1qptkLVczlmn9/rrVPrJwM7sLIPEuMIzUIpXJ/RnEkQiCFZ
         PYoStdmfvK4kqNMwq6GeBWejdfEhNVrip72se2BgV263crRxTc6PZP/qOeuq7JpqjGJB
         r5E8v8fyJRQotafunKNKEFZGt0vMbJfhL+96Rnag8y8y2+KJ20cgsYmrkX8f9r73Lamz
         1fXA39ndWAXk3zcjiFJ8EL0mEdX2FY2fjGoxe753UoNFNKOodSE59lTTkCi3ORc09Aka
         H2LAgcHaYiwClp0AtvPbgapIZ8IcH7iMHGiT84JJ1/wDvWgBdiDG9p7i7IWsYCwezNpz
         CLag==
X-Gm-Message-State: AOAM532cLvA9PPZLwsw6BXmiNlo7glPl1dscDjuExsciZ+cJ/FPQzYHf
        medCunh//r80ojULIjPUY/hxUQ==
X-Google-Smtp-Source: ABdhPJynySCUYW9OcsHXk9q3JwHz0Wmor0c6AIMY6LxpHHERrZ9Q1QmtUZAnZR2fonz7CQR0wbc2+g==
X-Received: by 2002:a17:906:924d:: with SMTP id c13mr20309117ejx.518.1593681917258;
        Thu, 02 Jul 2020 02:25:17 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id b18sm6569464ejl.52.2020.07.02.02.25.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 02:25:16 -0700 (PDT)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, Damien.LeMoal@wdc.com,
        mb@lightnvm.io, Johannes.Thumshirn@wdc.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH v3 1/4] block: Add zone flags to queue zone prop.
Date:   Thu,  2 Jul 2020 11:24:35 +0200
Message-Id: <20200702092438.63717-2-javier@javigon.com>
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

As the zoned block device will have to deal with features that are
optional for the backend device, add a flag field to inform the block
layer about supported features. This builds on top of
blk_zone_report_flags and extendes to the zone report code.

Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-zoned.c              | 3 ++-
 drivers/block/null_blk_zoned.c | 2 ++
 drivers/nvme/host/zns.c        | 1 +
 drivers/scsi/sd.c              | 2 ++
 include/linux/blkdev.h         | 3 +++
 5 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 81152a260354..0f156e96e48f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -312,7 +312,8 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 		return ret;
 
 	rep.nr_zones = ret;
-	rep.flags = BLK_ZONE_REP_CAPACITY;
+	rep.flags = q->zone_flags;
+
 	if (copy_to_user(argp, &rep, sizeof(struct blk_zone_report)))
 		return -EFAULT;
 	return 0;
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index b05832eb21b2..957c2103f240 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -78,6 +78,8 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	}
 
 	q->limits.zoned = BLK_ZONED_HM;
+	q->zone_flags = BLK_ZONE_REP_CAPACITY;
+
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
 
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index c08f6281b614..afe62dc27ff7 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -81,6 +81,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
 	}
 
 	q->limits.zoned = BLK_ZONED_HM;
+	q->zone_flags = BLK_ZONE_REP_CAPACITY;
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 free_data:
 	kfree(id);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index d90fefffe31b..b9c920bace28 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2967,6 +2967,7 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
 	if (sdkp->device->type == TYPE_ZBC) {
 		/* Host-managed */
 		q->limits.zoned = BLK_ZONED_HM;
+		q->zone_flags = BLK_ZONE_REP_CAPACITY;
 	} else {
 		sdkp->zoned = (buffer[8] >> 4) & 3;
 		if (sdkp->zoned == 1 && !disk_has_partitions(sdkp->disk)) {
@@ -2983,6 +2984,7 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
 					  "Drive-managed SMR disk\n");
 		}
 	}
+
 	if (blk_queue_is_zoned(q) && sdkp->first_scan)
 		sd_printk(KERN_NOTICE, sdkp, "Host-%s zoned block device\n",
 		      q->limits.zoned == BLK_ZONED_HM ? "managed" : "aware");
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8fd900998b4e..3f2e3425fa53 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -512,12 +512,15 @@ struct request_queue {
 	 * Stacking drivers (device mappers) may or may not initialize
 	 * these fields.
 	 *
+	 * Flags represent features as described by blk_zone_report_flags in blkzoned.h
+	 *
 	 * Reads of this information must be protected with blk_queue_enter() /
 	 * blk_queue_exit(). Modifying this information is only allowed while
 	 * no requests are being processed. See also blk_mq_freeze_queue() and
 	 * blk_mq_unfreeze_queue().
 	 */
 	unsigned int		nr_zones;
+	unsigned int		zone_flags;
 	unsigned long		*conv_zones_bitmap;
 	unsigned long		*seq_zones_wlock;
 #endif /* CONFIG_BLK_DEV_ZONED */
-- 
2.17.1

