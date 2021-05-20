Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F377C433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 749FC611BD
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhETEYA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 00:24:00 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63405 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhETEYA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 00:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621484559; x=1653020559;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=aVa7W8T6lKCbKI/ygLHjB1phf2zK6Oo7yLjeZw7C+Rk=;
  b=Nw4nbl5o60COMijYae++rd9Hm8kD2WVua8ivf6HkYBfTHr4JYE34F1m/
   f1SCZSphM6pButW1ohQF3GpKT1FeyZ+HdbKvAoKj6ngiST1oZqibxNEhx
   dLqCL6RL9sSN6ayjGfWsho804BAH0RnLqCYFmPYJ7lRLTbLZSAOoSFZrH
   hYV6os1cO4UtzTAE7HEky/2MIjKYwAATS5zUXiiiCKt757X0NVJtgVk1E
   KseDHyFZTxSEDFqG+lo4qqCrkQB+1oA/AP0lwg++GFRrisUjxhxmuuK1h
   +YVfY/orcf9KDe8E+Csl0YI+IpNmWQmC2EtdEsw/oAsoLHpIoYToGGch+
   g==;
IronPort-SDR: bUMu9tfoRhJXkcILhI2knKGNawdXsHr8Wp4K/4pjS98aOtkPcoCgYblokspieBGmn0AGFETNtX
 KayLK7bLfX0qD2PNmJlIQYMw+bWxHHo6VemSguYa6xHdZbIRoC0XAAu4FbsZfaQxLtOn+PPUJs
 I5DcwYRcV8PI1dEohBegLqlpJMcTKbgSmTn63v236fwG6m+Y4D2GBpRoAOJHVUQ61zjbmv4LKO
 v2R8aBdcFHmg8M8l/ivxCTj2cWbDwPdbfmZyyq4WRmZYqSVsnZ9Te7VYMTu8u/2NrtUkGjph6P
 0Pk=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168105847"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 12:22:39 +0800
IronPort-SDR: NjQ6DjpQ3TnELLmMtFw9ejdS5K7A79bElUDnos2hV+MLAcCxmwUoH87e/DgGr9vnv6A0k+d1KP
 Mm5l49ieJv110po2W8ZTpuV1cH8dChHL6q8XC3Rd/WGgb5mk7kdVno3w5CUKbBzgt7I+1sapm8
 v4Wrn7srIrDjNfVQJbs3za/rXyHxGOTESQ9YF6Ihzve8gJG0mEvJGmORIjTSOBWMf93iGVLHSi
 U8nXRJytGi61hYAFJpcTZOegYjhtEmtURJGrDM0gx1MqZxnyggv2+MDi/H1Of7HaVmxHPjsCX5
 /PgBm7Y1EIpQvadqIoA1ClzQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 21:02:16 -0700
IronPort-SDR: EcgtPPVTygsH3V0v7Emrr9J3ApOBd7B84hDHEv92sZCdLVTsv+90suF9sH+EOn0ruhHH8kTlEN
 3DdwhRX+SkDcCahzp8aDfF4vbw5nelKPKqCDMzIINkI/ZKlfivVKKiO9C2Fvo8rGegzJQsncxY
 nVKVD/e48L+SDn7ekC87wmd5UoUVuPMxWjJ3GINP8VP0XAH92k8ACmzRhcXK3rk5APNHc0X5qz
 PGXpAdN/t8I25lljyPakU5sBTB//QBzPR5yrFltPk58ElfnasAHYS2kZH6ktHNjK+99gCHsJvE
 +gg=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 May 2021 21:22:38 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 08/11] dm: Forbid requeue of writes to zones
Date:   Thu, 20 May 2021 13:22:25 +0900
Message-Id: <20210520042228.974083-9-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520042228.974083-1-damien.lemoal@wdc.com>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
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

