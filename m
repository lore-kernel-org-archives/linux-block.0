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
Subject: [PATCH 15/15] block: Add FIXME comment to handle device_add_disk error
Date: Wed, 17 Aug 2016 15:15:15 +0800
Message-Id: <1471418115-3654-16-git-send-email-famz@redhat.com>
In-Reply-To: <1471418115-3654-1-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Done with coccinelle:

  @@
  expression e1, e2, e3;
  identifier rc;
  @@
  (
    rc = device_add_disk(e1, e2, e3);
  |
  + /* FIXME: handle error. */
    device_add_disk(e1, e2, e3);
  )

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 arch/m68k/emu/nfblock.c             | 1 +
 arch/um/drivers/ubd_kern.c          | 1 +
 arch/xtensa/platforms/iss/simdisk.c | 1 +
 drivers/block/DAC960.c              | 1 +
 drivers/block/amiflop.c             | 1 +
 drivers/block/aoe/aoeblk.c          | 1 +
 drivers/block/ataflop.c             | 1 +
 drivers/block/brd.c                 | 2 ++
 drivers/block/cciss.c               | 1 +
 drivers/block/drbd/drbd_main.c      | 1 +
 drivers/block/floppy.c              | 1 +
 drivers/block/hd.c                  | 1 +
 drivers/block/loop.c                | 1 +
 drivers/block/mg_disk.c             | 1 +
 drivers/block/mtip32xx/mtip32xx.c   | 1 +
 drivers/block/nbd.c                 | 1 +
 drivers/block/null_blk.c            | 1 +
 drivers/block/osdblk.c              | 1 +
 drivers/block/paride/pcd.c          | 1 +
 drivers/block/paride/pd.c           | 1 +
 drivers/block/paride/pf.c           | 1 +
 drivers/block/pktcdvd.c             | 1 +
 drivers/block/ps3disk.c             | 1 +
 drivers/block/ps3vram.c             | 1 +
 drivers/block/rbd.c                 | 1 +
 drivers/block/rsxx/dev.c            | 1 +
 drivers/block/skd_main.c            | 1 +
 drivers/block/sunvdc.c              | 1 +
 drivers/block/swim.c                | 1 +
 drivers/block/swim3.c               | 1 +
 drivers/block/sx8.c                 | 1 +
 drivers/block/umem.c                | 1 +
 drivers/block/xen-blkfront.c        | 1 +
 drivers/block/xsysace.c             | 1 +
 drivers/block/z2ram.c               | 1 +
 drivers/cdrom/gdrom.c               | 1 +
 drivers/ide/ide-cd.c                | 1 +
 drivers/ide/ide-gd.c                | 1 +
 drivers/lightnvm/gennvm.c           | 1 +
 drivers/md/bcache/super.c           | 2 ++
 drivers/md/dm.c                     | 1 +
 drivers/md/md.c                     | 1 +
 drivers/memstick/core/ms_block.c    | 1 +
 drivers/memstick/core/mspro_block.c | 1 +
 drivers/mmc/card/block.c            | 1 +
 drivers/mtd/mtd_blkdevs.c           | 1 +
 drivers/mtd/ubi/block.c             | 1 +
 drivers/nvdimm/blk.c                | 1 +
 drivers/nvdimm/btt.c                | 1 +
 drivers/nvdimm/pmem.c               | 1 +
 drivers/nvme/host/core.c            | 1 +
 drivers/s390/block/dasd_genhd.c     | 1 +
 drivers/s390/block/dcssblk.c        | 1 +
 drivers/s390/block/scm_blk.c        | 1 +
 drivers/s390/block/xpram.c          | 1 +
 drivers/sbus/char/jsflash.c         | 1 +
 drivers/scsi/sd.c                   | 1 +
 drivers/scsi/sr.c                   | 1 +
 58 files changed, 60 insertions(+)

diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
index 29dfdd6..ec45cb6 100644
--- a/arch/m68k/emu/nfblock.c
+++ b/arch/m68k/emu/nfblock.c
@@ -138,6 +138,7 @@ static int __init nfhd_init_one(int id, u32 blocks, u32 bsize)
 	set_capacity(dev->disk, (sector_t)blocks * (bsize / 512));
 	dev->disk->queue = dev->queue;
 
