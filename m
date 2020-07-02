Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D0AC433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 06:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B09A42085B
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 06:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ASNQQXlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGBGzG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgGBGzG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 02:55:06 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D76BC08C5C1
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 23:55:05 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dp18so27944991ejc.8
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2020 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jNqe3xdMxYATpvkBSQ9DPSFzqAXCkxXTgUf0+2M14v8=;
        b=ASNQQXlO2BS6HubW/chFoh77ZBHR2d6dw101imcfuWkntcyR6qnBw/a48xBQzmstf5
         7DLyUy+9rDpTkYmCjsQwhx48rHwV5sT4dnPHCaHEQew3/UEj0Tfbfip1wiIxE6p5vl65
         DE0KRZhDCoR+v4BnF9R0xaYOERxUe0+1qd8gV3RUKVJYQrQyEqGIbEJZNJUAivUqEjHh
         7JzNU3P9jYtOL/D8D4645XG2Y80izIk+D86VrSHJF/lQUKjAyKdnpPzR6DefMNGG8BdR
         ikF1YNpH/eKDeOPkeaivUdgVDXeJhF8+62WkqPnkjBdVWD8saaOAW/EpFKj5gJTNgUzY
         SSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jNqe3xdMxYATpvkBSQ9DPSFzqAXCkxXTgUf0+2M14v8=;
        b=BQicgA2Tr+272halb1AcpBu/tk60QmVkjuHZ1RWANKY76przEg05v/xllWsTmaC551
         wBLCoQxuCoR/1WxL8HP5XtUFrtXh3Wpc2ws3649ThbEGTtZr4bzYA6CeWBU6Mzhiry6y
         jftHBvAMgVUPJm9a5tAwO7Gg26FpEH17JBe+pHEuQUj7PXTI5STCi3jxVIz/W/vsyhTL
         oWQRgSouyyw63sRDaW2DTYsUxPxKQpf0ecx04hI3kbDaIV1WD0j/xANkQqf1hhrayJly
         nFvafjpVkrZOWmLF11SfrBei14nzrfX1vd4bd7yZ2ouPmp5A/WlfyFp+T4Qfi2yxM6T+
         7DFg==
X-Gm-Message-State: AOAM531bGlv3Q5ARJdYuj4f2/OCbjneCw7aISle1Ns5ezYAFZo5popnj
        9wQdgk3YEWAr3wQsbgJ/HzWJku7Wc2P6G2Lb
X-Google-Smtp-Source: ABdhPJxDuednJiBTcKqTYBXgxGdlZ70OidSmz7DMv99/hfqdMejYL8GqON/h3xnBNhSzE3cnX69bTQ==
X-Received: by 2002:a17:906:33ca:: with SMTP id w10mr18822882eja.171.1593672904159;
        Wed, 01 Jul 2020 23:55:04 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id cz2sm7912769edb.82.2020.07.01.23.55.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 23:55:03 -0700 (PDT)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, Damien.LeMoal@wdc.com,
        mb@lightnvm.io,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH 1/4] block: Add zone flags to queue zone prop.
Date:   Thu,  2 Jul 2020 08:54:35 +0200
Message-Id: <20200702065438.46350-2-javier@javigon.com>
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
index 0642d3c54e8f..888264261ba3 100644
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

