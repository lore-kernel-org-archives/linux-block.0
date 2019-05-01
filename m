Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ACFC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C5D20866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qb9CmjKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfEAE3Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:29:25 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:27525 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfEAE3Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685043; x=1588221043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WAhIBBFdtnX/wls0/8YUbNzebo2/Z//tDR+nqmLo/eI=;
  b=qb9CmjKEAatp9MCEmD2L0whQK8ZjDKq9nsfZuutDcL7C7ugbMDj5x1Z0
   cplUPUv2+wiBgTLOq+wPtuRydbZUOwyKZmMIeZY/y5j9iyOhCw9Vlmh1n
   uoH8VE6sggjgESx+XaLSa4HmHaE0jfC973UWx/qh5b4qQY34cR4gYe2cI
   tjrv2lC94MOrjnmxN/8TpKMa06bz4ek6ZpF5LteDY+k9j9q1GS3MKFnfr
   EMz5Sp1kuNSuJlSHCB6m7AlOv1KUtlKhZ/MwlIYoBWoi2/jjqlJlvh2GE
   x+TanwMy9eIS9eIF2CQMoQY19fKvk3av/XdZaSvXj5/wYuI0/msLsdiC7
   g==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="206432289"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:30:43 +0800
IronPort-SDR: g6kSqOQ8TQlskyI94aSaGpmba42gz+rFnGoziyzc1lsSXQF1Hnk9IERIYBDCDj2kqFpLHVTdUR
 R9R99NlFvPDtOuN4dVlZcYzMAipojALKWpWoASetARGyDtPEJaePUImvPvvTUwkEEMJq+mk3qY
 REN065qI/695EWWwQ6tSGInohC/4JpCgIU4m2ZFA1Ql5Pomim5gt26W8Xxyw4dYwJY9qAmc4uo
 cxNPFcNYZxKB79PyO1VYuX70A4VWKWZocH0hQ8FRcCyDDh7kWa0kaiT2lrGpit3rq4Oo0riwzT
 l0PeScHCeqoH/tSma0jDZhHt
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:07:53 -0700
IronPort-SDR: 56fC8OFxO5USzI5WPXUqXDJ27ZVIJgMc+i9941b/+cwnlytWndnSHYHcgR/dP/QLxDqH1BptX/
 CFcRghe1/q7mjhhB90biaEmaY6hbfsGDil/AFAjcK1YNTEUo8QDiCAaZU6zrOKFN4XHdcrVa7W
 0cIAYGtWRm+ysijQOW9Q/tA7OGPv1Dfh+ehkcwugUMG85c9/UOB6VlXtjCZCqky4+6B1+qvjw1
 Xqpt6LSIQnR65w3m+Sv122jBzu+DcGFOJ5PisQYm9BMFAsMqXa+0cQDIErKJpi/UEToqUNrWxY
 D7g=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:29:25 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 13/18] drivers: set bio iopriority field
Date:   Tue, 30 Apr 2019 21:28:26 -0700
Message-Id: <20190501042831.5313-14-chaitanya.kulkarni@wdc.com>
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
 drivers/block/drbd/drbd_actlog.c    | 2 ++
 drivers/block/drbd/drbd_bitmap.c    | 3 +++
 drivers/block/xen-blkback/blkback.c | 3 +++
 drivers/block/zram/zram_drv.c       | 2 ++
 drivers/lightnvm/pblk-read.c        | 2 ++
 drivers/lightnvm/pblk-write.c       | 1 +
 drivers/md/bcache/journal.c         | 2 ++
 drivers/md/bcache/super.c           | 2 ++
 drivers/md/dm-bufio.c               | 2 ++
 drivers/md/dm-cache-target.c        | 1 +
 drivers/md/dm-io.c                  | 2 ++
 drivers/md/dm-log-writes.c          | 5 +++++
 drivers/md/dm-thin.c                | 1 +
 drivers/md/dm-writecache.c          | 2 ++
 drivers/md/dm-zoned-metadata.c      | 4 ++++
 drivers/md/md.c                     | 4 ++++
 drivers/md/raid5-cache.c            | 4 ++++
 drivers/md/raid5-ppl.c              | 3 +++
 drivers/nvme/target/io-cmd-bdev.c   | 7 +++++++
 drivers/staging/erofs/internal.h    | 3 +++
 drivers/target/target_core_iblock.c | 3 +++
 21 files changed, 58 insertions(+)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 5f0eaee8c8a7..67235633c172 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -27,6 +27,7 @@
 #include <linux/crc32c.h>
 #include <linux/drbd.h>
 #include <linux/drbd_limits.h>
