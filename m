Return-Path: <famz@redhat.com>
From: Fam Zheng <famz@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, "Michael S. Tsirkin" <mst@redhat.com>,
        linux-block@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Paul Mackerras <paulus@samba.org>, linux-mtd@lists.infradead.org,
        "Ed L. Cashin" <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 01/15] disk: Drop add_disk in favor of device_add_disk
Date: Wed, 17 Aug 2016 15:15:01 +0800
Message-Id: <1471418115-3654-2-git-send-email-famz@redhat.com>
In-Reply-To: <1471418115-3654-1-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
List-ID: <linux-block@vger.kernel.org>

add_disk is now a "convenience" wrapper of device_add_disk. Unwrap it so
that callers can be later converted to handle error and attribute group
more easily.

Callers are converted with coccinelle:

  @@
  expression x;
  @@
  - add_disk(x)
  + device_add_disk(NULL, x)

Removal of add_disk and update of related comments are done manually.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 arch/m68k/emu/nfblock.c             | 2 +-
 arch/xtensa/platforms/iss/simdisk.c | 2 +-
 drivers/block/DAC960.c              | 2 +-
 drivers/block/amiflop.c             | 2 +-
 drivers/block/aoe/aoeblk.c          | 4 ++--
 drivers/block/ataflop.c             | 2 +-
 drivers/block/brd.c                 | 4 ++--
 drivers/block/drbd/drbd_main.c      | 2 +-
 drivers/block/floppy.c              | 2 +-
 drivers/block/hd.c                  | 2 +-
 drivers/block/loop.c                | 2 +-
 drivers/block/mg_disk.c             | 2 +-
 drivers/block/nbd.c                 | 2 +-
 drivers/block/null_blk.c            | 2 +-
 drivers/block/osdblk.c              | 2 +-
 drivers/block/paride/pcd.c          | 2 +-
 drivers/block/paride/pd.c           | 2 +-
 drivers/block/paride/pf.c           | 2 +-
 drivers/block/pktcdvd.c             | 2 +-
 drivers/block/rbd.c                 | 2 +-
 drivers/block/skd_main.c            | 2 +-
 drivers/block/swim.c                | 2 +-
 drivers/block/swim3.c               | 2 +-
 drivers/block/sx8.c                 | 2 +-
 drivers/block/umem.c                | 2 +-
 drivers/block/xsysace.c             | 2 +-
 drivers/block/z2ram.c               | 2 +-
 drivers/block/zram/zram_drv.c       | 2 +-
 drivers/cdrom/gdrom.c               | 2 +-
 drivers/lightnvm/gennvm.c           | 2 +-
 drivers/md/bcache/super.c           | 4 ++--
 drivers/md/dm.c                     | 2 +-
 drivers/md/md.c                     | 4 ++--
 drivers/mtd/ubi/block.c             | 2 +-
 drivers/s390/block/xpram.c          | 2 +-
 drivers/sbus/char/jsflash.c         | 2 +-
 drivers/scsi/sr.c                   | 2 +-
 drivers/scsi/st.c                   | 4 ++--
 fs/block_dev.c                      | 2 +-
 include/linux/genhd.h               | 4 ----
 40 files changed, 44 insertions(+), 48 deletions(-)

diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
index e9110b9..573f76d 100644
--- a/arch/m68k/emu/nfblock.c
+++ b/arch/m68k/emu/nfblock.c
@@ -138,7 +138,7 @@ static int __init nfhd_init_one(int id, u32 blocks, u32 bsize)
 	set_capacity(dev->disk, (sector_t)blocks * (bsize / 512));
 	dev->disk->queue = dev->queue;
 
-	add_disk(dev->disk);
+	device_add_disk(NULL, dev->disk);
 
 	list_add_tail(&dev->list, &nfhd_list);
 
diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index f58a4e6..da000c1 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -288,7 +288,7 @@ static int __init simdisk_setup(struct simdisk *dev, int which,
 	dev->gd->private_data = dev;
 	snprintf(dev->gd->disk_name, 32, "simdisk%d", which);
 	set_capacity(dev->gd, 0);
-	add_disk(dev->gd);
+	device_add_disk(NULL, dev->gd);
 
 	dev->procfile = proc_create_data(tmp, 0644, procdir, &fops, dev);
 	return 0;
diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index 811e11c..9f22a17 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -3175,7 +3175,7 @@ DAC960_Probe(struct pci_dev *dev, const struct pci_device_id *entry)
 
   for (disk = 0; disk < DAC960_MaxLogicalDrives; disk++) {
         set_capacity(Controller->disks[disk], disk_size(Controller, disk));
-        add_disk(Controller->disks[disk]);
+        device_add_disk(NULL, Controller->disks[disk]);
   }
   DAC960_CreateProcEntries(Controller);
   return 0;
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 5fd50a2..398a30c 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1738,7 +1738,7 @@ static int __init fd_probe_drives(void)
 		sprintf(disk->disk_name, "fd%d", drive);
 		disk->private_data = &unit[drive];
 		set_capacity(disk, 880*2);
-		add_disk(disk);
+		device_add_disk(NULL, disk);
 	}
 	if ((drives > 0) || (nomem == 0)) {
 		if (drives == 0)
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index ec9d861..24f246b 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -345,7 +345,7 @@ static const struct block_device_operations aoe_bdops = {
 	.owner = THIS_MODULE,
 };
 
-/* alloc_disk and add_disk can sleep */
+/* alloc_disk and device_add_disk can sleep */
 void
 aoeblk_gdalloc(void *vp)
 {
@@ -417,7 +417,7 @@ aoeblk_gdalloc(void *vp)
 
 	spin_unlock_irqrestore(&d->lock, flags);
 
-	add_disk(gd);
+	device_add_disk(NULL, gd);
 	aoedisk_add_sysfs(d);
 	aoedisk_add_debugfs(d);
 
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 2104b1b..6345731 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1969,7 +1969,7 @@ static int __init atari_floppy_init (void)
 		if (!unit[i].disk->queue)
 			goto Enomem;
 		set_capacity(unit[i].disk, MAX_DISK_SIZE * 2);
-		add_disk(unit[i].disk);
+		device_add_disk(NULL, unit[i].disk);
 	}
 
 	blk_register_region(MKDEV(FLOPPY_MAJOR, 0), 256, THIS_MODULE,
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 0c76d40..cf98820 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -549,7 +549,7 @@ static struct brd_device *brd_init_one(int i, bool *new)
 
 	brd = brd_alloc(i);
 	if (brd) {
-		add_disk(brd->brd_disk);
+		device_add_disk(NULL, brd->brd_disk);
 		list_add_tail(&brd->brd_list, &brd_devices);
 	}
 	*new = true;
@@ -617,7 +617,7 @@ static int __init brd_init(void)
 	/* point of no return */
 
 	list_for_each_entry(brd, &brd_devices, brd_list)
-		add_disk(brd->brd_disk);
+		device_add_disk(NULL, brd->brd_disk);
 
 	blk_register_region(MKDEV(RAMDISK_MAJOR, 0), 1UL << MINORBITS,
 				  THIS_MODULE, brd_probe, NULL, NULL);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 100be55..2cc65cd 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2897,7 +2897,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 		goto out_idr_remove_vol;
 	}
 
-	add_disk(disk);
+	device_add_disk(NULL, disk);
 
 	/* inherit the connection state */
 	device->state.conn = first_connection(resource)->cstate;
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index b71a9c7..627d8ff 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4605,7 +4605,7 @@ static void __exit floppy_module_exit(void)
 		blk_cleanup_queue(disks[drive]->queue);
 
 		/*
-		 * These disks have not called add_disk().  Don't put down
+		 * These disks have not called device_add_disk().  Don't put down
 		 * queue reference in put_disk().
 		 */
 		if (!(allowed_drive_mask & (1 << drive)) ||
diff --git a/drivers/block/hd.c b/drivers/block/hd.c
index 3abb121..bf1d6f3 100644
--- a/drivers/block/hd.c
+++ b/drivers/block/hd.c
@@ -767,7 +767,7 @@ static int __init hd_init(void)
 
 	/* Let them fly */
 	for (drive = 0; drive < NR_HD; drive++)
-		add_disk(hd_gendisk[drive]);
+		device_add_disk(NULL, hd_gendisk[drive]);
 
 	return 0;
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c9f2107..1d2b75d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1794,7 +1794,7 @@ static int loop_add(struct loop_device **l, int i)
 	disk->private_data	= lo;
 	disk->queue		= lo->lo_queue;
 	sprintf(disk->disk_name, "loop%d", i);
-	add_disk(disk);
+	device_add_disk(NULL, disk);
 	*l = lo;
 	return lo->lo_number;
 
diff --git a/drivers/block/mg_disk.c b/drivers/block/mg_disk.c
index e937fcf7..23b330e 100644
--- a/drivers/block/mg_disk.c
+++ b/drivers/block/mg_disk.c
@@ -1006,7 +1006,7 @@ static int mg_probe(struct platform_device *plat_dev)
 
 	set_capacity(host->gd, host->n_sectors);
 
-	add_disk(host->gd);
+	device_add_disk(NULL, host->gd);
 
 	return err;
 
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a9e3980..3b9c194 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1085,7 +1085,7 @@ static int __init nbd_init(void)
 		disk->private_data = &nbd_dev[i];
 		sprintf(disk->disk_name, "nbd%d", i);
 		nbd_reset(&nbd_dev[i]);
-		add_disk(disk);
+		device_add_disk(NULL, disk);
 	}
 
 	return 0;
diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 75a7f88..f90c08e 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -740,7 +740,7 @@ static int null_add_dev(void)
 	disk->queue		= nullb->q;
 	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
 
-	add_disk(disk);
+	device_add_disk(NULL, disk);
 
 done:
 	mutex_lock(&lock);
diff --git a/drivers/block/osdblk.c b/drivers/block/osdblk.c
index 92900f5..e6e9e77 100644
--- a/drivers/block/osdblk.c
+++ b/drivers/block/osdblk.c
@@ -448,7 +448,7 @@ static int osdblk_init_disk(struct osdblk_device *osdev)
 
 	/* finally, announce the disk to the world */
 	set_capacity(disk, obj_size / 512ULL);
-	add_disk(disk);
+	device_add_disk(NULL, disk);
 
 	printk(KERN_INFO "%s: Added of size 0x%llx\n",
 		disk->disk_name, (unsigned long long)obj_size);
diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 9336236..87e4886 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -970,7 +970,7 @@ static int __init pcd_init(void)
 			register_cdrom(&cd->info);
 			cd->disk->private_data = cd;
 			cd->disk->queue = pcd_queue;
-			add_disk(cd->disk);
+			device_add_disk(NULL, cd->disk);
 		}
 	}
 
diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 78a39f7..0bc07ad 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -906,7 +906,7 @@ static int pd_detect(void)
 	for (unit = 0, disk = pd; unit < PD_UNITS; unit++, disk++) {
 		if (disk->gd) {
 			set_capacity(disk->gd, disk->capacity);
-			add_disk(disk->gd);
+			device_add_disk(NULL, disk->gd);
 			found = 1;
 		}
 	}
diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index 7a7d977..9e902a5 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -989,7 +989,7 @@ static int __init pf_init(void)
 			continue;
 		disk->private_data = pf;
 		disk->queue = pf_queue;
-		add_disk(disk);
+		device_add_disk(NULL, disk);
 	}
 	return 0;
 }
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 90fa4ac..853a6fc 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2785,7 +2785,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	disk->events = pd->bdev->bd_disk->events;
 	disk->async_events = pd->bdev->bd_disk->async_events;
 
-	add_disk(disk);
+	device_add_disk(NULL, disk);
 
 	pkt_sysfs_dev_new(pd);
 	pkt_debugfs_dev_new(pd);
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6c6519f..e1dae3c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5160,7 +5160,7 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 	set_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
 	up_write(&rbd_dev->header_rwsem);
 
-	add_disk(rbd_dev->disk);
+	device_add_disk(NULL, rbd_dev->disk);
 	pr_info("%s: added with size 0x%llx\n", rbd_dev->disk->disk_name,
 		(unsigned long long) rbd_dev->mapping.size);
 
diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 3822eae..a6bd5ca 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -4692,7 +4692,7 @@ static int skd_bdev_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 
 static int skd_bdev_attach(struct device *parent, struct skd_device *skdev)
 {
-	pr_debug("%s:%s:%d add_disk\n", skdev->name, __func__, __LINE__);
+	pr_debug("%s:%s:%d device_add_disk\n", skdev->name, __func__, __LINE__);
 	device_add_disk(parent, skdev->disk);
 	return 0;
 }
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index b5afd49..6037b74 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -858,7 +858,7 @@ static int swim_floppy_init(struct swim_priv *swd)
 		swd->unit[drive].disk->private_data = &swd->unit[drive];
 		swd->unit[drive].disk->queue = swd->queue;
 		set_capacity(swd->unit[drive].disk, 2880);
