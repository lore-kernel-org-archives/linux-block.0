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
Subject: [PATCH 07/15] genhd: Add attribute group parameter to device_add_disk
Date: Wed, 17 Aug 2016 15:15:07 +0800
Message-Id: <1471418115-3654-8-git-send-email-famz@redhat.com>
In-Reply-To: <1471418115-3654-1-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
List-ID: <linux-block@vger.kernel.org>

The added parameter attr_group, if not NULL, be added to the new disk.

The callers are converted with coccinelle:

  @@
  expression e1, e2;
  @@
  - device_add_disk(e1, e2);
  + device_add_disk(e1, e2, NULL);

So there is not behavior change yet.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 arch/m68k/emu/nfblock.c             |  2 +-
 arch/powerpc/sysdev/axonram.c       |  2 +-
 arch/um/drivers/ubd_kern.c          |  2 +-
 arch/xtensa/platforms/iss/simdisk.c |  2 +-
 block/genhd.c                       | 10 +++++++++-
 drivers/block/DAC960.c              |  2 +-
 drivers/block/amiflop.c             |  2 +-
 drivers/block/aoe/aoeblk.c          |  2 +-
 drivers/block/ataflop.c             |  2 +-
 drivers/block/brd.c                 |  4 ++--
 drivers/block/cciss.c               |  2 +-
 drivers/block/drbd/drbd_main.c      |  2 +-
 drivers/block/floppy.c              |  2 +-
 drivers/block/hd.c                  |  2 +-
 drivers/block/loop.c                |  2 +-
 drivers/block/mg_disk.c             |  2 +-
 drivers/block/mtip32xx/mtip32xx.c   |  2 +-
 drivers/block/nbd.c                 |  2 +-
 drivers/block/null_blk.c            |  2 +-
 drivers/block/osdblk.c              |  2 +-
 drivers/block/paride/pcd.c          |  2 +-
 drivers/block/paride/pd.c           |  2 +-
 drivers/block/paride/pf.c           |  2 +-
 drivers/block/pktcdvd.c             |  2 +-
 drivers/block/ps3disk.c             |  2 +-
 drivers/block/ps3vram.c             |  2 +-
 drivers/block/rbd.c                 |  2 +-
 drivers/block/rsxx/dev.c            |  2 +-
 drivers/block/skd_main.c            |  2 +-
 drivers/block/sunvdc.c              |  2 +-
 drivers/block/swim.c                |  2 +-
 drivers/block/swim3.c               |  2 +-
 drivers/block/sx8.c                 |  2 +-
 drivers/block/umem.c                |  2 +-
 drivers/block/virtio_blk.c          |  2 +-
 drivers/block/xen-blkfront.c        |  2 +-
 drivers/block/xsysace.c             |  2 +-
 drivers/block/z2ram.c               |  2 +-
 drivers/block/zram/zram_drv.c       |  2 +-
 drivers/cdrom/gdrom.c               |  2 +-
 drivers/ide/ide-cd.c                |  2 +-
 drivers/ide/ide-gd.c                |  2 +-
 drivers/lightnvm/gennvm.c           |  2 +-
 drivers/md/bcache/super.c           |  4 ++--
 drivers/md/dm.c                     |  2 +-
 drivers/md/md.c                     |  2 +-
 drivers/memstick/core/ms_block.c    |  2 +-
 drivers/memstick/core/mspro_block.c |  2 +-
 drivers/mmc/card/block.c            |  2 +-
 drivers/mtd/mtd_blkdevs.c           |  2 +-
 drivers/mtd/ubi/block.c             |  2 +-
 drivers/nvdimm/blk.c                |  2 +-
 drivers/nvdimm/btt.c                |  2 +-
 drivers/nvdimm/pmem.c               |  2 +-
 drivers/nvme/host/core.c            |  2 +-
 drivers/s390/block/dasd_genhd.c     |  2 +-
 drivers/s390/block/dcssblk.c        |  2 +-
 drivers/s390/block/scm_blk.c        |  2 +-
 drivers/s390/block/xpram.c          |  2 +-
 drivers/sbus/char/jsflash.c         |  2 +-
 drivers/scsi/sd.c                   |  2 +-
 drivers/scsi/sr.c                   |  2 +-
 include/linux/genhd.h               |  3 ++-
 63 files changed, 74 insertions(+), 65 deletions(-)

diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
index 573f76d..29dfdd6 100644
--- a/arch/m68k/emu/nfblock.c
+++ b/arch/m68k/emu/nfblock.c
@@ -138,7 +138,7 @@ static int __init nfhd_init_one(int id, u32 blocks, u32 bsize)
 	set_capacity(dev->disk, (sector_t)blocks * (bsize / 512));
 	dev->disk->queue = dev->queue;
 
-	device_add_disk(NULL, dev->disk);
+	device_add_disk(NULL, dev->disk, NULL);
 
 	list_add_tail(&dev->list, &nfhd_list);
 
diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index 9144204..6aef6c2 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -237,7 +237,7 @@ static int axon_ram_probe(struct platform_device *device)
 	set_capacity(bank->disk, bank->size >> AXON_RAM_SECTOR_SHIFT);
 	blk_queue_make_request(bank->disk->queue, axon_ram_make_request);
 	blk_queue_logical_block_size(bank->disk->queue, AXON_RAM_SECTOR_SIZE);
-	device_add_disk(&device->dev, bank->disk);
+	device_add_disk(&device->dev, bank->disk, NULL);
 
 	bank->irq_id = irq_of_parse_and_map(device->dev.of_node, 0);
 	if (bank->irq_id == NO_IRQ) {
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index f354027..45bbca5 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -829,7 +829,7 @@ static int ubd_disk_register(int major, u64 size, int unit,
 
 	disk->private_data = &ubd_devs[unit];
 	disk->queue = ubd_devs[unit].queue;
-	device_add_disk(parent, disk);
+	device_add_disk(parent, disk, NULL);
 
 	*disk_out = disk;
 	return 0;
diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index da000c1..6a3d8c3 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -288,7 +288,7 @@ static int __init simdisk_setup(struct simdisk *dev, int which,
 	dev->gd->private_data = dev;
 	snprintf(dev->gd->disk_name, 32, "simdisk%d", which);
 	set_capacity(dev->gd, 0);
-	device_add_disk(NULL, dev->gd);
+	device_add_disk(NULL, dev->gd, NULL);
 
 	dev->procfile = proc_create_data(tmp, 0644, procdir, &fops, dev);
 	return 0;
diff --git a/block/genhd.c b/block/genhd.c
index ffb3929..a2092e0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -598,7 +598,8 @@ exit:
  * RETURNS:
  * 0 on success, -errno on failure.
  */
-int device_add_disk(struct device *parent, struct gendisk *disk)
+int device_add_disk(struct device *parent, struct gendisk *disk,
+		    struct attribute_group *attr_group)
 {
 	struct backing_dev_info *bdi;
 	dev_t devt;
@@ -660,6 +661,13 @@ int device_add_disk(struct device *parent, struct gendisk *disk)
 	if (retval)
 		goto fail;
 
+	if (attr_group) {
+		retval = sysfs_create_group(&disk_to_dev(disk)->kobj,
+					    attr_group);
+		if (retval)
+			goto fail;
+	}
+
 	retval = blk_integrity_add(disk);
 	if (retval)
 		goto fail;
diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index 9f22a17..abaab30 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -3175,7 +3175,7 @@ DAC960_Probe(struct pci_dev *dev, const struct pci_device_id *entry)
 
   for (disk = 0; disk < DAC960_MaxLogicalDrives; disk++) {
         set_capacity(Controller->disks[disk], disk_size(Controller, disk));
-        device_add_disk(NULL, Controller->disks[disk]);
+        device_add_disk(NULL, Controller->disks[disk], NULL);
   }
   DAC960_CreateProcEntries(Controller);
   return 0;
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 398a30c..f00d3b4 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1738,7 +1738,7 @@ static int __init fd_probe_drives(void)
 		sprintf(disk->disk_name, "fd%d", drive);
 		disk->private_data = &unit[drive];
 		set_capacity(disk, 880*2);
-		device_add_disk(NULL, disk);
+		device_add_disk(NULL, disk, NULL);
 	}
 	if ((drives > 0) || (nomem == 0)) {
 		if (drives == 0)
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 24f246b..4edfff2 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -417,7 +417,7 @@ aoeblk_gdalloc(void *vp)
 
 	spin_unlock_irqrestore(&d->lock, flags);
 
-	device_add_disk(NULL, gd);
+	device_add_disk(NULL, gd, NULL);
 	aoedisk_add_sysfs(d);
 	aoedisk_add_debugfs(d);
 
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 6345731..0587aa36 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1969,7 +1969,7 @@ static int __init atari_floppy_init (void)
 		if (!unit[i].disk->queue)
 			goto Enomem;
 		set_capacity(unit[i].disk, MAX_DISK_SIZE * 2);
-		device_add_disk(NULL, unit[i].disk);
+		device_add_disk(NULL, unit[i].disk, NULL);
 	}
 
 	blk_register_region(MKDEV(FLOPPY_MAJOR, 0), 256, THIS_MODULE,
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index cf98820..99f6444 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -549,7 +549,7 @@ static struct brd_device *brd_init_one(int i, bool *new)
 
 	brd = brd_alloc(i);
 	if (brd) {
-		device_add_disk(NULL, brd->brd_disk);
+		device_add_disk(NULL, brd->brd_disk, NULL);
 		list_add_tail(&brd->brd_list, &brd_devices);
 	}
 	*new = true;
@@ -617,7 +617,7 @@ static int __init brd_init(void)
 	/* point of no return */
 
 	list_for_each_entry(brd, &brd_devices, brd_list)
-		device_add_disk(NULL, brd->brd_disk);
+		device_add_disk(NULL, brd->brd_disk, NULL);
 
 	blk_register_region(MKDEV(RAMDISK_MAJOR, 0), 1UL << MINORBITS,
 				  THIS_MODULE, brd_probe, NULL, NULL);
diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index db9d6bb..bef9f7f 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -1972,7 +1972,7 @@ static int cciss_add_disk(ctlr_info_t *h, struct gendisk *disk,
 	/* allows the interrupt handler to start the queue */
 	wmb();
 	h->drv[drv_index]->queue = disk->queue;
-	device_add_disk(&h->drv[drv_index]->dev, disk);
+	device_add_disk(&h->drv[drv_index]->dev, disk, NULL);
 	return 0;
 
 cleanup_queue:
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 2cc65cd..47aee0e 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2897,7 +2897,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 		goto out_idr_remove_vol;
 	}
 
-	device_add_disk(NULL, disk);
+	device_add_disk(NULL, disk, NULL);
 
 	/* inherit the connection state */
 	device->state.conn = first_connection(resource)->cstate;
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 627d8ff..952cad1 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4347,7 +4347,7 @@ static int __init do_floppy_init(void)
 		/* to be cleaned up... */
 		disks[drive]->private_data = (void *)(long)drive;
 		disks[drive]->flags |= GENHD_FL_REMOVABLE;
-		device_add_disk(&floppy_device[drive].dev, disks[drive]);
+		device_add_disk(&floppy_device[drive].dev, disks[drive], NULL);
 	}
 
 	return 0;
diff --git a/drivers/block/hd.c b/drivers/block/hd.c
index bf1d6f3..eeb5085 100644
--- a/drivers/block/hd.c
+++ b/drivers/block/hd.c
@@ -767,7 +767,7 @@ static int __init hd_init(void)
 
 	/* Let them fly */
 	for (drive = 0; drive < NR_HD; drive++)
-		device_add_disk(NULL, hd_gendisk[drive]);
+		device_add_disk(NULL, hd_gendisk[drive], NULL);
 
 	return 0;
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1d2b75d..3c5ad19 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1794,7 +1794,7 @@ static int loop_add(struct loop_device **l, int i)
 	disk->private_data	= lo;
 	disk->queue		= lo->lo_queue;
 	sprintf(disk->disk_name, "loop%d", i);
-	device_add_disk(NULL, disk);
+	device_add_disk(NULL, disk, NULL);
 	*l = lo;
 	return lo->lo_number;
 
diff --git a/drivers/block/mg_disk.c b/drivers/block/mg_disk.c
index 23b330e..48c67f6 100644
--- a/drivers/block/mg_disk.c
+++ b/drivers/block/mg_disk.c
@@ -1006,7 +1006,7 @@ static int mg_probe(struct platform_device *plat_dev)
 
 	set_capacity(host->gd, host->n_sectors);
 
-	device_add_disk(NULL, host->gd);
+	device_add_disk(NULL, host->gd, NULL);
 
 	return err;
 
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 2aca98e..4048a70 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -4041,7 +4041,7 @@ skip_create_disk:
 	set_capacity(dd->disk, capacity);
 
 	/* Enable the block device and add it to /dev */
-	device_add_disk(&dd->pdev->dev, dd->disk);
+	device_add_disk(&dd->pdev->dev, dd->disk, NULL);
 
 	dd->bdev = bdget_disk(dd->disk, 0);
 	/*
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3b9c194..c31a7df 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1085,7 +1085,7 @@ static int __init nbd_init(void)
 		disk->private_data = &nbd_dev[i];
 		sprintf(disk->disk_name, "nbd%d", i);
 		nbd_reset(&nbd_dev[i]);
-		device_add_disk(NULL, disk);
+		device_add_disk(NULL, disk, NULL);
 	}
 
 	return 0;
diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index f90c08e..61a7f69 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -740,7 +740,7 @@ static int null_add_dev(void)
 	disk->queue		= nullb->q;
 	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
 
-	device_add_disk(NULL, disk);
+	device_add_disk(NULL, disk, NULL);
 
 done:
 	mutex_lock(&lock);
diff --git a/drivers/block/osdblk.c b/drivers/block/osdblk.c
index e6e9e77..5683ef4 100644
--- a/drivers/block/osdblk.c
+++ b/drivers/block/osdblk.c
@@ -448,7 +448,7 @@ static int osdblk_init_disk(struct osdblk_device *osdev)
 
 	/* finally, announce the disk to the world */
 	set_capacity(disk, obj_size / 512ULL);
-	device_add_disk(NULL, disk);
+	device_add_disk(NULL, disk, NULL);
 
 	printk(KERN_INFO "%s: Added of size 0x%llx\n",
 		disk->disk_name, (unsigned long long)obj_size);
diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 87e4886..32920f8 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -970,7 +970,7 @@ static int __init pcd_init(void)
 			register_cdrom(&cd->info);
 			cd->disk->private_data = cd;
 			cd->disk->queue = pcd_queue;
-			device_add_disk(NULL, cd->disk);
+			device_add_disk(NULL, cd->disk, NULL);
 		}
 	}
 
diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 0bc07ad..3901529 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -906,7 +906,7 @@ static int pd_detect(void)
 	for (unit = 0, disk = pd; unit < PD_UNITS; unit++, disk++) {
 		if (disk->gd) {
 			set_capacity(disk->gd, disk->capacity);
-			device_add_disk(NULL, disk->gd);
+			device_add_disk(NULL, disk->gd, NULL);
 			found = 1;
 		}
 	}
diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index 9e902a5..c7b2f13 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -989,7 +989,7 @@ static int __init pf_init(void)
 			continue;
 		disk->private_data = pf;
 		disk->queue = pf_queue;
-		device_add_disk(NULL, disk);
+		device_add_disk(NULL, disk, NULL);
 	}
 	return 0;
 }
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 853a6fc..3ebec28 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2785,7 +2785,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	disk->events = pd->bdev->bd_disk->events;
 	disk->async_events = pd->bdev->bd_disk->async_events;
 
