Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ED3C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA9020866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BG4e3SBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfEAE32 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:29:28 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:27525 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEAE32 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685047; x=1588221047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EcKGZsgWLZJw3wBrBVYuLduuVl2jOu7lCXLBJ4Wrl/A=;
  b=BG4e3SBBQVB+s3SVz/Nlh/gi4Ini2cJOXJSrde0o7bCXJqc0Suyro0hV
   Rpni/YkR71bgRUQGvLbY8H+EJOi1C2ssnAj/xAfLtzlWFWCVIM0DD/JKC
   4+peu9yP84RlkZPwu23b032Ul/FQz0g54c+6cKYeNcb5M6PuuUw5ZgKBO
   TBwE/0uUf++AWuStSBXWIOo4GvcJKVLbSBayZvn+WI8C3vEl3UU2s/3NR
   7ZDQ07u2EkNbfs+QP90Q6RTLA/Dq6X5jee6KSGx9sbUn2H7elrbH6EFEx
   2Sh7eFE8Fi+TL5ds7jFv4hXT/dBrB4riDRh8WRy6xcLjHzkwwHEEeEcED
   g==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="206432290"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:30:47 +0800
IronPort-SDR: hxmDLNYFiY3FnAPhzy0KBbchkg2Lf9ztpppyXzMQ6dJD7QfcJOhrW1Xkh0wqlVdjnOMtZRCHF+
 vnQrL1K9CVMyCZ35nVNDUh9P3KAU2KlRug+z9QhIJtU1Uar9XfqSd2JHLcT4oApAn82GsUt63c
 jhZl2k0ISM7leXiqtHpwrvzdlupqkiMKw0eQOMPTjV+yIEaUe1un2Z1T5Ym9pnzUAOlX/rbr4f
 spGiIkRjhLvtxy0cvJ8hq8bvPumH9II4jiAl0I/gDutsPJZNMhUUx/4MO/ahH8okD+LSHFQbq9
 1+uzAtrximU/geH7JgdLrG1s
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:07:56 -0700
IronPort-SDR: PYaY8OwWBgQXoinb6D1myr4ucy4c0SX/SIsu6mPulBYHUpzWBmO7zsGkMY5UZS3qrI9QSt9add
 RgMsyJvrgxWiq01D9uJguOef2kP/NSil32e+PNglvvHXGP+fTKDi6qxahM0I1mz1UBL4OL73uJ
 YyQg2tTR16M4AomLZ0FvMhjjgZSTSw86JtXYuguZilL2HzJQ/3CkagqLlRjORk4Bdtg6nDI+dZ
 PiGyL6L9U7IkkkgznuxSWGqQBOQGEziOX4/P6JxtswC9bHemrueEFeLauuHVBq/dhUEIy9mIUF
 TKY=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:29:28 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 14/18] fs: set bio iopriority field
Date:   Tue, 30 Apr 2019 21:28:27 -0700
Message-Id: <20190501042831.5313-15-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fs/btrfs/disk-io.c               | 2 ++
 fs/btrfs/extent_io.c             | 3 +++
 fs/btrfs/raid56.c                | 6 ++++++
 fs/btrfs/scrub.c                 | 2 ++
 fs/btrfs/volumes.c               | 3 +++
 fs/buffer.c                      | 2 ++
 fs/crypto/bio.c                  | 3 +++
 fs/direct-io.c                   | 2 ++
 fs/ext4/page-io.c                | 2 ++
 fs/ext4/readpage.c               | 1 +
 fs/f2fs/data.c                   | 3 +++
 fs/f2fs/segment.c                | 1 +
 fs/gfs2/lops.c                   | 2 ++
 fs/gfs2/meta_io.c                | 2 ++
 fs/gfs2/ops_fstype.c             | 2 ++
 fs/hfsplus/wrapper.c             | 2 ++
 fs/iomap.c                       | 2 ++
 fs/jfs/jfs_logmgr.c              | 3 +++
 fs/jfs/jfs_metapage.c            | 3 +++
 fs/mpage.c                       | 1 +
 fs/nfs/blocklayout/blocklayout.c | 2 ++
 fs/nilfs2/segbuf.c               | 2 ++
 fs/ocfs2/cluster/heartbeat.c     | 2 ++
 fs/xfs/xfs_aops.c                | 3 +++
 fs/xfs/xfs_buf.c                 | 2 ++
 25 files changed, 58 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6fe9197f6ee4..28e147b78b25 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -19,6 +19,7 @@
 #include <linux/crc32c.h>
 #include <linux/sched/mm.h>
 #include <asm/unaligned.h>