+#include <linux/ioprio.h>
 #include "drbd_int.h"
 
 
@@ -159,6 +160,7 @@ static int _drbd_md_sync_page_io(struct drbd_device *device,
 	bio->bi_private = device;
 	bio->bi_end_io = drbd_md_endio;
 	bio_set_op_attrs(bio, op, op_flags);
+	bio_set_prio(bio, get_current_ioprio());
 
 	if (op != REQ_OP_WRITE && device->state.disk == D_DISKLESS && device->ldev == NULL)
 		/* special case, drbd_md_read() during drbd_adm_attach(): no get_ldev */
diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 11a85b740327..e7cb027488c7 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -30,6 +30,7 @@
 #include <linux/drbd.h>
 #include <linux/slab.h>
 #include <linux/highmem.h>
+#include <linux/ioprio.h>
 
 #include "drbd_int.h"
 
@@ -1028,6 +1029,8 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
 	bio->bi_private = ctx;
 	bio->bi_end_io = drbd_bm_endio;
 	bio_set_op_attrs(bio, op, 0);
+	bio_set_prio(bio, get_current_ioprio());
+
 
 	if (drbd_insert_fault(device, (op == REQ_OP_WRITE) ? DRBD_FAULT_MD_WR : DRBD_FAULT_MD_RD)) {
 		bio_io_error(bio);
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index fd1e19f1a49f..41294944267d 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -42,6 +42,7 @@
 #include <linux/delay.h>
 #include <linux/freezer.h>
 #include <linux/bitmap.h>
+#include <linux/ioprio.h>
 
 #include <xen/events.h>
 #include <xen/page.h>
@@ -1375,6 +1376,7 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 			bio->bi_end_io  = end_block_io_op;
 			bio->bi_iter.bi_sector  = preq.sector_number;
 			bio_set_op_attrs(bio, operation, operation_flags);
+			bio_set_prio(bio, get_current_ioprio());
 		}
 
 		preq.sector_number += seg[i].nsec;
@@ -1393,6 +1395,7 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 		bio->bi_private = pending_req;
 		bio->bi_end_io  = end_block_io_op;
 		bio_set_op_attrs(bio, operation, operation_flags);
+		bio_set_prio(bio, get_current_ioprio());
 	}
 
 	atomic_set(&pending_req->pendcnt, nbio);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 399cad7daae7..1a4e3b0e98ad 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -33,6 +33,7 @@
 #include <linux/sysfs.h>
 #include <linux/debugfs.h>
 #include <linux/cpuhotplug.h>
+#include <linux/ioprio.h>
 
 #include "zram_drv.h"
 
@@ -596,6 +597,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 
 	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
 	bio_set_dev(bio, zram->bdev);