+	/* FIXME: handle error. */
 	device_add_disk(NULL, dev->disk, NULL);
 
 	list_add_tail(&dev->list, &nfhd_list);
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 45bbca5..3725af0 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -829,6 +829,7 @@ static int ubd_disk_register(int major, u64 size, int unit,
 
 	disk->private_data = &ubd_devs[unit];
 	disk->queue = ubd_devs[unit].queue;
+	/* FIXME: handle error. */
 	device_add_disk(parent, disk, NULL);
 
 	*disk_out = disk;
diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 6a3d8c3..b9a1a37 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -288,6 +288,7 @@ static int __init simdisk_setup(struct simdisk *dev, int which,
 	dev->gd->private_data = dev;
 	snprintf(dev->gd->disk_name, 32, "simdisk%d", which);
 	set_capacity(dev->gd, 0);
+	/* FIXME: handle error. */
 	device_add_disk(NULL, dev->gd, NULL);
 
 	dev->procfile = proc_create_data(tmp, 0644, procdir, &fops, dev);
diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index abaab30..f6121d3 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -3175,6 +3175,7 @@ DAC960_Probe(struct pci_dev *dev, const struct pci_device_id *entry)
 
   for (disk = 0; disk < DAC960_MaxLogicalDrives; disk++) {
         set_capacity(Controller->disks[disk], disk_size(Controller, disk));
+        /* FIXME: handle error. */
         device_add_disk(NULL, Controller->disks[disk], NULL);
   }
   DAC960_CreateProcEntries(Controller);
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index f00d3b4..48de00b 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1738,6 +1738,7 @@ static int __init fd_probe_drives(void)
 		sprintf(disk->disk_name, "fd%d", drive);
 		disk->private_data = &unit[drive];
 		set_capacity(disk, 880*2);
+		/* FIXME: handle error. */
 		device_add_disk(NULL, disk, NULL);
 	}
 	if ((drives > 0) || (nomem == 0)) {
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index d1b7541..6e7a128 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -412,6 +412,7 @@ aoeblk_gdalloc(void *vp)
 
 	spin_unlock_irqrestore(&d->lock, flags);
 
+	/* FIXME: handle error. */
 	device_add_disk(NULL, gd, &attr_group);
 	aoedisk_add_debugfs(d);
 
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 0587aa36..f3a2974 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1969,6 +1969,7 @@ static int __init atari_floppy_init (void)
 		if (!unit[i].disk->queue)
 			goto Enomem;
 		set_capacity(unit[i].disk, MAX_DISK_SIZE * 2);
+		/* FIXME: handle error. */
 		device_add_disk(NULL, unit[i].disk, NULL);
 	}
 
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 99f6444..5bb5bd4 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -549,6 +549,7 @@ static struct brd_device *brd_init_one(int i, bool *new)
 
 	brd = brd_alloc(i);
 	if (brd) {
+		/* FIXME: handle error. */
 		device_add_disk(NULL, brd->brd_disk, NULL);
 		list_add_tail(&brd->brd_list, &brd_devices);
 	}
@@ -617,6 +618,7 @@ static int __init brd_init(void)
 	/* point of no return */
 
 	list_for_each_entry(brd, &brd_devices, brd_list)
+		/* FIXME: handle error. */
 		device_add_disk(NULL, brd->brd_disk, NULL);
 
 	blk_register_region(MKDEV(RAMDISK_MAJOR, 0), 1UL << MINORBITS,
diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index bef9f7f..45eac78 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -1972,6 +1972,7 @@ static int cciss_add_disk(ctlr_info_t *h, struct gendisk *disk,
 	/* allows the interrupt handler to start the queue */
 	wmb();
 	h->drv[drv_index]->queue = disk->queue;
+	/* FIXME: handle error. */
 	device_add_disk(&h->drv[drv_index]->dev, disk, NULL);
 	return 0;
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 47aee0e..3e4e195 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2897,6 +2897,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 		goto out_idr_remove_vol;
 	}
 
+	/* FIXME: handle error. */
 	device_add_disk(NULL, disk, NULL);
 
 	/* inherit the connection state */
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 952cad1..4eb6125 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4347,6 +4347,7 @@ static int __init do_floppy_init(void)
 		/* to be cleaned up... */
 		disks[drive]->private_data = (void *)(long)drive;
 		disks[drive]->flags |= GENHD_FL_REMOVABLE;
+		/* FIXME: handle error. */
 		device_add_disk(&floppy_device[drive].dev, disks[drive], NULL);
 	}
 
diff --git a/drivers/block/hd.c b/drivers/block/hd.c
index eeb5085..64d8ee9 100644
--- a/drivers/block/hd.c
+++ b/drivers/block/hd.c
@@ -767,6 +767,7 @@ static int __init hd_init(void)
 
 	/* Let them fly */
 	for (drive = 0; drive < NR_HD; drive++)
+		/* FIXME: handle error. */
 		device_add_disk(NULL, hd_gendisk[drive], NULL);
 
 	return 0;
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3c5ad19..533839b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1794,6 +1794,7 @@ static int loop_add(struct loop_device **l, int i)
 	disk->private_data	= lo;
 	disk->queue		= lo->lo_queue;
 	sprintf(disk->disk_name, "loop%d", i);
+	/* FIXME: handle error. */
 	device_add_disk(NULL, disk, NULL);
 	*l = lo;
 	return lo->lo_number;
diff --git a/drivers/block/mg_disk.c b/drivers/block/mg_disk.c
index 48c67f6..81f289a 100644
--- a/drivers/block/mg_disk.c
+++ b/drivers/block/mg_disk.c
@@ -1006,6 +1006,7 @@ static int mg_probe(struct platform_device *plat_dev)
 
 	set_capacity(host->gd, host->n_sectors);
 
+	/* FIXME: handle error. */
 	device_add_disk(NULL, host->gd, NULL);
 
 	return err;
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 504c549..83dc3dc 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -4028,6 +4028,7 @@ skip_create_disk:
 	set_capacity(dd->disk, capacity);
 
 	/* Enable the block device and add it to /dev */
+	/* FIXME: handle error. */
 	device_add_disk(&dd->pdev->dev, dd->disk, &mtip_attr_group);
 
 	dd->bdev = bdget_disk(dd->disk, 0);
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c31a7df..e619529 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1085,6 +1085,7 @@ static int __init nbd_init(void)
 		disk->private_data = &nbd_dev[i];
 		sprintf(disk->disk_name, "nbd%d", i);
 		nbd_reset(&nbd_dev[i]);
+		/* FIXME: handle error. */
 		device_add_disk(NULL, disk, NULL);
 	}
 
diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 61a7f69..ed4523d 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -740,6 +740,7 @@ static int null_add_dev(void)
 	disk->queue		= nullb->q;
 	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
 
+	/* FIXME: handle error. */
 	device_add_disk(NULL, disk, NULL);
 
 done:
diff --git a/drivers/block/osdblk.c b/drivers/block/osdblk.c
index 5683ef4..8313e4b 100644
--- a/drivers/block/osdblk.c
+++ b/drivers/block/osdblk.c
@@ -448,6 +448,7 @@ static int osdblk_init_disk(struct osdblk_device *osdev)
 
 	/* finally, announce the disk to the world */
 	set_capacity(disk, obj_size / 512ULL);
+	/* FIXME: handle error. */
 	device_add_disk(NULL, disk, NULL);
 
 	printk(KERN_INFO "%s: Added of size 0x%llx\n",
diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 32920f8..108655d 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -970,6 +970,7 @@ static int __init pcd_init(void)
 			register_cdrom(&cd->info);
 			cd->disk->private_data = cd;
 			cd->disk->queue = pcd_queue;
+			/* FIXME: handle error. */
 			device_add_disk(NULL, cd->disk, NULL);
 		}
 	}
diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 3901529..9e3a4d5 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -906,6 +906,7 @@ static int pd_detect(void)
 	for (unit = 0, disk = pd; unit < PD_UNITS; unit++, disk++) {
 		if (disk->gd) {
 			set_capacity(disk->gd, disk->capacity);
+			/* FIXME: handle error. */
 			device_add_disk(NULL, disk->gd, NULL);
 			found = 1;
 		}
diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index c7b2f13..c7b5202 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -989,6 +989,7 @@ static int __init pf_init(void)
 			continue;
 		disk->private_data = pf;
 		disk->queue = pf_queue;
+		/* FIXME: handle error. */
 		device_add_disk(NULL, disk, NULL);
 	}
 	return 0;
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 3ebec28..c281812 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2785,6 +2785,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	disk->events = pd->bdev->bd_disk->events;
 	disk->async_events = pd->bdev->bd_disk->async_events;
 
