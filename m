Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBE9C47089
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15AD561417
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhEYV0o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 17:26:44 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36430 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhEYV0n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 17:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621977913; x=1653513913;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=NFDVj12G1cIiBpkkJ+xVxGjioQchYAhGgThHQ32LasU=;
  b=ip+IfTMy7gfgysVCNl4FPvLMtO6+37Hzj9YcJ9SXsS1/jwpE2zCsdq57
   cB5pY5bZBM687Vu9qTHbQqVmmhgmutHcbWTL+/1sbk77FoN2rHgErWArS
   Hhz5C6gHZd94DEiSvsehfrlFASnLDYgGpA59cobRV1cUrZiDt9dUxhOkQ
   EmcVOQlEOBAgOk/GIFCidcri+rZv/99UrCfrQmWZQvQhHrsjcmmh+NWOw
   9L6w7UIrAPWzObLcKxTrytgXY5HFHM60RKKMzkd60Cdwy8ypWRwTf/fNY
   z7g6KTbpar9NZwFDI8zzHK3dhMLRnj8480AnCFWDshB2Co6Ee0QYxm6aH
   A==;
IronPort-SDR: mhK98u00I1XIpIyylb6ujbEdHfc4Wu5pVTWb7YE/5DMzBWXLR+GYRe+upx5P/WfuchYwvHvQZH
 mTDBgrTrzGv/fVlBpHuntYYJQxDVrYExTqRzTlYAy5dl66qVRbytlC4LHw6ukmKtRkH7Hx4zth
 4LWM1kkAYMxw8sABEFwPI9Oc0bTHLAO7RBObpn8cbbpvMFoKbTQwQU/MSe9CGp3+ubnzSUhGdb
 OkifQ1fPprza455fK0H0ZYAB1V1ObCYW+R7188IPAOUrJvuzJoCJBKDS7v9RO6Yh9K3n1KwCUb
 iIU=
X-IronPort-AV: E=Sophos;i="5.82,329,1613404800"; 
   d="scan'208";a="168717528"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2021 05:25:11 +0800
IronPort-SDR: /UuhItDH9nKnQ+cYek/imHdA2KKavZzXIIY0ynHuHK8cdZMqJ4ErwSXimnKMHzYfw6mcdiCwgd
 SOgZNDQVd0YXVj0ZxwauSJq8Lj3bWZynMS0k1FNAnmsbbjaEIaqlucT1w47iuAVjNdaLFkORgb
 SL62NMTljz7zcrGKP78YbFWG3hPJm6Tw+DO/UC1Xx/i6oJyDoMons+epdOScqjwBQFu+NbHyIp
 uDI/C5lvsdoTpf3EfEDtZrR7RVVmQNT1qni+ZywM5U8wY5mN9bPlr7qytwFUDICBNQQpbOw/MD
 t5vS5Iqc0j7Itw7+AZWI3lne
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 14:04:38 -0700
IronPort-SDR: nVgte37Yi4En00VqZY7CHg2Ck5Zja5zDiLxN7bmoDn3lgi8jozlu5qA8xlNQAX5otyotwy1POE
 wnrIvT7XFaXuTBNZxG7fsW8uCP0TMiKZcQDtliy1743VHxaoDvP2Gx6m0meCu9O76DPSMK8l+0
 MzWMj+2KOi2rXRqf5QzQBuqNZgTYV+s0Hx0OrNzwmHb5lU9HeRKR4MDvrpV016vKyKG/nSxeJB
 e1nrWZZ7AlTUe3JjnTdkPl2PkCyJGiRGObKSLN4V2G3CzCjdmgR8SY4yVdCUEMfbYWqL1Fw1MW
 bnw=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 May 2021 14:25:11 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v5 06/11] dm: move zone related code to dm-zone.c
Date:   Wed, 26 May 2021 06:24:56 +0900
Message-Id: <20210525212501.226888-7-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525212501.226888-1-damien.lemoal@wdc.com>
References: <20210525212501.226888-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move core and table code used for zoned targets and conditionally
defined with #ifdef CONFIG_BLK_DEV_ZONED to the new file dm-zone.c.
This file is conditionally compiled depending on CONFIG_BLK_DEV_ZONED.
The small helper dm_set_zones_restrictions() is introduced to
initialize a mapped device request queue zone attributes in
dm_table_set_restrictions().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/md/Makefile   |   4 ++
 drivers/md/dm-table.c |  14 ++----
 drivers/md/dm-zone.c  | 102 ++++++++++++++++++++++++++++++++++++++++++
 drivers/md/dm.c       |  78 --------------------------------
 drivers/md/dm.h       |  11 +++++
 5 files changed, 120 insertions(+), 89 deletions(-)
 create mode 100644 drivers/md/dm-zone.c

diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index ef7ddc27685c..a74aaf8b1445 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -92,6 +92,10 @@ ifeq ($(CONFIG_DM_UEVENT),y)
 dm-mod-objs			+= dm-uevent.o
 endif
 
+ifeq ($(CONFIG_BLK_DEV_ZONED),y)
+dm-mod-objs			+= dm-zone.o
+endif
+
 ifeq ($(CONFIG_DM_VERITY_FEC),y)
 dm-verity-objs			+= dm-verity-fec.o
 endif
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 21fd9cd4da32..dd9f648ab598 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -2064,17 +2064,9 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	    dm_table_any_dev_attr(t, device_is_not_random, NULL))
 		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
 
-	/*
-	 * For a zoned target, the number of zones should be updated for the
-	 * correct value to be exposed in sysfs queue/nr_zones. For a BIO based
-	 * target, this is all that is needed.
-	 */
-#ifdef CONFIG_BLK_DEV_ZONED
-	if (blk_queue_is_zoned(q)) {
-		WARN_ON_ONCE(queue_is_mq(q));
-		q->nr_zones = blkdev_nr_zones(t->md->disk);
-	}
-#endif
+	/* For a zoned target, setup the zones related queue attributes */
+	if (blk_queue_is_zoned(q))
+		dm_set_zones_restrictions(t, q);
 
 	dm_update_keyslot_manager(q, t);
 	blk_queue_update_readahead(q);
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
new file mode 100644
index 000000000000..3243c42b7951
--- /dev/null
+++ b/drivers/md/dm-zone.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/blkdev.h>
+
+#include "dm-core.h"
+
+/*
+ * User facing dm device block device report zone operation. This calls the
+ * report_zones operation for each target of a device table. This operation is
+ * generally implemented by targets using dm_report_zones().
+ */
+int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
+			unsigned int nr_zones, report_zones_cb cb, void *data)
+{
+	struct mapped_device *md = disk->private_data;
+	struct dm_table *map;
+	int srcu_idx, ret;
+	struct dm_report_zones_args args = {
+		.next_sector = sector,
+		.orig_data = data,
+		.orig_cb = cb,
+	};
+
+	if (dm_suspended_md(md))
+		return -EAGAIN;
+
+	map = dm_get_live_table(md, &srcu_idx);
+	if (!map) {
+		ret = -EIO;
+		goto out;
+	}
+
+	do {
+		struct dm_target *tgt;
+
+		tgt = dm_table_find_target(map, args.next_sector);
+		if (WARN_ON_ONCE(!tgt->type->report_zones)) {
+			ret = -EIO;
+			goto out;
+		}
+
+		args.tgt = tgt;
+		ret = tgt->type->report_zones(tgt, &args,
+					      nr_zones - args.zone_idx);
+		if (ret < 0)
+			goto out;
+	} while (args.zone_idx < nr_zones &&
+		 args.next_sector < get_capacity(disk));
+
+	ret = args.zone_idx;
+out:
+	dm_put_live_table(md, srcu_idx);
+	return ret;
+}
+
+int dm_report_zones_cb(struct blk_zone *zone, unsigned int idx, void *data)
+{
+	struct dm_report_zones_args *args = data;
+	sector_t sector_diff = args->tgt->begin - args->start;
+
+	/*
+	 * Ignore zones beyond the target range.
+	 */
+	if (zone->start >= args->start + args->tgt->len)
+		return 0;
+
+	/*
+	 * Remap the start sector and write pointer position of the zone
+	 * to match its position in the target range.
+	 */
+	zone->start += sector_diff;
+	if (zone->type != BLK_ZONE_TYPE_CONVENTIONAL) {
+		if (zone->cond == BLK_ZONE_COND_FULL)
+			zone->wp = zone->start + zone->len;
+		else if (zone->cond == BLK_ZONE_COND_EMPTY)
+			zone->wp = zone->start;
+		else
+			zone->wp += sector_diff;
+	}
+
+	args->next_sector = zone->start + zone->len;
+	return args->orig_cb(zone, args->zone_idx++, args->orig_data);
+}
+EXPORT_SYMBOL_GPL(dm_report_zones_cb);
+
+void dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
+{
+	if (!blk_queue_is_zoned(q))
+		return;
+
+	/*
+	 * For a zoned target, the number of zones should be updated for the
+	 * correct value to be exposed in sysfs queue/nr_zones. For a BIO based
+	 * target, this is all that is needed.
+	 */
+	WARN_ON_ONCE(queue_is_mq(q));
+	q->nr_zones = blkdev_nr_zones(t->md->disk);
+}
+
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 11af20080639..c49976cc4e44 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -444,84 +444,6 @@ static int dm_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return dm_get_geometry(md, geo);
 }
 