+	bio_set_prio(bio, get_current_ioprio());
 	if (!bio_add_page(bio, bvec->bv_page, bvec->bv_len, bvec->bv_offset)) {
 		bio_put(bio);
 		return -EIO;
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 0b7d5fb4548d..2b866744545e 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -16,6 +16,7 @@
  * pblk-read.c - pblk's read path
  */
 
+#include <linux/ioprio.h>
 #include "pblk.h"
 
 /*
@@ -336,6 +337,7 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 
 	new_bio->bi_iter.bi_sector = 0; /* internal bio */
 	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
+	bio_set_prio(bio, get_current_ioprio());
 
 	rqd->bio = new_bio;
 	rqd->nr_ppas = nr_holes;
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 6593deab52da..3fdbbff40fde 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -628,6 +628,7 @@ static int pblk_submit_write(struct pblk *pblk, int *secs_left)
 
 	bio->bi_iter.bi_sector = 0; /* internal bio */
 	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+	bio_set_prio(bio, get_current_ioprio());
 
 	rqd = pblk_alloc_rqd(pblk, PBLK_WRITE);
 	rqd->bio = bio;
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index b2fd412715b1..8fda51134919 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -10,6 +10,7 @@
 #include "debug.h"
 #include "extents.h"
 
+#include <linux/ioprio.h>
 #include <trace/events/bcache.h>
 
 /*
@@ -445,6 +446,7 @@ static void journal_discard_work(struct work_struct *work)
 	struct journal_device *ja =
 		container_of(work, struct journal_device, discard_work);
 
+	bio_set_prio(&ja->discard_bio, get_current_ioprio());
 	submit_bio(&ja->discard_bio);
 }
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index a697a3a923cd..336208a8d05e 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -24,6 +24,7 @@
 #include <linux/random.h>
 #include <linux/reboot.h>
 #include <linux/sysfs.h>
+#include <linux/ioprio.h>
 
 unsigned int bch_cutoff_writeback;
 unsigned int bch_cutoff_writeback_sync;
@@ -210,6 +211,7 @@ static void __write_super(struct cache_sb *sb, struct bio *bio)
 	bio->bi_iter.bi_sector	= SB_SECTOR;
 	bio->bi_iter.bi_size	= SB_SIZE;
 	bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_SYNC|REQ_META);
+	bio_set_prio(bio, get_current_ioprio());
 	bch_bio_map(bio, NULL);
 
 	out->offset		= cpu_to_le64(sb->offset);
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 1ecef76225a1..2e9b4fb3b2c9 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/rbtree.h>
 #include <linux/stacktrace.h>
+#include <linux/ioprio.h>
 
 #define DM_MSG_PREFIX "bufio"
 
@@ -591,6 +592,7 @@ static void use_bio(struct dm_buffer *b, int rw, sector_t sector,
 	bio_set_op_attrs(bio, rw, 0);
 	bio->bi_end_io = bio_complete;
 	bio->bi_private = b;
+	bio_set_prio(bio, get_current_ioprio());
 
 	ptr = (char *)b->data + offset;
 	len = n_sectors << SECTOR_SHIFT;
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index d249cf8ac277..d09bd8e2db36 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -938,6 +938,7 @@ static void remap_to_origin_and_cache(struct cache *cache, struct bio *bio,
 	 * all code that might use per_bio_data (since clone doesn't have it)
 	 */
 	__remap_to_origin_clear_discard(cache, origin_bio, oblock, false);
+	bio_set_prio(bio, get_current_ioprio());
 	submit_bio(origin_bio);
 
 	remap_to_cache(cache, bio, cblock);
diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index 81ffc59d05c9..5964be4a4a2a 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -16,6 +16,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/dm-io.h>
+#include <linux/ioprio.h>
 
 #define DM_MSG_PREFIX "io"
 
@@ -350,6 +351,7 @@ static void do_region(int op, int op_flags, unsigned region,
 		bio_set_dev(bio, where->bdev);
 		bio->bi_end_io = endio;
 		bio_set_op_attrs(bio, op, op_flags);
+		bio_set_prio(bio, get_current_ioprio());
 		store_io_and_region_in_bio(bio, io, region);
 
 		if (op == REQ_OP_DISCARD || op == REQ_OP_WRITE_ZEROES) {
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 9ea2b0291f20..d06e70f4dbf6 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -15,6 +15,7 @@
 #include <linux/kthread.h>
 #include <linux/freezer.h>
 #include <linux/uio.h>
+#include <linux/ioprio.h>
 
 #define DM_MSG_PREFIX "log-writes"
 
@@ -218,6 +219,7 @@ static int write_metadata(struct log_writes_c *lc, void *entry,
 	bio->bi_end_io = log_end_io;
 	bio->bi_private = lc;
 	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+	bio_set_prio(bio, get_current_ioprio());
 
 	page = alloc_page(GFP_KERNEL);
 	if (!page) {
@@ -277,6 +279,7 @@ static int write_inline_data(struct log_writes_c *lc, void *entry,
 		bio->bi_end_io = log_end_io;
 		bio->bi_private = lc;
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+		bio_set_prio(bio, get_current_ioprio());
 
 		for (i = 0; i < bio_pages; i++) {
 			pg_datalen = min_t(int, datalen, PAGE_SIZE);
@@ -364,6 +367,7 @@ static int log_one_block(struct log_writes_c *lc,
 	bio->bi_end_io = log_end_io;
 	bio->bi_private = lc;
 	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+	bio_set_prio(bio, get_current_ioprio());
 
 	for (i = 0; i < block->vec_cnt; i++) {
 		/*
@@ -386,6 +390,7 @@ static int log_one_block(struct log_writes_c *lc,
 			bio->bi_end_io = log_end_io;
 			bio->bi_private = lc;
 			bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+			bio_set_prio(bio, get_current_ioprio());
 
 			ret = bio_add_page(bio, block->vecs[i].bv_page,
 					   block->vecs[i].bv_len, 0);
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index fcd887703f95..fab5a7b20ffd 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -1180,6 +1180,7 @@ static void process_prepared_discard_passdown_pt1(struct dm_thin_new_mapping *m)
 	}
 
 	discard_parent = bio_alloc(GFP_NOIO, 1);
+	bio_set_prio(discard_parent, get_current_ioprio());
 	if (!discard_parent) {
 		DMWARN("%s: unable to allocate top level discard bio for passdown. Skipping passdown.",
 		       dm_device_name(tc->pool->pool_md));
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index f7822875589e..bc7fad54cbec 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -15,6 +15,7 @@
 #include <linux/dax.h>
 #include <linux/pfn_t.h>
 #include <linux/libnvdimm.h>
+#include <linux/ioprio.h>
 
 #define DM_MSG_PREFIX "writecache"
 
@@ -1480,6 +1481,7 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
 		wb->wc = wc;
 		wb->bio.bi_end_io = writecache_writeback_endio;
 		bio_set_dev(&wb->bio, wc->dev->bdev);
+		bio_set_prio(bio, get_current_ioprio());
 		wb->bio.bi_iter.bi_sector = read_original_sector(wc, e);
 		wb->page_offset = PAGE_SIZE;
 		if (max_pages <= WB_LIST_INLINE ||
diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index fa68336560c3..a57556e58808 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -7,6 +7,7 @@
 #include "dm-zoned.h"
 
 #include <linux/module.h>
+#include <linux/ioprio.h>
 #include <linux/crc32.h>
 
 #define	DM_MSG_PREFIX		"zoned metadata"
@@ -439,6 +440,7 @@ static struct dmz_mblock *dmz_get_mblock_slow(struct dmz_metadata *zmd,
 	bio->bi_end_io = dmz_mblock_bio_end_io;
 	bio_set_op_attrs(bio, REQ_OP_READ, REQ_META | REQ_PRIO);
 	bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
+	bio_set_prio(bio, get_current_ioprio());
 	submit_bio(bio);
 
 	return mblk;
@@ -589,6 +591,7 @@ static void dmz_write_mblock(struct dmz_metadata *zmd, struct dmz_mblock *mblk,
 	bio->bi_end_io = dmz_mblock_bio_end_io;
 	bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_META | REQ_PRIO);
 	bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
+	bio_set_prio(bio, get_current_ioprio());
 	submit_bio(bio);
 }
 
@@ -609,6 +612,7 @@ static int dmz_rdwr_block(struct dmz_metadata *zmd, int op, sector_t block,
 	bio_set_dev(bio, zmd->dev->bdev);
 	bio_set_op_attrs(bio, op, REQ_SYNC | REQ_META | REQ_PRIO);
 	bio_add_page(bio, page, DMZ_BLOCK_SIZE, 0);
+	bio_set_prio(bio, get_current_ioprio());
 	ret = submit_bio_wait(bio);
 	bio_put(bio);
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 45ffa23fa85d..def94bdc2a48 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -446,6 +446,7 @@ static void submit_flushes(struct work_struct *ws)
 			bi->bi_private = rdev;
 			bio_set_dev(bi, rdev->bdev);
 			bi->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
+			bio_set_prio(bi, get_current_ioprio());
 			atomic_inc(&mddev->flush_pending);
 			submit_bio(bi);
 			rcu_read_lock();
@@ -822,6 +823,8 @@ void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 	    !test_bit(LastDev, &rdev->flags))
 		ff = MD_FAILFAST;
 	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH | REQ_FUA | ff;
+	bio_set_prio(bio, get_current_ioprio());
+
 
 	atomic_inc(&mddev->pending_writes);
 	submit_bio(bio);
@@ -856,6 +859,7 @@ int sync_page_io(struct md_rdev *rdev, sector_t sector, int size,
 	else
 		bio->bi_iter.bi_sector = sector + rdev->data_offset;
 	bio_add_page(bio, page, size, 0);
+	bio_set_prio(bio, get_current_ioprio());
 
 	submit_bio_wait(bio);
 
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index cbbe6b6535be..7efbb910b133 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -656,6 +656,8 @@ static void r5l_do_submit_io(struct r5l_log *log, struct r5l_io_unit *io)
 			io->split_bio->bi_opf |= REQ_PREFLUSH;
 		if (io->has_fua)
 			io->split_bio->bi_opf |= REQ_FUA;
+
+		bio_set_prio(io->split_bio, get_current_ioprio());
 		submit_bio(io->split_bio);
 	}
 
@@ -663,6 +665,7 @@ static void r5l_do_submit_io(struct r5l_log *log, struct r5l_io_unit *io)
 		io->current_bio->bi_opf |= REQ_PREFLUSH;
 	if (io->has_fua)
 		io->current_bio->bi_opf |= REQ_FUA;
+	bio_set_prio(io->current_bio, get_current_ioprio());
 	submit_bio(io->current_bio);
 }
 
@@ -1315,6 +1318,7 @@ void r5l_flush_stripe_to_raid(struct r5l_log *log)
 		return;
 	bio_reset(&log->flush_bio);
 	bio_set_dev(&log->flush_bio, log->rdev->bdev);
+	bio_set_prio(&log->flush_bio, get_current_ioprio());
 	log->flush_bio.bi_end_io = r5l_log_flush_endio;
 	log->flush_bio.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 	submit_bio(&log->flush_bio);
diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index 17e9e7d51097..badfdad742db 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -18,6 +18,7 @@
 #include <linux/crc32c.h>
 #include <linux/async_tx.h>
 #include <linux/raid/md_p.h>
+#include <linux/ioprio.h>
 #include "md.h"
 #include "raid5.h"
 #include "raid5-log.h"
@@ -511,6 +512,7 @@ static void ppl_submit_iounit(struct ppl_io_unit *io)
 			bio_copy_dev(bio, prev);
 			bio->bi_iter.bi_sector = bio_end_sector(prev);
 			bio_add_page(bio, sh->ppl_page, PAGE_SIZE, 0);
+			bio_set_prio(bio, get_current_ioprio());
 
 			bio_chain(bio, prev);
 			ppl_submit_iounit_bio(io, prev);
@@ -647,6 +649,7 @@ static void ppl_do_flush(struct ppl_io_unit *io)
 
 			bio = bio_alloc_bioset(GFP_NOIO, 0, &ppl_conf->flush_bs);
 			bio_set_dev(bio, bdev);
+			bio_set_prio(bio, get_current_ioprio());
 			bio->bi_private = io;
 			bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 			bio->bi_end_io = ppl_flush_endio;
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 3efc52f9c309..c4feb8e12d26 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/blkdev.h>
 #include <linux/module.h>
+#include <linux/ioprio.h>
 #include "nvmet.h"
 
 int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
@@ -142,6 +143,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
 	bio_set_op_attrs(bio, op, op_flags);
+	bio_set_prio(bio, get_current_ioprio());
 
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
@@ -149,9 +151,11 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 			struct bio *prev = bio;
 
 			bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
+			bio_set_prio(bio, get_current_ioprio());
 			bio_set_dev(bio, req->ns->bdev);
 			bio->bi_iter.bi_sector = sector;
 			bio_set_op_attrs(bio, op, op_flags);
+			bio_set_prio(bio, get_current_ioprio());
 
 			bio_chain(bio, prev);
 			submit_bio(prev);
@@ -170,6 +174,7 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 
 	bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
 	bio_set_dev(bio, req->ns->bdev);
+	bio_set_prio(bio, get_current_ioprio());
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
 	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
@@ -226,6 +231,7 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 			bio->bi_status = BLK_STS_IOERR;
 			bio_endio(bio);
 		} else {
+			bio_set_prio(bio, get_current_ioprio());
 			submit_bio(bio);
 		}
 	} else {
@@ -266,6 +272,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	if (bio) {
 		bio->bi_private = req;
 		bio->bi_end_io = nvmet_bio_done;
+		bio_set_prio(bio, get_current_ioprio());
 		submit_bio(bio);
 	} else {
 		nvmet_req_complete(req, errno_to_nvme_status(req, ret));
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index e3bfde00c7d2..6df239a5856b 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -22,6 +22,7 @@
 #include <linux/cleancache.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/ioprio.h>
 #include "erofs_fs.h"
 
 /* redefine pr_fmt "erofs: " */
@@ -482,12 +483,14 @@ erofs_grab_bio(struct super_block *sb,
 	bio->bi_end_io = endio;
 	bio_set_dev(bio, sb->s_bdev);
 	bio->bi_iter.bi_sector = (sector_t)blkaddr << LOG_SECTORS_PER_BLOCK;
+	bio_set_prio(bio, get_current_ioprio());
 	return bio;
 }
 
 static inline void __submit_bio(struct bio *bio, unsigned op, unsigned op_flags)
 {
 	bio_set_op_attrs(bio, op, op_flags);
+	bio_set_prio(bio, get_current_ioprio());
 	submit_bio(bio);
 }
 
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index b5ed9c377060..0db3fb9f339a 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -37,6 +37,7 @@
 #include <linux/module.h>
 #include <scsi/scsi_proto.h>
 #include <asm/unaligned.h>
+#include <linux/ioprio.h>
 
 #include <target/target_core_base.h>
 #include <target/target_core_backend.h>
@@ -341,6 +342,7 @@ iblock_get_bio(struct se_cmd *cmd, sector_t lba, u32 sg_num, int op,
 	bio->bi_end_io = &iblock_bio_done;
 	bio->bi_iter.bi_sector = lba;
 	bio_set_op_attrs(bio, op, op_flags);
+	bio_set_prio(bio, get_current_ioprio());
 
 	return bio;
 }
@@ -395,6 +397,7 @@ iblock_execute_sync_cache(struct se_cmd *cmd)
 	bio->bi_end_io = iblock_end_io_flush;
 	bio_set_dev(bio, ib_dev->ibd_bd);
 	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
+	bio_set_prio(bio, get_current_ioprio());
 	if (!immed)
 		bio->bi_private = cmd;
 	submit_bio(bio);
-- 
2.19.1

