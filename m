Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8BAC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiF2Xcg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiF2Xcf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:35 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9056EB39
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:34 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id n10so15531055plp.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fSuQHpGu4ld1123FLLzhaFDF+c7bwJVO7lzj11D+EhM=;
        b=FQ29sYUvJGkRSS7V/pTVbJlCGyYUAEUNBNYQOHpstV6tu7an3wGQEE3CcTCUV7yED7
         8KuiodVj5Yir1tesKIy8ZnVxNB4F+FrbXF9mJgiPp05yg0qWFKyjVSZSceHJkKlrVm+/
         AvCgNmeAPBkLi8qPcY0P0NtaidbDbSUdo/LoDHwoX6VKnGluEe2XM9QXvTyICumPbWyI
         +PQLtFqmV719HcK8+z5y54NBthChRfspqvec5ZBBc7lPy4eXJZW1CbXnGqQajdQVo856
         fvTZy6U1ePi+hkeLZuqocUVkjN0LXuukFvMin//5cuyx/LOlE7MjvQvuLlG2ixJCNPc+
         YXCg==
X-Gm-Message-State: AJIora+F9qTvK0mbDCKV3Q0QB7KHNi8ZKvNKGBUcygaRZgcqJ4oSLwct
        2wnghGV5tBDExLGrRHSV9po=
X-Google-Smtp-Source: AGRyM1u/xI4J+VGczKyz6CqvprDSI3PdyNfwL34oZ0NJpqlxRG6Dn1S/jzFqAgJMk5R9FrakUGSRcQ==
X-Received: by 2002:a17:902:f705:b0:16b:9b6d:67a1 with SMTP id h5-20020a170902f70500b0016b9b6d67a1mr7703274plo.39.1656545553981;
        Wed, 29 Jun 2022 16:32:33 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:33 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH v2 26/63] dm/dm-integrity: Combine request operation and flags
Date:   Wed, 29 Jun 2022 16:31:08 -0700
Message-Id: <20220629233145.2779494-27-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Combine the request operation type and request flags into a single
argument. Improve static type checking by using the enum req_op type for
variables that represent a request operation and the new blk_opf_t type for
variables that represent request flags.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Eric Biggers <ebiggers@google.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-integrity.c | 63 +++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 2ccc103dea1e..c60f9b2ece2d 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -551,13 +551,14 @@ static int sb_mac(struct dm_integrity_c *ic, bool wr)
 	return 0;
 }
 
-static int sync_rw_sb(struct dm_integrity_c *ic, int op, int op_flags)
+static int sync_rw_sb(struct dm_integrity_c *ic, blk_opf_t opf)
 {
 	struct dm_io_request io_req;
 	struct dm_io_region io_loc;
+	const enum req_op op = opf & REQ_OP_MASK;
 	int r;
 
-	io_req.bi_opf = op | op_flags;
+	io_req.bi_opf = opf;
 	io_req.mem.type = DM_IO_KMEM;
 	io_req.mem.ptr.addr = ic->sb;
 	io_req.notify.fn = NULL;
@@ -1049,8 +1050,9 @@ static void complete_journal_io(unsigned long error, void *context)
 	complete_journal_op(comp);
 }
 