-#ifdef CONFIG_BLK_DEV_ZONED
-int dm_report_zones_cb(struct blk_zone *zone, unsigned int idx, void *data)
-{
-	struct dm_report_zones_args *args = data;
-	sector_t sector_diff = args->tgt->begin - args->start;
-
-	/*
-	 * Ignore zones beyond the target range.
-	 */
-	if (zone->start >= args->start + args->tgt->len)
-		return 0;
-
-	/*
-	 * Remap the start sector and write pointer position of the zone
-	 * to match its position in the target range.
-	 */
-	zone->start += sector_diff;
-	if (zone->type != BLK_ZONE_TYPE_CONVENTIONAL) {
-		if (zone->cond == BLK_ZONE_COND_FULL)
-			zone->wp = zone->start + zone->len;
-		else if (zone->cond == BLK_ZONE_COND_EMPTY)
-			zone->wp = zone->start;
-		else
-			zone->wp += sector_diff;
-	}
-
-	args->next_sector = zone->start + zone->len;
-	return args->orig_cb(zone, args->zone_idx++, args->orig_data);
-}
-EXPORT_SYMBOL_GPL(dm_report_zones_cb);
-
-static int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
-		unsigned int nr_zones, report_zones_cb cb, void *data)
-{
-	struct mapped_device *md = disk->private_data;
-	struct dm_table *map;
-	int srcu_idx, ret;
-	struct dm_report_zones_args args = {
-		.next_sector = sector,
-		.orig_data = data,
-		.orig_cb = cb,
-	};
-
-	if (dm_suspended_md(md))
-		return -EAGAIN;
-
-	map = dm_get_live_table(md, &srcu_idx);
-	if (!map) {
-		ret = -EIO;
-		goto out;
-	}
-
-	do {
-		struct dm_target *tgt;
-
-		tgt = dm_table_find_target(map, args.next_sector);
-		if (WARN_ON_ONCE(!tgt->type->report_zones)) {
-			ret = -EIO;
-			goto out;
-		}
-
-		args.tgt = tgt;
-		ret = tgt->type->report_zones(tgt, &args,
-					      nr_zones - args.zone_idx);
-		if (ret < 0)
-			goto out;
-	} while (args.zone_idx < nr_zones &&
-		 args.next_sector < get_capacity(disk));
-
-	ret = args.zone_idx;
-out:
-	dm_put_live_table(md, srcu_idx);
-	return ret;
-}
-#else
-#define dm_blk_report_zones		NULL
-#endif /* CONFIG_BLK_DEV_ZONED */
-
 static int dm_prepare_ioctl(struct mapped_device *md, int *srcu_idx,
 			    struct block_device **bdev)
 {
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index b441ad772c18..fdf1536a4b62 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -100,6 +100,17 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t);
  */
 #define dm_target_hybrid(t) (dm_target_bio_based(t) && dm_target_request_based(t))
 
+/*
+ * Zoned targets related functions.
+ */
+void dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q);
+#ifdef CONFIG_BLK_DEV_ZONED
+int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
+			unsigned int nr_zones, report_zones_cb cb, void *data);
+#else
+#define dm_blk_report_zones	NULL
+#endif
+
 /*-----------------------------------------------------------------
  * A registry of target types.
  *---------------------------------------------------------------*/
-- 
2.31.1

