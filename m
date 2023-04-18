Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C73C77B76
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 22:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjDRWkd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 18:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjDRWk0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 18:40:26 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7608A41
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:21 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-63b733fd00bso1772535b3a.0
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857620; x=1684449620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WrYXntLkahaukdzYD3lJoBk6nGpoWNjG6dpCzkLcto=;
        b=ff7e8iCqPTIvVCscRtoapTA7mfel53Gjwjp2pDSARzv/Xe9PcZJGypUvM0JOVR1l7x
         WBLYhm4G2pxlmzszd63K7cbg74fr6c5pEgx5dIMhqdmDL2k6DMANAvJdCTS+UeXKP1e1
         3VJQ8BxwjN6KzhO1swFrwh+VSHhOkzdvxlGiP8EpJAQhZxoR/NmsWVj1WX8l+bQgBi4Q
         yEwc/+EIpT3L/oMoyWVEG01muQXdkR+6F8wrdt1G09TR4VzNnexYzfdKBm7Lj7dUcQ2z
         WHbwblV+3F21yD6fW91UD7SJlisiRk6fUyDxSrChEYf2Z46H9pY1tKL92DcocyjTPk1o
         e/Fw==
X-Gm-Message-State: AAQBX9chUDwEwm/Ef+CcUwaN1C3/I1hnCveCgtivU4id56yHlzH16FHV
        OZ69TT4Imy+XaEuLFrGKNoQ=
X-Google-Smtp-Source: AKy350anaoydd7KRlZSUAzOWRCmqOXfOxv67kP6DsGmO1J0b7L3lPXn6pojSdtO+o+Tterb8ybzekg==
X-Received: by 2002:a17:902:d492:b0:1a6:68fe:2ea2 with SMTP id c18-20020a170902d49200b001a668fe2ea2mr3980025plg.2.1681857620714;
        Tue, 18 Apr 2023 15:40:20 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5d9b:263d:206c:895a])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001a4ee93efa2sm8285646plb.137.2023.04.18.15.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:40:20 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 10/11] block: Add support for the zone capacity concept
Date:   Tue, 18 Apr 2023 15:40:01 -0700
Message-ID: <20230418224002.1195163-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230418224002.1195163-1-bvanassche@acm.org>
References: <20230418224002.1195163-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make the zone capacity available in struct queue_limits for those
drivers that need it.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 Documentation/ABI/stable/sysfs-block |  8 ++++++++
 block/blk-settings.c                 |  1 +
 block/blk-sysfs.c                    |  7 +++++++
 block/blk-zoned.c                    | 15 +++++++++++++++
 include/linux/blkdev.h               |  1 +
 5 files changed, 32 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index c57e5b7cb532..4527d0514fdb 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -671,6 +671,14 @@ Description:
 		regular block devices.
 
 
+What:		/sys/block/<disk>/queue/zone_capacity
+Date:		March 2023
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] The number of 512-byte sectors in a zone that can be read
+		or written. This number is less than or equal to the zone size.
+
+
 What:		/sys/block/<disk>/queue/zone_write_granularity
 Date:		January 2021
 Contact:	linux-block@vger.kernel.org
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 896b4654ab00..96f5dc63a815 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -685,6 +685,7 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 						   b->max_secure_erase_sectors);
 	t->zone_write_granularity = max(t->zone_write_granularity,
 					b->zone_write_granularity);
+	t->zone_capacity = max(t->zone_capacity, b->zone_capacity);
 	t->zoned = max(t->zoned, b->zoned);
 	return ret;
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index a64208583853..0443b8f536f4 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -337,6 +337,11 @@ static ssize_t queue_nr_zones_show(struct request_queue *q, char *page)
 	return queue_var_show(disk_nr_zones(q->disk), page);
 }
 
+static ssize_t queue_zone_capacity_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->limits.zone_capacity, page);
+}
+
 static ssize_t queue_max_open_zones_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(bdev_max_open_zones(q->disk->part0), page);
@@ -587,6 +592,7 @@ QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
 
 QUEUE_RO_ENTRY(queue_zoned, "zoned");
 QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
+QUEUE_RO_ENTRY(queue_zone_capacity, "zone_capacity");
 QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 
@@ -644,6 +650,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_nonrot_entry.attr,
 	&queue_zoned_entry.attr,
 	&queue_nr_zones_entry.attr,
+	&queue_zone_capacity_entry.attr,
 	&queue_max_open_zones_entry.attr,
 	&queue_max_active_zones_entry.attr,
 	&queue_nomerges_entry.attr,
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 9b9cd6adfd1b..a319acbe377b 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -463,6 +463,7 @@ struct blk_revalidate_zone_args {
 	unsigned long	*seq_zones_wlock;
 	unsigned int	nr_zones;
 	sector_t	zone_sectors;
+	sector_t	zone_capacity;
 	sector_t	sector;
 };
 
@@ -489,6 +490,7 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 		}
 
 		args->zone_sectors = zone->len;
+		args->zone_capacity = zone->capacity;
 		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
 	} else if (zone->start + args->zone_sectors < capacity) {
 		if (zone->len != args->zone_sectors) {
@@ -496,12 +498,23 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 				disk->disk_name);
 			return -ENODEV;
 		}
+		if (zone->capacity != args->zone_capacity) {
+			pr_warn("%s: Invalid zoned device with non constant zone capacity\n",
+				disk->disk_name);
+			return -ENODEV;
+		}
 	} else {
 		if (zone->len > args->zone_sectors) {
 			pr_warn("%s: Invalid zoned device with larger last zone size\n",
 				disk->disk_name);
 			return -ENODEV;
 		}
+		if (zone->capacity >
+		    min(args->zone_sectors, args->zone_capacity)) {
+			pr_warn("%s: Invalid zoned device with too large last zone capacity\n",
+				disk->disk_name);
+			return -ENODEV;
+		}
 	}
 
 	/* Check for holes in the zone report */
@@ -604,6 +617,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	blk_mq_freeze_queue(q);
 	if (ret > 0) {
 		blk_queue_chunk_sectors(q, args.zone_sectors);
+		q->limits.zone_capacity = args.zone_capacity;
 		disk->nr_zones = args.nr_zones;
 		swap(disk->seq_zones_wlock, args.seq_zones_wlock);
 		swap(disk->conv_zones_bitmap, args.conv_zones_bitmap);
@@ -635,6 +649,7 @@ void disk_clear_zone_settings(struct gendisk *disk)
 	disk->max_open_zones = 0;
 	disk->max_active_zones = 0;
 	q->limits.chunk_sectors = 0;
+	q->limits.zone_capacity = 0;
 	q->limits.zone_write_granularity = 0;
 	q->limits.max_zone_append_sectors = 0;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 261538319bbf..4fb0e6d7fdc8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -297,6 +297,7 @@ struct queue_limits {
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
 	unsigned int		zone_write_granularity;
+	unsigned int		zone_capacity;
 
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
