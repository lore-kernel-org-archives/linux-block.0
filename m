Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B462CCA47B
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbiGNSJc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240581AbiGNSJS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:09:18 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79555222BB
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:01 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id b9so2537862pfp.10
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2gp0UvqLbsoA0Ni6cyG6gP2JZx76ey6eHskW647sBT4=;
        b=ma/MI6oV9ihntp3ifVb4HbsbmsTEOfuZbn4bwIqV8nmszRKQaU7RBhcD6p4Kt/5E2P
         Fjil21nTUaJ048Yj1jNoBytSkA3kPrnAKIJ3aWyBkytuOixQw+6rBgM3J9e82wa2qSzJ
         rx7xWbDUdwKeqm4+nIApz5+YvYlwKfHNTprFMisKyq7L60KxVPm4VHdg5faYXJ+IsKfE
         W14TILTTo5lHB706O2tFcEB40lkaxsZv7jRNTJZFqoPUVcleIU0jTpQMrdacEPCOhfkU
         xrSsw6hQm0HDw/aGMZhF+fV0ePCoKIU40reE+MwJ1ZB6Rq5quGihytVXTyDvEyYrRPog
         344A==
X-Gm-Message-State: AJIora/ttXTyDDibxmfSeg4dorlg8XqjQBxqpEHq+31lfhmozNnhNiqa
        sN0ZPuHxgcSXEJ87nTbWI5s=
X-Google-Smtp-Source: AGRyM1tt7NvJ5xuM2/LMj/7h68pAvPw+rdO8ZfW0J8lyxDhJYJmW+1sTGO/NcNgJB4zb5xWPz/LroQ==
X-Received: by 2002:a05:6a00:26cf:b0:4f6:fc52:7b6a with SMTP id p15-20020a056a0026cf00b004f6fc527b6amr9679286pfw.39.1657822141225;
        Thu, 14 Jul 2022 11:09:01 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:09:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 52/63] fs/f2fs: Use the enum req_op and blk_opf_t types
Date:   Thu, 14 Jul 2022 11:07:18 -0700
Message-Id: <20220714180729.1065367-53-bvanassche@acm.org>
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
variables that represent request flags.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/f2fs/data.c              | 11 ++++++-----
 fs/f2fs/f2fs.h              |  6 +++---
 fs/f2fs/node.c              |  2 +-
 fs/f2fs/segment.c           |  2 +-
 include/trace/events/f2fs.h | 22 +++++++++++-----------
 5 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7fcbcf979737..5c13ee321940 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -387,11 +387,11 @@ int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr)
 	return 0;
 }
 
-static unsigned int f2fs_io_flags(struct f2fs_io_info *fio)
+static blk_opf_t f2fs_io_flags(struct f2fs_io_info *fio)
 {
 	unsigned int temp_mask = (1 << NR_TEMP_TYPE) - 1;
 	unsigned int fua_flag, meta_flag, io_flag;
-	unsigned int op_flags = 0;
+	blk_opf_t op_flags = 0;
 
 	if (fio->op != REQ_OP_WRITE)
 		return 0;
@@ -999,7 +999,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 }
 
 static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
-				      unsigned nr_pages, unsigned op_flag,
+				      unsigned nr_pages, blk_opf_t op_flag,
 				      pgoff_t first_idx, bool for_write)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -1047,7 +1047,8 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 
 /* This can handle encryption stuffs */
 static int f2fs_submit_page_read(struct inode *inode, struct page *page,
-				 block_t blkaddr, int op_flags, bool for_write)
+				 block_t blkaddr, blk_opf_t op_flags,
+				 bool for_write)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct bio *bio;
@@ -1181,7 +1182,7 @@ int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index)
 }
 
 struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