-	device_add_disk(NULL, disk);
+	device_add_disk(NULL, disk, NULL);
 
 	pkt_sysfs_dev_new(pd);
 	pkt_debugfs_dev_new(pd);
diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index 76f33c8..2fdeabc 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -498,7 +498,7 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 		 gendisk->disk_name, priv->model, priv->raw_capacity >> 11,
 		 get_capacity(gendisk) >> 11);
 
-	device_add_disk(&dev->sbd.core, gendisk);
+	device_add_disk(&dev->sbd.core, gendisk, NULL);
 	return 0;
 
 fail_cleanup_queue:
diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 456b4fe..49a2699 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -779,7 +779,7 @@ static int ps3vram_probe(struct ps3_system_bus_device *dev)
 	dev_info(&dev->core, "%s: Using %lu MiB of GPU memory\n",
 		 gendisk->disk_name, get_capacity(gendisk) >> 11);
 
-	device_add_disk(&dev->core, gendisk);
+	device_add_disk(&dev->core, gendisk, NULL);
 	return 0;
 
 fail_cleanup_queue:
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e1dae3c..77114cd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5160,7 +5160,7 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 	set_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
 	up_write(&rbd_dev->header_rwsem);
 
-	device_add_disk(NULL, rbd_dev->disk);
+	device_add_disk(NULL, rbd_dev->disk, NULL);
 	pr_info("%s: added with size 0x%llx\n", rbd_dev->disk->disk_name,
 		(unsigned long long) rbd_dev->mapping.size);
 
diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index f81d70b..bc26e23 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -230,7 +230,7 @@ int rsxx_attach_dev(struct rsxx_cardinfo *card)
 			set_capacity(card->gendisk, card->size8 >> 9);
 		else
 			set_capacity(card->gendisk, 0);
-		device_add_disk(CARD_TO_DEV(card), card->gendisk);
+		device_add_disk(CARD_TO_DEV(card), card->gendisk, NULL);
 		card->bdev_attached = 1;
 	}
 
diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index a6bd5ca..4187060 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -4693,7 +4693,7 @@ static int skd_bdev_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 static int skd_bdev_attach(struct device *parent, struct skd_device *skdev)
 {
 	pr_debug("%s:%s:%d device_add_disk\n", skdev->name, __func__, __LINE__);
-	device_add_disk(parent, skdev->disk);
+	device_add_disk(parent, skdev->disk, NULL);
 	return 0;
 }
 
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index cab1573..197c133 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -834,7 +834,7 @@ static int probe_disk(struct vdc_port *port)
 	       port->vdisk_size, (port->vdisk_size >> (20 - 9)),
 	       port->vio.ver.major, port->vio.ver.minor);
 
-	device_add_disk(&port->vio.vdev->dev, g);
+	device_add_disk(&port->vio.vdev->dev, g, NULL);
 
 	return 0;
 }
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 6037b74..a4d3e30 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -858,7 +858,7 @@ static int swim_floppy_init(struct swim_priv *swd)
 		swd->unit[drive].disk->private_data = &swd->unit[drive];
 		swd->unit[drive].disk->queue = swd->queue;
 		set_capacity(swd->unit[drive].disk, 2880);
