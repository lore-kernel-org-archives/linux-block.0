Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255E3C433F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 22:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345036AbiBJWi4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:38:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345032AbiBJWi4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 17:38:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42A272664
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644532735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=64mfGr+BkNDL/qyiDObOyXjA+jYS7+jce6ArkgUIKnM=;
        b=d+YDSjsKBTRiq53DFnXfC1ahIFeQZlR+rR2k+9C4buJhTewmWV1IcHnjUkbfY+9SsAuah9
        f0boDPiZpMspj7hmv4ZRCXWO3ysJe9ObWHAzo3E/5yEYobuZ17+LWpjRDtbOZy5+8WPVyK
        jGiUorm2G4Ubep8V3ptn8NyEd4KQHoo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-GYcVAw12PoW0NF11as0S7g-1; Thu, 10 Feb 2022 17:38:54 -0500
X-MC-Unique: GYcVAw12PoW0NF11as0S7g-1
Received: by mail-qv1-f71.google.com with SMTP id ge15-20020a05621427cf00b00421df9f8f23so4991287qvb.17
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=64mfGr+BkNDL/qyiDObOyXjA+jYS7+jce6ArkgUIKnM=;
        b=Cpi4s6gX03EEd3pjXTqlOZqJ3Hk98x/faQ/n5vsXTnoMzMBelxZVWRIzxDUV01ZXoB
         jL+iF3PHsBEiZ3DAxp1Y6FhgoBo3V/rDxWmLusxDBPVbDA0PDnb6AqGNPoxrdpkpuHiX
         OFo32uiWiH/60ydeL0k0XTvH3Pu8+UfdyEg8d+zTDvbczTAb61vByciM+YxVXUcvaW4S
         gi5mSQo8CHMepbFh6HSKqziQxv32mnyZSaQEPOBqYMqO4YYCbABq9dhhNvQjIWu9LCb4
         YUyX7zzGK7sNKnpxvEB3vlXTCbyQWmfFtPW0ICeEhlxlUJn3/EMOoGMiB9OaQ+awB09s
         hlFw==
X-Gm-Message-State: AOAM532FEfc5rqRcmbyY/8OqE9J/TUqrVqn/KUMvwlCHSNrGFRLPZcR/
        cFbrzZ8Fa+h3Z5I8NXbPbM4UxBUUXgEAv+2dRr3hE6iRKWZKycZuVTsp4DZLVDnY88XxREjsZt6
        26U5guqPGjJBgGnygcCMtzQ==
X-Received: by 2002:a05:622a:1303:: with SMTP id v3mr6633036qtk.294.1644532733425;
        Thu, 10 Feb 2022 14:38:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyiq9A/dl8/a5+pxZQ8CSXaYG/GlW7bPYTGMKHlZVSuct7m0MfGG+eetHtVr60p3O6UF0//mw==
X-Received: by 2002:a05:622a:1303:: with SMTP id v3mr6633025qtk.294.1644532733141;
        Thu, 10 Feb 2022 14:38:53 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id q12sm12007982qtx.51.2022.02.10.14.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:38:52 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 14/14] block: add bio_start_io_acct_remapped for the benefit of DM
Date:   Thu, 10 Feb 2022 17:38:32 -0500
Message-Id: <20220210223832.99412-15-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220210223832.99412-1-snitzer@redhat.com>
References: <20220210223832.99412-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DM needs the ability to account a clone bio's IO to the original
block_device. So add @orig_bdev argument to bio_start_io_acct_time.
Rename bio_start_io_acct_time to bio_start_io_acct_remapped.
Also, follow bio_end_io_acct and bio_end_io_acct_remapped pattern by
moving bio_start_io_acct to blkdev.h and have it call
bio_start_io_acct_remapped.

Improve DM to no longer need to play games with swizzling a clone
bio's bi_bdev (in dm_submit_bio_remap) and remove DM's
clone_and_start_io_acct() interface.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/blk-core.c       | 24 ++++++++----------------
 drivers/md/dm.c        | 41 ++++++++---------------------------------
 include/linux/blkdev.h | 16 ++++++++++++++--
 3 files changed, 30 insertions(+), 51 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index be8812f5489d..8f23be96c737 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1077,29 +1077,21 @@ static unsigned long __part_start_io_acct(struct block_device *part,
 }
 
 /**
- * bio_start_io_acct_time - start I/O accounting for bio based drivers
+ * bio_start_io_acct_remapped - start I/O accounting for bio based drivers
  * @bio:	bio to start account for
  * @start_time:	start time that should be passed back to bio_end_io_acct().
- */
-void bio_start_io_acct_time(struct bio *bio, unsigned long start_time)
-{
-	__part_start_io_acct(bio->bi_bdev, bio_sectors(bio),
-			     bio_op(bio), start_time);
-}
-EXPORT_SYMBOL_GPL(bio_start_io_acct_time);
-
-/**
- * bio_start_io_acct - start I/O accounting for bio based drivers
- * @bio:	bio to start account for
+ * @orig_bdev:	block device that I/O must be accounted to.
  *
  * Returns the start time that should be passed back to bio_end_io_acct().
  */
