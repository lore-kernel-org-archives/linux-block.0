Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54361C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbiGNSJd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240578AbiGNSJS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:09:18 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192302018C
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:00 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so9446049pjn.0
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jed3aCAnXHD03aD3g5SBZl6FVWmXMXuTWzT/JC04qTc=;
        b=ZBZExvGMveicTgaz5aKehvV0XzrBxpFsLOIXIhm53ZAczqsSW5X0dfCgoRXxsaYRCK
         UIxC4mR6djiBjwQ0IZ2aGeD+ihXyAY/LRPh7RnngfcK2JmwexKqLBAtCkDKXiZlu3/9Q
         Z4+y1cCTcZDbkAsixL2wJPW+QvemTCupzc69DrFxTQ3RckwP04LereoaqNAT9YOq3dyl
         TV9kBoD4ltkQEqOD0GFT89rA0Un22mVXRkq68S7aHbD6Z+E8qZmuXergF4yCgG4GUhlG
         lc1bxAyublUESfYIu84/5u1XmHmtLB8ZHAeAqsYd++Qw06eVXqj7HQmZ5N3kc3NH5rRB
         Dhxw==
X-Gm-Message-State: AJIora+rhepJFKC185raQ9Orj+OonE5biJ8stxpZ5jPamRyIiTonp+6A
        A8WXNQNSg+bgKE3t3qpdaGM=
X-Google-Smtp-Source: AGRyM1uLhCGrkcNwZkgukUe+oO1+ydK2/Bp9cMlxryK30J3SdO5KmNsJuLyMaRrXIk1LfRNq7jdoGQ==
X-Received: by 2002:a17:90b:28e:b0:1ef:9a42:d8c with SMTP id az14-20020a17090b028e00b001ef9a420d8cmr17558942pjb.54.1657822139167;
        Thu, 14 Jul 2022 11:08:59 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Baokun Li <libaokun1@huawei.com>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH v3 51/63] fs/ext4: Use the new blk_opf_t type
Date:   Thu, 14 Jul 2022 11:07:17 -0700
Message-Id: <20220714180729.1065367-52-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for
variables that represent request flags.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Baokun Li <libaokun1@huawei.com>
Cc: Ye Bin <yebin10@huawei.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/ext4/ext4.h        |  8 ++++----
 fs/ext4/fast_commit.c |  2 +-
 fs/ext4/super.c       | 14 +++++++-------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 75b8d81b2469..29fc575a4eb6 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3058,14 +3058,14 @@ extern unsigned int ext4_list_backups(struct super_block *sb,
 
 /* super.c */
 extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
-					 sector_t block, int op_flags);
+					 sector_t block, blk_opf_t op_flags);
 extern struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 						   sector_t block);
-extern void ext4_read_bh_nowait(struct buffer_head *bh, int op_flags,
+extern void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
 				bh_end_io_t *end_io);
-extern int ext4_read_bh(struct buffer_head *bh, int op_flags,
+extern int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
 			bh_end_io_t *end_io);
-extern int ext4_read_bh_lock(struct buffer_head *bh, int op_flags, bool wait);
+extern int ext4_read_bh_lock(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
 extern void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block);
 extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
 extern int ext4_calculate_overhead(struct super_block *sb);
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 0df5482c6c1c..eb4c8ad1bb61 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -658,7 +658,7 @@ void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t star
 
 static void ext4_fc_submit_bh(struct super_block *sb, bool is_tail)
 {
-	int write_flags = REQ_SYNC;
+	blk_opf_t write_flags = REQ_SYNC;
 	struct buffer_head *bh = EXT4_SB(sb)->s_fc_bh;
 
 	/* Add REQ_FUA | REQ_PREFLUSH only its tail */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 24922184b622..2c68dec63e54 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -159,7 +159,7 @@ MODULE_ALIAS("ext3");
 #define IS_EXT3_SB(sb) ((sb)->s_bdev->bd_holder == &ext3_fs_type)
 
 
-static inline void __ext4_read_bh(struct buffer_head *bh, int op_flags,
+static inline void __ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
 				  bh_end_io_t *end_io)
 {
 	/*
@@ -174,7 +174,7 @@ static inline void __ext4_read_bh(struct buffer_head *bh, int op_flags,
 	submit_bh(REQ_OP_READ | op_flags, bh);
 }
 
-void ext4_read_bh_nowait(struct buffer_head *bh, int op_flags,
+void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
 			 bh_end_io_t *end_io)
 {
 	BUG_ON(!buffer_locked(bh));
@@ -186,7 +186,7 @@ void ext4_read_bh_nowait(struct buffer_head *bh, int op_flags,
 	__ext4_read_bh(bh, op_flags, end_io);
 }
 
-int ext4_read_bh(struct buffer_head *bh, int op_flags, bh_end_io_t *end_io)
+int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags, bh_end_io_t *end_io)
 {
 	BUG_ON(!buffer_locked(bh));
 
@@ -203,7 +203,7 @@ int ext4_read_bh(struct buffer_head *bh, int op_flags, bh_end_io_t *end_io)
 	return -EIO;
 }
 
-int ext4_read_bh_lock(struct buffer_head *bh, int op_flags, bool wait)
+int ext4_read_bh_lock(struct buffer_head *bh, blk_opf_t op_flags, bool wait)
 {
 	if (trylock_buffer(bh)) {
 		if (wait)
@@ -227,8 +227,8 @@ int ext4_read_bh_lock(struct buffer_head *bh, int op_flags, bool wait)
  * return.
  */
 static struct buffer_head *__ext4_sb_bread_gfp(struct super_block *sb,
-					       sector_t block, int op_flags,
-					       gfp_t gfp)
+					       sector_t block,
+					       blk_opf_t op_flags, gfp_t gfp)
 {
 	struct buffer_head *bh;
 	int ret;
@@ -248,7 +248,7 @@ static struct buffer_head *__ext4_sb_bread_gfp(struct super_block *sb,
 }
 
 struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
-				   int op_flags)
+				   blk_opf_t op_flags)
 {
 	return __ext4_sb_bread_gfp(sb, block, op_flags, __GFP_MOVABLE);
 }
