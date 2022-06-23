Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B902CCA47C
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiFWTBp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiFWTBW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:22 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31AA65E4
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:39 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id u37so326585pfg.3
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQoCVR8sjxT2PQsdyc9RrxPkFcahnRoIG+jmu+pHHW4=;
        b=FHbOFikoIIn1r+SnMSGHWl0OGfzQa5xKJEePYa2xJWaUDsCayj+745pHWE1hneAuLs
         AnL8BBPJIHN1km6VPSInvj4qAUhyGwqImy9jZbS1qi5+X+Dcc/aTaGFmG6ZHLz3D33LJ
         5VArP4XdsD9goNqmYH/uYR3MGOviFLgfX+6QNrAKW+FVPdtIPZjjf9SCImLs7h43KBWa
         NSIe9GPMvPuqkLFCDinXSUfTN5Bon6Ik8Yut+yF/4blrBEmYOxdI+Y971BqB2XBxSK3n
         WFw+571EIsdq+sR3i8fZ58Ep63wOgGue47SUZEZMbqBUSl3A/kUqghzLNEZphOA/+js6
         Stzw==
X-Gm-Message-State: AJIora+J+5K9f9d83CoJ0e2vauOuUukueO1aqvcJI/sdaNEARtxBnr73
        s3Nlojej8jxXHeDnAYDCbsthtxJRKik=
X-Google-Smtp-Source: AGRyM1sRk9DQBPJ7KtsEpXs1H+Q/ajrP+eHEvfHhhkpJP1XIx7f50C6WeORzvu8973cLZMZz30lojg==
X-Received: by 2002:a65:6e9b:0:b0:3fc:587a:6dcd with SMTP id bm27-20020a656e9b000000b003fc587a6dcdmr8564580pgb.200.1656007598547;
        Thu, 23 Jun 2022 11:06:38 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:37 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 40/51] fs/ext4: Use the new blk_opf_t type
Date:   Thu, 23 Jun 2022 11:05:17 -0700
Message-Id: <20220623180528.3595304-41-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for
variables that represent request flags.

Cc: Theodore Ts'o <tytso@mit.edu>
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
index 795a60ad1897..de6c73d0f431 100644
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
index 845f2f8aee5f..1d7f65088ddc 100644
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
 	submit_bh(REQ_OP_READ, op_flags, bh);
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
