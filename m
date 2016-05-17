Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33267 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbcEQVxz (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 17 May 2016 17:53:55 -0400
Received: by mail-lf0-f68.google.com with SMTP id j8so2043651lfd.0
        for <linux-block@vger.kernel.org>; Tue, 17 May 2016 14:53:54 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 17 May 2016 15:53:53 -0600
Message-ID: <CADm5WxNoroL1h09sxksym_imvQCxLNZ1zmTjH-RhOgGQYSyf5A@mail.gmail.com>
Subject: [PATCH v2 3/4] block: Add and use a rw_stat_group function for
 indexing partition stat fields.
From: Michael Callahan <coder.callahan@gmail.com>
To: linux-block@vger.kernel.org
Cc: Michael Callahan <michaelcallahan@fb.com>,
	Jens Axboe <axboe@fb.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add and use a new rw_stat_group function for indexing partition stat
fields rather than indexing them by rq_data_dir or bio_data_dir.  This
function works similarly to rw_is_sync in that it takes the
request::cmd_flags or bio::bi_rw flags and determines which stats should
et updated.

In addition the first parameter to generic_start_io_acct and
generic_end_io_acct is now a stat group rather than simply a read or
write bit.  STAT_READ and STAT_WRITE have been defined such that this
is backwards compatible but callers who want to track new stats should
be updated to pass the extended parameter.  This has been done by this
patch for all current consumers of these two functions.

Note that the partition in_flight counts are not part of the per-cpu
statistics and as such are not indexed via this function.  An additional
stat_group_to_rw helper macro has been added to more cleanly handle that
case.

Signed-off-by: Michael Callahan <michaelcallahan@fb.com>
---
diff --git a/block/bio.c b/block/bio.c
index 807d25e..79db488 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1678,27 +1678,31 @@ void bio_check_pages_dirty(struct bio *bio)
        }
 }