+	/* FIXME: handle error. */
 	device_add_disk(NULL, disk, NULL);
 
 	pkt_sysfs_dev_new(pd);
diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index 2fdeabc..715ac8a 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -498,6 +498,7 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 		 gendisk->disk_name, priv->model, priv->raw_capacity >> 11,
 		 get_capacity(gendisk) >> 11);
 
+	/* FIXME: handle error. */
 	device_add_disk(&dev->sbd.core, gendisk, NULL);
 	return 0;
 
diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 49a2699..d82d87a 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -779,6 +779,7 @@ static int ps3vram_probe(struct ps3_system_bus_device *dev)
 	dev_info(&dev->core, "%s: Using %lu MiB of GPU memory\n",
 		 gendisk->disk_name, get_capacity(gendisk) >> 11);
 
+	/* FIXME: handle error. */
 	device_add_disk(&dev->core, gendisk, NULL);
 	return 0;
 
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 77114cd..dcc073e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5160,6 +5160,7 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 	set_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
 	up_write(&rbd_dev->header_rwsem);
 
+	/* FIXME: handle error. */
 	device_add_disk(NULL, rbd_dev->disk, NULL);
 	pr_info("%s: added with size 0x%llx\n", rbd_dev->disk->disk_name,
 		(unsigned long long) rbd_dev->mapping.size);
diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index bc26e23..e0dba88 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -230,6 +230,7 @@ int rsxx_attach_dev(struct rsxx_cardinfo *card)
 			set_capacity(card->gendisk, card->size8 >> 9);
 		else
 			set_capacity(card->gendisk, 0);
+		/* FIXME: handle error. */
 		device_add_disk(CARD_TO_DEV(card), card->gendisk, NULL);
 		card->bdev_attached = 1;
 	}
diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 4187060..0eadda5 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -4693,6 +4693,7 @@ static int skd_bdev_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 static int skd_bdev_attach(struct device *parent, struct skd_device *skdev)
 {
 	pr_debug("%s:%s:%d device_add_disk\n", skdev->name, __func__, __LINE__);
+	/* FIXME: handle error. */
 	device_add_disk(parent, skdev->disk, NULL);
 	return 0;
 }
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 197c133..b2b10e1 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -834,6 +834,7 @@ static int probe_disk(struct vdc_port *port)
 	       port->vdisk_size, (port->vdisk_size >> (20 - 9)),
 	       port->vio.ver.major, port->vio.ver.minor);
 
+	/* FIXME: handle error. */
 	device_add_disk(&port->vio.vdev->dev, g, NULL);
 
 	return 0;
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index a4d3e30..82dde18 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -858,6 +858,7 @@ static int swim_floppy_init(struct swim_priv *swd)
 		swd->unit[drive].disk->private_data = &swd->unit[drive];
 		swd->unit[drive].disk->queue = swd->queue;
 		set_capacity(swd->unit[drive].disk, 2880);
