Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFCEC388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 18:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9902206FB
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 18:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgKKSIy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 13:08:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:43506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgKKSIy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 13:08:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A932AB95;
        Wed, 11 Nov 2020 18:08:53 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-block@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>, ltp@lists.linux.it
Subject: [PATCH 1/1] loop: Fix occasional uevent drop
Date:   Wed, 11 Nov 2020 19:08:46 +0100
Message-Id: <20201111180846.21515-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

716ad0986cbd caused to occasional drop of loop device uevent, which was
no longer triggered in loop_set_size() but in a different part of code.

Bug is reproducible with LTP test uevent01 [1]:

i=0; while true; do
    i=$((i+1)); echo "== $i =="
    lsmod |grep -q loop && rmmod -f loop
    ./uevent01 || break
done

Put back triggering through code called in loop_set_size().

Fix required to add yet another parameter to
set_capacity_revalidate_and_notify().

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/uevents/uevent01.c

Fixes: 716ad0986cbd ("loop: Switch to set_capacity_revalidate_and_notify")
Reported-by: <ltp@lists.linux.it>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

original bug looks to be a rice (usually ~ 10 loops is enough),
so this might just covers another problems).

Kind regards,
Petr

 block/genhd.c                | 6 ++++--
 drivers/block/loop.c         | 2 +-
 drivers/block/virtio_blk.c   | 2 +-
 drivers/block/xen-blkfront.c | 2 +-
 drivers/nvme/host/core.c     | 2 +-
 drivers/scsi/sd.c            | 4 ++--
 include/linux/genhd.h        | 2 +-
 7 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 0a273211fec2..3092910945c0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -47,10 +47,10 @@ static void disk_release_events(struct gendisk *disk);
 
 /*
  * Set disk capacity and notify if the size is not currently
- * zero and will not be set to zero
+ * zero and will not be set to zero or not explicitly forced.
  */
 void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
-					bool update_bdev)
+					bool update_bdev, bool force_notify)
 {
 	sector_t capacity = get_capacity(disk);
 
@@ -62,6 +62,8 @@ void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
 		char *envp[] = { "RESIZE=1", NULL };
 
 		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
+	} else if (force_notify) {
+		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
 	}
 }
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cb1191d6e945..7233f3482447 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -255,7 +255,7 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 
 	bd_set_nr_sectors(bdev, size);
 
-	set_capacity_revalidate_and_notify(lo->lo_disk, size, false);
+	set_capacity_revalidate_and_notify(lo->lo_disk, size, false, true);
 }
 
 static inline int
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index a314b9382442..93e56e2ba15c 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -470,7 +470,7 @@ static void virtblk_update_capacity(struct virtio_blk *vblk, bool resize)
 		   cap_str_10,
 		   cap_str_2);
 
-	set_capacity_revalidate_and_notify(vblk->disk, capacity, true);
+	set_capacity_revalidate_and_notify(vblk->disk, capacity, true, false);
 }
 
 static void virtblk_config_changed_work(struct work_struct *work)
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 48629d3433b4..5b5795a612cc 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2370,7 +2370,7 @@ static void blkfront_connect(struct blkfront_info *info)
 			return;
 		printk(KERN_INFO "Setting capacity to %Lu\n",
 		       sectors);
-		set_capacity_revalidate_and_notify(info->gd, sectors, true);
+		set_capacity_revalidate_and_notify(info->gd, sectors, true, false);
 
 		return;
 	case BLKIF_STATE_SUSPENDED:
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40ca71b29bb9..ca7ebd0b9668 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2053,7 +2053,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 			capacity = 0;
 	}
 
-	set_capacity_revalidate_and_notify(disk, capacity, false);
+	set_capacity_revalidate_and_notify(disk, capacity, false, false);
 
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk, ns);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 656bcf4940d6..81503e99e937 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3266,7 +3266,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 	sdkp->first_scan = 0;
 
 	set_capacity_revalidate_and_notify(disk,
-		logical_to_sectors(sdp, sdkp->capacity), false);
+		logical_to_sectors(sdp, sdkp->capacity), false, false);
 	sd_config_write_same(sdkp);
 	kfree(buffer);
 
@@ -3276,7 +3276,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 	 * capacity to 0.
 	 */
 	if (sd_zbc_revalidate_zones(sdkp))
-		set_capacity_revalidate_and_notify(disk, 0, false);
+		set_capacity_revalidate_and_notify(disk, 0, false, false);
 
  out:
 	return 0;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 38f23d757013..6656e7931379 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -316,7 +316,7 @@ extern void disk_block_events(struct gendisk *disk);
 extern void disk_unblock_events(struct gendisk *disk);
 extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
 void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
-		bool update_bdev);
+		bool update_bdev, bool force_notify);
 
 /* drivers/char/random.c */
 extern void add_disk_randomness(struct gendisk *disk) __latent_entropy;
-- 
2.29.2

