Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EE2C43334
	for <linux-block@archiver.kernel.org>; Sun, 19 Jun 2022 06:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiFSGGP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 02:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiFSGGO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 02:06:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5046FF58E
        for <linux-block@vger.kernel.org>; Sat, 18 Jun 2022 23:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Skm5Lj4QUVZrEYuj30OnCVne5+HWBPJnpcQ+MERzcIc=; b=YArT9u8H01OeELJb+0oCKk2OM/
        DGAWMXn6bSYDV54W3S6iwPIO8C0Nevu6CWuWPMdL0azgL+phi1XRoj9vDv4x56j4tjnvY4WW6o5F1
        eagBGAe+OgdXsqWGPQMGNyGAhGDkDjPm+a9kRLYcuUUFFDCBaINdHweqMZXBiiKDA0flt3pcO2Fud
        yLYk/TwffrMnDoQNZM1f6rCphO62h9ZxxIQ6bHHTaT0uoFzk2/AVZGLIPngPW8Qyczcc5cWTSMbwD
        8ClE+zBR3GdwMHv57ZIyo/pGR5eAJ+D9Ur8dSNH/mAZJ+Ax2lQdIg+BSDr/s/WDGcVsBJckoqyvdc
        ubLfBHNw==;
Received: from [2001:4bb8:189:7251:513c:d533:c6f1:1e56] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2o4Y-00DJoq-Hb; Sun, 19 Jun 2022 06:06:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH 6/6] block: remove blk_cleanup_disk
Date:   Sun, 19 Jun 2022 08:05:52 +0200
Message-Id: <20220619060552.1850436-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220619060552.1850436-1-hch@lst.de>
References: <20220619060552.1850436-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_cleanup_disk is nothing but a trivial wrapper for put_disk now,
so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/emu/nfblock.c             |  4 ++--
 arch/um/drivers/ubd_kern.c          |  4 ++--
 arch/xtensa/platforms/iss/simdisk.c |  4 ++--
 block/genhd.c                       | 15 ---------------
 drivers/block/amiflop.c             |  2 +-
 drivers/block/aoe/aoeblk.c          |  2 +-
 drivers/block/aoe/aoedev.c          |  2 +-
 drivers/block/ataflop.c             |  4 ++--
 drivers/block/brd.c                 |  4 ++--
 drivers/block/drbd/drbd_main.c      |  4 ++--
 drivers/block/floppy.c              |  6 +++---
 drivers/block/loop.c                |  2 +-
 drivers/block/mtip32xx/mtip32xx.c   |  2 +-
 drivers/block/n64cart.c             |  2 +-
 drivers/block/nbd.c                 |  4 ++--
 drivers/block/null_blk/main.c       |  4 ++--
 drivers/block/paride/pcd.c          |  4 ++--
 drivers/block/paride/pd.c           |  4 ++--
 drivers/block/paride/pf.c           |  4 ++--
 drivers/block/pktcdvd.c             |  4 ++--
 drivers/block/ps3disk.c             |  4 ++--
 drivers/block/ps3vram.c             |  4 ++--
 drivers/block/rbd.c                 |  2 +-
 drivers/block/rnbd/rnbd-clt.c       |  4 ++--
 drivers/block/sunvdc.c              |  4 ++--
 drivers/block/swim.c                |  2 +-
 drivers/block/swim3.c               |  2 +-
 drivers/block/sx8.c                 |  2 +-
 drivers/block/virtio_blk.c          |  2 +-
 drivers/block/xen-blkfront.c        |  4 ++--
 drivers/block/z2ram.c               |  2 +-
 drivers/block/zram/zram_drv.c       |  4 ++--
 drivers/cdrom/gdrom.c               |  2 +-
 drivers/md/bcache/super.c           |  2 +-
 drivers/md/dm.c                     |  2 +-
 drivers/md/md.c                     |  4 ++--
 drivers/memstick/core/ms_block.c    |  2 +-
 drivers/memstick/core/mspro_block.c |  2 +-
 drivers/mtd/mtd_blkdevs.c           |  4 ++--
 drivers/mtd/ubi/block.c             |  4 ++--
 drivers/nvdimm/btt.c                |  4 ++--
 drivers/nvdimm/pmem.c               |  4 ++--
 drivers/nvme/host/core.c            |  2 +-
 drivers/nvme/host/multipath.c       |  2 +-
 drivers/s390/block/dcssblk.c        |  8 ++++----
 drivers/s390/block/scm_blk.c        |  4 ++--
 include/linux/blkdev.h              |  1 -
 47 files changed, 74 insertions(+), 90 deletions(-)

diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
index 267b02cc5655b..a708fbd5a844f 100644
--- a/arch/m68k/emu/nfblock.c
+++ b/arch/m68k/emu/nfblock.c
@@ -138,7 +138,7 @@ static int __init nfhd_init_one(int id, u32 blocks, u32 bsize)
 	return 0;
 
 out_cleanup_disk:
-	blk_cleanup_disk(dev->disk);
+	put_disk(dev->disk);
 free_dev:
 	kfree(dev);
 out:
@@ -180,7 +180,7 @@ static void __exit nfhd_exit(void)
 	list_for_each_entry_safe(dev, next, &nfhd_list, list) {
 		list_del(&dev->list);
 		del_gendisk(dev->disk);
-		blk_cleanup_disk(dev->disk);
+		put_disk(dev->disk);
 		kfree(dev);
 	}
 	unregister_blkdev(major_num, "nfhd");
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index c4344b67628dd..479b79e114424 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -925,7 +925,7 @@ static int ubd_add(int n, char **error_out)
 	return 0;
 
 out_cleanup_disk:
-	blk_cleanup_disk(disk);
+	put_disk(disk);
 out_cleanup_tags:
 	blk_mq_free_tag_set(&ubd_dev->tag_set);
 out:
@@ -1032,7 +1032,7 @@ static int ubd_remove(int n, char **error_out)
 	ubd_gendisk[n] = NULL;
 	if(disk != NULL){
 		del_gendisk(disk);
-		blk_cleanup_disk(disk);
+		put_disk(disk);
 	}
 
 	err = 0;
diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 4255b92fa3eb0..f50caaa1c2496 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -290,7 +290,7 @@ static int __init simdisk_setup(struct simdisk *dev, int which,
 	return 0;
 
 out_cleanup_disk:
-	blk_cleanup_disk(dev->gd);
+	put_disk(dev->gd);
 out:
 	return err;
 }
@@ -344,7 +344,7 @@ static void simdisk_teardown(struct simdisk *dev, int which,
 	simdisk_detach(dev);
 	if (dev->gd) {
 		del_gendisk(dev->gd);
-		blk_cleanup_disk(dev->gd);
+		put_disk(dev->gd);
 	}
 	remove_proc_entry(tmp, procdir);
 }
diff --git a/block/genhd.c b/block/genhd.c
index 4d15f828c4498..bf9be06af2c8d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1432,21 +1432,6 @@ void put_disk(struct gendisk *disk)
 }
 EXPORT_SYMBOL(put_disk);
 
-/**
- * blk_cleanup_disk - shutdown a gendisk allocated by blk_alloc_disk
- * @disk: gendisk to shutdown
- *
- * Mark the queue hanging off @disk DYING, drain all pending requests, then mark
- * the queue DEAD, destroy and put it and the gendisk structure.
- *
- * Context: can sleep
- */
-void blk_cleanup_disk(struct gendisk *disk)
-{
-	put_disk(disk);
-}
-EXPORT_SYMBOL(blk_cleanup_disk);
-
 static void set_disk_ro_uevent(struct gendisk *gd, int ro)
 {
 	char event[] = "DISK_RO=1";
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 5a566f2fd533a..4c8b2ba579ee6 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1802,7 +1802,7 @@ static int fd_alloc_disk(int drive, int system)
 	unit[drive].gendisk[system] = disk;
 	err = add_disk(disk);
 	if (err)
-		blk_cleanup_disk(disk);
+		put_disk(disk);
 	return err;
 }
 
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 348adf3352177..12b3ca8f6f4a9 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -427,7 +427,7 @@ aoeblk_gdalloc(void *vp)
 	return;
 
 out_disk_cleanup:
-	blk_cleanup_disk(gd);
+	put_disk(gd);
 err_tagset:
 	blk_mq_free_tag_set(set);
 err_mempool:
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index b381d1c3ef327..3523dd82d7a00 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -277,7 +277,7 @@ freedev(struct aoedev *d)
 	if (d->gd) {
 		aoedisk_rm_debugfs(d);
 		del_gendisk(d->gd);
-		blk_cleanup_disk(d->gd);
+		put_disk(d->gd);
 		blk_mq_free_tag_set(&d->tag_set);
 	}
 	t = d->targets;
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index c6e41ee18aaa2..9deb4df6bdb8b 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2031,7 +2031,7 @@ static void ataflop_probe(dev_t dev)
 	return;
 
 cleanup_disk:
-	blk_cleanup_disk(unit[drive].disk[type]);
+	put_disk(unit[drive].disk[type]);
 	unit[drive].disk[type] = NULL;
 }
 
@@ -2063,7 +2063,7 @@ static void atari_cleanup_floppy_disk(struct atari_floppy_struct *fs)
 			continue;
 		if (fs->registered[type])
 			del_gendisk(fs->disk[type]);
-		blk_cleanup_disk(fs->disk[type]);
+		put_disk(fs->disk[type]);
 	}
 	blk_mq_free_tag_set(&fs->tag_set);
 }
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 6e3f2f0d23520..9e26d5e769f32 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -419,7 +419,7 @@ static int brd_alloc(int i)
 	return 0;
 
 out_cleanup_disk:
-	blk_cleanup_disk(disk);
+	put_disk(disk);
 out_free_dev:
 	list_del(&brd->brd_list);
 	kfree(brd);