-void generic_start_io_acct(int rw, unsigned long sectors,
+void generic_start_io_acct(int rw_flags, unsigned long sectors,
                           struct hd_struct *part)
 {
+       const int sgrp = rw_stat_group(rw_flags);
+       const int rw = (rw_flags & REQ_WRITE) != 0;
        int cpu = part_stat_lock();

        part_round_stats(cpu, part);
-       part_stat_inc(cpu, part, ios[rw]);
-       part_stat_add(cpu, part, sectors[rw], sectors);
+       part_stat_inc(cpu, part, ios[sgrp]);
+       part_stat_add(cpu, part, sectors[sgrp], sectors);
        part_inc_in_flight(part, rw);

        part_stat_unlock();
 }
 EXPORT_SYMBOL(generic_start_io_acct);

-void generic_end_io_acct(int rw, struct hd_struct *part,
+void generic_end_io_acct(int rw_flags, struct hd_struct *part,
                         unsigned long start_time)
 {
        unsigned long duration = jiffies - start_time;
+       const int sgrp = rw_stat_group(rw_flags);
+       const int rw = (rw_flags & REQ_WRITE) != 0;
        int cpu = part_stat_lock();

-       part_stat_add(cpu, part, ticks[rw], duration);
+       part_stat_add(cpu, part, ticks[sgrp], duration);
        part_round_stats(cpu, part);
        part_dec_in_flight(part, rw);

diff --git a/block/blk-core.c b/block/blk-core.c
index b60537b..1459e9c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2273,13 +2273,13 @@ EXPORT_SYMBOL_GPL(blk_rq_err_bytes);
 void blk_account_io_completion(struct request *req, unsigned int bytes)
 {
        if (blk_do_io_stat(req)) {
-               const int rw = rq_data_dir(req);
+               const int sgrp = rw_stat_group(req->cmd_flags);
                struct hd_struct *part;
                int cpu;

                cpu = part_stat_lock();
                part = req->part;
-               part_stat_add(cpu, part, sectors[rw], bytes >> 9);
+               part_stat_add(cpu, part, sectors[sgrp], bytes >> 9);
                part_stat_unlock();
        }
 }
@@ -2293,6 +2293,7 @@ void blk_account_io_done(struct request *req)
         */
        if (blk_do_io_stat(req) && !(req->cmd_flags & REQ_FLUSH_SEQ)) {
                unsigned long duration = jiffies - req->start_time;
+               const int sgrp = rw_stat_group(req->cmd_flags);
                const int rw = rq_data_dir(req);
                struct hd_struct *part;
                int cpu;
@@ -2300,8 +2301,8 @@ void blk_account_io_done(struct request *req)
                cpu = part_stat_lock();
                part = req->part;

-               part_stat_inc(cpu, part, ios[rw]);
-               part_stat_add(cpu, part, ticks[rw], duration);
+               part_stat_inc(cpu, part, ios[sgrp]);
+               part_stat_add(cpu, part, ticks[sgrp], duration);
                part_round_stats(cpu, part);
                part_dec_in_flight(part, rw);

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 2255dcf..6f31f67 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -36,14 +36,14 @@ static bool drbd_may_do_local_read(struct
drbd_device *device, sector_t sector,
 /* Update disk stats at start of I/O request */
 static void _drbd_start_io_acct(struct drbd_device *device, struct
drbd_request *req)
 {
-       generic_start_io_acct(bio_data_dir(req->master_bio), req->i.size >> 9,
+       generic_start_io_acct(req->master_bio->bi_rw, req->i.size >> 9,
                              &device->vdisk->part0);
 }

 /* Update disk stats when completing request upwards */
 static void _drbd_end_io_acct(struct drbd_device *device, struct
drbd_request *req)
 {
-       generic_end_io_acct(bio_data_dir(req->master_bio),
+       generic_end_io_acct(req->master_bio->bi_rw,
                            &device->vdisk->part0, req->start_jif);
 }

diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index e1b8b70..17ab33f 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -112,7 +112,7 @@ static const struct block_device_operations rsxx_fops = {

 static void disk_stats_start(struct rsxx_cardinfo *card, struct bio *bio)
 {
-       generic_start_io_acct(bio_data_dir(bio), bio_sectors(bio),
+       generic_start_io_acct(bio->bi_rw, bio_sectors(bio),
                             &card->gendisk->part0);
 }

@@ -120,8 +120,7 @@ static void disk_stats_complete(struct rsxx_cardinfo *card,
                                struct bio *bio,
                                unsigned long start_time)
 {
-       generic_end_io_acct(bio_data_dir(bio), &card->gendisk->part0,
-                          start_time);
+       generic_end_io_acct(bio->bi_rw, &card->gendisk->part0, start_time);
 }

 static void bio_dma_done_cb(struct rsxx_cardinfo *card,
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 370c2f7..31811a0 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -810,12 +810,12 @@ static void zram_bio_discard(struct zram *zram, u32 index,
 }

 static int zram_bvec_rw(struct zram *zram, struct bio_vec *bvec, u32 index,
-                       int offset, int rw)
+                       int offset, int rw, int rw_flags)
 {
        unsigned long start_time = jiffies;
        int ret;

-       generic_start_io_acct(rw, bvec->bv_len >> SECTOR_SHIFT,
+       generic_start_io_acct(rw_flags, bvec->bv_len >> SECTOR_SHIFT,
                        &zram->disk->part0);

        if (rw == READ) {
@@ -826,7 +826,7 @@ static int zram_bvec_rw(struct zram *zram, struct
bio_vec *bvec, u32 index,
                ret = zram_bvec_write(zram, bvec, index, offset);
        }

-       generic_end_io_acct(rw, &zram->disk->part0, start_time);
+       generic_end_io_acct(rw_flags, &zram->disk->part0, start_time);

        if (unlikely(ret)) {
                if (rw == READ)
@@ -870,15 +870,15 @@ static void __zram_make_request(struct zram
*zram, struct bio *bio)
                        bv.bv_len = max_transfer_size;
                        bv.bv_offset = bvec.bv_offset;

-                       if (zram_bvec_rw(zram, &bv, index, offset, rw) < 0)
+                       if (zram_bvec_rw(zram, &bv, index, offset, rw,
bio->bi_rw) < 0)
                                goto out;

                        bv.bv_len = bvec.bv_len - max_transfer_size;
                        bv.bv_offset += max_transfer_size;
-                       if (zram_bvec_rw(zram, &bv, index + 1, 0, rw) < 0)
+                       if (zram_bvec_rw(zram, &bv, index + 1, 0, rw,
bio->bi_rw) < 0)
                                goto out;
                } else
-                       if (zram_bvec_rw(zram, &bvec, index, offset, rw) < 0)
+                       if (zram_bvec_rw(zram, &bvec, index, offset,
rw, bio->bi_rw) < 0)
                                goto out;

                update_position(&index, &offset, &bvec);
@@ -959,7 +959,7 @@ static int zram_rw_page(struct block_device *bdev,
sector_t sector,
        bv.bv_len = PAGE_SIZE;
        bv.bv_offset = 0;

-       err = zram_bvec_rw(zram, &bv, index, offset, rw);
+       err = zram_bvec_rw(zram, &bv, index, offset, rw, rw ? REQ_WRITE : 0);
 put_zram:
        zram_meta_put(zram);
 out:
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 25fa844..3319ce1 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -609,7 +609,7 @@ static void request_endio(struct bio *bio)
 static void bio_complete(struct search *s)
 {
        if (s->orig_bio) {
-               generic_end_io_acct(bio_data_dir(s->orig_bio),
+               generic_end_io_acct(s->orig_bio->bi_rw,
                                    &s->d->disk->part0, s->start_time);

                trace_bcache_request_end(s->d, s->orig_bio);
@@ -964,9 +964,9 @@ static blk_qc_t cached_dev_make_request(struct
request_queue *q,
        struct search *s;
        struct bcache_device *d = bio->bi_bdev->bd_disk->private_data;
        struct cached_dev *dc = container_of(d, struct cached_dev, disk);
-       int rw = bio_data_dir(bio);
+       const int rw = bio_data_dir(bio);

-       generic_start_io_acct(rw, bio_sectors(bio), &d->disk->part0);
+       generic_start_io_acct(bio->bi_rw, bio_sectors(bio), &d->disk->part0);

        bio->bi_bdev = dc->bdev;
        bio->bi_iter.bi_sector += dc->sb.data_offset;
@@ -1079,9 +1079,9 @@ static blk_qc_t flash_dev_make_request(struct
request_queue *q,
        struct search *s;
        struct closure *cl;
        struct bcache_device *d = bio->bi_bdev->bd_disk->private_data;
-       int rw = bio_data_dir(bio);
+       const int rw = bio_data_dir(bio);

-       generic_start_io_acct(rw, bio_sectors(bio), &d->disk->part0);
+       generic_start_io_acct(bio->bi_rw, bio_sectors(bio), &d->disk->part0);

        s = search_alloc(bio, d);
        cl = &s->cl;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3d3ac13..d692c23 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -733,9 +733,9 @@ static void end_io_acct(struct dm_io *io)
        struct bio *bio = io->bio;
        unsigned long duration = jiffies - io->start_time;
        int pending;
-       int rw = bio_data_dir(bio);
+       const int rw = bio_data_dir(bio);

-       generic_end_io_acct(rw, &dm_disk(md)->part0, io->start_time);
+       generic_end_io_acct(bio->bi_rw, &dm_disk(md)->part0, io->start_time);

        if (unlikely(dm_stats_used(&md->stats)))
                dm_stats_account_io(&md->stats, bio->bi_rw,
bio->bi_iter.bi_sector,
@@ -1820,14 +1820,13 @@ static void __split_and_process_bio(struct
mapped_device *md,
  */
 static blk_qc_t dm_make_request(struct request_queue *q, struct bio *bio)
 {
-       int rw = bio_data_dir(bio);
        struct mapped_device *md = q->queuedata;
        int srcu_idx;
        struct dm_table *map;

        map = dm_get_live_table(md, &srcu_idx);

-       generic_start_io_acct(rw, bio_sectors(bio), &dm_disk(md)->part0);
+       generic_start_io_acct(bio->bi_rw, bio_sectors(bio),
&dm_disk(md)->part0);

        /* if we're suspended, we have to queue this io for later */
        if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags))) {
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9fc8d1e..fd83843 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -245,6 +245,7 @@ static DEFINE_SPINLOCK(all_mddevs_lock);
 static blk_qc_t md_make_request(struct request_queue *q, struct bio *bio)
 {
        const int rw = bio_data_dir(bio);
+       const int sgrp = rw_stat_group(bio->bi_rw);
        struct mddev *mddev = q->queuedata;
        unsigned int sectors;
        int cpu;
@@ -289,8 +290,8 @@ static blk_qc_t md_make_request(struct
request_queue *q, struct bio *bio)
        mddev->pers->make_request(mddev, bio);

        cpu = part_stat_lock();
-       part_stat_inc(cpu, &mddev->gendisk->part0, ios[rw]);
-       part_stat_add(cpu, &mddev->gendisk->part0, sectors[rw], sectors);
+       part_stat_inc(cpu, &mddev->gendisk->part0, ios[sgrp]);
+       part_stat_add(cpu, &mddev->gendisk->part0, sectors[sgrp], sectors);
        part_stat_unlock();

        if (atomic_dec_and_test(&mddev->active_io) && mddev->suspended)
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index 182a93f..7e6ab85 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -219,12 +219,13 @@ void __nd_iostat_start(struct bio *bio, unsigned
long *start)
 {
        struct gendisk *disk = bio->bi_bdev->bd_disk;
        const int rw = bio_data_dir(bio);
+       const int sgrp = rw_stat_group(bio->bi_rw);
        int cpu = part_stat_lock();

        *start = jiffies;
        part_round_stats(cpu, &disk->part0);
-       part_stat_inc(cpu, &disk->part0, ios[rw]);
-       part_stat_add(cpu, &disk->part0, sectors[rw], bio_sectors(bio));
+       part_stat_inc(cpu, &disk->part0, ios[sgrp]);
+       part_stat_add(cpu, &disk->part0, sectors[sgrp], bio_sectors(bio));
        part_inc_in_flight(&disk->part0, rw);
        part_stat_unlock();
 }
@@ -234,10 +235,11 @@ void nd_iostat_end(struct bio *bio, unsigned long start)
 {
        struct gendisk *disk = bio->bi_bdev->bd_disk;
        unsigned long duration = jiffies - start;
+       const int sgrp = rw_stat_group(bio->bi_rw);
        const int rw = bio_data_dir(bio);
        int cpu = part_stat_lock();

-       part_stat_add(cpu, &disk->part0, ticks[rw], duration);
+       part_stat_add(cpu, &disk->part0, ticks[sgrp], duration);
        part_round_stats(cpu, &disk->part0);
        part_dec_in_flight(&disk->part0, rw);
        part_stat_unlock();
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 6b7481f..a13ac5a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -494,9 +494,9 @@ extern struct bio *bio_copy_kern(struct
request_queue *, void *, unsigned int,
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);

-void generic_start_io_acct(int rw, unsigned long sectors,
+void generic_start_io_acct(int rw_flags, unsigned long sectors,
                           struct hd_struct *part);
-void generic_end_io_acct(int rw, struct hd_struct *part,
+void generic_end_io_acct(int rw_flags, struct hd_struct *part,
                         unsigned long start_time);

 #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 19e809c..db96322 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -434,6 +434,11 @@ static inline void free_part_info(struct hd_struct *part)
        kfree(part->info);
 }

+static inline int rw_stat_group(unsigned int rw_flags)
+{
+       return (rw_flags & REQ_WRITE) != 0;
+}
+
 /* block/blk-core.c */
 extern void part_round_stats(int cpu, struct hd_struct *part);