-static void rw_journal_sectors(struct dm_integrity_c *ic, int op, int op_flags,
-			       unsigned sector, unsigned n_sectors, struct journal_completion *comp)
+static void rw_journal_sectors(struct dm_integrity_c *ic, blk_opf_t opf,
+			       unsigned sector, unsigned n_sectors,
+			       struct journal_completion *comp)
 {
 	struct dm_io_request io_req;
 	struct dm_io_region io_loc;
@@ -1066,7 +1068,7 @@ static void rw_journal_sectors(struct dm_integrity_c *ic, int op, int op_flags,
 	pl_index = sector >> (PAGE_SHIFT - SECTOR_SHIFT);
 	pl_offset = (sector << SECTOR_SHIFT) & (PAGE_SIZE - 1);
 
-	io_req.bi_opf = op | op_flags;
+	io_req.bi_opf = opf;
 	io_req.mem.type = DM_IO_PAGE_LIST;
 	if (ic->journal_io)
 		io_req.mem.ptr.pl = &ic->journal_io[pl_index];
@@ -1086,7 +1088,8 @@ static void rw_journal_sectors(struct dm_integrity_c *ic, int op, int op_flags,
 
 	r = dm_io(&io_req, 1, &io_loc, NULL);
 	if (unlikely(r)) {
-		dm_integrity_io_error(ic, op == REQ_OP_READ ? "reading journal" : "writing journal", r);
+		dm_integrity_io_error(ic, (opf & REQ_OP_MASK) == REQ_OP_READ ?
+				      "reading journal" : "writing journal", r);
 		if (comp) {
 			WARN_ONCE(1, "asynchronous dm_io failed: %d", r);
 			complete_journal_io(-1UL, comp);
@@ -1094,15 +1097,16 @@ static void rw_journal_sectors(struct dm_integrity_c *ic, int op, int op_flags,
 	}
 }
 
-static void rw_journal(struct dm_integrity_c *ic, int op, int op_flags, unsigned section,
-		       unsigned n_sections, struct journal_completion *comp)
+static void rw_journal(struct dm_integrity_c *ic, blk_opf_t opf,
+		       unsigned section, unsigned n_sections,
+		       struct journal_completion *comp)
 {
 	unsigned sector, n_sectors;
 
 	sector = section * ic->journal_section_sectors;
 	n_sectors = n_sections * ic->journal_section_sectors;
 
-	rw_journal_sectors(ic, op, op_flags, sector, n_sectors, comp);
+	rw_journal_sectors(ic, opf, sector, n_sectors, comp);
 }
 
 static void write_journal(struct dm_integrity_c *ic, unsigned commit_start, unsigned commit_sections)
@@ -1127,7 +1131,7 @@ static void write_journal(struct dm_integrity_c *ic, unsigned commit_start, unsi
 			for (i = 0; i < commit_sections; i++)
 				rw_section_mac(ic, commit_start + i, true);
 		}
-		rw_journal(ic, REQ_OP_WRITE, REQ_FUA | REQ_SYNC, commit_start,
+		rw_journal(ic, REQ_OP_WRITE | REQ_FUA | REQ_SYNC, commit_start,
 			   commit_sections, &io_comp);
 	} else {
 		unsigned to_end;
@@ -1139,7 +1143,8 @@ static void write_journal(struct dm_integrity_c *ic, unsigned commit_start, unsi
 			crypt_comp_1.in_flight = (atomic_t)ATOMIC_INIT(0);
 			encrypt_journal(ic, true, commit_start, to_end, &crypt_comp_1);
 			if (try_wait_for_completion(&crypt_comp_1.comp)) {
-				rw_journal(ic, REQ_OP_WRITE, REQ_FUA, commit_start, to_end, &io_comp);
+				rw_journal(ic, REQ_OP_WRITE | REQ_FUA,
+					   commit_start, to_end, &io_comp);
 				reinit_completion(&crypt_comp_1.comp);
 				crypt_comp_1.in_flight = (atomic_t)ATOMIC_INIT(0);
 				encrypt_journal(ic, true, 0, commit_sections - to_end, &crypt_comp_1);
@@ -1150,17 +1155,17 @@ static void write_journal(struct dm_integrity_c *ic, unsigned commit_start, unsi
 				crypt_comp_2.in_flight = (atomic_t)ATOMIC_INIT(0);
 				encrypt_journal(ic, true, 0, commit_sections - to_end, &crypt_comp_2);
 				wait_for_completion_io(&crypt_comp_1.comp);
-				rw_journal(ic, REQ_OP_WRITE, REQ_FUA, commit_start, to_end, &io_comp);
+				rw_journal(ic, REQ_OP_WRITE | REQ_FUA, commit_start, to_end, &io_comp);
 				wait_for_completion_io(&crypt_comp_2.comp);
 			}
 		} else {
 			for (i = 0; i < to_end; i++)
 				rw_section_mac(ic, commit_start + i, true);
-			rw_journal(ic, REQ_OP_WRITE, REQ_FUA, commit_start, to_end, &io_comp);
+			rw_journal(ic, REQ_OP_WRITE | REQ_FUA, commit_start, to_end, &io_comp);
 			for (i = 0; i < commit_sections - to_end; i++)
 				rw_section_mac(ic, i, true);
 		}
-		rw_journal(ic, REQ_OP_WRITE, REQ_FUA, 0, commit_sections - to_end, &io_comp);
+		rw_journal(ic, REQ_OP_WRITE | REQ_FUA, 0, commit_sections - to_end, &io_comp);
 	}
 
 	wait_for_completion_io(&io_comp.comp);
@@ -2622,7 +2627,7 @@ static void recalc_write_super(struct dm_integrity_c *ic)
 	if (dm_integrity_failed(ic))
 		return;
 
-	r = sync_rw_sb(ic, REQ_OP_WRITE, 0);
+	r = sync_rw_sb(ic, REQ_OP_WRITE);
 	if (unlikely(r))
 		dm_integrity_io_error(ic, "writing superblock", r);
 }
@@ -2795,7 +2800,7 @@ static void bitmap_block_work(struct work_struct *w)
 	if (bio_list_empty(&waiting))
 		return;
 
-	rw_journal_sectors(ic, REQ_OP_WRITE, REQ_FUA | REQ_SYNC,
+	rw_journal_sectors(ic, REQ_OP_WRITE | REQ_FUA | REQ_SYNC,
 			   bbs->idx * (BITMAP_BLOCK_SIZE >> SECTOR_SHIFT),
 			   BITMAP_BLOCK_SIZE >> SECTOR_SHIFT, NULL);
 
@@ -2841,7 +2846,7 @@ static void bitmap_flush_work(struct work_struct *work)
 	block_bitmap_op(ic, ic->journal, 0, limit, BITMAP_OP_CLEAR);
 	block_bitmap_op(ic, ic->may_write_bitmap, 0, limit, BITMAP_OP_CLEAR);
 
-	rw_journal_sectors(ic, REQ_OP_WRITE, REQ_FUA | REQ_SYNC, 0,
+	rw_journal_sectors(ic, REQ_OP_WRITE | REQ_FUA | REQ_SYNC, 0,
 			   ic->n_bitmap_blocks * (BITMAP_BLOCK_SIZE >> SECTOR_SHIFT), NULL);
 
 	spin_lock_irq(&ic->endio_wait.lock);
@@ -2913,7 +2918,7 @@ static void replay_journal(struct dm_integrity_c *ic)
 
 	if (!ic->just_formatted) {
 		DEBUG_print("reading journal\n");
-		rw_journal(ic, REQ_OP_READ, 0, 0, ic->journal_sections, NULL);
+		rw_journal(ic, REQ_OP_READ, 0, ic->journal_sections, NULL);
 		if (ic->journal_io)
 			DEBUG_bytes(lowmem_page_address(ic->journal_io[0].page), 64, "read journal");
 		if (ic->journal_io) {
@@ -3108,7 +3113,7 @@ static void dm_integrity_postsuspend(struct dm_target *ti)
 		/* set to 0 to test bitmap replay code */
 		init_journal(ic, 0, ic->journal_sections, 0);
 		ic->sb->flags &= ~cpu_to_le32(SB_FLAG_DIRTY_BITMAP);
-		r = sync_rw_sb(ic, REQ_OP_WRITE, REQ_FUA);
+		r = sync_rw_sb(ic, REQ_OP_WRITE | REQ_FUA);
 		if (unlikely(r))
 			dm_integrity_io_error(ic, "writing superblock", r);
 #endif
@@ -3131,23 +3136,23 @@ static void dm_integrity_resume(struct dm_target *ti)
 		if (ic->provided_data_sectors > old_provided_data_sectors &&
 		    ic->mode == 'B' &&
 		    ic->sb->log2_blocks_per_bitmap_bit == ic->log2_blocks_per_bitmap_bit) {
-			rw_journal_sectors(ic, REQ_OP_READ, 0, 0,
+			rw_journal_sectors(ic, REQ_OP_READ, 0,
 					   ic->n_bitmap_blocks * (BITMAP_BLOCK_SIZE >> SECTOR_SHIFT), NULL);
 			block_bitmap_op(ic, ic->journal, old_provided_data_sectors,
 					ic->provided_data_sectors - old_provided_data_sectors, BITMAP_OP_SET);
-			rw_journal_sectors(ic, REQ_OP_WRITE, REQ_FUA | REQ_SYNC, 0,
+			rw_journal_sectors(ic, REQ_OP_WRITE | REQ_FUA | REQ_SYNC, 0,
 					   ic->n_bitmap_blocks * (BITMAP_BLOCK_SIZE >> SECTOR_SHIFT), NULL);
 		}
 
 		ic->sb->provided_data_sectors = cpu_to_le64(ic->provided_data_sectors);
-		r = sync_rw_sb(ic, REQ_OP_WRITE, REQ_FUA);
+		r = sync_rw_sb(ic, REQ_OP_WRITE | REQ_FUA);
 		if (unlikely(r))
 			dm_integrity_io_error(ic, "writing superblock", r);
 	}
 
 	if (ic->sb->flags & cpu_to_le32(SB_FLAG_DIRTY_BITMAP)) {
 		DEBUG_print("resume dirty_bitmap\n");
-		rw_journal_sectors(ic, REQ_OP_READ, 0, 0,
+		rw_journal_sectors(ic, REQ_OP_READ, 0,
 				   ic->n_bitmap_blocks * (BITMAP_BLOCK_SIZE >> SECTOR_SHIFT), NULL);
 		if (ic->mode == 'B') {
 			if (ic->sb->log2_blocks_per_bitmap_bit == ic->log2_blocks_per_bitmap_bit &&
@@ -3166,7 +3171,7 @@ static void dm_integrity_resume(struct dm_target *ti)
 				block_bitmap_op(ic, ic->recalc_bitmap, 0, ic->provided_data_sectors, BITMAP_OP_SET);
 				block_bitmap_op(ic, ic->may_write_bitmap, 0, ic->provided_data_sectors, BITMAP_OP_SET);
 				block_bitmap_op(ic, ic->journal, 0, ic->provided_data_sectors, BITMAP_OP_SET);
-				rw_journal_sectors(ic, REQ_OP_WRITE, REQ_FUA | REQ_SYNC, 0,
+				rw_journal_sectors(ic, REQ_OP_WRITE | REQ_FUA | REQ_SYNC, 0,
 						   ic->n_bitmap_blocks * (BITMAP_BLOCK_SIZE >> SECTOR_SHIFT), NULL);
 				ic->sb->flags |= cpu_to_le32(SB_FLAG_RECALCULATING);
 				ic->sb->recalc_sector = cpu_to_le64(0);
@@ -3182,7 +3187,7 @@ static void dm_integrity_resume(struct dm_target *ti)
 			replay_journal(ic);
 			ic->sb->flags &= ~cpu_to_le32(SB_FLAG_DIRTY_BITMAP);
 		}
-		r = sync_rw_sb(ic, REQ_OP_WRITE, REQ_FUA);
+		r = sync_rw_sb(ic, REQ_OP_WRITE | REQ_FUA);
 		if (unlikely(r))
 			dm_integrity_io_error(ic, "writing superblock", r);
 	} else {
@@ -3194,7 +3199,7 @@ static void dm_integrity_resume(struct dm_target *ti)
 		if (ic->mode == 'B') {
 			ic->sb->flags |= cpu_to_le32(SB_FLAG_DIRTY_BITMAP);
 			ic->sb->log2_blocks_per_bitmap_bit = ic->log2_blocks_per_bitmap_bit;
-			r = sync_rw_sb(ic, REQ_OP_WRITE, REQ_FUA);
+			r = sync_rw_sb(ic, REQ_OP_WRITE | REQ_FUA);
 			if (unlikely(r))
 				dm_integrity_io_error(ic, "writing superblock", r);
 
@@ -3210,7 +3215,7 @@ static void dm_integrity_resume(struct dm_target *ti)
 				block_bitmap_op(ic, ic->may_write_bitmap, le64_to_cpu(ic->sb->recalc_sector),
 						ic->provided_data_sectors - le64_to_cpu(ic->sb->recalc_sector), BITMAP_OP_SET);
 			}
-			rw_journal_sectors(ic, REQ_OP_WRITE, REQ_FUA | REQ_SYNC, 0,
+			rw_journal_sectors(ic, REQ_OP_WRITE | REQ_FUA | REQ_SYNC, 0,
 					   ic->n_bitmap_blocks * (BITMAP_BLOCK_SIZE >> SECTOR_SHIFT), NULL);
 		}
 	}
@@ -4251,7 +4256,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		goto bad;
 	}
 
-	r = sync_rw_sb(ic, REQ_OP_READ, 0);
+	r = sync_rw_sb(ic, REQ_OP_READ);
 	if (r) {
 		ti->error = "Error reading superblock";
 		goto bad;
@@ -4495,7 +4500,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 			ti->error = "Error initializing journal";
 			goto bad;
 		}
-		r = sync_rw_sb(ic, REQ_OP_WRITE, REQ_FUA);
+		r = sync_rw_sb(ic, REQ_OP_WRITE | REQ_FUA);
 		if (r) {
 			ti->error = "Error initializing superblock";
 			goto bad;
