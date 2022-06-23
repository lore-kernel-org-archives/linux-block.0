Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122BCCCA480
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiFWTBq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiFWTB3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:29 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B340D10EF7F
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:40 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id n10so1495768plp.0
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbqJk9X+e4LnUrGqAiO/XLFGsNwZG2TtaOxZSknhgOA=;
        b=VBO9QqdoDK56NNsxis3U9PzBn6OwCux4NH0IBjdtKHqRzJLnqfDrJELh1VwSgenwIJ
         cL2YeY7KzbiPLDZ1tvDYqO/GKJtI78DSJSH+vOl3/FEjBlNAwIK7Lvgfnjfm8JRnCCaz
         yi3sCMmNnx7q2Dby4CXXtivG57/EHLEb6QvO8dmKxiChbv8Vt4kw7bAr4vERXmAGCLSY
         uwzy4DFv9nqw0YQB8b1FXPS8UhiMBLWR9dL/XZ3p9T9hC4mC7TQnEbwO95acbJ9QQy1H
         w/O+IgRBGT315OkqIFCNLPDuz+tkBPpzP7t9EkBwmJiQvXoEcHgd2tTXtrtFVwKrobl0
         QW9Q==
X-Gm-Message-State: AJIora9gVKxXogELPdF+zYrDFK2XLB1L036tXvHQRwxu3qTijMn5FpBP
        Wqxtkhwo3z+xnc3FKTUeRnw95rSbG64=
X-Google-Smtp-Source: AGRyM1u2og4SLSE7WAzLqkJpJcM2DrKeMM0eK/4cB2guw6I5VUUpodc2NvPL8B1HccMVUpzd/vggHw==
X-Received: by 2002:a17:902:f544:b0:16a:2b62:ef77 with SMTP id h4-20020a170902f54400b0016a2b62ef77mr18995609plf.134.1656007599814;
        Thu, 23 Jun 2022 11:06:39 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 41/51] fs/f2fs: Use the enum req_op and blk_opf_t types
Date:   Thu, 23 Jun 2022 11:05:18 -0700
Message-Id: <20220623180528.3595304-42-bvanassche@acm.org>
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

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/f2fs/data.c              | 11 ++++++-----
 fs/f2fs/f2fs.h              |  6 +++---
 fs/f2fs/node.c              |  2 +-
 fs/f2fs/segment.c           |  2 +-
 include/trace/events/f2fs.h | 28 +++++++++++++++-------------
 5 files changed, 26 insertions(+), 23 deletions(-)

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
index 836c79a20afc..c4f1e895ebd2 100644
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
index 513e889ef8aa..0f51b2e9c3d0 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -66,7 +66,7 @@ TRACE_DEFINE_ENUM(CP_RESIZE);
 
 #define F2FS_OP_FLAGS (REQ_RAHEAD | REQ_SYNC | REQ_META | REQ_PRIO |	\
 			REQ_PREFLUSH | REQ_FUA)
-#define F2FS_BIO_FLAG_MASK(t)	(t & F2FS_OP_FLAGS)
+#define F2FS_BIO_FLAG_MASK(t) ((t) & (__force u32)F2FS_OP_FLAGS)
 
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
@@ -1048,8 +1048,8 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 		__entry->index		= page->index;
 		__entry->old_blkaddr	= fio->old_blkaddr;
 		__entry->new_blkaddr	= fio->new_blkaddr;
-		__entry->op		= fio->op;
-		__entry->op_flags	= fio->op_flags;
+		__entry->op		= (__force int)fio->op;
+		__entry->op_flags	= (__force int)fio->op_flags;
 		__entry->temp		= fio->temp;
 		__entry->type		= fio->type;
 	),
@@ -1060,7 +1060,8 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 		(unsigned long)__entry->index,
 		(unsigned long long)__entry->old_blkaddr,
 		(unsigned long long)__entry->new_blkaddr,
-		show_bio_type(__entry->op, __entry->op_flags),
+		show_bio_type((__force enum req_op)__entry->op,
+			      __entry->op_flags),
 		show_block_temp(__entry->temp),
 		show_block_type(__entry->type))
 );
@@ -1102,8 +1103,8 @@ DECLARE_EVENT_CLASS(f2fs__bio,
 	TP_fast_assign(
 		__entry->dev		= sb->s_dev;
 		__entry->target		= bio_dev(bio);
-		__entry->op		= bio_op(bio);
-		__entry->op_flags	= bio->bi_opf;
+		__entry->op		= (__force int)bio_op(bio);
+		__entry->op_flags	= (__force int)bio->bi_opf;
 		__entry->type		= type;
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->size		= bio->bi_iter.bi_size;
@@ -1112,7 +1113,8 @@ DECLARE_EVENT_CLASS(f2fs__bio,
 	TP_printk("dev = (%d,%d)/(%d,%d), rw = %s(%s), %s, sector = %lld, size = %u",
 		show_dev(__entry->target),
 		show_dev(__entry->dev),
-		show_bio_type(__entry->op, __entry->op_flags),
+		show_bio_type((__force enum req_op)__entry->op,
+			      __entry->op_flags),
 		show_block_type(__entry->type),
 		(unsigned long long)__entry->sector,
 		__entry->size)