-		add_disk(swd->unit[drive].disk);
+		device_add_disk(NULL, swd->unit[drive].disk);
 	}
 
 	blk_register_region(MKDEV(FLOPPY_MAJOR, 0), 256, THIS_MODULE,
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index c264f2d..d6ee4a6 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1240,7 +1240,7 @@ static int swim3_attach(struct macio_dev *mdev,
 	disk->flags |= GENHD_FL_REMOVABLE;
 	sprintf(disk->disk_name, "fd%d", index);
 	set_capacity(disk, 2880);
-	add_disk(disk);
+	device_add_disk(NULL, disk);
 
 	return 0;
 }
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index ba4bfe9..d80766c 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1333,7 +1333,7 @@ static void carm_fsm_task (struct work_struct *work)
 				struct gendisk *disk = port->disk;
 
 				set_capacity(disk, port->capacity);
-				add_disk(disk);
+				device_add_disk(NULL, disk);
 				activated++;
 			}
 
diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index be90e15..579fa05 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -1096,7 +1096,7 @@ static int __init mm_init(void)
 		disk->private_data = &cards[i];
 		disk->queue = cards[i].queue;
 		set_capacity(disk, cards[i].mm_size << 1);
-		add_disk(disk);
+		device_add_disk(NULL, disk);
 	}
 
 	init_battery_timer();
diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index c4328d9..0fe5b28 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -1057,7 +1057,7 @@ static int ace_setup(struct ace_device *ace)
 	ace_revalidate_disk(ace->gd);
 
 	/* Make the sysace device 'live' */
-	add_disk(ace->gd);
+	device_add_disk(NULL, ace->gd);
 
 	return 0;
 
diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index 968f9e5..0c4af61 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -364,7 +364,7 @@ z2_init(void)
     sprintf(z2ram_gendisk->disk_name, "z2ram");
 
     z2ram_gendisk->queue = z2_queue;
-    add_disk(z2ram_gendisk);
+    device_add_disk(NULL, z2ram_gendisk);
     blk_register_region(MKDEV(Z2RAM_MAJOR, 0), Z2MINOR_COUNT, THIS_MODULE,
 				z2_find, NULL, NULL);
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 04365b1..053ea53 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1298,7 +1298,7 @@ static int zram_add(void)
 		zram->disk->queue->limits.discard_zeroes_data = 0;
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, zram->disk->queue);
 
-	add_disk(zram->disk);
+	device_add_disk(NULL, zram->disk);
 
 	ret = sysfs_create_group(&disk_to_dev(zram->disk)->kobj,
 				&zram_disk_attr_group);
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 584bc31..1090205 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -817,7 +817,7 @@ static int probe_gdrom(struct platform_device *devptr)
 	gd.toc = kzalloc(sizeof(struct gdromtoc), GFP_KERNEL);
 	if (!gd.toc)
 		goto probe_fail_toc;
-	add_disk(gd.disk);
+	device_add_disk(NULL, gd.disk);
 	return 0;
 
 probe_fail_toc:
diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index b74174c..f752479 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -90,7 +90,7 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	blk_queue_max_hw_sectors(tqueue, 8 * dev->ops->max_phys_sect);
 
 	set_capacity(tdisk, tt->capacity(targetdata));
-	add_disk(tdisk);
+	device_add_disk(NULL, tdisk);
 
 	t->type = tt;
 	t->disk = tdisk;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 95a4ca6..5a72f8e 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -866,7 +866,7 @@ void bch_cached_dev_run(struct cached_dev *dc)
 		closure_sync(&cl);
 	}
 
-	add_disk(d->disk);
+	device_add_disk(NULL, d->disk);
 	bd_link_disk_holder(dc->bdev, dc->disk.disk);
 	/* won't show up in the uevent file, use udevadm monitor -e instead
 	 * only class / kset properties are persistent */
@@ -1229,7 +1229,7 @@ static int flash_dev_run(struct cache_set *c, struct uuid_entry *u)
 
 	bcache_device_attach(d, c, u - c->uuids);
 	bch_flash_dev_request_init(d);
-	add_disk(d->disk);
+	device_add_disk(NULL, d->disk);
 
 	if (kobject_add(&d->kobj, &disk_to_dev(d->disk)->kobj, "bcache"))
 		goto err;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index fa9b1cb..b594364 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1514,7 +1514,7 @@ static struct mapped_device *alloc_dev(int minor)
 	md->disk->queue = md->queue;
 	md->disk->private_data = md;
 	sprintf(md->disk->disk_name, "dm-%d", minor);
