Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DA8C2B9F7
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9CBB6141E
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhEYC1T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 22:27:19 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34067 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhEYC1T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 22:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621909550; x=1653445550;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=fT8Bn2N/hDneLu0IulSghPa3VnHS7U7B+KnPGflHK+I=;
  b=ObsFl8ALOIVRzklP9ce6fM9KULBj8AWqxO548l0f4p3Bw681BPcioFhM
   fNQsJePuwQChkjhp7LTeeYohb7/89OOwg21jwtsMFGQhSmpLw5KXI1d4b
   zEis4q/Y2/+u3ByIOgVG9Cgx8sjn1t/sCpqJ6wU/GPHh6CMT6xkETr5d2
   55/sQ2LV6FKXCu6FAmeLUAX22kpXkiucEogt1nGGFFeb/d2pdr0tTLaL9
   e59511X+TzBwdf3wVDC942j94OPIQYuf4xZUnzitAS7AH68cW4yxcypv+
   4WZQj4fpoMSjKozMgaN54pv3h8vlr17upgEyChp65sqtyyYVv3Uium5Ks
   Q==;
IronPort-SDR: 7Z/RW3iefZPj44LhhiUxD9Y4O5ukdVV3kd41U32TNDgTWf1Trq0IgaOzzauUkyLxGf0mhRH4kw
 jgoWwea9Zf74PibtA5SFiZ53xENOgqQPeOKB5E8+usR0JUop2A/KY8Y1zVvqOrWJ+4cYUx3y/h
 KuuugxQENgblfxBkUwVOBz6pKKIDa9SE8akwd/BxF5PmyB9B3JFiy0TfewQ7gklkmklti0fQUX
 zksF9R5Q6O6ZTcdhpbPvGAU05pOt3g9mzFtDXW7HG4iC55kdVs24uRSb2KfzklfCcqFkT3iHWr
 kBo=
X-IronPort-AV: E=Sophos;i="5.82,327,1613404800"; 
   d="scan'208";a="173981330"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2021 10:25:49 +0800
IronPort-SDR: QPPINjcCQwlub4rhQoJU/IsanPsLMqH+b3yBn7qxyEyyIccpLYsWxsFgFIKnxzn67gxpBd7FZF
 VDnFcFVJo0vsA6JXtBOSv3Sf4dbgr6IuuXxsiZWn9yntzy07PDO+D4bkBhEP8CtVa5dKkOm7Hx
 Py/ChSecIPuv7yM5WGn8R23AlS6E2c65XZbZguVp/8N9uwZBnOkqxBscRVGzQbc62ZNHnWKELE
 pxtrsIXE7JosE5AqvWDUg33NmMB2xbR5sXZsNEtEg/8NJbnhz1UpZe6v2MKitnGxguCKf7AIa+
 k6/ByPpt7aGsCWJgMj483CQa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 19:04:04 -0700
IronPort-SDR: zrRUPZK05/qs9KweFlyGel2ysmEk7Dae2GO3xopdamUbRJOSUbUKbws6NybEWf+GCqeUTJwO1U
 38k4pmZLSFbZj/dLFlXw3h5l1JimTeVXuUagmBG1n/lTs4e5gaXSd0jyhJPTmw2fd2Sb0lgpE+
 IreaXvDSALJ1TQNRVup8onaiA6jb3Wrys3G2P/Ju9k7yC+Jhwdem0bMGvPQw4/NE4A0fmtn04w
 IVeF7oCrQ25oLZq9WJG7tINvO4i4wnlH2tWHz3tp15wMN0xVP/S8+HfYJ7WtD+RIoLUlsqktPH
 O0s=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 May 2021 19:25:49 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 08/11] dm: Forbid requeue of writes to zones
Date:   Tue, 25 May 2021 11:25:36 +0900
Message-Id: <20210525022539.119661-9-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525022539.119661-1-damien.lemoal@wdc.com>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
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