+		/* FIXME: handle error. */
 		device_add_disk(NULL, swd->unit[drive].disk, NULL);
 	}
 
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 39ad51e..9d52396 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1240,6 +1240,7 @@ static int swim3_attach(struct macio_dev *mdev,
 	disk->flags |= GENHD_FL_REMOVABLE;
 	sprintf(disk->disk_name, "fd%d", index);
 	set_capacity(disk, 2880);
+	/* FIXME: handle error. */
 	device_add_disk(NULL, disk, NULL);
 
 	return 0;
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 507dea8..4f49a97 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1333,6 +1333,7 @@ static void carm_fsm_task (struct work_struct *work)
 				struct gendisk *disk = port->disk;
 
 				set_capacity(disk, port->capacity);
+				/* FIXME: handle error. */
 				device_add_disk(NULL, disk, NULL);
 				activated++;
 			}
diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 44cb01d..016a0db 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -1096,6 +1096,7 @@ static int __init mm_init(void)
 		disk->private_data = &cards[i];
 		disk->queue = cards[i].queue;
 		set_capacity(disk, cards[i].mm_size << 1);
+		/* FIXME: handle error. */
 		device_add_disk(NULL, disk, NULL);
 	}
 
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 2c1fe8d..68737bd 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2442,6 +2442,7 @@ static void blkfront_connect(struct blkfront_info *info)
 	for (i = 0; i < info->nr_rings; i++)
 		kick_pending_request_queues(&info->rinfo[i]);
 
+	/* FIXME: handle error. */
 	device_add_disk(&info->xbdev->dev, info->gd, NULL);
 
 	info->is_ready = 1;
diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index edafc73..7683337 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -1057,6 +1057,7 @@ static int ace_setup(struct ace_device *ace)
 	ace_revalidate_disk(ace->gd);
 
 	/* Make the sysace device 'live' */
+	/* FIXME: handle error. */
 	device_add_disk(NULL, ace->gd, NULL);
 
 	return 0;
diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index 19b7188..b3e2718 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -364,6 +364,7 @@ z2_init(void)
     sprintf(z2ram_gendisk->disk_name, "z2ram");
 
     z2ram_gendisk->queue = z2_queue;
+    /* FIXME: handle error. */
     device_add_disk(NULL, z2ram_gendisk, NULL);
     blk_register_region(MKDEV(Z2RAM_MAJOR, 0), Z2MINOR_COUNT, THIS_MODULE,
 				z2_find, NULL, NULL);
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 89f4028..a4a569f 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -817,6 +817,7 @@ static int probe_gdrom(struct platform_device *devptr)
 	gd.toc = kzalloc(sizeof(struct gdromtoc), GFP_KERNEL);
 	if (!gd.toc)
 		goto probe_fail_toc;
+	/* FIXME: handle error. */
 	device_add_disk(NULL, gd.disk, NULL);
 	return 0;
 
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 0e16085..d6b6558 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1779,6 +1779,7 @@ static int ide_cd_probe(ide_drive_t *drive)
 	ide_cd_read_toc(drive, &sense);
 	g->fops = &idecd_ops;
 	g->flags |= GENHD_FL_REMOVABLE | GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE;
+	/* FIXME: handle error. */
 	device_add_disk(&drive->gendev, g, NULL);
 	return 0;
 
diff --git a/drivers/ide/ide-gd.c b/drivers/ide/ide-gd.c
index 04e008e..6b1758b 100644
--- a/drivers/ide/ide-gd.c
+++ b/drivers/ide/ide-gd.c
@@ -416,6 +416,7 @@ static int ide_gd_probe(ide_drive_t *drive)
 	if (drive->dev_flags & IDE_DFLAG_REMOVABLE)
 		g->flags = GENHD_FL_REMOVABLE;
 	g->fops = &ide_gd_ops;
+	/* FIXME: handle error. */
 	device_add_disk(&drive->gendev, g, NULL);
 	return 0;
 
diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index 08c6cdf..a4ff352 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -90,6 +90,7 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	blk_queue_max_hw_sectors(tqueue, 8 * dev->ops->max_phys_sect);
 
 	set_capacity(tdisk, tt->capacity(targetdata));
+	/* FIXME: handle error. */
 	device_add_disk(NULL, tdisk, NULL);
 
 	t->type = tt;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 071465a..391fbd2 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -866,6 +866,7 @@ void bch_cached_dev_run(struct cached_dev *dc)
 		closure_sync(&cl);
 	}
 