-	add_disk(md->disk);
+	device_add_disk(NULL, md->disk);
 	format_dev_t(md->name, MKDEV(_major, minor));
 
 	md->wq = alloc_workqueue("kdmflush", WQ_MEM_RECLAIM, 0);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index d646f6e..bdc7e1e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5062,11 +5062,11 @@ static int md_alloc(dev_t dev, char *name)
 	 */
 	disk->flags |= GENHD_FL_EXT_DEVT;
 	mddev->gendisk = disk;
-	/* As soon as we call add_disk(), another thread could get
+	/* As soon as we call device_add_disk(), another thread could get
 	 * through to md_open, so make sure it doesn't get too far
 	 */
 	mutex_lock(&mddev->open_mutex);
-	add_disk(disk);
+	device_add_disk(NULL, disk);
 
 	error = kobject_init_and_add(&mddev->kobj, &md_ktype,
 				     &disk_to_dev(disk)->kobj, "%s", "md");
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index ebf46ad..3952ea4 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -445,7 +445,7 @@ int ubiblock_create(struct ubi_volume_info *vi)
 	mutex_unlock(&devices_mutex);
 
 	/* Must be the last step: anyone can call file ops from now on */
-	add_disk(dev->gd);
+	device_add_disk(NULL, dev->gd);
 	dev_info(disk_to_dev(dev->gd), "created from ubi%d:%d(%s)",
 		 dev->ubi_num, dev->vol_id, vi->name);
 	return 0;
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index 288f59a..80c761e 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -377,7 +377,7 @@ static int __init xpram_setup_blkdev(void)
 		disk->queue = xpram_queues[i];
 		sprintf(disk->disk_name, "slram%d", i);
 		set_capacity(disk, xpram_sizes[i] << 1);
-		add_disk(disk);
+		device_add_disk(NULL, disk);
 	}
 
 	return 0;
diff --git a/drivers/sbus/char/jsflash.c b/drivers/sbus/char/jsflash.c
index a40ee1e..ace4859 100644
--- a/drivers/sbus/char/jsflash.c
+++ b/drivers/sbus/char/jsflash.c
@@ -590,7 +590,7 @@ static int jsfd_init(void)
 		set_capacity(disk, jdp->dsize >> 9);
 		disk->private_data = jdp;
 		disk->queue = jsf_queue;
-		add_disk(disk);
+		device_add_disk(NULL, disk);
 		set_disk_ro(disk, 1);
 	}
 	return 0;
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index ed17934..1dd4aaa 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -723,7 +723,7 @@ static int sr_probe(struct device *dev)
 
 	/*
 	 * Initialize block layer runtime PM stuffs before the
-	 * periodic event checking request gets started in add_disk.
+	 * periodic event checking request gets started in device_add_disk.
 	 */
 	blk_pm_runtime_init(sdev->request_queue, dev);
 
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 7af5226..ebeb1bd 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4299,8 +4299,8 @@ static int st_probe(struct device *dev)
 	tpnt->disk = disk;
 	disk->private_data = &tpnt->driver;
 	disk->queue = SDp->request_queue;
-	/* SCSI tape doesn't register this gendisk via add_disk().  Manually
-	 * take queue reference that release_disk() expects. */
+	/* SCSI tape doesn't register this gendisk via device_add_disk().
+	 * Manually take queue reference that release_disk() expects. */
 	if (!blk_get_queue(disk->queue))
 		goto out_put_disk;
 	tpnt->driver = &st_template;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index c3cdde8..336c320d 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1028,7 +1028,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 
 	WARN_ON_ONCE(!bdev->bd_holder);
 
-	/* FIXME: remove the following once add_disk() handles errors */
+	/* FIXME: remove the following once device_add_disk() handles errors */
 	if (WARN_ON(!disk->slave_dir || !bdev->bd_part->holder_dir))
 		goto out_unlock;
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 1dbf52f..889b1bb 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -414,10 +414,6 @@ extern void part_round_stats(int cpu, struct hd_struct *part);
 
 /* block/genhd.c */
 extern void device_add_disk(struct device *parent, struct gendisk *disk);
-static inline void add_disk(struct gendisk *disk)
-{
-	device_add_disk(NULL, disk);
-}
 
 extern void del_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *partno);
-- 
2.7.4
