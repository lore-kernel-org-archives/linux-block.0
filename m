Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E855DC43460
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 02:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA1AA611BF
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 02:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbhESC47 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 22:56:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5175 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbhESC47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 22:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621392940; x=1652928940;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=aVa7W8T6lKCbKI/ygLHjB1phf2zK6Oo7yLjeZw7C+Rk=;
  b=mv1dL2j9fAtYovmD6j4s+e/9AZAGHOqnahMd0ORm5d0NQlwWcmUywBI6
   ar4zejV5P3tbAQP4Gdxr6osowlZXrRRqT6Wms6phHvBPR+8hpO/V+c07p
   ijSc3nAaXtcboGrStaTXl8nF/xEVRnPHpaiyox29uOfxETnnNnW85GEHF
   iiz1W6xZaUjfuslQfkmXH5bvBqpCiU3Q9vgp7TC0Mp45zk1HQb0N5uX9c
   AMEzRCXr+sa7UbP/rgPXBWMy4Z6fjxRlCw/sebz5EIr504fqeYbbUZ7cS
   SpJ3IQ/0h8opmi58OjnVixNXV7MfLR96H+vZ3I2+ofRg32s8MikPv9mqB
   Q==;
IronPort-SDR: tWqzTopWGkTFCUc5NcRVa8Bn2MvbQQ39tTJbCPmZSC7X0pL+4casor1KOECx2fqf6m/YVNy9rQ
 cucdLlMjiN5uFFUmrRGSAILx58h3vIiCuGayAlDtmg3eM5Q+GqVUZUeVORjD+6aggcIBC5IAv2
 B2P7A+zyR8I94uythjD8wgsXH0RBFUC3pzaBnS0a9G0lnI8zgvGRLoS6p0FwelEYnZXjs7Tm2m
 WyLN92VTJc0OOST4Nd/MF8L7Jm53y9Zf7FS5dikHjyQJFtKkyYpBZBF78S5OzZOQtknTGxP/Cq
 HNY=
X-IronPort-AV: E=Sophos;i="5.82,311,1613404800"; 
   d="scan'208";a="173265906"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 10:55:39 +0800
IronPort-SDR: hT9UCWCU8KkiNqoMtQAnfM5+ia3vHHtPtZyzoGmpK4P0bjE1Jru/o8rjC8uHSf5cVyfPzXvbB2
 L0OyWo88QjWfBkA8i4VY07HDcZNpqcHoILl9hJQCR5y0Vip+uvwaJJsktNs9tnHUACYKyA06gx
 Au2IeiOSkt9ch8VN3E/IC6jFhTJd+SgAbaxDdk7SaIR/0IN/4eq5BAdey99ckyvsVD6ur6iwip
 5O7gvbGJXA0Hn7Dex2ELDM6FFrsCEMAtFO8eymsVMbzco4gjqKdWfLt8VMwkFpHNXCXNUV/hlQ
 WZiFtsf8tJqIbDuqb6Q/FHvI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 19:35:19 -0700
IronPort-SDR: 0UQ9iEcznzJkmRbe6Dx9LCZmmKO+7yOsDQUuKOKkqT20CEV5wEZPPUsDVrxFeXOO2ebZ91cOCO
 DcHmTJ+wcDsycyCT+uXtBliqH67u+4kfcsZoImNk6fvRIvM7cLuAlGoTcy7TFEq0QsnZ3onsBM
 LUCly5uk0JTsZL8WR9RTNts+rJoVPzxudC0rw7+tVaR+1LYo/Psy1ySnt1IOeRuYRc4ftzghtN
 CHt0xw5keSWBjEywpASgnoraT5Era2tCO+MULVMQvIbyT+oyBiVJ12B0FugekZ8ftl6f2hCCjy
 Ims=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2021 19:55:39 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/11] dm: Forbid requeue of writes to zones
Date:   Wed, 19 May 2021 11:55:26 +0900
Message-Id: <20210519025529.707897-9-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519025529.707897-1-damien.lemoal@wdc.com>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
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