+	/* FIXME: handle error. */
 	device_add_disk(NULL, d->disk, NULL);
 	bd_link_disk_holder(dc->bdev, dc->disk.disk);
 	/* won't show up in the uevent file, use udevadm monitor -e instead
@@ -1229,6 +1230,7 @@ static int flash_dev_run(struct cache_set *c, struct uuid_entry *u)
 
 	bcache_device_attach(d, c, u - c->uuids);
 	bch_flash_dev_request_init(d);
+	/* FIXME: handle error. */
 	device_add_disk(NULL, d->disk, NULL);
 
 	if (kobject_add(&d->kobj, &disk_to_dev(d->disk)->kobj, "bcache"))
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 8ba15b5..14da668 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1514,6 +1514,7 @@ static struct mapped_device *alloc_dev(int minor)
 	md->disk->queue = md->queue;
 	md->disk->private_data = md;
 	sprintf(md->disk->disk_name, "dm-%d", minor);
+	/* FIXME: handle error. */
 	device_add_disk(NULL, md->disk, NULL);
 	format_dev_t(md->name, MKDEV(_major, minor));
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 16fe7e7..1343590 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5066,6 +5066,7 @@ static int md_alloc(dev_t dev, char *name)
 	 * through to md_open, so make sure it doesn't get too far
 	 */
 	mutex_lock(&mddev->open_mutex);
