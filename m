Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EC4C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbiGNSI3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240490AbiGNSI2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:28 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743B968714
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:26 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id x21so1119177plb.3
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NiwmI3GHlzgspqrFuC5O9Y4Cz8CN7Qhn+CTD564f0hM=;
        b=q1vv4TGMTCrvWX7IEiigni4wvIIYm4A5MbvEMuisBIeOQjEZzzhiQ5MCofopDIAKUe
         +Qh7TtwKb/OD4lCEBA7R02GwrKOA55neeKvjeRWFv2qnz3HFXIodvgzPt3xzG0bYqqvl
         uJem9IobKtdBykD/qm6tYV5V3jpJZdE+pqG+67jQyytaQiYIdU0n9to61RvR9lR/y49e
         B9obDZgYMPKwS7pkgNyEoAnBN0WxPbrAEKcdJu4jshHD2aIsBSPHl58JpFWwvx4kQJbN
         Le2RvS4X5yEwkqfWX0qc9XAgbZJXNeFaS+E3SvIziKT6GscgRVqNmQnLxrMBKDqu1iOM
         4b6w==
X-Gm-Message-State: AJIora94806KYcD1S3NIJK8nAfYZW6qBMZN0SOqmdG8rMoBmrT9Qoawd
        GnimXKgygjlNTxcXFFjzaQs=
X-Google-Smtp-Source: AGRyM1sbUuAlob1vgQe2I287YQwo2Yju2Y5cCiWYNkgoa77hXzr5wSMLr3QSesdnPJRGmg9l+bOmRg==
X-Received: by 2002:a17:902:70cc:b0:16c:60e0:50fb with SMTP id l12-20020a17090270cc00b0016c60e050fbmr9501331plt.156.1657822105811;
        Thu, 14 Jul 2022 11:08:25 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH v3 31/63] md/core: Combine two sync_page_io() arguments
Date:   Thu, 14 Jul 2022 11:06:57 -0700
Message-Id: <20220714180729.1065367-32-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve uniformity in the kernel of handling of request operation and
flags by passing these as a single argument.

Cc: Song Liu <song@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-raid.c     |  2 +-
 drivers/md/md-bitmap.c   |  2 +-
 drivers/md/md.c          | 10 +++++-----
 drivers/md/md.h          |  3 +--
 drivers/md/raid1.c       |  8 ++++----
 drivers/md/raid10.c      | 10 +++++-----
 drivers/md/raid5-cache.c | 12 ++++++------
 drivers/md/raid5-ppl.c   | 12 ++++++------
 8 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 9526ccbedafb..fdd6616632c9 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -2036,7 +2036,7 @@ static int read_disk_sb(struct md_rdev *rdev, int size, bool force_reload)
 
 	rdev->sb_loaded = 0;
 