-		device_add_disk(NULL, swd->unit[drive].disk);
+		device_add_disk(NULL, swd->unit[drive].disk, NULL);
 	}
 
 	blk_register_region(MKDEV(FLOPPY_MAJOR, 0), 256, THIS_MODULE,
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index d6ee4a6..39ad51e 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1240,7 +1240,7 @@ static int swim3_attach(struct macio_dev *mdev,
 	disk->flags |= GENHD_FL_REMOVABLE;
 	sprintf(disk->disk_name, "fd%d", index);
 	set_capacity(disk, 2880);
-	device_add_disk(NULL, disk);
+	device_add_disk(NULL, disk, NULL);
 
 	return 0;
 }
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index d80766c..507dea8 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1333,7 +1333,7 @@ static void carm_fsm_task (struct work_struct *work)
 				struct gendisk *disk = port->disk;
 
 				set_capacity(disk, port->capacity);
-				device_add_disk(NULL, disk);
+				device_add_disk(NULL, disk, NULL);
 				activated++;
 			}
 
diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 579fa05..44cb01d 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -1096,7 +1096,7 @@ static int __init mm_init(void)
 		disk->private_data = &cards[i];
 		disk->queue = cards[i].queue;
 		set_capacity(disk, cards[i].mm_size << 1);
-		device_add_disk(NULL, disk);
+		device_add_disk(NULL, disk, NULL);
 	}
 
 	init_battery_timer();
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 93b1aaa..4564df5 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -719,7 +719,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	device_add_disk(&vdev->dev, vblk->disk);
+	device_add_disk(&vdev->dev, vblk->disk, NULL);
 	err = device_create_file(disk_to_dev(vblk->disk), &dev_attr_serial);
 	if (err)
 		goto out_del_disk;
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index be4fea6..2c1fe8d 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2442,7 +2442,7 @@ static void blkfront_connect(struct blkfront_info *info)
 	for (i = 0; i < info->nr_rings; i++)
 		kick_pending_request_queues(&info->rinfo[i]);
 
-	device_add_disk(&info->xbdev->dev, info->gd);
+	device_add_disk(&info->xbdev->dev, info->gd, NULL);
 
 	info->is_ready = 1;
 }
diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 0fe5b28..edafc73 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -1057,7 +1057,7 @@ static int ace_setup(struct ace_device *ace)
 	ace_revalidate_disk(ace->gd);
 
 	/* Make the sysace device 'live' */
-	device_add_disk(NULL, ace->gd);
+	device_add_disk(NULL, ace->gd, NULL);
 
 	return 0;
 
diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index 0c4af61..19b7188 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -364,7 +364,7 @@ z2_init(void)
     sprintf(z2ram_gendisk->disk_name, "z2ram");
 
     z2ram_gendisk->queue = z2_queue;
-    device_add_disk(NULL, z2ram_gendisk);
+    device_add_disk(NULL, z2ram_gendisk, NULL);
     blk_register_region(MKDEV(Z2RAM_MAJOR, 0), Z2MINOR_COUNT, THIS_MODULE,
 				z2_find, NULL, NULL);
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 053ea53..20920a2 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1298,7 +1298,7 @@ static int zram_add(void)
 		zram->disk->queue->limits.discard_zeroes_data = 0;
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, zram->disk->queue);
 
-	device_add_disk(NULL, zram->disk);
+	device_add_disk(NULL, zram->disk, NULL);
 
 	ret = sysfs_create_group(&disk_to_dev(zram->disk)->kobj,
 				&zram_disk_attr_group);
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 1090205..89f4028 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -817,7 +817,7 @@ static int probe_gdrom(struct platform_device *devptr)
 	gd.toc = kzalloc(sizeof(struct gdromtoc), GFP_KERNEL);
 	if (!gd.toc)
 		goto probe_fail_toc;
-	device_add_disk(NULL, gd.disk);
+	device_add_disk(NULL, gd.disk, NULL);
 	return 0;
 
 probe_fail_toc:
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index bf9a2ad..0e16085 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1779,7 +1779,7 @@ static int ide_cd_probe(ide_drive_t *drive)
 	ide_cd_read_toc(drive, &sense);
 	g->fops = &idecd_ops;
 	g->flags |= GENHD_FL_REMOVABLE | GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE;
-	device_add_disk(&drive->gendev, g);
+	device_add_disk(&drive->gendev, g, NULL);
 	return 0;
 
 out_free_disk:
diff --git a/drivers/ide/ide-gd.c b/drivers/ide/ide-gd.c
index e823394..04e008e 100644
--- a/drivers/ide/ide-gd.c
+++ b/drivers/ide/ide-gd.c
@@ -416,7 +416,7 @@ static int ide_gd_probe(ide_drive_t *drive)
 	if (drive->dev_flags & IDE_DFLAG_REMOVABLE)
 		g->flags = GENHD_FL_REMOVABLE;
 	g->fops = &ide_gd_ops;
-	device_add_disk(&drive->gendev, g);
+	device_add_disk(&drive->gendev, g, NULL);
 	return 0;
 
 out_free_disk:
diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index f752479..08c6cdf 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -90,7 +90,7 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	blk_queue_max_hw_sectors(tqueue, 8 * dev->ops->max_phys_sect);
 
 	set_capacity(tdisk, tt->capacity(targetdata));
-	device_add_disk(NULL, tdisk);
+	device_add_disk(NULL, tdisk, NULL);
 
 	t->type = tt;
 	t->disk = tdisk;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 5a72f8e..071465a 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -866,7 +866,7 @@ void bch_cached_dev_run(struct cached_dev *dc)
 		closure_sync(&cl);
 	}
 
-	device_add_disk(NULL, d->disk);
+	device_add_disk(NULL, d->disk, NULL);
 	bd_link_disk_holder(dc->bdev, dc->disk.disk);
 	/* won't show up in the uevent file, use udevadm monitor -e instead
 	 * only class / kset properties are persistent */
@@ -1229,7 +1229,7 @@ static int flash_dev_run(struct cache_set *c, struct uuid_entry *u)
 
 	bcache_device_attach(d, c, u - c->uuids);
 	bch_flash_dev_request_init(d);
-	device_add_disk(NULL, d->disk);
+	device_add_disk(NULL, d->disk, NULL);
 
 	if (kobject_add(&d->kobj, &disk_to_dev(d->disk)->kobj, "bcache"))
 		goto err;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index b594364..8ba15b5 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1514,7 +1514,7 @@ static struct mapped_device *alloc_dev(int minor)
 	md->disk->queue = md->queue;
 	md->disk->private_data = md;
 	sprintf(md->disk->disk_name, "dm-%d", minor);
