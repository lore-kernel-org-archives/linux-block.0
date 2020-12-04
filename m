Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E44C4361A
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 17:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B6B22AAB
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 17:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbgLDRdV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 12:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731079AbgLDRdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 12:33:21 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F773C061A4F
        for <linux-block@vger.kernel.org>; Fri,  4 Dec 2020 09:32:41 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id o1so4475412qtp.5
        for <linux-block@vger.kernel.org>; Fri, 04 Dec 2020 09:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EiLgz3cFmOTZFgOgkcmRmdON3lfage8yl0U3bbppWkw=;
        b=vRR+XiIlDcqZu2zVfGgnaXGhs/2FI7GoyPRjmAYpVXEzIy21XgZ+P9RKhOY9tvgstP
         FD1rbD89Mhn45xUDgv8Whd4WBg6DJcxjnFr42/hREM+3HVivivHbrTQsGlYZVLFKtMT/
         K0y0bntGArfHIg2DGSu4zsypTJqzNFK7HOwuAdP9F1iohJ2UUI4vUmOCkgDl2ZZvByXW
         fCq4nq7TV3OnVFx5hfgVI1Ck1ZcQyLEamHQfO8UyfOU+jxGnRWJERJED3i6J6/cBYGq+
         FIK9jxM/Dli6T5heg5XN8NoVN2v3NLSpC448fX8FUzJa6BB9QEP2gspKkHtDeI6hxa/c
         1IZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EiLgz3cFmOTZFgOgkcmRmdON3lfage8yl0U3bbppWkw=;
        b=nL6xVns0qLAmDRcdPalGiv0w/IL03hnbn+FDRUCWa7mgBaheGiFzgZJockW8e6t1w/
         a8HpYHcib04fnr2PEcXwvJM9V0+eRqXH6qEbpeP4R1N5JnlpvNb0ez4Q5clfoVv9ACOF
         sL75PkvDpDmupBGn9ka5VFTr263D8WCHjId4vHruGxwCPKj3Y40bIzysg7Xve4Oj2YVl
         c0tfZQUwBg+3IzZT4l1SphVEeFztRAE2YRIramRqAzo9W8FQwa7dHqdJoOXYfq+PcVBL
         /KzwaiHAPJ8X6IAYLB2FFB4Uz/zHd4UvsCRu4mG3pkNrOBsWwcWqLma9hbyoBW8FTjss
         sIYg==
X-Gm-Message-State: AOAM533hlB0xx7hTixNj2naIeYUvePIaqXTWyJw90aWnDDmvWAt9BB/z
        VaIBI/qqsSyoWJQW5ToGI1k=
X-Google-Smtp-Source: ABdhPJzW1WthnEn+Ct83VTJy3Vrxog5jTBuR43vlqGlkzogioEJD7btfdgoCq/0LU2zfpk1RD0DSow==
X-Received: by 2002:ac8:6d0a:: with SMTP id o10mr2383662qtt.113.1607103160286;
        Fri, 04 Dec 2020 09:32:40 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u20sm1256873qtb.9.2020.12.04.09.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 09:32:39 -0800 (PST)
Sender: Mike Snitzer <snitzer@gmail.com>
Date:   Fri, 4 Dec 2020 12:32:38 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk
Cc:     martin.petersen@oracle.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jdorminy@redhat.com, bjohnsto@redhat.com
Subject: [RFC PATCH] dm: fix IO splitting [was: Re: [PATCH v2] block: use
 gcd() to fix chunk_sectors limit stacking]
Message-ID: <20201204173238.GA59222@lobo>
References: <20201130171805.77712-1-snitzer@redhat.com>
 <20201201160709.31748-1-snitzer@redhat.com>
 <20201203032608.GD540033@T590>
 <20201203143359.GA29261@redhat.com>
 <20201204011243.GB661914@T590>
 <20201204020343.GA32150@redhat.com>
 <20201204035924.GD661914@T590>
 <20201204164759.GA2761@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204164759.GA2761@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 04 2020 at 11:47P -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Thu, Dec 03 2020 at 10:59pm -0500,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > On Thu, Dec 03, 2020 at 09:03:43PM -0500, Mike Snitzer wrote:
> > > Stacking chunk_sectors seems ill-conceived.  One size-fits-all splitting
> > > is too rigid.
> > 
> > DM/VDO knows exactly it is one hard chunk_sectors limit, and DM shouldn't play
> > the stacking trick on VDO's chunk_sectors limit, should it?
> 
> Feel like I already answered this in detail but... correct, DM cannot
> and should not use stacked chunk_sectors as basis for splitting.
> 
> Up until 5.9, where I changed DM core to set and then use chunk_sectors
> for splitting via blk_max_size_offset(), DM only used its own per-target
> ti->max_io_len in drivers/md/dm.c:max_io_len().
> 
> But I reverted back to DM's pre-5.9 splitting in this stable@ fix that
> I'll be sending to Linus today for 5.10-rcX:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.10-rcX&id=6bb38bcc33bf3093c08bd1b71e4f20c82bb60dd1
> 
> DM is now back to pre-5.9 behavior where it doesn't even consider
> chunk_sectors for splitting (NOTE: dm-zoned sets ti->max_io_len though
> so it is effectively achieves the same boundary splits via max_io_len).

Last question for all, I'd be fine with the following fix instead of
the above referenced commit 6bb38bcc33. It'd allow DM to continue to
use blk_max_size_offset(), any opinions?

From: Mike Snitzer <snitzer@redhat.com>
Date: Fri, 4 Dec 2020 12:03:25 -0500
Subject: [RFC PATCH] dm: fix IO splitting

FIXME: add proper header
Add chunk_sectors override to blk_max_size_offset().

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/blk-merge.c      |  2 +-
 drivers/md/dm-table.c  |  5 -----
 drivers/md/dm.c        | 19 +++++++++++--------
 include/linux/blkdev.h |  9 +++++----
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index bcf5e4580603..97b7c2821565 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -144,7 +144,7 @@ static struct bio *blk_bio_write_same_split(struct request_queue *q,
 static inline unsigned get_max_io_size(struct request_queue *q,
 				       struct bio *bio)
 {
-	unsigned sectors = blk_max_size_offset(q, bio->bi_iter.bi_sector);
+	unsigned sectors = blk_max_size_offset(q, bio->bi_iter.bi_sector, 0);
 	unsigned max_sectors = sectors;
 	unsigned pbs = queue_physical_block_size(q) >> SECTOR_SHIFT;
 	unsigned lbs = queue_logical_block_size(q) >> SECTOR_SHIFT;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 2073ee8d18f4..7eeb7c4169c9 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -18,7 +18,6 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/atomic.h>
-#include <linux/lcm.h>
 #include <linux/blk-mq.h>
 #include <linux/mount.h>
 #include <linux/dax.h>
@@ -1449,10 +1448,6 @@ int dm_calculate_queue_limits(struct dm_table *table,
 			zone_sectors = ti_limits.chunk_sectors;
 		}
 
-		/* Stack chunk_sectors if target-specific splitting is required */
-		if (ti->max_io_len)
-			ti_limits.chunk_sectors = lcm_not_zero(ti->max_io_len,
-							       ti_limits.chunk_sectors);
 		/* Set I/O hints portion of queue limits */
 		if (ti->type->io_hints)
 			ti->type->io_hints(ti, &ti_limits);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 98866e725f25..f7eb3d2964f3 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1039,15 +1039,18 @@ static sector_t max_io_len(struct dm_target *ti, sector_t sector)
 	sector_t max_len;
 
 	/*
-	 * Does the target need to split even further?
-	 * - q->limits.chunk_sectors reflects ti->max_io_len so
-	 *   blk_max_size_offset() provides required splitting.
-	 * - blk_max_size_offset() also respects q->limits.max_sectors
+	 * Does the target need to split IO even further?
+	 * - varied (per target) IO splitting is a tenet of DM; this
+	 *   explains why stacked chunk_sectors based splitting via
+	 *   blk_max_size_offset() isn't possible here. So pass in
+	 *   ti->max_io_len to override stacked chunk_sectors.
 	 */
-	max_len = blk_max_size_offset(ti->table->md->queue,
-				      target_offset);
-	if (len > max_len)
-		len = max_len;
+	if (ti->max_io_len) {
+		max_len = blk_max_size_offset(ti->table->md->queue,
+					      target_offset, ti->max_io_len);
+		if (len > max_len)
+			len = max_len;
+	}
 
 	return len;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 639cae2c158b..f56dc5497e67 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1073,11 +1073,12 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
  * file system requests.
  */
 static inline unsigned int blk_max_size_offset(struct request_queue *q,
-					       sector_t offset)
+					       sector_t offset,
+					       unsigned int chunk_sectors)
 {
-	unsigned int chunk_sectors = q->limits.chunk_sectors;
-
-	if (!chunk_sectors)
+	if (!chunk_sectors && q->limits.chunk_sectors)
+		chunk_sectors = q->limits.chunk_sectors;
+	else
 		return q->limits.max_sectors;
 
 	if (likely(is_power_of_2(chunk_sectors)))