-	if (!sync_page_io(rdev, 0, size, rdev->sb_page, REQ_OP_READ, 0, true)) {
+	if (!sync_page_io(rdev, 0, size, rdev->sb_page, REQ_OP_READ, true)) {
 		DMERR("Failed to read superblock of device at position %d",
 		      rdev->raid_disk);
 		md_error(rdev->mddev, rdev);
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index d87f674ab762..0a21b8317103 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -165,7 +165,7 @@ static int read_sb_page(struct mddev *mddev, loff_t offset,
 
 		if (sync_page_io(rdev, target,
 				 roundup(size, bdev_logical_block_size(rdev->bdev)),
-				 page, REQ_OP_READ, 0, true)) {
+				 page, REQ_OP_READ, true)) {
 			page->index = index;
 			return 0;
 		}
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4be9d8173071..4df78e30b76a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -993,15 +993,15 @@ int md_super_wait(struct mddev *mddev)
 }
 
 int sync_page_io(struct md_rdev *rdev, sector_t sector, int size,
-		 struct page *page, int op, int op_flags, bool metadata_op)
+		 struct page *page, blk_opf_t opf, bool metadata_op)
 {
 	struct bio bio;
 	struct bio_vec bvec;
 
 	if (metadata_op && rdev->meta_bdev)
-		bio_init(&bio, rdev->meta_bdev, &bvec, 1, op | op_flags);
+		bio_init(&bio, rdev->meta_bdev, &bvec, 1, opf);
 	else
-		bio_init(&bio, rdev->bdev, &bvec, 1, op | op_flags);
+		bio_init(&bio, rdev->bdev, &bvec, 1, opf);
 
 	if (metadata_op)
 		bio.bi_iter.bi_sector = sector + rdev->sb_start;
@@ -1024,7 +1024,7 @@ static int read_disk_sb(struct md_rdev *rdev, int size)
 	if (rdev->sb_loaded)
 		return 0;
 
-	if (!sync_page_io(rdev, 0, size, rdev->sb_page, REQ_OP_READ, 0, true))
+	if (!sync_page_io(rdev, 0, size, rdev->sb_page, REQ_OP_READ, true))
 		goto fail;
 	rdev->sb_loaded = 1;
 	return 0;
@@ -1722,7 +1722,7 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 			return -EINVAL;
 		bb_sector = (long long)offset;
 		if (!sync_page_io(rdev, bb_sector, sectors << 9,
-				  rdev->bb_page, REQ_OP_READ, 0, true))
+				  rdev->bb_page, REQ_OP_READ, true))
 			return -EIO;
 		bbp = (__le64 *)page_address(rdev->bb_page);
 		rdev->badblocks.shift = sb->bblog_shift;
diff --git a/drivers/md/md.h b/drivers/md/md.h
index cf2cbb17acbd..b4f84b27bdef 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -738,8 +738,7 @@ extern void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 			   sector_t sector, int size, struct page *page);
 extern int md_super_wait(struct mddev *mddev);
 extern int sync_page_io(struct md_rdev *rdev, sector_t sector, int size,
-			struct page *page, int op, int op_flags,
-			bool metadata_op);
+		struct page *page, blk_opf_t opf, bool metadata_op);
 extern void md_do_sync(struct md_thread *thread);
 extern void md_new_event(void);
 extern void md_allow_write(struct mddev *mddev);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 65cd90f0b2a8..8f1a2e4a6e50 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1988,9 +1988,9 @@ static void end_sync_write(struct bio *bio)
 }
 
 static int r1_sync_page_io(struct md_rdev *rdev, sector_t sector,
-			    int sectors, struct page *page, int rw)
+			   int sectors, struct page *page, int rw)
 {
-	if (sync_page_io(rdev, sector, sectors << 9, page, rw, 0, false))
+	if (sync_page_io(rdev, sector, sectors << 9, page, rw, false))
 		/* success */
 		return 1;
 	if (rw == WRITE) {
@@ -2057,7 +2057,7 @@ static int fix_sync_read_error(struct r1bio *r1_bio)
 				rdev = conf->mirrors[d].rdev;
 				if (sync_page_io(rdev, sect, s<<9,
 						 pages[idx],
-						 REQ_OP_READ, 0, false)) {
+						 REQ_OP_READ, false)) {
 					success = 1;
 					break;
 				}
@@ -2305,7 +2305,7 @@ static void fix_read_error(struct r1conf *conf, int read_disk,
 				atomic_inc(&rdev->nr_pending);
 				rcu_read_unlock();
 				if (sync_page_io(rdev, sect, s<<9,
-					 conf->tmppage, REQ_OP_READ, 0, false))
+					 conf->tmppage, REQ_OP_READ, false))
 					success = 1;
 				rdev_dec_pending(rdev, mddev);
 				if (success)
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index a7dcb1bf6b0a..3b80120cba30 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2512,7 +2512,7 @@ static void fix_recovery_read_error(struct r10bio *r10_bio)
 				  addr,
 				  s << 9,
 				  pages[idx],