-	device_add_disk(NULL, md->disk);
+	device_add_disk(NULL, md->disk, NULL);
 	format_dev_t(md->name, MKDEV(_major, minor));
 
 	md->wq = alloc_workqueue("kdmflush", WQ_MEM_RECLAIM, 0);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index bdc7e1e..16fe7e7 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5066,7 +5066,7 @@ static int md_alloc(dev_t dev, char *name)
 	 * through to md_open, so make sure it doesn't get too far
 	 */
 	mutex_lock(&mddev->open_mutex);
-	device_add_disk(NULL, disk);
+	device_add_disk(NULL, disk, NULL);
 
 	error = kobject_init_and_add(&mddev->kobj, &md_ktype,
 				     &disk_to_dev(disk)->kobj, "%s", "md");
diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index aacf584..d5e6c3c 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2161,7 +2161,7 @@ static int msb_init_disk(struct memstick_dev *card)
 		set_disk_ro(msb->disk, 1);
 
 	msb_start(card);
-	device_add_disk(&card->dev, msb->disk);
+	device_add_disk(&card->dev, msb->disk, NULL);
 	dbg("Disk added");
 	return 0;
 
diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index c147227..e26a2b80 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -1253,7 +1253,7 @@ static int mspro_block_init_disk(struct memstick_dev *card)
 	set_capacity(msb->disk, capacity);
 	dev_dbg(&card->dev, "capacity set %ld\n", capacity);
 
-	device_add_disk(&card->dev, msb->disk);
+	device_add_disk(&card->dev, msb->disk, NULL);
 	msb->active = 1;
 	return 0;
 
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 48a5dd7..9030023 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2460,7 +2460,7 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 	int ret;
 	struct mmc_card *card = md->queue.card;
 
-	device_add_disk(md->parent, md->disk);
+	device_add_disk(md->parent, md->disk, NULL);
 	md->force_ro.show = force_ro_show;
 	md->force_ro.store = force_ro_store;
 	sysfs_attr_init(&md->force_ro.attr);
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 8d58acf..4ff9381 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -434,7 +434,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	if (new->readonly)
 		set_disk_ro(gd, 1);
 