-						int op_flags, bool for_write)
+				     blk_opf_t op_flags, bool for_write)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct dnode_of_data dn;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d9bbecd008d2..868170b72de9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1183,8 +1183,8 @@ struct f2fs_io_info {
 	nid_t ino;		/* inode number */
 	enum page_type type;	/* contains DATA/NODE/META/META_FLUSH */
 	enum temp_type temp;	/* contains HOT/WARM/COLD */
-	int op;			/* contains REQ_OP_ */
-	int op_flags;		/* req_flag_bits */
+	enum req_op op;		/* contains REQ_OP_ */
+	blk_opf_t op_flags;	/* req_flag_bits */
 	block_t new_blkaddr;	/* new block address to be written */
 	block_t old_blkaddr;	/* old block address before Cow */
 	struct page *page;	/* page to be written */
@@ -3741,7 +3741,7 @@ int f2fs_reserve_new_block(struct dnode_of_data *dn);
 int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index);
 int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index);
 struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
-			int op_flags, bool for_write);
+			blk_opf_t op_flags, bool for_write);
 struct page *f2fs_find_data_page(struct inode *inode, pgoff_t index);
 struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
 			bool for_write);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index cf6f7fc83c08..04a145f1dcfc 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1327,7 +1327,7 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
  * 0: f2fs_put_page(page, 0)
  * LOCKED_PAGE or error: f2fs_put_page(page, 1)
  */
-static int read_node_page(struct page *page, int op_flags)
+static int read_node_page(struct page *page, blk_opf_t op_flags)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 	struct node_info ni;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 874c1b9c41a2..c7afc588cf26 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1082,7 +1082,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
 					&(dcc->fstrim_list) : &(dcc->wait_list);
-	int flag = dpolicy->sync ? REQ_SYNC : 0;
+	blk_opf_t flag = dpolicy->sync ? REQ_SYNC : 0;
 	block_t lstart, start, len, total_len;
 	int err = 0;
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 513e889ef8aa..f1e922237736 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -66,7 +66,7 @@ TRACE_DEFINE_ENUM(CP_RESIZE);
 
 #define F2FS_OP_FLAGS (REQ_RAHEAD | REQ_SYNC | REQ_META | REQ_PRIO |	\
 			REQ_PREFLUSH | REQ_FUA)
-#define F2FS_BIO_FLAG_MASK(t)	(t & F2FS_OP_FLAGS)
+#define F2FS_BIO_FLAG_MASK(t) (__force u32)((t) & F2FS_OP_FLAGS)
 
 #define show_bio_type(op,op_flags)	show_bio_op(op),		\
 						show_bio_op_flags(op_flags)
@@ -75,12 +75,12 @@ TRACE_DEFINE_ENUM(CP_RESIZE);
 
 #define show_bio_op_flags(flags)					\
 	__print_flags(F2FS_BIO_FLAG_MASK(flags), "|",			\
-		{ REQ_RAHEAD,		"R" },				\
-		{ REQ_SYNC,		"S" },				\
-		{ REQ_META,		"M" },				\
-		{ REQ_PRIO,		"P" },				\
-		{ REQ_PREFLUSH,		"PF" },				\
-		{ REQ_FUA,		"FUA" })
+		{ (__force u32)REQ_RAHEAD,	"R" },			\
+		{ (__force u32)REQ_SYNC,	"S" },			\
+		{ (__force u32)REQ_META,	"M" },			\
+		{ (__force u32)REQ_PRIO,	"P" },			\
+		{ (__force u32)REQ_PREFLUSH,	"PF" },			\
+		{ (__force u32)REQ_FUA,		"FUA" })
 
 #define show_data_type(type)						\
 	__print_symbolic(type,						\
@@ -1036,8 +1036,8 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 		__field(pgoff_t, index)
 		__field(block_t, old_blkaddr)
 		__field(block_t, new_blkaddr)
-		__field(int, op)
-		__field(int, op_flags)
+		__field(enum req_op, op)
+		__field(blk_opf_t, op_flags)
 		__field(int, temp)
 		__field(int, type)
 	),
@@ -1092,8 +1092,8 @@ DECLARE_EVENT_CLASS(f2fs__bio,
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(dev_t,	target)
-		__field(int,	op)
-		__field(int,	op_flags)
+		__field(enum req_op,	op)
+		__field(blk_opf_t,	op_flags)
 		__field(int,	type)
 		__field(sector_t,	sector)
 		__field(unsigned int,	size)