@@ -439,7 +439,7 @@ static void brd_cleanup(void)
 
 	list_for_each_entry_safe(brd, next, &brd_devices, brd_list) {
 		del_gendisk(brd->brd_disk);
-		blk_cleanup_disk(brd->brd_disk);
+		put_disk(brd->brd_disk);
 		brd_free_pages(brd);
 		list_del(&brd->brd_list);
 		kfree(brd);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 2887350ae010a..f3e4db16fd07b 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2207,7 +2207,7 @@ void drbd_destroy_device(struct kref *kref)
 	if (device->bitmap) /* should no longer be there. */
 		drbd_bm_cleanup(device);
 	__free_page(device->md_io.page);
-	blk_cleanup_disk(device->vdisk);
+	put_disk(device->vdisk);
 	kfree(device->rs_plan_s);
 
 	/* not for_each_connection(connection, resource):
@@ -2807,7 +2807,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 out_no_bitmap:
 	__free_page(device->md_io.page);
 out_no_io_page:
-	blk_cleanup_disk(disk);
+	put_disk(disk);
 out_no_disk:
 	kref_put(&resource->kref, drbd_destroy_resource);
 	kfree(device);
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 015841f50f4e9..491e7205a0db0 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4557,7 +4557,7 @@ static void floppy_probe(dev_t dev)
 	return;
 
 cleanup_disk:
-	blk_cleanup_disk(disks[drive][type]);
+	put_disk(disks[drive][type]);
 	disks[drive][type] = NULL;
 	mutex_unlock(&floppy_probe_lock);
 }
@@ -4753,7 +4753,7 @@ static int __init do_floppy_init(void)
 		if (!disks[drive][0])
 			break;
 		del_timer_sync(&motor_off_timer[drive]);
-		blk_cleanup_disk(disks[drive][0]);
+		put_disk(disks[drive][0]);
 		blk_mq_free_tag_set(&tag_sets[drive]);
 	}
 	return err;
@@ -4985,7 +4985,7 @@ static void __exit floppy_module_exit(void)
 		}
 		for (i = 0; i < ARRAY_SIZE(floppy_type); i++) {
 			if (disks[drive][i])
-				blk_cleanup_disk(disks[drive][i]);
+				put_disk(disks[drive][i]);
 		}
 		blk_mq_free_tag_set(&tag_sets[drive]);
 	}
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cc608226c8c78..e3c0ba93c1a34 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2040,7 +2040,7 @@ static int loop_add(int i)
 	return i;
 
 out_cleanup_disk:
-	blk_cleanup_disk(disk);
+	put_disk(disk);
 out_cleanup_tags:
 	blk_mq_free_tag_set(&lo->tag_set);
 out_free_idr:
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 1d0e0a9fdd7c2..e116c6cf56f5f 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3534,7 +3534,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 disk_index_error:
 	ida_free(&rssd_index_ida, index);
 ida_get_error:
-	blk_cleanup_disk(dd->disk);
+	put_disk(dd->disk);
 block_queue_alloc_init_error:
 	blk_mq_free_tag_set(&dd->tags);
 block_queue_alloc_tag_error:
diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
index e094d2b8b5a92..d914156db2d8b 100644
--- a/drivers/block/n64cart.c
+++ b/drivers/block/n64cart.c
@@ -157,7 +157,7 @@ static int __init n64cart_probe(struct platform_device *pdev)
 	return 0;
 
 out_cleanup_disk:
-	blk_cleanup_disk(disk);
+	put_disk(disk);
 out:
 	return err;
 }
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 07f3c139a3d77..5c4c9c45c6ace 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -250,7 +250,7 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 	struct gendisk *disk = nbd->disk;
 
 	del_gendisk(disk);
-	blk_cleanup_disk(disk);
+	put_disk(disk);
 	blk_mq_free_tag_set(&nbd->tag_set);
 
 	/*
@@ -1833,7 +1833,7 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 out_free_work:
 	destroy_workqueue(nbd->recv_workq);
 out_err_disk:
-	blk_cleanup_disk(disk);
+	put_disk(disk);
 out_free_idr:
 	mutex_lock(&nbd_index_mutex);
 	idr_remove(&nbd_index_idr, index);
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 6b67088f4ea71..d695ea29efa6d 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1737,7 +1737,7 @@ static void null_del_dev(struct nullb *nullb)
 		null_restart_queue_async(nullb);
 	}
 
-	blk_cleanup_disk(nullb->disk);
+	put_disk(nullb->disk);
 	if (dev->queue_mode == NULL_Q_MQ &&
 	    nullb->tag_set == &nullb->__tag_set)
 		blk_mq_free_tag_set(nullb->tag_set);
@@ -2082,7 +2082,7 @@ static int null_add_dev(struct nullb_device *dev)
 out_cleanup_zone:
 	null_free_zoned_dev(dev);
 out_cleanup_disk:
-	blk_cleanup_disk(nullb->disk);
+	put_disk(nullb->disk);
 out_cleanup_tags:
 	if (dev->queue_mode == NULL_Q_MQ && nullb->tag_set == &nullb->__tag_set)
 		blk_mq_free_tag_set(nullb->tag_set);
diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index f462ad67931aa..a5ab407841193 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -956,7 +956,7 @@ static int pcd_init_unit(struct pcd_unit *cd, bool autoprobe, int port,
 out_pi_release:
 	pi_release(cd->pi);
 out_free_disk:
-	blk_cleanup_disk(cd->disk);
+	put_disk(cd->disk);
 out_free_tag_set:
 	blk_mq_free_tag_set(&cd->tag_set);
 	return ret;
@@ -1029,7 +1029,7 @@ static void __exit pcd_exit(void)
 		unregister_cdrom(&cd->info);
 		del_gendisk(cd->disk);
 		pi_release(cd->pi);
-		blk_cleanup_disk(cd->disk);
+		put_disk(cd->disk);
 
 		blk_mq_free_tag_set(&cd->tag_set);
 	}
diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 3637c38c72f97..c8c14c6f5c3a2 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -943,7 +943,7 @@ static int pd_probe_drive(struct pd_unit *disk, int autoprobe, int port,
 		goto cleanup_disk;
 	return 0;
 cleanup_disk:
-	blk_cleanup_disk(disk->gd);
+	put_disk(disk->gd);
 put_disk:
 	put_disk(p);
 	disk->gd = NULL;
@@ -1018,7 +1018,7 @@ static void __exit pd_exit(void)
 		if (p) {
 			disk->gd = NULL;
 			del_gendisk(p);
-			blk_cleanup_disk(p);
+			put_disk(p);
 			blk_mq_free_tag_set(&disk->tag_set);
 			pi_release(disk->pi);
 		}
diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index 292e9a4ce1b9e..eec1b9fde2450 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -975,7 +975,7 @@ static int __init pf_init_unit(struct pf_unit *pf, bool autoprobe, int port,
 out_pi_release:
 	pi_release(pf->pi);
 out_free_disk:
-	blk_cleanup_disk(pf->disk);
+	put_disk(pf->disk);
 out_free_tag_set:
 	blk_mq_free_tag_set(&pf->tag_set);
 	return ret;
@@ -1044,7 +1044,7 @@ static void __exit pf_exit(void)
 		if (!pf->present)
 			continue;
 		del_gendisk(pf->disk);
-		blk_cleanup_disk(pf->disk);
+		put_disk(pf->disk);
 		blk_mq_free_tag_set(&pf->tag_set);
 		pi_release(pf->pi);
 	}
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 7890933753443..653d242314830 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2733,7 +2733,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	return 0;
 
 out_mem2:
-	blk_cleanup_disk(disk);
+	put_disk(disk);
 out_mem:
 	mempool_exit(&pd->rb_pool);
 	kfree(pd);
@@ -2783,7 +2783,7 @@ static int pkt_remove_dev(dev_t pkt_dev)
 	pkt_dbg(1, pd, "writer unmapped\n");
 
 	del_gendisk(pd->disk);
-	blk_cleanup_disk(pd->disk);
+	put_disk(pd->disk);
 
 	mempool_exit(&pd->rb_pool);
 	kfree(pd);
diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index 3054adf774603..36d7b36c60c76 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -473,7 +473,7 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 
 	return 0;
 fail_cleanup_disk:
-	blk_cleanup_disk(gendisk);
+	put_disk(gendisk);
 fail_free_tag_set:
 	blk_mq_free_tag_set(&priv->tag_set);
 fail_teardown:
@@ -500,7 +500,7 @@ static void ps3disk_remove(struct ps3_system_bus_device *_dev)
 		    &ps3disk_mask);
 	mutex_unlock(&ps3disk_mask_mutex);
 	del_gendisk(priv->gendisk);
-	blk_cleanup_disk(priv->gendisk);
+	put_disk(priv->gendisk);
 	blk_mq_free_tag_set(&priv->tag_set);
 	dev_notice(&dev->sbd.core, "Synchronizing disk cache\n");
 	ps3disk_sync_cache(dev);
diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 4f90819e245e9..d1e0fefec90ba 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -761,7 +761,7 @@ static int ps3vram_probe(struct ps3_system_bus_device *dev)
 	return 0;
 
 out_cleanup_disk:
-	blk_cleanup_disk(gendisk);
+	put_disk(gendisk);
 out_cache_cleanup:
 	remove_proc_entry(DEVICE_NAME, NULL);
 	ps3vram_cache_cleanup(dev);
@@ -792,7 +792,7 @@ static void ps3vram_remove(struct ps3_system_bus_device *dev)
 	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 
 	del_gendisk(priv->gendisk);
-	blk_cleanup_disk(priv->gendisk);
+	put_disk(priv->gendisk);
 	remove_proc_entry(DEVICE_NAME, NULL);
 	ps3vram_cache_cleanup(dev);
 	iounmap(priv->reports);
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ef9bc62e9afd7..0d8ec2fe57400 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4729,7 +4729,7 @@ static blk_status_t rbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 static void rbd_free_disk(struct rbd_device *rbd_dev)
 {
-	blk_cleanup_disk(rbd_dev->disk);
+	put_disk(rbd_dev->disk);
 	blk_mq_free_tag_set(&rbd_dev->tag_set);
 	rbd_dev->disk = NULL;
 }
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index a4470374f54fc..b8d9e2824d9c7 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1408,7 +1408,7 @@ static int rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, dev->queue);
 	err = add_disk(dev->gd);
 	if (err)
-		blk_cleanup_disk(dev->gd);
+		put_disk(dev->gd);
 
 	return err;
 }
@@ -1630,7 +1630,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 static void destroy_gen_disk(struct rnbd_clt_dev *dev)
 {
 	del_gendisk(dev->gd);
-	blk_cleanup_disk(dev->gd);
+	put_disk(dev->gd);
 }
 
 static void destroy_sysfs(struct rnbd_clt_dev *dev,
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index dd0a1a6fed296..fb855da971ee7 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -886,7 +886,7 @@ static int probe_disk(struct vdc_port *port)
 	return 0;
 
 out_cleanup_disk:
-	blk_cleanup_disk(g);
+	put_disk(g);
 out_free_tag:
 	blk_mq_free_tag_set(&port->tag_set);
 	return err;
@@ -1070,7 +1070,7 @@ static void vdc_port_remove(struct vio_dev *vdev)
 		del_timer_sync(&port->vio.timer);
 
 		del_gendisk(port->disk);
-		blk_cleanup_disk(port->disk);
+		put_disk(port->disk);
 		blk_mq_free_tag_set(&port->tag_set);
 
 		vdc_free_tx_ring(port);
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index fef65a18d56fa..42b4b68286909 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -783,7 +783,7 @@ static void swim_cleanup_floppy_disk(struct floppy_state *fs)
 	if (fs->registered)
 		del_gendisk(fs->disk);
 
-	blk_cleanup_disk(disk);
+	put_disk(disk);
 	blk_mq_free_tag_set(&fs->tag_set);
 }
 
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 6c39f2c9f806d..da811a7da03f3 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1238,7 +1238,7 @@ static int swim3_attach(struct macio_dev *mdev,
 	return 0;
 
 out_cleanup_disk:
-	blk_cleanup_disk(disk);
+	put_disk(disk);
 out_free_tag_set:
 	blk_mq_free_tag_set(&fs->tag_set);
 out_unregister:
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 75057dbbcfbea..0e1a484cab0b6 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1377,7 +1377,7 @@ static void carm_free_disk(struct carm_host *host, unsigned int port_no)
 
 	if (host->state > HST_DEV_ACTIVATE)
 		del_gendisk(disk);
-	blk_cleanup_disk(disk);
+	put_disk(disk);
 }
 
 static int carm_init_shm(struct carm_host *host)
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index cff1b6f6b0548..d7d72e8f6e551 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1089,7 +1089,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	return 0;
 
 out_cleanup_disk:
-	blk_cleanup_disk(vblk->disk);
+	put_disk(vblk->disk);
 out_free_tags:
 	blk_mq_free_tag_set(&vblk->tag_set);
 out_free_vq:
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index a88ce4426400e..ee909d7a50fc9 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2382,7 +2382,7 @@ static void blkfront_connect(struct blkfront_info *info)
 
 	err = device_add_disk(&info->xbdev->dev, info->gd, NULL);
 	if (err) {
-		blk_cleanup_disk(info->gd);
+		put_disk(info->gd);
 		blk_mq_free_tag_set(&info->tag_set);
 		info->rq = NULL;
 		goto fail;
@@ -2465,7 +2465,7 @@ static int blkfront_remove(struct xenbus_device *xbdev)
 
 	blkif_free(info, 0);
 	xlbd_release_minors(info->gd->first_minor, info->gd->minors);
-	blk_cleanup_disk(info->gd);
+	put_disk(info->gd);
 	blk_mq_free_tag_set(&info->tag_set);
 
 	kfree(info);
diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index 18ad43d9933ec..c1e85f356e4df 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -337,7 +337,7 @@ static int z2ram_register_disk(int minor)
 	z2ram_gendisk[minor] = disk;
 	err = add_disk(disk);
 	if (err)
-		blk_cleanup_disk(disk);
+		put_disk(disk);
 	return err;
 }
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b8549c61ff2ce..e5233c911e436 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1957,7 +1957,7 @@ static int zram_add(void)
 	return device_id;
 
 out_cleanup_disk:
-	blk_cleanup_disk(zram->disk);
+	put_disk(zram->disk);
 out_free_idr:
 	idr_remove(&zram_index_idr, device_id);
 out_free_dev:
@@ -2008,7 +2008,7 @@ static int zram_remove(struct zram *zram)
 	 */
 	zram_reset_device(zram);
 
-	blk_cleanup_disk(zram->disk);
+	put_disk(zram->disk);
 	kfree(zram);
 	return 0;
 }
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index f4cc90ea6198e..ceded5772aac6 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -817,7 +817,7 @@ static int probe_gdrom(struct platform_device *devptr)
 	free_irq(HW_EVENT_GDROM_DMA, &gd);
 	free_irq(HW_EVENT_GDROM_CMD, &gd);
 probe_fail_cleanup_disk:
-	blk_cleanup_disk(gd.disk);
+	put_disk(gd.disk);
 probe_fail_free_tag_set:
 	blk_mq_free_tag_set(&gd.tag_set);
 probe_fail_free_cd_info:
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 3563d15dbaf27..9dd752d272f60 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -884,7 +884,7 @@ static void bcache_device_free(struct bcache_device *d)
 	if (disk) {
 		ida_simple_remove(&bcache_device_idx,
 				  first_minor_to_idx(disk->first_minor));
-		blk_cleanup_disk(disk);
+		put_disk(disk);
 	}
 
 	bioset_exit(&d->bio_split);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index d8f16183bf27c..a46474c4900a2 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1884,7 +1884,7 @@ static void cleanup_mapped_device(struct mapped_device *md)
 			del_gendisk(md->disk);
 		}
 		dm_queue_destroy_crypto_profile(md->queue);
-		blk_cleanup_disk(md->disk);
+		put_disk(md->disk);
 	}
 
 	if (md->pending_io) {
diff --git a/drivers/md/md.c b/drivers/md/md.c
index c7ecb0bffda0d..076255ec9ba18 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5579,7 +5579,7 @@ static void md_free(struct kobject *ko)
 
 	if (mddev->gendisk) {
 		del_gendisk(mddev->gendisk);
-		blk_cleanup_disk(mddev->gendisk);
+		put_disk(mddev->gendisk);
 	}
 	percpu_ref_exit(&mddev->writes_pending);
 
@@ -5718,7 +5718,7 @@ static int md_alloc(dev_t dev, char *name)
 out_del_gendisk:
 	del_gendisk(disk);
 out_cleanup_disk:
-	blk_cleanup_disk(disk);
+	put_disk(disk);
 out_unlock_disks_mutex:
 	mutex_unlock(&disks_mutex);
 	mddev_put(mddev);
diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index ba7e7249a3db4..ed9a683b3ca86 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2129,7 +2129,7 @@ static int msb_init_disk(struct memstick_dev *card)
 	return 0;
 
 out_cleanup_disk:
-	blk_cleanup_disk(msb->disk);
+	put_disk(msb->disk);
 out_free_tag_set:
 	blk_mq_free_tag_set(&msb->tag_set);
 out_release_id:
diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index 72e91c06c618b..61cf75d4a01ea 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -1209,7 +1209,7 @@ static int mspro_block_init_disk(struct memstick_dev *card)
 	return 0;
 
 out_cleanup_disk:
-	blk_cleanup_disk(msb->disk);
+	put_disk(msb->disk);
 out_free_tag_set:
 	blk_mq_free_tag_set(&msb->tag_set);
 out_release_id:
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index f731721114655..60b222799871e 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -29,7 +29,7 @@ static void blktrans_dev_release(struct kref *kref)
 	struct mtd_blktrans_dev *dev =
 		container_of(kref, struct mtd_blktrans_dev, ref);
 
-	blk_cleanup_disk(dev->disk);
+	put_disk(dev->disk);
 	blk_mq_free_tag_set(dev->tag_set);
 	kfree(dev->tag_set);
 	list_del(&dev->list);
@@ -398,7 +398,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	return 0;
 
 out_cleanup_disk:
-	blk_cleanup_disk(new->disk);
+	put_disk(new->disk);
 out_free_tag_set:
 	blk_mq_free_tag_set(new->tag_set);
 out_kfree_tag_set:
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index a78fdf3b30f7e..4cf67a2a0d04b 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -467,7 +467,7 @@ int ubiblock_create(struct ubi_volume_info *vi)
 out_remove_minor:
 	idr_remove(&ubiblock_minor_idr, gd->first_minor);
 out_cleanup_disk:
-	blk_cleanup_disk(dev->gd);
+	put_disk(dev->gd);
 out_free_tags:
 	blk_mq_free_tag_set(&dev->tag_set);
 out_free_dev:
@@ -486,7 +486,7 @@ static void ubiblock_cleanup(struct ubiblock *dev)
 	destroy_workqueue(dev->wq);
 	/* Finally destroy the blk queue */
 	dev_info(disk_to_dev(dev->gd), "released");
-	blk_cleanup_disk(dev->gd);
+	put_disk(dev->gd);
 	blk_mq_free_tag_set(&dev->tag_set);
 	idr_remove(&ubiblock_minor_idr, dev->gd->first_minor);
 }
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 9613e54c7a675..5e622c0d4b66a 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1548,14 +1548,14 @@ static int btt_blk_init(struct btt *btt)
 	return 0;
 
 out_cleanup_disk:
-	blk_cleanup_disk(btt->btt_disk);
+	put_disk(btt->btt_disk);
 	return rc;
 }
 
 static void btt_blk_cleanup(struct btt *btt)
 {
 	del_gendisk(btt->btt_disk);
-	blk_cleanup_disk(btt->btt_disk);
+	put_disk(btt->btt_disk);
 }
 
 /**
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 629d10fcf53b2..a72b81fa32426 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -450,7 +450,7 @@ static void pmem_release_disk(void *__pmem)
 	put_dax(pmem->dax_dev);
 	del_gendisk(pmem->disk);
 
-	blk_cleanup_disk(pmem->disk);
+	put_disk(pmem->disk);
 }
 
 static int pmem_attach_disk(struct device *dev,
@@ -596,7 +596,7 @@ static int pmem_attach_disk(struct device *dev,
 	kill_dax(pmem->dax_dev);
 	put_dax(pmem->dax_dev);
 out:
-	blk_cleanup_disk(pmem->disk);
+	put_disk(pmem->disk);
 	return rc;
 }
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 697af049b49d4..e14413cfe95c7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4047,7 +4047,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	mutex_unlock(&ctrl->subsys->lock);
 	nvme_put_ns_head(ns->head);
  out_cleanup_disk:
-	blk_cleanup_disk(disk);
+	put_disk(disk);
  out_free_ns:
 	kfree(ns);
  out_free_id:
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d3e2440d8abb0..ccf9a6da8f6e1 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -853,7 +853,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	/* make sure all pending bios are cleaned up */
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
-	blk_cleanup_disk(head->disk);
+	put_disk(head->disk);
 }
 
 void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl)
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 8d0d0eaa30594..4d8d1759775ae 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -414,7 +414,7 @@ dcssblk_shared_store(struct device *dev, struct device_attribute *attr, const ch
 	kill_dax(dev_info->dax_dev);
 	put_dax(dev_info->dax_dev);
 	del_gendisk(dev_info->gd);
-	blk_cleanup_disk(dev_info->gd);
+	put_disk(dev_info->gd);
 	up_write(&dcssblk_devices_sem);
 
 	if (device_remove_file_self(dev, attr)) {
@@ -712,7 +712,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
 	put_dax(dev_info->dax_dev);
 put_dev:
 	list_del(&dev_info->lh);
-	blk_cleanup_disk(dev_info->gd);
+	put_disk(dev_info->gd);
 	list_for_each_entry(seg_info, &dev_info->seg_list, lh) {
 		segment_unload(seg_info->segment_name);
 	}
@@ -722,7 +722,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
 dev_list_del:
 	list_del(&dev_info->lh);
 release_gd:
-	blk_cleanup_disk(dev_info->gd);
+	put_disk(dev_info->gd);
 	up_write(&dcssblk_devices_sem);
 seg_list_del:
 	if (dev_info == NULL)
@@ -790,7 +790,7 @@ dcssblk_remove_store(struct device *dev, struct device_attribute *attr, const ch
 	kill_dax(dev_info->dax_dev);
 	put_dax(dev_info->dax_dev);
 	del_gendisk(dev_info->gd);
-	blk_cleanup_disk(dev_info->gd);
+	put_disk(dev_info->gd);
 
 	/* unload all related segments */
 	list_for_each_entry(entry, &dev_info->seg_list, lh)
diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index 2a9c0ddcade59..0c1df1d5f1aca 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -501,7 +501,7 @@ int scm_blk_dev_setup(struct scm_blk_dev *bdev, struct scm_device *scmdev)
 	return 0;
 
 out_cleanup_disk:
-	blk_cleanup_disk(bdev->gendisk);
+	put_disk(bdev->gendisk);
 out_tag:
 	blk_mq_free_tag_set(&bdev->tag_set);
 out:
@@ -512,7 +512,7 @@ int scm_blk_dev_setup(struct scm_blk_dev *bdev, struct scm_device *scmdev)
 void scm_blk_dev_cleanup(struct scm_blk_dev *bdev)
 {
 	del_gendisk(bdev->gendisk);
-	blk_cleanup_disk(bdev->gendisk);
+	put_disk(bdev->gendisk);
 	blk_mq_free_tag_set(&bdev->tag_set);
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b9bf092531bc7..cfe36c87ac4ca 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -830,7 +830,6 @@ struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass);
 									\
 	__blk_alloc_disk(node_id, &__key);				\
 })
-void blk_cleanup_disk(struct gendisk *disk);
 
 int __register_blkdev(unsigned int major, const char *name,
 		void (*probe)(dev_t devt));
-- 
2.30.2