+	/* FIXME: handle error. */
 	device_add_disk(NULL, disk, NULL);
 
 	error = kobject_init_and_add(&mddev->kobj, &md_ktype,
diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index d5e6c3c..888cb51 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2161,6 +2161,7 @@ static int msb_init_disk(struct memstick_dev *card)
 		set_disk_ro(msb->disk, 1);
 
 	msb_start(card);
+	/* FIXME: handle error. */
 	device_add_disk(&card->dev, msb->disk, NULL);
 	dbg("Disk added");
 	return 0;
diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index e26a2b80..75d11cb 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -1253,6 +1253,7 @@ static int mspro_block_init_disk(struct memstick_dev *card)
 	set_capacity(msb->disk, capacity);
 	dev_dbg(&card->dev, "capacity set %ld\n", capacity);
 
+	/* FIXME: handle error. */
 	device_add_disk(&card->dev, msb->disk, NULL);
 	msb->active = 1;
 	return 0;
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 9030023..a824f44 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2460,6 +2460,7 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 	int ret;
 	struct mmc_card *card = md->queue.card;
 
+	/* FIXME: handle error. */
 	device_add_disk(md->parent, md->disk, NULL);
 	md->force_ro.show = force_ro_show;
 	md->force_ro.store = force_ro_store;
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index fc9265d..e37e547 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -434,6 +434,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	if (new->readonly)
 		set_disk_ro(gd, 1);
 
+	/* FIXME: handle error. */
 	device_add_disk(&new->mtd->dev, gd, new->disk_attributes);
 	return 0;
 error4:
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 979e4d4..8c8b8dc 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -445,6 +445,7 @@ int ubiblock_create(struct ubi_volume_info *vi)
 	mutex_unlock(&devices_mutex);
 
 	/* Must be the last step: anyone can call file ops from now on */
+	/* FIXME: handle error. */
 	device_add_disk(NULL, dev->gd, NULL);
 	dev_info(disk_to_dev(dev->gd), "created from ubi%d:%d(%s)",
 		 dev->ubi_num, dev->vol_id, vi->name);
diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index cb74017..2601609 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -287,6 +287,7 @@ static int nsblk_attach_disk(struct nd_namespace_blk *nsblk)
 	disk->flags		= GENHD_FL_EXT_DEVT;
 	nvdimm_namespace_disk_name(&nsblk->common, disk->disk_name);
 	set_capacity(disk, 0);
+	/* FIXME: handle error. */
 	device_add_disk(dev, disk, NULL);
 
 	if (devm_add_action_or_reset(dev, nd_blk_release_disk, disk))
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 8e97bc9..f64d775 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1257,6 +1257,7 @@ static int btt_blk_init(struct btt *btt)
 	btt->btt_queue->queuedata = btt;
 
 	set_capacity(btt->btt_disk, 0);
+	/* FIXME: handle error. */
 	device_add_disk(&btt->nd_btt->dev, btt->btt_disk, NULL);
 	if (btt_meta_size(btt)) {
 		int rc = nd_integrity_init(btt->btt_disk, btt_meta_size(btt));
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 7f3f611..2ab0dd8 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -309,6 +309,7 @@ static int pmem_attach_disk(struct device *dev,
 		return -ENOMEM;
 	nvdimm_badblocks_populate(nd_region, &pmem->bb, res);
 	disk->bb = &pmem->bb;
+	/* FIXME: handle error. */
 	device_add_disk(dev, disk, NULL);
 
 	if (devm_add_action_or_reset(dev, pmem_release_disk, disk))
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1921cb2..a3d7f82 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1686,6 +1686,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (ns->type == NVME_NS_LIGHTNVM)
 		return;
 
+	/* FIXME: handle error. */
 	device_add_disk(ctrl->device, ns->disk, &nvme_ns_attr_group);
 	return;
  out_free_disk:
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index cf5e081..eec1856 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -75,6 +75,7 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 	gdp->queue = block->request_queue;
 	block->gdp = gdp;
 	set_capacity(block->gdp, 0);
+	/* FIXME: handle error. */
 	device_add_disk(&base->cdev->dev, block->gdp, NULL);
 	return 0;
 }
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 376e0fd..41af886 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -655,6 +655,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
 		goto put_dev;
 
 	get_device(&dev_info->dev);
+	/* FIXME: handle error. */
 	device_add_disk(&dev_info->dev, dev_info->gd, NULL);
 
 	switch (dev_info->segment_type) {
diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index 6dba6eb..1c7950f 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -530,6 +530,7 @@ int scm_blk_dev_setup(struct scm_blk_dev *bdev, struct scm_device *scmdev)
 
 	/* 512 byte sectors */
 	set_capacity(bdev->gendisk, scmdev->size >> 9);
+	/* FIXME: handle error. */
 	device_add_disk(&scmdev->dev, bdev->gendisk, NULL);
 	return 0;
 
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index 65cca0a..7725c24 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -377,6 +377,7 @@ static int __init xpram_setup_blkdev(void)
 		disk->queue = xpram_queues[i];
 		sprintf(disk->disk_name, "slram%d", i);
 		set_capacity(disk, xpram_sizes[i] << 1);
+		/* FIXME: handle error. */
 		device_add_disk(NULL, disk, NULL);
 	}
 
diff --git a/drivers/sbus/char/jsflash.c b/drivers/sbus/char/jsflash.c
index 1c823fa..1e8403c 100644
--- a/drivers/sbus/char/jsflash.c
+++ b/drivers/sbus/char/jsflash.c
@@ -590,6 +590,7 @@ static int jsfd_init(void)
 		set_capacity(disk, jdp->dsize >> 9);
 		disk->private_data = jdp;
 		disk->queue = jsf_queue;
+		/* FIXME: handle error. */
 		device_add_disk(NULL, disk, NULL);
 		set_disk_ro(disk, 1);
 	}
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index eb8e67f..bd4862d 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3000,6 +3000,7 @@ static void sd_probe_async(void *data, async_cookie_t cookie)
 	}
 
 	blk_pm_runtime_init(sdp->request_queue, dev);
+	/* FIXME: handle error. */
 	device_add_disk(dev, gd, NULL);
 	if (sdkp->capacity)
 		sd_dif_config_host(sdkp);
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index e9619a6..5b869da 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -729,6 +729,7 @@ static int sr_probe(struct device *dev)
 
 	dev_set_drvdata(dev, cd);
 	disk->flags |= GENHD_FL_REMOVABLE;
+	/* FIXME: handle error. */
 	device_add_disk(&sdev->sdev_gendev, disk, NULL);
 
 	sdev_printk(KERN_DEBUG, sdev,
-- 
2.7.4
