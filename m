Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9A5C4708A
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9CB611BE
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhEYV0p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 17:26:45 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36441 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhEYV0o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 17:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621977914; x=1653513914;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=PPqL/jfrmA+hhRRrzr2vGOU3ZQvBfOeDHMkCng2K9OI=;
  b=N1sOZAKBfaEhE7xVAdYbN/3exz/Visps7jefV7fFdbJFGaL7D/mpkRCN
   i4qx248ESTps2dJJ1Fv1MNB5xVuR6vNO7BxccuhEqFQAPqaNkc/2hn1P7
   lIRtQkCCqPjp2r+RxynUTR3jxDPNm4rL9XrFr53YNFmXKa92uHT8B9H8m
   7rvlR5ch/tSDGSth+JxSDxSCd/QM3Y5xo9zZj5JfOmAnoQM4wqIdXs51a
   5Uw7EXAkHa8fXis1CGo6TO/6K48dq/II45WwFlKksBaQ2f5sukfjf3qak
   vMXWx/5WdEkBDDNVbaMi0xPNOOjEPBeiVHEbjw1LozQ54BQ6TFaGZWrbe
   g==;
IronPort-SDR: ExoThD2spBX1CdWo8RIKHmDvuEkYkvedXfuMiVNYgAAcbDCVCyv+tzwqJv/Pclrq3cfBbTx3jy
 WdGs+TuCjGGGebA1j2jKYneOCOQ8O4PBHfPs3czJIVZsaAjJSjO0BIdMckdi+OXNW08BoaSf0t
 kLvykNhf0jbzNRFeu9oc51aau5pyUZ51Hn8cxJdwcLnr/MNaTITD2tnGHzfRXWvl9bIRP54hQ3
 D7BfJr03SYJ0dNX+sMSwWT6S6vmRYSgwmVUe72HnrXKcBh1IHfblBjAU4Mwe9wo2jjyxG/z/ZH
 jGk=
X-IronPort-AV: E=Sophos;i="5.82,329,1613404800"; 
   d="scan'208";a="168717537"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2021 05:25:14 +0800
IronPort-SDR: A8aIf2tOMFLex+0SpH3A29vIqlxouWPSpNGRNcsSjbeUWIKymMr04bIMV7s+SIi7maghkmb5Qn
 MpWZhr1PpDVmHpyTXlbJssOxXh2xbYqNQDz2bAe5wz3TWXVMSZBiPJlP1eodVo9UEjD/fyAxwH
 VCRj80SznwCIk+C/MhuzgRxLRcV4VbMF/WD1d+pxCo4Hzeexa9ucvUzUho6GgrhuxHd6o9J6Pt
 Udvls+P47mxcxjuXLWXWTu+9IvQeWH+HRuGwAtm8gBjU0mx5QWYu96QXw5w79qBZlkPzkcnUH3
 5uq1seB6sDEeW07J4ILcEieo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 14:04:41 -0700
IronPort-SDR: FFF1c2FJ+cgQhwiu2tSFsJhXIDXOtA/SS6F6R1Iy5+bwYpMV7vaYEY7WPhSqBcsD8tMZkR9flM
 99Ne8g2pnfyxWCGLrZkpx1PRwBUmLTH9oCqNOZUCCOw1WtLMkfbiij+gpskbG8opzpmObsaPXQ
 A00LILqLiLlzH9QEHCjEOElt6aqVLCrglHOFMM9LI5kd9t180Ntk5oYtuQ0J/CyNO0QmkBk/MG
 MS5+OopH4yZp3elwi2jYQnBYTwXU9a5vYn22BCOizO2XEH7REaNpp9UEbqwotRcYVQzqx8ZM1f
 WjU=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 May 2021 14:25:13 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v5 08/11] dm: Forbid requeue of writes to zones
Date:   Wed, 26 May 2021 06:24:58 +0900
Message-Id: <20210525212501.226888-9-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525212501.226888-1-damien.lemoal@wdc.com>
References: <20210525212501.226888-1-damien.lemoal@wdc.com>
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
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
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
index c49976cc4e44..ed8c5a8df2e5 100644
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

