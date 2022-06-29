Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FA1C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiF2Xdg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiF2Xdb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:31 -0400
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32E2CF3
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:18 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id h192so16803492pgc.4
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLGvabJnHak23YMl7WkULWKcdLS3aj6ZvDPGT4E3H8c=;
        b=qc3fL0bFEk1op3AHKMMqJdk2HLZYOYx6M43qjtK868ewg9k8LE9DGVQWKXIZsiGGMV
         j95/K88HxhUrv5dil3s9yOOrimhPbYQ8ZHAPtg6zETS7UsAg5ukp8HCKdhHVBU8zy+SC
         x1lPOYYKCe7bZeFZQcoqxGqEqZCGGdqxNeGGCC755g7j91RqEGvDftV2QJO9CeIxg6JK
         5JkyCGC2oLGVC/5oFTB3MFZjMnx69SMXTAYlbTJBTq5gL+RlRJxgT3dqR8GQ67vOMSfB
         mM3K9tjIC1W5PEM797a5Vy7+EQJQf8lBx9rZjpvSIdZ1I4cVM4km/HluuZ3mFquYArAP
         Jnmw==
X-Gm-Message-State: AJIora/M55Vx/+1SaRsCSNXQNAZE2424wGPFYgl9ew0CBZJhFXITrGFp
        RB7G14AcNDSZCO95UoNiLlo=
X-Google-Smtp-Source: AGRyM1vtTNa1WGgP3Xh5KaQqN9Zv9GX9vEIEHnw3pKviKOg+xeZRKxMV5CXvq0u54E22vpaFW/jBAQ==
X-Received: by 2002:a63:6dcf:0:b0:40c:a2b5:3480 with SMTP id i198-20020a636dcf000000b0040ca2b53480mr4961400pgc.203.1656545594143;
        Wed, 29 Jun 2022 16:33:14 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 53/63] fs/gfs2: Use the enum req_op and blk_opf_t types
Date:   Wed, 29 Jun 2022 16:31:35 -0700
Message-Id: <20220629233145.2779494-54-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags. Combine the first two
gfs2_submit_bhs() arguments into a single argument.

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/gfs2/log.c     | 4 ++--
 fs/gfs2/log.h     | 2 +-
 fs/gfs2/lops.c    | 4 ++--
 fs/gfs2/lops.h    | 2 +-
 fs/gfs2/meta_io.c | 9 ++++-----
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index f0ee3ff6f9a8..eec4159b08aa 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -823,7 +823,7 @@ void gfs2_flush_revokes(struct gfs2_sbd *sdp)
 
 void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 			   u64 seq, u32 tail, u32 lblock, u32 flags,
-			   int op_flags)
+			   blk_opf_t op_flags)
 {
 	struct gfs2_log_header *lh;
 	u32 hash, crc;
@@ -905,7 +905,7 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 
 static void log_write_header(struct gfs2_sbd *sdp, u32 flags)
 {
-	int op_flags = REQ_PREFLUSH | REQ_FUA | REQ_META | REQ_SYNC;
+	blk_opf_t op_flags = REQ_PREFLUSH | REQ_FUA | REQ_META | REQ_SYNC;
 	enum gfs2_freeze_state state = atomic_read(&sdp->sd_freeze_state);
 
 	gfs2_assert_withdraw(sdp, (state != SFS_FROZEN));
diff --git a/fs/gfs2/log.h b/fs/gfs2/log.h
index fc905c2af53c..653cffcbf869 100644
--- a/fs/gfs2/log.h
+++ b/fs/gfs2/log.h
@@ -82,7 +82,7 @@ extern void gfs2_log_reserve(struct gfs2_sbd *sdp, struct gfs2_trans *tr,
 			     unsigned int *extra_revokes);
 extern void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 				  u64 seq, u32 tail, u32 lblock, u32 flags,
-				  int op_flags);
+				  blk_opf_t op_flags);
 extern void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl,
 			   u32 type);
 extern void gfs2_log_commit(struct gfs2_sbd *sdp, struct gfs2_trans *trans);
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 6ba51cbb94cf..90a2d7bc91c4 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -238,7 +238,7 @@ static void gfs2_end_log_write(struct bio *bio)
  * there is no pending bio, then this is a no-op.
  */
 
-void gfs2_log_submit_bio(struct bio **biop, int opf)
+void gfs2_log_submit_bio(struct bio **biop, blk_opf_t opf)
 {
 	struct bio *bio = *biop;
 	if (bio) {
@@ -292,7 +292,7 @@ static struct bio *gfs2_log_alloc_bio(struct gfs2_sbd *sdp, u64 blkno,
  */
 
 static struct bio *gfs2_log_get_bio(struct gfs2_sbd *sdp, u64 blkno,
-				    struct bio **biop, int op,
+				    struct bio **biop, enum req_op op,
 				    bio_end_io_t *end_io, bool flush)
 {
 	struct bio *bio = *biop;
diff --git a/fs/gfs2/lops.h b/fs/gfs2/lops.h
index f707601597dc..1412ffba1d44 100644
--- a/fs/gfs2/lops.h
+++ b/fs/gfs2/lops.h
@@ -16,7 +16,7 @@ extern u64 gfs2_log_bmap(struct gfs2_jdesc *jd, unsigned int lbn);
 extern void gfs2_log_write(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 			   struct page *page, unsigned size, unsigned offset,
 			   u64 blkno);
-extern void gfs2_log_submit_bio(struct bio **biop, int opf);
+extern void gfs2_log_submit_bio(struct bio **biop, blk_opf_t opf);
 extern void gfs2_pin(struct gfs2_sbd *sdp, struct buffer_head *bh);
 extern int gfs2_find_jhead(struct gfs2_jdesc *jd,
 			   struct gfs2_log_header_host *head, bool keep_cache);
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 3570739f005d..7e70e0ba5a6c 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -34,7 +34,7 @@ static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wb
 {
 	struct buffer_head *bh, *head;
 	int nr_underway = 0;
-	int write_flags = REQ_META | REQ_PRIO | wbc_to_write_flags(wbc);
+	blk_opf_t write_flags = REQ_META | REQ_PRIO | wbc_to_write_flags(wbc);
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(!page_has_buffers(page));
@@ -217,14 +217,13 @@ static void gfs2_meta_read_endio(struct bio *bio)
  * Submit several consecutive buffer head I/O requests as a single bio I/O
  * request.  (See submit_bh_wbc.)
  */
-static void gfs2_submit_bhs(int op, int op_flags, struct buffer_head *bhs[],
-			    int num)
+static void gfs2_submit_bhs(blk_opf_t opf, struct buffer_head *bhs[], int num)
 {
 	while (num > 0) {
 		struct buffer_head *bh = *bhs;
 		struct bio *bio;
 
-		bio = bio_alloc(bh->b_bdev, num, op | op_flags, GFP_NOIO);
+		bio = bio_alloc(bh->b_bdev, num, opf, GFP_NOIO);
 		bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 		while (num > 0) {
 			bh = *bhs;
@@ -288,7 +287,7 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 		}
 	}
 
-	gfs2_submit_bhs(REQ_OP_READ, REQ_META | REQ_PRIO, bhs, num);
+	gfs2_submit_bhs(REQ_OP_READ | REQ_META | REQ_PRIO, bhs, num);
 	if (!(flags & DIO_WAIT))
 		return 0;
 
