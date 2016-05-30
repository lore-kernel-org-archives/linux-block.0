Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33645 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161230AbcE3NgV (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 30 May 2016 09:36:21 -0400
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Ming Lei <ming.lei@canonical.com>,
	Keith Busch <keith.busch@intel.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Tejun Heo <tj@kernel.org>, Mike Snitzer <snitzer@redhat.com>,
	Jan Kara <jack@suse.cz>, Shaohua Li <shli@fb.com>
Subject: [PATCH v6 2/8] block: move two bvec structure into bvec.h
Date: Mon, 30 May 2016 21:34:30 +0800
Message-Id: <1464615294-9946-3-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch moves 'struct bio_vec' and 'struct bvec_iter'
into 'include/linux/bvec.h', then always include this header
into 'include/linux/blk_types.h'.

With this change, both 'struct bvec_iter' and bvec iterator
helpers don't depend on CONFIG_BLOCK any more, then we can
use bvec iterator to implement iterate_bvec(): lib/iov_iter.c.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 include/linux/bio.h       |  1 -
 include/linux/blk_types.h | 22 +---------------------
 include/linux/bvec.h      | 23 ++++++++++++++++++++++-
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index ed4bfb9..8555b90 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -31,7 +31,6 @@
 
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
 #include <linux/blk_types.h>
-#include <linux/bvec.h>
 
 #define BIO_DEBUG
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 77e5d81..dadc240 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -6,6 +6,7 @@
 #define __LINUX_BLK_TYPES_H
 
 #include <linux/types.h>
+#include <linux/bvec.h>
 
 struct bio_set;
 struct bio;
@@ -17,28 +18,7 @@ struct cgroup_subsys_state;
 typedef void (bio_end_io_t) (struct bio *);
 typedef void (bio_destructor_t) (struct bio *);
 
-/*
- * was unsigned short, but we might as well be ready for > 64kB I/O pages
- */
-struct bio_vec {
-	struct page	*bv_page;
-	unsigned int	bv_len;
-	unsigned int	bv_offset;
-};
-
 #ifdef CONFIG_BLOCK
-
-struct bvec_iter {
-	sector_t		bi_sector;	/* device address in 512 byte
-						   sectors */
-	unsigned int		bi_size;	/* residual I/O count */
-
-	unsigned int		bi_idx;		/* current index into bvl_vec */
-
-	unsigned int            bi_bvec_done;	/* number of bytes completed in
-						   current bvec */
-};
-
 /*
  * main unit of I/O for the block layer and lower layers (ie drivers and
  * stacking drivers)
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 29c459d..096efd2 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -20,7 +20,28 @@
 #ifndef __LINUX_BVEC_ITER_H
 #define __LINUX_BVEC_ITER_H
 
-#include <linux/blk_types.h>
+#include <linux/kernel.h>
+#include <linux/bug.h>
+
+/*
+ * was unsigned short, but we might as well be ready for > 64kB I/O pages
+ */
+struct bio_vec {
+	struct page	*bv_page;
+	unsigned int	bv_len;
+	unsigned int	bv_offset;
+};
+
+struct bvec_iter {
+	sector_t		bi_sector;	/* device address in 512 byte
+						   sectors */
+	unsigned int		bi_size;	/* residual I/O count */
+
+	unsigned int		bi_idx;		/* current index into bvl_vec */
+
+	unsigned int            bi_bvec_done;	/* number of bytes completed in
+						   current bvec */
+};
 
 /*
  * various member access, note that bio_data should of course not be used
-- 
1.9.1

