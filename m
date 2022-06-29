Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A055C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiF2Xda (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiF2Xd0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:26 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC34F11A1E
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:15 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id h192so16803395pgc.4
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFFvKBDktTZDSpMin/HG+D9bri0jZ3z5lVkZWEnO0xY=;
        b=c5XVxwRxBOftlL8dfgUgXmMg80a3+eLRPzKw81XFL+0SSneK4KTpeRcbn9hWAZy0b3
         IiOLhzEWljK3Zzbrig9gGXZnk6IkjY/uuGjRRmE3l+C4xbdHOYifaSWus0BjkLJg+cB/
         /vDnoLFrws7v7qngDcN+KXakZFJucJLPVT5frqaqDRAlm/GEEtp3HD6BAtWt/1CdQwQg
         X4IrduwHAx+kalIOuAbl8MWJUYqApCD4e/AJLpQOEGyo/yUmBJiCCv/x6Cqd1eb6D0un
         o55/NTCiQqaB5jLWWnZwelbTGSOzHOZL1zGgu0KtTW0OtYfqgFxucLYiMkOz4Zeb72U9
         soug==
X-Gm-Message-State: AJIora+O/E9YRVLdE83B/WI+FEy52VUc8rj3M3sNqdCCEYQ1iN2JqWk6
        Gmv0RJ1JWCwSDKCkr+C8Qms=
X-Google-Smtp-Source: AGRyM1u6GDAwnpE3eL3BB9IWltwMiI6TNmc8q+ger9AijSFcS2LFDfA8gDR4LC3a5AG6MdhmG4EAYQ==
X-Received: by 2002:a62:1a0f:0:b0:527:d84e:100e with SMTP id a15-20020a621a0f000000b00527d84e100emr8691249pfa.4.1656545591397;
        Wed, 29 Jun 2022 16:33:11 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:10 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2 51/63] fs/ext4: Use the new blk_opf_t type
Date:   Wed, 29 Jun 2022 16:31:33 -0700
Message-Id: <20220629233145.2779494-52-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
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
