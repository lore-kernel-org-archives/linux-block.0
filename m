Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8FEC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiGNSLK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240555AbiGNSJI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:09:08 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58C91D0F9
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:51 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id l12so1121039plk.13
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3OV8Eu56dnqXGT8WBEY+VdBbf6XZ1sEmnfl/AJHfs8=;
        b=B8Ei5+9XHfPOdfqSMNXWQmZskHuC/mjDgcLwLFNNJ7epG9l46aMcUH1OwH+3rruQIR
         AL8aC0uxJ0TwYw8dqGtGkoiZSU2kulpVTRcttckfbopFv+4kYTuAc6u81ZYGj8C9LDGo
         Nhqky2qkI6io0gsxNvGXU3zkP8Gm9XhKtQwnx38ZU4U0RbbfApyRY0x3Xx6hiHBbCvDO
         X6zetesNgHPT8kuIdVm2THpHUlAemRoCF547ldw+HYT6AapukvQ6UmJzPCO6VHtBu5m3
         Fv9g+bVdQb9HnwofoASic3Umd+wak2Obt3Y9+aCNlNd/xkWSZjniBJ0uD+nApAAfchv/
         vaZQ==
X-Gm-Message-State: AJIora+dbq8GSN31GWfeyiQUjjhr+VBvcB1x3Ub+O9dh2Nc7z/mtBZzG
        wO+9nzX67hFT5FF/mJtymK4=
X-Google-Smtp-Source: AGRyM1tWDQr8gW9Cdpw2RzWNZUvxJWQH9ziS7K0XOsvA1cJZPfGIaoYHIDsHwUctjiv9BFQpZ8o9lw==
X-Received: by 2002:a17:903:3093:b0:16b:deea:4d36 with SMTP id u19-20020a170903309300b0016bdeea4d36mr9413725plc.126.1657822131082;
        Thu, 14 Jul 2022 11:08:51 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:50 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 46/63] fs/buffer: Use the new blk_opf_t type
Date:   Thu, 14 Jul 2022 11:07:12 -0700
Message-Id: <20220714180729.1065367-47-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for block layer
request flags. Change WRITE into REQ_OP_WRITE. This patch does not change
any functionality since REQ_OP_WRITE == WRITE == 1.

Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/buffer.c                 | 21 +++++++++++----------
 include/linux/buffer_head.h |  9 +++++----
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 898c7f301b1b..4a00b61f35ec 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -52,8 +52,8 @@
 #include "internal.h"
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
-static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
-			 struct writeback_control *wbc);
+static int submit_bh_wbc(enum req_op op, blk_opf_t op_flags,
+			 struct buffer_head *bh, struct writeback_control *wbc);
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
 
@@ -1716,7 +1716,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	struct buffer_head *bh, *head;
 	unsigned int blocksize, bbits;
 	int nr_underway = 0;
-	int write_flags = wbc_to_write_flags(wbc);
+	blk_opf_t write_flags = wbc_to_write_flags(wbc);
 
 	head = create_page_buffers(page, inode,
 					(1 << BH_Dirty)|(1 << BH_Uptodate));
@@ -2994,8 +2994,8 @@ static void end_bio_bh_io_sync(struct bio *bio)
 	bio_put(bio);
 }
 
-static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
-			 struct writeback_control *wbc)
+static int submit_bh_wbc(enum req_op op, blk_opf_t op_flags,
+			 struct buffer_head *bh, struct writeback_control *wbc)
 {
 	struct bio *bio;
 
@@ -3040,7 +3040,7 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	return 0;
 }
 
-int submit_bh(int op, int op_flags, struct buffer_head *bh)
+int submit_bh(enum req_op op, blk_opf_t op_flags, struct buffer_head *bh)
 {
 	return submit_bh_wbc(op, op_flags, bh, NULL);
 }
@@ -3072,7 +3072,8 @@ EXPORT_SYMBOL(submit_bh);
  * All of the buffers must be for the same device, and must also be a
  * multiple of the current approved size for the device.
  */
-void ll_rw_block(int op, int op_flags,  int nr, struct buffer_head *bhs[])
+void ll_rw_block(enum req_op op, blk_opf_t op_flags, int nr,
+		 struct buffer_head *bhs[])
 {
 	int i;
 
@@ -3081,7 +3082,7 @@ void ll_rw_block(int op, int op_flags,  int nr, struct buffer_head *bhs[])
 
 		if (!trylock_buffer(bh))
 			continue;
-		if (op == WRITE) {
+		if (op == REQ_OP_WRITE) {
 			if (test_clear_buffer_dirty(bh)) {
 				bh->b_end_io = end_buffer_write_sync;
 				get_bh(bh);
@@ -3101,7 +3102,7 @@ void ll_rw_block(int op, int op_flags,  int nr, struct buffer_head *bhs[])
 }
 EXPORT_SYMBOL(ll_rw_block);
 
-void write_dirty_buffer(struct buffer_head *bh, int op_flags)
+void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
 {
 	lock_buffer(bh);
 	if (!test_clear_buffer_dirty(bh)) {
@@ -3119,7 +3120,7 @@ EXPORT_SYMBOL(write_dirty_buffer);
  * and then start new I/O and then wait upon it.  The caller must have a ref on
  * the buffer_head.
  */
-int __sync_dirty_buffer(struct buffer_head *bh, int op_flags)
+int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
 {
 	int ret = 0;
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index c9d1463bb20f..9795df9400bd 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -9,6 +9,7 @@
 #define _LINUX_BUFFER_HEAD_H
 
 #include <linux/types.h>
+#include <linux/blk_types.h>
 #include <linux/fs.h>
 #include <linux/linkage.h>
 #include <linux/pagemap.h>
@@ -201,11 +202,11 @@ struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
 void unlock_buffer(struct buffer_head *bh);
 void __lock_buffer(struct buffer_head *bh);
-void ll_rw_block(int, int, int, struct buffer_head * bh[]);
+void ll_rw_block(enum req_op, blk_opf_t, int, struct buffer_head * bh[]);
 int sync_dirty_buffer(struct buffer_head *bh);
-int __sync_dirty_buffer(struct buffer_head *bh, int op_flags);
-void write_dirty_buffer(struct buffer_head *bh, int op_flags);
-int submit_bh(int, int, struct buffer_head *);
+int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
+void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
+int submit_bh(enum req_op, blk_opf_t, struct buffer_head *);
 void write_boundary_block(struct block_device *bdev,
 			sector_t bblock, unsigned blocksize);
 int bh_uptodate_or_lock(struct buffer_head *bh);
