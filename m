Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEDAC43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240235AbiGNSJc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240582AbiGNSJS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:09:18 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDC0255BC
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:03 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so9346146pjo.3
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8++QWhqhcQOZANXJkJ0l1AWsqDRP4OOaVT65wqSgGZ8=;
        b=h/4TscRANdn+F3mgNsjXk0NIaYrXlqA1ZAjKxhh4vpkFXrmN6kvWnQVnPoRttrfDcr
         qF5PgNjeMMGtq+4holKNosrYGlTAWF2YN8oUQxQRlRdz1TIT4lyZmly7fdWqPwr9fl3T
         tzJiaWF+QHeswn4YdzOujjvuTGyGona+vil5Ep/Z24kXzS8sG2jZbRATSPQjQrr0iDub
         9lS7Chf+RFimy+oWyC/exv1rvIHgtnRy7zywhkdGRRN8DmBQVoe2s6lwujI54xGkOcf2
         7uqxOxw2vOKGXhLeyI/IZonrhT5kF/VOYyJ3ymlvY+89FaaNVcFClFFqU1SH9aQxLDG7
         XwUA==
X-Gm-Message-State: AJIora8gokI3g8oW4uHbzgcZeElrbrqmmY0v0KlORSgFfm1Y1sXnsgzp
        gEmsJM8N9lA9eWxMRvoT/c2tRC5UgQQ=
X-Google-Smtp-Source: AGRyM1sdPyHhUNCqqHV65vk5VnlpJ1N3NHA2jjp6THeDk1IazpEl/HnqV1u+jim9JNsnLGCWZ9hcEQ==
X-Received: by 2002:a17:90b:240e:b0:1e0:775b:f8fc with SMTP id nr14-20020a17090b240e00b001e0775bf8fcmr11119872pjb.132.1657822143370;
        Thu, 14 Jul 2022 11:09:03 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:09:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH v3 53/63] fs/gfs2: Use the enum req_op and blk_opf_t types
Date:   Thu, 14 Jul 2022 11:07:19 -0700
Message-Id: <20220714180729.1065367-54-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags. Combine the first two
gfs2_submit_bhs() arguments into a single argument.

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Bob Peterson <rpeterso@redhat.com>
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
 