-unsigned long bio_start_io_acct(struct bio *bio)
+unsigned long bio_start_io_acct_remapped(struct bio *bio,
+				unsigned long start_time,
+				struct block_device *orig_bdev)
 {
-	return __part_start_io_acct(bio->bi_bdev, bio_sectors(bio),
-				    bio_op(bio), jiffies);
+	return __part_start_io_acct(orig_bdev, bio_sectors(bio),
+				    bio_op(bio), start_time);
 }
-EXPORT_SYMBOL_GPL(bio_start_io_acct);
+EXPORT_SYMBOL_GPL(bio_start_io_acct_remapped);
 
 unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 				 unsigned int op)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 329f0be64523..e020f505e243 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -485,35 +485,19 @@ u64 dm_start_time_ns_from_clone(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(dm_start_time_ns_from_clone);
 
-static void __start_io_acct(struct dm_io *io, struct bio *bio)
-{
-	bio_start_io_acct_time(bio, io->start_time);
-	if (unlikely(dm_stats_used(&io->md->stats)))
-		dm_stats_account_io(&io->md->stats, bio_data_dir(bio),
-				    bio->bi_iter.bi_sector, bio_sectors(bio),
-				    false, 0, &io->stats_aux);
-}
-
 static void start_io_acct(struct dm_io *io, struct bio *bio)
 {
 	/* Ensure IO accounting is only ever started once */
 	if (xchg(&io->was_accounted, 1) == 1)
 		return;
 
-	__start_io_acct(io, bio);
-}
+	bio_start_io_acct_remapped(bio, io->start_time,
+				   io->orig_bio->bi_bdev);
 
-static void clone_and_start_io_acct(struct dm_io *io, struct bio *bio)
-{
-	struct bio io_acct_clone;
-
-	/* Ensure IO accounting is only ever started once */
-	if (xchg(&io->was_accounted, 1) == 1)
-		return;
-
-	bio_init_clone(io->orig_bio->bi_bdev,
-		       &io_acct_clone, bio, GFP_NOIO);
-	__start_io_acct(io, &io_acct_clone);
+	if (unlikely(dm_stats_used(&io->md->stats)))
+		dm_stats_account_io(&io->md->stats, bio_data_dir(bio),
+				    bio->bi_iter.bi_sector, bio_sectors(bio),
+				    false, 0, &io->stats_aux);
 }
 
 static void end_io_acct(struct mapped_device *md, struct bio *bio,
@@ -1137,7 +1121,6 @@ void dm_submit_bio_remap(struct bio *clone, struct bio *tgt_clone)
 {
 	struct dm_target_io *tio = clone_to_tio(clone);
 	struct dm_io *io = tio->io;
-	struct block_device *clone_bdev = clone->bi_bdev;
 
 	/* establish bio that will get submitted */
 	if (!tgt_clone)
@@ -1151,9 +1134,7 @@ void dm_submit_bio_remap(struct bio *clone, struct bio *tgt_clone)
 	 *   io->orig_bio so there is no IO imbalance in
 	 *   end_io_acct().
 	 */
-	clone->bi_bdev = io->orig_bio->bi_bdev;
 	start_io_acct(io, clone);
-	clone->bi_bdev = clone_bdev;
 
 	trace_block_bio_remap(tgt_clone, bio_dev(io->orig_bio),
 			      tio->old_sector);
@@ -1213,14 +1194,8 @@ static void __map_bio(struct bio *clone)
 	switch (r) {
 	case DM_MAPIO_SUBMITTED:
 		/* target has assumed ownership of this io */
-		if (!ti->accounts_remapped_io) {
-			/*
-			 * Any split isn't reflected in io->orig_bio yet. And bio
-			 * cannot be modified because target is submitting it.
-			 * Clone bio and account IO to DM device.
-			 */
-			clone_and_start_io_acct(io, clone);
-		}
+		if (!ti->accounts_remapped_io)
+			start_io_acct(io, clone);
 		break;
 	case DM_MAPIO_REMAPPED:
 		/* the bio has been remapped so dispatch it */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3bfc75a2a450..31d055d4a17e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1512,11 +1512,23 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 void disk_end_io_acct(struct gendisk *disk, unsigned int op,
 		unsigned long start_time);
 
-void bio_start_io_acct_time(struct bio *bio, unsigned long start_time);
-unsigned long bio_start_io_acct(struct bio *bio);
+unsigned long bio_start_io_acct_remapped(struct bio *bio,
+				unsigned long start_time,
+				struct block_device *orig_bdev);
 void bio_end_io_acct_remapped(struct bio *bio, unsigned long start_time,
 		struct block_device *orig_bdev);
 
+/**
+ * bio_start_io_acct - start I/O accounting for bio based drivers
+ * @bio:	bio to start account for
+ *
+ * Returns the start time that should be passed back to bio_end_io_acct().
+ */
+static inline unsigned long bio_start_io_acct(struct bio *bio)
+{
+	return bio_start_io_acct_remapped(bio, jiffies, bio->bi_bdev);
+}
+
 /**
  * bio_end_io_acct - end I/O accounting for bio based drivers
  * @bio:	bio to end account for
-- 
2.15.0