-				  REQ_OP_READ, 0, false);
+				  REQ_OP_READ, false);
 		if (ok) {
 			rdev = conf->mirrors[dw].rdev;
 			addr = r10_bio->devs[1].addr + sect;
@@ -2520,7 +2520,7 @@ static void fix_recovery_read_error(struct r10bio *r10_bio)
 					  addr,
 					  s << 9,
 					  pages[idx],
-					  REQ_OP_WRITE, 0, false);
+					  REQ_OP_WRITE, false);
 			if (!ok) {
 				set_bit(WriteErrorSeen, &rdev->flags);
 				if (!test_and_set_bit(WantReplacement,
@@ -2644,7 +2644,7 @@ static int r10_sync_page_io(struct md_rdev *rdev, sector_t sector,
 	if (is_badblock(rdev, sector, sectors, &first_bad, &bad_sectors)
 	    && (rw == READ || test_bit(WriteErrorSeen, &rdev->flags)))
 		return -1;
-	if (sync_page_io(rdev, sector, sectors << 9, page, rw, 0, false))
+	if (sync_page_io(rdev, sector, sectors << 9, page, rw, false))
 		/* success */
 		return 1;
 	if (rw == WRITE) {
@@ -2726,7 +2726,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 						       sect,
 						       s<<9,
 						       conf->tmppage,
-						       REQ_OP_READ, 0, false);
+						       REQ_OP_READ, false);
 				rdev_dec_pending(rdev, mddev);
 				rcu_read_lock();
 				if (success)
@@ -5107,7 +5107,7 @@ static int handle_reshape_read_error(struct mddev *mddev,
 					       addr,
 					       s << 9,
 					       pages[idx],
-					       REQ_OP_READ, 0, false);
+					       REQ_OP_READ, false);
 			rdev_dec_pending(rdev, mddev);
 			rcu_read_lock();
 			if (success)
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 83c184eddbda..6f2dd73128b0 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1788,7 +1788,7 @@ static int r5l_log_write_empty_meta_block(struct r5l_log *log, sector_t pos,
 	mb = page_address(page);
 	mb->checksum = cpu_to_le32(crc32c_le(log->uuid_checksum,
 					     mb, PAGE_SIZE));
-	if (!sync_page_io(log->rdev, pos, PAGE_SIZE, page, REQ_OP_WRITE,
+	if (!sync_page_io(log->rdev, pos, PAGE_SIZE, page, REQ_OP_WRITE |
 			  REQ_SYNC | REQ_FUA, false)) {
 		__free_page(page);
 		return -EIO;
@@ -1898,7 +1898,7 @@ r5l_recovery_replay_one_stripe(struct r5conf *conf,
 			atomic_inc(&rdev->nr_pending);
 			rcu_read_unlock();
 			sync_page_io(rdev, sh->sector, PAGE_SIZE,
-				     sh->dev[disk_index].page, REQ_OP_WRITE, 0,
+				     sh->dev[disk_index].page, REQ_OP_WRITE,
 				     false);
 			rdev_dec_pending(rdev, rdev->mddev);
 			rcu_read_lock();
@@ -1908,7 +1908,7 @@ r5l_recovery_replay_one_stripe(struct r5conf *conf,
 			atomic_inc(&rrdev->nr_pending);
 			rcu_read_unlock();
 			sync_page_io(rrdev, sh->sector, PAGE_SIZE,
-				     sh->dev[disk_index].page, REQ_OP_WRITE, 0,
+				     sh->dev[disk_index].page, REQ_OP_WRITE,
 				     false);
 			rdev_dec_pending(rrdev, rrdev->mddev);
 			rcu_read_lock();
@@ -2394,7 +2394,7 @@ r5c_recovery_rewrite_data_only_stripes(struct r5l_log *log,
 						  PAGE_SIZE));
 				kunmap_atomic(addr);
 				sync_page_io(log->rdev, write_pos, PAGE_SIZE,
-					     dev->page, REQ_OP_WRITE, 0, false);
+					     dev->page, REQ_OP_WRITE, false);
 				write_pos = r5l_ring_add(log, write_pos,
 							 BLOCK_SECTORS);
 				offset += sizeof(__le32) +
@@ -2406,7 +2406,7 @@ r5c_recovery_rewrite_data_only_stripes(struct r5l_log *log,
 		mb->checksum = cpu_to_le32(crc32c_le(log->uuid_checksum,
 						     mb, PAGE_SIZE));
 		sync_page_io(log->rdev, ctx->pos, PAGE_SIZE, page,
-			     REQ_OP_WRITE, REQ_SYNC | REQ_FUA, false);
+			     REQ_OP_WRITE | REQ_SYNC | REQ_FUA, false);
 		sh->log_start = ctx->pos;
 		list_add_tail(&sh->r5c, &log->stripe_in_journal_list);
 		atomic_inc(&log->stripe_in_journal_count);
@@ -2971,7 +2971,7 @@ static int r5l_load_log(struct r5l_log *log)
 	if (!page)
 		return -ENOMEM;
 
-	if (!sync_page_io(rdev, cp, PAGE_SIZE, page, REQ_OP_READ, 0, false)) {
+	if (!sync_page_io(rdev, cp, PAGE_SIZE, page, REQ_OP_READ, false)) {
 		ret = -EIO;
 		goto ioerr;
 	}
diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index 0a2e4806b1ec..98988cb26295 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -897,7 +897,7 @@ static int ppl_recover_entry(struct ppl_log *log, struct ppl_header_entry *e,
 				 __func__, indent, "", rdev->bdev,
 				 (unsigned long long)sector);
 			if (!sync_page_io(rdev, sector, block_size, page2,
-					REQ_OP_READ, 0, false)) {
+					REQ_OP_READ, false)) {
 				md_error(mddev, rdev);
 				pr_debug("%s:%*s read failed!\n", __func__,
 					 indent, "");
@@ -919,7 +919,7 @@ static int ppl_recover_entry(struct ppl_log *log, struct ppl_header_entry *e,
 				 (unsigned long long)(ppl_sector + i));
 			if (!sync_page_io(log->rdev,
 					ppl_sector - log->rdev->data_offset + i,
-					block_size, page2, REQ_OP_READ, 0,
+					block_size, page2, REQ_OP_READ,
 					false)) {
 				pr_debug("%s:%*s read failed!\n", __func__,
 					 indent, "");
@@ -946,7 +946,7 @@ static int ppl_recover_entry(struct ppl_log *log, struct ppl_header_entry *e,
 			 (unsigned long long)parity_sector,
 			 parity_rdev->bdev);
 		if (!sync_page_io(parity_rdev, parity_sector, block_size,
-				page1, REQ_OP_WRITE, 0, false)) {
+				  page1, REQ_OP_WRITE, false)) {
 			pr_debug("%s:%*s parity write error!\n", __func__,
 				 indent, "");
 			md_error(mddev, parity_rdev);
@@ -998,7 +998,7 @@ static int ppl_recover(struct ppl_log *log, struct ppl_header *pplhdr,
 			int s = pp_size > PAGE_SIZE ? PAGE_SIZE : pp_size;
 
 			if (!sync_page_io(rdev, sector - rdev->data_offset,
-					s, page, REQ_OP_READ, 0, false)) {
+					s, page, REQ_OP_READ, false)) {
 				md_error(mddev, rdev);
 				ret = -EIO;
 				goto out;
@@ -1062,7 +1062,7 @@ static int ppl_write_empty_header(struct ppl_log *log)
 
 	if (!sync_page_io(rdev, rdev->ppl.sector - rdev->data_offset,
 			  PPL_HEADER_SIZE, page, REQ_OP_WRITE | REQ_SYNC |
-			  REQ_FUA, 0, false)) {
+			  REQ_FUA, false)) {
 		md_error(rdev->mddev, rdev);
 		ret = -EIO;
 	}
@@ -1100,7 +1100,7 @@ static int ppl_load_distributed(struct ppl_log *log)
 		if (!sync_page_io(rdev,
 				  rdev->ppl.sector - rdev->data_offset +
 				  pplhdr_offset, PAGE_SIZE, page, REQ_OP_READ,
-				  0, false)) {
+				  false)) {
 			md_error(mddev, rdev);
 			ret = -EIO;
 			/* if not able to read - don't recover any PPL */
