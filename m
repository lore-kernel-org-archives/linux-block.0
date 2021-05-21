Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22959C43460
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 03:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052086108D
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 03:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbhEUDCz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 23:02:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25389 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbhEUDCz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 23:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621566092; x=1653102092;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=fT8Bn2N/hDneLu0IulSghPa3VnHS7U7B+KnPGflHK+I=;
  b=eeWYtqM5LVXtqMM7GWSEp7ABAKrw29Zgz23rYeqi/GTBcvIeN0zC4D8Z
   rjxlU3GC/VnJXtBZpKM9+dIyGivrp8mUXGXiagOlcmhbyvHao0fs0RRKr
   jwnXI4fF4e+NuS5lJ58sb6URrWLQTqJJB5CP3x5KRztKe67V5qTHWIcy5
   zsqj1dhBqL/p7t4boXz4ABlLuF/mqtRLSxEiKPorewnysQlVI+1OM89IM
   XKIz1SG5mlzReEpekYX0LyZR8mPLsfyILh1HGwIui7ZlYWFMLYygRmzcJ
   S0n7NiEznQA7zsXhFtWZyYu99u64+kuvJP9xclRt17l1W96nxp2Ba4OtI
   Q==;
IronPort-SDR: g5DuFHaqYVRerXx4imeVEI5DHYjteFgVHPQhNiV+LsVUICVt9jQfcDIQYu7Y1vInqwFoNAtELD
 p0NDJV+hzQES33tJU87IgEjEmqels67mAPFlT0zDD+/Md5mjBr0sQmhMR/JkexzOqpum7tAyVp
 Ffi4r9DkK23MfhsghjRHY7KlQb6k5Sdf7nk0XyArkadiKiiYV18SpVgAgeVN8eEDbpWwea1h93
 JbWnLGmrPcqPW2sYcu+vVfR3npe/6B5KRTsDU2Z/wuYFLedLynvj7ejLdGvLefj6nGTIKLIIAn
 HYE=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168943876"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 11:01:32 +0800
IronPort-SDR: AMNego9UGwm/92kOJeAPV3JCoyGl5uX4oEhVEtu+/4+B/9a2ylHsxdbtl0KjH4/iOvBs6waVGM
 sgYFg5AFsc/SKA7cjsGh7998JuQVUWf5ppjmGm8d3cIrPBKYAcKeEEWRDVK3Fy0sn+DChb0Bk4
 xCXecIupzy/YCfHnBnt8//1W0NhKz7JoXgxuUqYGtIFInOV/6bOLem2FwNaZJTlXzp/uHUPkQ4
 GRlT2dBcL8Q/0r7q6zr9FV+C2T0Pb2o/xc1RV82zt77PC1+zYvQJl9jg82bOJv3mvfJIdWg7RQ
 wm0SoPWhU8JQOnt3/3V4ugEL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 19:41:08 -0700
IronPort-SDR: RAD/kYBdYh3LJ64YeVuAYXWHENoCW0YElm3jtEfobVEjhQ9kzBBjCH/iPr+ASuy0nMAsjNe8DS
 /SaYZ8aeSBDlwWztzeUk0zbcOoX5BI8Jw1GybLeW8ajgbCZjOKJAmQe7SuxMjWZF6hEwIeLKwC
 t6DC/qW6w+Rtfg932+ugEJ347giEQKNN7+8QbILwY/DWmDxp8c5WuOri9ZBu49bmFbZiAsQl+W
 k2PuYAqDitp4GT4e3sCfIHxTQ89alh7WQ2O2YQTlFNNgBXdG5mCB8A/X9d2Ze7/cFGDG1psREs
 07I=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2021 20:01:32 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 08/11] dm: Forbid requeue of writes to zones
Date:   Fri, 21 May 2021 12:01:16 +0900
Message-Id: <20210521030119.1209035-9-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521030119.1209035-1-damien.lemoal@wdc.com>
References: <20210521030119.1209035-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A target map method requesting the requeue of a bio with
DM_MAPIO_REQUEUE or completing it with DM_ENDIO_REQUEUE can cause
unaligned write errors if the bio is a write operation targeting a
sequential zone. If a zoned target request such a requeue, warn about
it and kill the IO.

The function dm_is_zone_write() is introduced to detect write operations
to zoned targets.

This change does not affect the target drivers supporting zoned devices
and exposing a zoned device, namely dm-crypt, dm-linear and dm-flakey as
none of these targets ever request a requeue.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/dm-zone.c | 17 +++++++++++++++++
 drivers/md/dm.c      | 18 +++++++++++++++---
 drivers/md/dm.h      |  5 +++++
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index b42474043249..edc3bbb45637 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -104,6 +104,23 @@ int dm_report_zones(struct block_device *bdev, sector_t start, sector_t sector,
 }
 EXPORT_SYMBOL_GPL(dm_report_zones);
 
+bool dm_is_zone_write(struct mapped_device *md, struct bio *bio)
+{
+	struct request_queue *q = md->queue;
+
+	if (!blk_queue_is_zoned(q))
+		return false;
+
+	switch (bio_op(bio)) {
+	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_WRITE_SAME:
+	case REQ_OP_WRITE:
+		return !op_is_flush(bio->bi_opf) && bio_sectors(bio);
+	default:
+		return false;
+	}
+}
+
 void dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
 {
 	if (!blk_queue_is_zoned(q))
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 45d2dc2ee844..4426019a89cc 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -846,11 +846,15 @@ static void dec_pending(struct dm_io *io, blk_status_t error)
 			 * Target requested pushing back the I/O.
 			 */
 			spin_lock_irqsave(&md->deferred_lock, flags);
-			if (__noflush_suspending(md))
+			if (__noflush_suspending(md) &&
+			    !WARN_ON_ONCE(dm_is_zone_write(md, bio)))
 				/* NOTE early return due to BLK_STS_DM_REQUEUE below */
 				bio_list_add_head(&md->deferred, io->orig_bio);
 			else
-				/* noflush suspend was interrupted. */
+				/*
+				 * noflush suspend was interrupted or this is
+				 * a write to a zoned target.
+				 */
 				io->status = BLK_STS_IOERR;
 			spin_unlock_irqrestore(&md->deferred_lock, flags);
 		}
@@ -947,7 +951,15 @@ static void clone_endio(struct bio *bio)
 		int r = endio(tio->ti, bio, &error);
 		switch (r) {
 		case DM_ENDIO_REQUEUE:
-			error = BLK_STS_DM_REQUEUE;
+			/*
+			 * Requeuing writes to a sequential zone of a zoned
+			 * target will break the sequential write pattern:
+			 * fail such IO.
+			 */
+			if (WARN_ON_ONCE(dm_is_zone_write(md, bio)))
+				error = BLK_STS_IOERR;
+			else
+				error = BLK_STS_DM_REQUEUE;
 			fallthrough;
 		case DM_ENDIO_DONE:
 			break;
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index fdf1536a4b62..39c243258e24 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -107,8 +107,13 @@ void dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q);
 #ifdef CONFIG_BLK_DEV_ZONED
 int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
+bool dm_is_zone_write(struct mapped_device *md, struct bio *bio);
 #else
 #define dm_blk_report_zones	NULL
+static inline bool dm_is_zone_write(struct mapped_device *md, struct bio *bio)
+{
+	return false;
+}
 #endif
 
 /*-----------------------------------------------------------------
-- 
2.31.1

