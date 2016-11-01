Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/16] mm: only include blk_types in swap.h if CONFIG_SWAP is enabled
Date: Tue,  1 Nov 2016 07:40:16 -0600
Message-Id: <1478007617-18715-16-git-send-email-hch@lst.de>
In-Reply-To: <1478007617-18715-1-git-send-email-hch@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

It's only needed for the CONFIG_SWAP-only use of bio_end_io_t.

Because CONFIG_SWAP implies CONFIG_BLOCK this will allow to drop some
ifdefs in blk_types.h.

Instead we'll need to add a few explicit includes that were implicit
before, though.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/staging/lustre/include/linux/lnet/types.h | 1 +
 drivers/staging/lustre/lustre/llite/rw.c          | 1 +
 fs/ntfs/aops.c                                    | 1 +
 fs/ntfs/mft.c                                     | 1 +
 fs/reiserfs/inode.c                               | 1 +
 fs/splice.c                                       | 1 +
 include/linux/swap.h                              | 4 +++-
 7 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/include/linux/lnet/types.h b/drivers/staging/lustre/include/linux/lnet/types.h
index f8be0e2..8ca1e9d 100644
--- a/drivers/staging/lustre/include/linux/lnet/types.h
+++ b/drivers/staging/lustre/include/linux/lnet/types.h
@@ -34,6 +34,7 @@
 #define __LNET_TYPES_H__
 
 #include <linux/types.h>
+#include <linux/bvec.h>
 
 /** \addtogroup lnet
  * @{
diff --git a/drivers/staging/lustre/lustre/llite/rw.c b/drivers/staging/lustre/lustre/llite/rw.c
index 50c0152..76a6836 100644
--- a/drivers/staging/lustre/lustre/llite/rw.c
+++ b/drivers/staging/lustre/lustre/llite/rw.c
@@ -47,6 +47,7 @@
 #include <linux/pagemap.h>
 /* current_is_kswapd() */
 #include <linux/swap.h>
+#include <linux/bvec.h>
 
 #define DEBUG_SUBSYSTEM S_LLITE
 
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index fe251f1..d0cf6fe 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -29,6 +29,7 @@
 #include <linux/buffer_head.h>
 #include <linux/writeback.h>
 #include <linux/bit_spinlock.h>
+#include <linux/bio.h>
 
 #include "aops.h"
 #include "attrib.h"
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index d3c0096..b6f4021 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -23,6 +23,7 @@
 #include <linux/buffer_head.h>
 #include <linux/slab.h>
 #include <linux/swap.h>
+#include <linux/bio.h>
 
 #include "attrib.h"
 #include "aops.h"
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 58b2ded..cfeae9b 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -19,6 +19,7 @@
 #include <linux/quotaops.h>
 #include <linux/swap.h>
 #include <linux/uio.h>
+#include <linux/bio.h>
 
 int reiserfs_commit_write(struct file *f, struct page *page,
 			  unsigned from, unsigned to);
diff --git a/fs/splice.c b/fs/splice.c
index 153d4f3..51492f2 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -17,6 +17,7 @@
  * Copyright (C) 2006 Ingo Molnar <mingo@elte.hu>
  *
  */
+#include <linux/bvec.h>
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/pagemap.h>
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 3a6aebc..bfee1af 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -11,7 +11,6 @@
 #include <linux/fs.h>
 #include <linux/atomic.h>
 #include <linux/page-flags.h>
-#include <linux/blk_types.h>
 #include <asm/page.h>
 
 struct notifier_block;
@@ -352,6 +351,9 @@ extern int kswapd_run(int nid);
 extern void kswapd_stop(int nid);
 
 #ifdef CONFIG_SWAP
+
+#include <linux/blk_types.h> /* for bio_end_io_t */
+
 /* linux/mm/page_io.c */
 extern int swap_readpage(struct page *);
 extern int swap_writepage(struct page *page, struct writeback_control *wbc);
-- 
2.1.4

