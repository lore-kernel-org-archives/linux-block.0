Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50273 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424352AbcKANkg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2016 09:40:36 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/16] block,fs: untangle fs.h and blk_types.h
Date: Tue,  1 Nov 2016 07:40:13 -0600
Message-Id: <1478007617-18715-13-git-send-email-hch@lst.de>
In-Reply-To: <1478007617-18715-1-git-send-email-hch@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Nothing in fs.h should require blk_types.h to be included.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/9p/vfs_addr.c          | 1 +
 fs/cifs/connect.c         | 1 +
 fs/cifs/transport.c       | 1 +
 fs/gfs2/dir.c             | 1 +
 fs/isofs/compress.c       | 1 +
 fs/ntfs/logfile.c         | 1 +
 fs/ocfs2/buffer_head_io.c | 1 +
 fs/orangefs/inode.c       | 1 +
 fs/reiserfs/stree.c       | 1 +
 fs/squashfs/block.c       | 1 +
 fs/udf/dir.c              | 1 +
 fs/udf/directory.c        | 1 +
 fs/udf/inode.c            | 1 +
 fs/ufs/balloc.c           | 1 +
 include/linux/fs.h        | 2 +-
 include/linux/swap.h      | 1 +
 include/linux/writeback.h | 2 ++
 lib/iov_iter.c            | 1 +
 18 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 6181ad7..5ca1fb0 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -34,6 +34,7 @@
 #include <linux/idr.h>
 #include <linux/sched.h>
 #include <linux/uio.h>
+#include <linux/bvec.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index aab5227..db726e8 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -41,6 +41,7 @@
 #include <keys/user-type.h>
 #include <net/ipv6.h>
 #include <linux/parser.h>
+#include <linux/bvec.h>
 
 #include "cifspdu.h"
 #include "cifsglob.h"
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 206a597..5f02edc 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -28,6 +28,7 @@
 #include <linux/delay.h>
 #include <linux/freezer.h>
 #include <linux/tcp.h>
+#include <linux/bvec.h>
 #include <linux/highmem.h>
 #include <asm/uaccess.h>
 #include <asm/processor.h>
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 3cdde5f..7911321 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -62,6 +62,7 @@
 #include <linux/gfs2_ondisk.h>
 #include <linux/crc32.h>
 #include <linux/vmalloc.h>
+#include <linux/bio.h>
 
 #include "gfs2.h"
 #include "incore.h"
diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index 44af14b..9bb2fe3 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -18,6 +18,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/bio.h>
 
 #include <linux/vmalloc.h>
 #include <linux/zlib.h>
diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
index 761f12f..353379f 100644
--- a/fs/ntfs/logfile.c
+++ b/fs/ntfs/logfile.c
@@ -27,6 +27,7 @@
 #include <linux/buffer_head.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/bio.h>
 
 #include "attrib.h"
 #include "aops.h"
diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index 8f040f8..d9ebe11 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -26,6 +26,7 @@
 #include <linux/fs.h>
 #include <linux/types.h>
 #include <linux/highmem.h>
+#include <linux/bio.h>
 
 #include <cluster/masklog.h>
 
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index ef3b4eb..551bc74 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -8,6 +8,7 @@
  *  Linux VFS inode operations.
  */
 
+#include <linux/bvec.h>
 #include "protocol.h"
 #include "orangefs-kernel.h"
 #include "orangefs-bufmap.h"
diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index a97e352..0037aea 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -11,6 +11,7 @@
 #include <linux/time.h>
 #include <linux/string.h>
 #include <linux/pagemap.h>
+#include <linux/bio.h>
 #include "reiserfs.h"
 #include <linux/buffer_head.h>
 #include <linux/quotaops.h>
diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index ce62a38..2751476 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -31,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/buffer_head.h>
+#include <linux/bio.h>
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
diff --git a/fs/udf/dir.c b/fs/udf/dir.c
index aaec13c..2d0e028 100644
--- a/fs/udf/dir.c
+++ b/fs/udf/dir.c
@@ -30,6 +30,7 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/bio.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 988d535..7aa48bd 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -16,6 +16,7 @@
 
 #include <linux/fs.h>
 #include <linux/string.h>
+#include <linux/bio.h>
 
 struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
 					 struct udf_fileident_bh *fibh,
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index aad4640..0f3db71 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -38,6 +38,7 @@
 #include <linux/crc-itu-t.h>
 #include <linux/mpage.h>
 #include <linux/uio.h>
+#include <linux/bio.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index 67e085d..b035af5 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -15,6 +15,7 @@
 #include <linux/buffer_head.h>
 #include <linux/capability.h>
 #include <linux/bitops.h>
+#include <linux/bio.h>
 #include <asm/byteorder.h>
 
 #include "ufs_fs.h"
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5b0a9b7..8533e9d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -28,7 +28,6 @@
 #include <linux/uidgid.h>
 #include <linux/lockdep.h>
 #include <linux/percpu-rwsem.h>
-#include <linux/blk_types.h>
 #include <linux/workqueue.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/delayed_call.h>
@@ -38,6 +37,7 @@
 
 struct backing_dev_info;
 struct bdi_writeback;
+struct bio;
 struct export_operations;
 struct hd_geometry;
 struct iovec;
diff --git a/include/linux/swap.h b/include/linux/swap.h
index a56523c..3a6aebc 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/atomic.h>
 #include <linux/page-flags.h>
+#include <linux/blk_types.h>
 #include <asm/page.h>
 
 struct notifier_block;
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 797100e..e4c3870 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -10,6 +10,8 @@
 #include <linux/flex_proportions.h>
 #include <linux/backing-dev-defs.h>
 
+struct bio;
+
 DECLARE_PER_CPU(int, dirty_throttle_leaks);
 
 /*
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f0c7f14..efc953c 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1,4 +1,5 @@
 #include <linux/export.h>
+#include <linux/bvec.h>
 #include <linux/uio.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
-- 
2.1.4