+#include <linux/ioprio.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
@@ -3603,6 +3604,7 @@ static void write_dev_flush(struct btrfs_device *device)
 	bio_reset(bio);
 	bio->bi_end_io = btrfs_end_empty_barrier;
 	bio_set_dev(bio, device->bdev);
+	bio_set_prio(bio, get_current_ioprio());
 	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH;
 	init_completion(&device->flush_wait);
 	bio->bi_private = &device->flush_wait;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ca8b8e785cf3..b0689a8aade0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -13,6 +13,7 @@
 #include <linux/pagevec.h>
 #include <linux/prefetch.h>
 #include <linux/cleancache.h>
+#include <linux/ioprio.h>
 #include "extent_io.h"
 #include "extent_map.h"
 #include "ctree.h"
@@ -160,6 +161,7 @@ static int __must_check submit_one_bio(struct bio *bio, int mirror_num,
 	start = page_offset(bv.bv_page) + bv.bv_offset;
 
 	bio->bi_private = NULL;
+	bio_set_prio(bio, get_current_ioprio());
 
 	if (tree->ops)
 		ret = tree->ops->submit_bio_hook(tree->private_data, bio,
@@ -2043,6 +2045,7 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	bio_set_dev(bio, dev->bdev);
 	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
 	bio_add_page(bio, page, length, pg_offset);
+	bio_set_prio(bio, get_current_ioprio());
 
 	if (btrfsic_submit_bio_wait(bio)) {
 		/* try to remap that extent elsewhere? */
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 67a6f7d47402..77211e45b11c 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -13,6 +13,7 @@
 #include <linux/list_sort.h>
 #include <linux/raid/xor.h>
 #include <linux/mm.h>
+#include <linux/ioprio.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "volumes.h"
@@ -1324,6 +1325,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 		bio->bi_private = rbio;
 		bio->bi_end_io = raid_write_end_io;
 		bio->bi_opf = REQ_OP_WRITE;
+		bio_set_prio(bio, get_current_ioprio());
 
 		submit_bio(bio);
 	}
@@ -1567,6 +1569,7 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 		bio->bi_private = rbio;
 		bio->bi_end_io = raid_rmw_end_io;
 		bio->bi_opf = REQ_OP_READ;
+		bio_set_prio(bio, get_current_ioprio());
 
 		btrfs_bio_wq_end_io(rbio->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
@@ -2114,6 +2117,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 		bio->bi_private = rbio;
 		bio->bi_end_io = raid_recover_end_io;
 		bio->bi_opf = REQ_OP_READ;
+		bio_set_prio(bio, get_current_ioprio());
 
 		btrfs_bio_wq_end_io(rbio->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
@@ -2487,6 +2491,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 		bio->bi_private = rbio;
 		bio->bi_end_io = raid_write_end_io;
 		bio->bi_opf = REQ_OP_WRITE;
+		bio_set_prio(bio, get_current_ioprio());
 
 		submit_bio(bio);
 	}
@@ -2669,6 +2674,7 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 		bio->bi_private = rbio;
 		bio->bi_end_io = raid56_parity_scrub_end_io;
 		bio->bi_opf = REQ_OP_READ;
+		bio_set_prio(bio, get_current_ioprio());
 
 		btrfs_bio_wq_end_io(rbio->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a99588536c79..b0be49a6a87a 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1485,6 +1485,7 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 		WARN_ON(!page->page);
 		bio = btrfs_io_bio_alloc(1);
 		bio_set_dev(bio, page->dev->bdev);
+		bio_set_prio(bio, get_current_ioprio());
 
 		bio_add_page(bio, page->page, PAGE_SIZE, 0);
 		bio->bi_iter.bi_sector = page->physical >> 9;
@@ -2058,6 +2059,7 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 		bio->bi_private = sbio;
 		bio->bi_end_io = scrub_bio_end_io;
 		bio_set_dev(bio, sbio->dev->bdev);
+		bio_set_prio(bio, get_current_ioprio());
 		bio->bi_iter.bi_sector = sbio->physical >> 9;
 		bio->bi_opf = REQ_OP_READ;
 		sbio->status = 0;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index db934ceae9c1..ea95c719aa11 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -14,6 +14,7 @@
 #include <linux/semaphore.h>
 #include <linux/uuid.h>
 #include <linux/list_sort.h>
+#include <linux/ioprio.h>
 #include "ctree.h"
 #include "extent_map.h"
 #include "disk-io.h"
@@ -641,6 +642,7 @@ static noinline void run_scheduled_bios(struct btrfs_device *device)
 			sync_pending = 0;
 		}
 
+		bio_set_prio(cur, get_current_ioprio());
 		btrfsic_submit_bio(cur);
 		num_run++;
 		batch_run++;
@@ -6499,6 +6501,7 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 	struct btrfs_fs_info *fs_info = bbio->fs_info;
 
 	bio->bi_private = bbio;
+	bio_set_prio(bio, get_current_ioprio());
 	btrfs_io_bio(bio)->stripe_index = dev_nr;
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
diff --git a/fs/buffer.c b/fs/buffer.c
index ce357602f471..a172f032b739 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -44,6 +44,7 @@
 #include <linux/mpage.h>
 #include <linux/bit_spinlock.h>
 #include <linux/pagevec.h>
+#include <linux/ioprio.h>
 #include <linux/sched/mm.h>
 #include <trace/events/block.h>
 
@@ -3089,6 +3090,7 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	if (buffer_prio(bh))
 		op_flags |= REQ_PRIO;
 	bio_set_op_attrs(bio, op, op_flags);
+	bio_set_prio(bio, get_current_ioprio());
 
 	if (wbc) {
 		wbc_init_bio(wbc, bio);
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 5759bcd018cd..75b2284e03cb 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/bio.h>
 #include <linux/namei.h>
+#include <linux/ioprio.h>
 #include "fscrypt_private.h"
 
 static void __fscrypt_decrypt_bio(struct bio *bio, bool done)
@@ -139,6 +140,8 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 			err = -EIO;
 			goto errout;
 		}
+
+		bio_set_prio(bio, get_current_ioprio());
 		err = submit_bio_wait(bio);
 		if (err == 0 && bio->bi_status)
 			err = -EIO;
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 9bb015bc4a83..744e5ca35def 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -37,6 +37,7 @@
 #include <linux/uio.h>
 #include <linux/atomic.h>
 #include <linux/prefetch.h>
+#include <linux/ioprio.h>
 
 /*
  * How many user pages to map in one call to get_user_pages().  This determines
@@ -440,6 +441,7 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	bio_set_dev(bio, bdev);
 	bio->bi_iter.bi_sector = first_sector;
 	bio_set_op_attrs(bio, dio->op, dio->op_flags);
+	bio_set_prio(bio, get_current_ioprio());
 	if (dio->is_async)
 		bio->bi_end_io = dio_bio_end_aio;
 	else
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 3e9298e6a705..7c9857c276aa 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/backing-dev.h>
+#include <linux/ioprio.h>
 
 #include "ext4_jbd2.h"
 #include "xattr.h"
@@ -382,6 +383,7 @@ static int io_submit_init_bio(struct ext4_io_submit *io,
 	io->io_bio = bio;
 	io->io_next_block = bh->b_blocknr;
 	wbc_init_bio(io->io_wbc, bio);
+	bio_set_prio(bio, get_current_ioprio());
 	return 0;
 }
 
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 3adadf461825..243ca2a33171 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -261,6 +261,7 @@ int ext4_mpage_readpages(struct address_space *mapping,
 			bio->bi_private = ctx;
 			bio_set_op_attrs(bio, REQ_OP_READ,
 						is_readahead ? REQ_RAHEAD : 0);
+			bio_set_prio(bio, get_current_ioprio());
 		}
 
 		length = first_hole << blkbits;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9727944139f2..c0050a6e0723 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -18,6 +18,7 @@
 #include <linux/uio.h>
 #include <linux/cleancache.h>
 #include <linux/sched/signal.h>
+#include <linux/ioprio.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -276,6 +277,7 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
 	if (wbc)
 		wbc_init_bio(wbc, bio);
 
+	bio_set_prio(bio, get_current_ioprio());
 	return bio;
 }
 
@@ -569,6 +571,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 	f2fs_target_device(sbi, blkaddr, bio);
 	bio->bi_end_io = f2fs_read_end_io;
 	bio_set_op_attrs(bio, REQ_OP_READ, op_flag);
+	bio_set_prio(bio, get_current_ioprio());
 
 	if (f2fs_encrypted_file(inode))
 		post_read_steps |= 1 << STEP_DECRYPT;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index aa7fe79b62b2..d1b67ff8ce66 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -567,6 +567,7 @@ static int __submit_flush_wait(struct f2fs_sb_info *sbi,
 
 	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH;
 	bio_set_dev(bio, bdev);
+	bio_set_prio(bio, get_current_ioprio());
 	ret = submit_bio_wait(bio);
 	bio_put(bio);
 
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 8722c60b11fe..fd9752209be6 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -17,6 +17,7 @@
 #include <linux/bio.h>
 #include <linux/fs.h>
 #include <linux/list_sort.h>
+#include <linux/ioprio.h>
 
 #include "dir.h"
 #include "gfs2.h"
@@ -272,6 +273,7 @@ static struct bio *gfs2_log_alloc_bio(struct gfs2_sbd *sdp, u64 blkno,
 	bio_set_dev(bio, sb->s_bdev);
 	bio->bi_end_io = end_io;
 	bio->bi_private = sdp;
+	bio_set_prio(bio, get_current_ioprio());
 
 	return bio;
 }
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 3201342404a7..9502b808c78c 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/bio.h>
 #include <linux/gfs2_ondisk.h>
+#include <linux/ioprio.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -234,6 +235,7 @@ static void gfs2_submit_bhs(int op, int op_flags, struct buffer_head *bhs[],
 		}
 		bio->bi_end_io = gfs2_meta_read_endio;
 		bio_set_op_attrs(bio, op, op_flags);
+		bio_set_prio(bio, get_current_ioprio());
 		submit_bio(bio);
 	}
 }
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index b041cb8ae383..a7aa38456f31 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -24,6 +24,7 @@
 #include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/backing-dev.h>
+#include <linux/ioprio.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -248,6 +249,7 @@ static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int silent)
 	bio->bi_end_io = end_bio_io_page;
 	bio->bi_private = page;
 	bio_set_op_attrs(bio, REQ_OP_READ, REQ_META);
+	bio_set_prio(bio, get_current_ioprio());
 	submit_bio(bio);
 	wait_on_page_locked(page);
 	bio_put(bio);
diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 08c1580bdf7a..b04eae16cf53 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -14,6 +14,7 @@
 #include <linux/cdrom.h>
 #include <linux/genhd.h>
 #include <asm/unaligned.h>
+#include <linux/ioprio.h>
 
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
@@ -68,6 +69,7 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector,
 	bio->bi_iter.bi_sector = sector;
 	bio_set_dev(bio, sb->s_bdev);
 	bio_set_op_attrs(bio, op, op_flags);
+	bio_set_prio(bio, get_current_ioprio());
 
 	if (op != WRITE && data)
 		*data = (u8 *)buf + offset;
diff --git a/fs/iomap.c b/fs/iomap.c
index abdd18e404f8..47ca9a4fe427 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -30,6 +30,7 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/dax.h>
 #include <linux/sched/signal.h>
+#include <linux/ioprio.h>
 
 #include "internal.h"
 
@@ -1618,6 +1619,7 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 	get_page(page);
 	__bio_add_page(bio, page, len, 0);
 	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
+	bio_set_prio(bio, get_current_ioprio());
 	iomap_dio_submit_bio(dio, iomap, bio);
 }
 
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 6b68df395892..2311868160a2 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -72,6 +72,7 @@
 #include <linux/mutex.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/ioprio.h>
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
 #include "jfs_metapage.h"
@@ -1996,6 +1997,7 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
 	bio_set_dev(bio, log->bdev);
+	bio_set_prio(bio, get_current_ioprio());
 
 	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
@@ -2140,6 +2142,7 @@ static void lbmStartIO(struct lbuf * bp)
 	bio = bio_alloc(GFP_NOFS, 1);
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
 	bio_set_dev(bio, log->bdev);
+	bio_set_prio(bio, get_current_ioprio());
 
 	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index fa2c6824c7f2..021841273a25 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -26,6 +26,7 @@
 #include <linux/buffer_head.h>
 #include <linux/mempool.h>
 #include <linux/seq_file.h>
+#include <linux/ioprio.h>
 #include "jfs_incore.h"
 #include "jfs_superblock.h"
 #include "jfs_filsys.h"
@@ -435,6 +436,7 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 		bio->bi_end_io = metapage_write_end_io;
 		bio->bi_private = page;
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+		bio_set_prio(bio, get_current_ioprio());
 
 		/* Don't call bio_add_page yet, we may add to this vec */
 		bio_offset = offset;
@@ -516,6 +518,7 @@ static int metapage_readpage(struct file *fp, struct page *page)
 			bio->bi_end_io = metapage_read_end_io;
 			bio->bi_private = page;
 			bio_set_op_attrs(bio, REQ_OP_READ, 0);
+			bio_set_prio(bio, get_current_ioprio());
 			len = xlen << inode->i_blkbits;
 			offset = block_offset << inode->i_blkbits;
 			if (bio_add_page(bio, page, len, offset) < len)
diff --git a/fs/mpage.c b/fs/mpage.c
index 3f19da75178b..766be568395a 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -87,6 +87,7 @@ mpage_alloc(struct block_device *bdev,
 	if (bio) {
 		bio_set_dev(bio, bdev);
 		bio->bi_iter.bi_sector = first_sector;
+		bio_set_prio(bio, get_current_ioprio());
 	}
 	return bio;
 }
diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 690221747b47..ccec9bfad963 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -37,6 +37,7 @@
 #include <linux/bio.h>		/* struct bio */
 #include <linux/prefetch.h>
 #include <linux/pagevec.h>
+#include <linux/ioprio.h>
 
 #include "../pnfs.h"
 #include "../nfs4session.h"
@@ -133,6 +134,7 @@ bl_alloc_init_bio(int npg, struct block_device *bdev, sector_t disk_sector,
 		bio_set_dev(bio, bdev);
 		bio->bi_end_io = end_io;
 		bio->bi_private = par;
+		bio_set_prio(bio, get_current_ioprio());
 	}
 	return bio;
 }
diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 20c479b5e41b..8632bbb1c620 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -13,6 +13,7 @@
 #include <linux/crc32.h>
 #include <linux/backing-dev.h>
 #include <linux/slab.h>
+#include <linux/ioprio.h>
 #include "page.h"
 #include "segbuf.h"
 
@@ -394,6 +395,7 @@ static struct bio *nilfs_alloc_seg_bio(struct the_nilfs *nilfs, sector_t start,
 		bio_set_dev(bio, nilfs->ns_bdev);
 		bio->bi_iter.bi_sector =
 			start << (nilfs->ns_blocksize_bits - 9);
+		bio_set_prio(bio, get_current_ioprio());
 	}
 	return bio;
 }
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index f3c20b279eb2..38b6a8799613 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -37,6 +37,7 @@
 #include <linux/slab.h>
 #include <linux/bitmap.h>
 #include <linux/ktime.h>
+#include <linux/ioprio.h>
 #include "heartbeat.h"
 #include "tcp.h"
 #include "nodemanager.h"
@@ -557,6 +558,7 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 	bio->bi_private = wc;
 	bio->bi_end_io = o2hb_bio_end_io;
 	bio_set_op_attrs(bio, op, op_flags);
+	bio_set_prio(bio, get_current_ioprio());
 
 	vec_start = (cs << bits) % PAGE_SIZE;
 	while(cs < max_slots) {
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 3619e9e8d359..30a27c386ff0 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -22,6 +22,7 @@
 #include "xfs_bmap_btree.h"
 #include "xfs_reflink.h"
 #include <linux/writeback.h>
+#include <linux/ioprio.h>
 
 /*
  * structure owned by writepages passed to individual writepage calls
@@ -597,6 +598,7 @@ xfs_alloc_ioend(
 	INIT_WORK(&ioend->io_work, xfs_end_io);
 	ioend->io_append_trans = NULL;
 	ioend->io_bio = bio;
+	bio_set_prio(bio, get_current_ioprio());
 	return ioend;
 }
 
@@ -620,6 +622,7 @@ xfs_chain_bio(
 	bio_set_dev(new, bdev);
 	new->bi_iter.bi_sector = sector;
 	bio_chain(ioend->io_bio, new);
+	bio_set_prio(new, get_current_ioprio());
 	bio_get(ioend->io_bio);		/* for xfs_destroy_ioend */
 	ioend->io_bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
 	ioend->io_bio->bi_write_hint = ioend->io_inode->i_write_hint;
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 548344e25128..2a91b4414e84 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -21,6 +21,7 @@
 #include <linux/migrate.h>
 #include <linux/backing-dev.h>
 #include <linux/freezer.h>
+#include <linux/ioprio.h>
 
 #include "xfs_format.h"
 #include "xfs_log_format.h"
@@ -1381,6 +1382,7 @@ xfs_buf_ioapply_map(
 	bio->bi_end_io = xfs_buf_bio_end_io;
 	bio->bi_private = bp;
 	bio_set_op_attrs(bio, op, op_flags);
+	bio_set_prio(bio, get_current_ioprio());
 
 	for (; size && nr_pages; nr_pages--, page_index++) {
 		int	rbytes, nbytes = PAGE_SIZE - offset;
-- 
2.19.1