-	device_add_disk(&new->mtd->dev, gd);
+	device_add_disk(&new->mtd->dev, gd, NULL);
 
 	if (new->disk_attributes) {
 		ret = sysfs_create_group(&disk_to_dev(gd)->kobj,
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 3952ea4..979e4d4 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -445,7 +445,7 @@ int ubiblock_create(struct ubi_volume_info *vi)
 	mutex_unlock(&devices_mutex);
 
 	/* Must be the last step: anyone can call file ops from now on */
-	device_add_disk(NULL, dev->gd);
+	device_add_disk(NULL, dev->gd, NULL);
 	dev_info(disk_to_dev(dev->gd), "created from ubi%d:%d(%s)",
 		 dev->ubi_num, dev->vol_id, vi->name);
 	return 0;
diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 9faaa96..cb74017 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -287,7 +287,7 @@ static int nsblk_attach_disk(struct nd_namespace_blk *nsblk)
 	disk->flags		= GENHD_FL_EXT_DEVT;
 	nvdimm_namespace_disk_name(&nsblk->common, disk->disk_name);
 	set_capacity(disk, 0);
-	device_add_disk(dev, disk);
+	device_add_disk(dev, disk, NULL);
 
 	if (devm_add_action_or_reset(dev, nd_blk_release_disk, disk))
 		return -ENOMEM;
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 368795a..8e97bc9 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1257,7 +1257,7 @@ static int btt_blk_init(struct btt *btt)
 	btt->btt_queue->queuedata = btt;
 
 	set_capacity(btt->btt_disk, 0);
-	device_add_disk(&btt->nd_btt->dev, btt->btt_disk);
+	device_add_disk(&btt->nd_btt->dev, btt->btt_disk, NULL);
 	if (btt_meta_size(btt)) {
 		int rc = nd_integrity_init(btt->btt_disk, btt_meta_size(btt));
 
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 571a6c7..7f3f611 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -309,7 +309,7 @@ static int pmem_attach_disk(struct device *dev,
 		return -ENOMEM;
 	nvdimm_badblocks_populate(nd_region, &pmem->bb, res);
 	disk->bb = &pmem->bb;
-	device_add_disk(dev, disk);
+	device_add_disk(dev, disk, NULL);
 
 	if (devm_add_action_or_reset(dev, pmem_release_disk, disk))
 		return -ENOMEM;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7ff2e82..23a795f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1686,7 +1686,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (ns->type == NVME_NS_LIGHTNVM)
 		return;
 
-	device_add_disk(ctrl->device, ns->disk);
+	device_add_disk(ctrl->device, ns->disk, NULL);
 	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
 					&nvme_ns_attr_group))
 		pr_warn("%s: failed to create sysfs group for identification\n",
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index e2fa759..cf5e081 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -75,7 +75,7 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 	gdp->queue = block->request_queue;
 	block->gdp = gdp;
 	set_capacity(block->gdp, 0);
-	device_add_disk(&base->cdev->dev, block->gdp);
+	device_add_disk(&base->cdev->dev, block->gdp, NULL);
 	return 0;
 }
 
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 9d66b4f..376e0fd 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -655,7 +655,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
 		goto put_dev;
 
 	get_device(&dev_info->dev);
-	device_add_disk(&dev_info->dev, dev_info->gd);
+	device_add_disk(&dev_info->dev, dev_info->gd, NULL);
 
 	switch (dev_info->segment_type) {
 		case SEG_TYPE_SR:
diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index 9f16ea6..6dba6eb 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -530,7 +530,7 @@ int scm_blk_dev_setup(struct scm_blk_dev *bdev, struct scm_device *scmdev)
 
 	/* 512 byte sectors */
 	set_capacity(bdev->gendisk, scmdev->size >> 9);
-	device_add_disk(&scmdev->dev, bdev->gendisk);
+	device_add_disk(&scmdev->dev, bdev->gendisk, NULL);
 	return 0;
 
 out_queue:
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index 80c761e..65cca0a 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -377,7 +377,7 @@ static int __init xpram_setup_blkdev(void)
 		disk->queue = xpram_queues[i];
 		sprintf(disk->disk_name, "slram%d", i);
 		set_capacity(disk, xpram_sizes[i] << 1);
-		device_add_disk(NULL, disk);
+		device_add_disk(NULL, disk, NULL);
 	}
 
 	return 0;
diff --git a/drivers/sbus/char/jsflash.c b/drivers/sbus/char/jsflash.c
index ace4859..1c823fa 100644
--- a/drivers/sbus/char/jsflash.c
+++ b/drivers/sbus/char/jsflash.c
@@ -590,7 +590,7 @@ static int jsfd_init(void)
 		set_capacity(disk, jdp->dsize >> 9);
 		disk->private_data = jdp;
 		disk->queue = jsf_queue;
-		device_add_disk(NULL, disk);
+		device_add_disk(NULL, disk, NULL);
 		set_disk_ro(disk, 1);
 	}
 	return 0;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index d3e852a..eb8e67f 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3000,7 +3000,7 @@ static void sd_probe_async(void *data, async_cookie_t cookie)
 	}
 
 	blk_pm_runtime_init(sdp->request_queue, dev);
-	device_add_disk(dev, gd);
+	device_add_disk(dev, gd, NULL);
 	if (sdkp->capacity)
 		sd_dif_config_host(sdkp);
 
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 1dd4aaa..e9619a6 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -729,7 +729,7 @@ static int sr_probe(struct device *dev)
 
 	dev_set_drvdata(dev, cd);
 	disk->flags |= GENHD_FL_REMOVABLE;
-	device_add_disk(&sdev->sdev_gendev, disk);
+	device_add_disk(&sdev->sdev_gendev, disk, NULL);
 
 	sdev_printk(KERN_DEBUG, sdev,
 		    "Attached scsi CD-ROM %s\n", cd->cdi.name);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 991b5ff..510e332 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -413,7 +413,8 @@ static inline void free_part_info(struct hd_struct *part)
 extern void part_round_stats(int cpu, struct hd_struct *part);
 
 /* block/genhd.c */
-extern int device_add_disk(struct device *parent, struct gendisk *disk);
+extern int device_add_disk(struct device *parent, struct gendisk *disk,
+			   struct attribute_group *attr_group);
 
 extern void del_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *partno);
-- 
2.7.4
