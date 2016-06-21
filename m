Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12661 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbcFUUtT (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 21 Jun 2016 16:49:19 -0400
Subject: [PATCH v4 2/5] mmc: move 'parent' tracking to mmc_blk_data
From: Dan Williams <dan.j.williams@intel.com>
To: axboe@fb.com
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-nvdimm@lists.01.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@sandisk.com>, hch@lst.de
Date: Tue, 21 Jun 2016 13:46:12 -0700
Message-ID: <146654197196.34694.11595948607042214658.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <146654196111.34694.7735150373057824399.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <146654196111.34694.7735150373057824399.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In preparation for the removal of 'driverfs_dev' from 'struct gendisk',
carry this data in mmc_blk_data. It is used for registration of parent
disks and partitions.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Reported-by: Bart Van Assche <bart.vanassche@sandisk.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/mmc/card/block.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 383184743f9a..d1733424bf6e 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -93,6 +93,7 @@ static DEFINE_SPINLOCK(mmc_blk_lock);
  */
 struct mmc_blk_data {
 	spinlock_t	lock;
+	struct device	*parent;
 	struct gendisk	*disk;
 	struct mmc_queue queue;
 	struct list_head part;
@@ -2270,7 +2271,7 @@ again:
 	md->disk->fops = &mmc_bdops;
 	md->disk->private_data = md;
 	md->disk->queue = md->queue.queue;
-	md->disk->driverfs_dev = parent;
+	md->parent = parent;
 	set_disk_ro(md->disk, md->read_only || default_ro);
 	md->disk->flags = GENHD_FL_EXT_DEVT;
 	if (area_type & (MMC_BLK_DATA_AREA_RPMB | MMC_BLK_DATA_AREA_BOOT))
@@ -2458,7 +2459,7 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 	int ret;
 	struct mmc_card *card = md->queue.card;
 
-	add_disk(md->disk);
+	device_add_disk(md->parent, md->disk);
 	md->force_ro.show = force_ro_show;
 	md->force_ro.store = force_ro_store;
 	sysfs_attr_init(&md->force_ro.attr);

