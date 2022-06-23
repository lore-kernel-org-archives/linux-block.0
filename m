Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203CDC433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiFWTBr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiFWTBb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:31 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A2860F09
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:42 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id r1so18808172plo.10
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SVHkZf2sTQS9SE2dnzik0Dn4Cehwp8o6/dpBWgcOOn0=;
        b=iJce6cSF1t4W2AjUcKcBKQXfoEMxp0+/cESzI/kg77oI03meXj7Uvx28PC/1h1ObCT
         qaMEo/qS8OmxlfgSGW3D4i2sqF8DZduUAxLk0I29NhnnIiuRnHc+QUCNGZpvSM3vc2So
         mwNzF5B/xoOZ8HoD2CyQkXq8plF/BmWAJiEVMye0Fj/qMFpCflcnB76ohF1Pi+8PNukP
         Liiyk+sm4/oXrQs4UDxVmWZEZ596xHXzrOyzqkJgeHDz2hF7XnYKu3pmnLZ+K0CI0OME
         fAItEIuX2vkKTjXrFXQ6E6oT5n49EIfEpu1RwvegpuBgkgc+UudAAIFrc9mHEAlReHWk
         Tyzw==
X-Gm-Message-State: AJIora+ZsMtue4NzcS08p80YbR612f5wu9Up+irxxjn0+fcRD+nXLOnm
        ev5lBQ0yYyZ7XNeB6b6YdaM=
X-Google-Smtp-Source: AGRyM1sa43og8CnN5oApJY5eMw6rLBV7DFqYg/KhmYQrWzrhoi9pgI5VoNben/PFZxmNnxvs4GtYYw==
X-Received: by 2002:a17:902:b105:b0:16a:1a48:3382 with SMTP id q5-20020a170902b10500b0016a1a483382mr24684133plr.128.1656007601560;
        Thu, 23 Jun 2022 11:06:41 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:40 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 42/51] fs/gfs2: Use the enum req_op and blk_opf_t types
Date:   Thu, 23 Jun 2022 11:05:19 -0700
Message-Id: <20220623180528.3595304-43-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags.

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/gfs2/log.c     | 4 ++--
 fs/gfs2/log.h     | 2 +-
 fs/gfs2/lops.c    | 4 ++--
 fs/gfs2/lops.h    | 2 +-
 fs/gfs2/meta_io.c | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

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
index 868dcc71b581..fe0fdec628ea 100644
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
@@ -217,8 +217,8 @@ static void gfs2_meta_read_endio(struct bio *bio)
  * Submit several consecutive buffer head I/O requests as a single bio I/O
  * request.  (See submit_bh_wbc.)
  */
-static void gfs2_submit_bhs(int op, int op_flags, struct buffer_head *bhs[],
-			    int num)
+static void gfs2_submit_bhs(enum req_op op, blk_opf_t op_flags,
+			    struct buffer_head *bhs[], int num)
 {
 	while (num > 0) {
 		struct buffer_head *bh = *bhs;
