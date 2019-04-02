Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADEFC4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 12:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455A320883
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 12:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfDBMCk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:02:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6213 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726903AbfDBMCk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Apr 2019 08:02:40 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [10.3.19.206])
        by Forcepoint Email with ESMTP id 201D3BFED204050679AA;
        Tue,  2 Apr 2019 20:02:38 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Tue, 2 Apr 2019
 20:02:35 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <jack@suse.cz>
CC:     <viro@zeniv.linux.org.uk>, <bart.vanassche@wdc.com>,
        <linux-block@vger.kernel.org>
Subject: [PATCH v3] block: fix use-after-free on gendisk
Date:   Tue, 2 Apr 2019 20:06:34 +0800
Message-ID: <20190402120634.51040-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

commit 2da78092dda "block: Fix dev_t minor allocation lifetime"
specifically moved blk_free_devt(dev->devt) call to part_release()
to avoid reallocating device number before the device is fully
shutdown.

However, it can cause use-after-free on gendisk in get_gendisk().
We use md device as example to show the race scenes:

Process1		Worker			Process2
md_free
						blkdev_open
del_gendisk
  add delete_partition_work_fn() to wq
  						__blkdev_get
						get_gendisk
put_disk
  disk_release
    kfree(disk)
    						find part from ext_devt_idr
						get_disk_and_module(disk)
    					  	cause use after free

    			delete_partition_work_fn
			put_device(part)
    		  	part_release
		    	remove part from ext_devt_idr

Before <devt, hd_struct pointer> is removed from ext_devt_idr by
delete_partition_work_fn(), we can find the devt and then access
gendisk by hd_struct pointer. But, if we access the gendisk after
it have been freed, it can cause in use-after-freeon gendisk in
get_gendisk().

We fix this by adding a new helper blk_invalidate_devt() in
delete_partition() and del_gendisk(). It replaces hd_struct
pointer in idr with value 'NULL', and deletes the entry from
idr in part_release() as we do now.

Thanks to Jan Kara for providing the solution and more clear comments
for the code.

Fixes: 2da78092dda1 ("block: Fix dev_t minor allocation lifetime")
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/genhd.c             | 19 +++++++++++++++++++
 block/partition-generic.c |  7 +++++++
 include/linux/genhd.h     |  1 +
 3 files changed, 27 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 961b2bc4634f..a4ef0068dbb2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -529,6 +529,18 @@ void blk_free_devt(dev_t devt)
 	}
 }
 
+/**
+ *	We invalidate devt by assigning NULL pointer for devt in idr.
+ */
+void blk_invalidate_devt(dev_t devt)
+{
+	if (MAJOR(devt) == BLOCK_EXT_MAJOR) {
+		spin_lock_bh(&ext_devt_lock);
+		idr_replace(&ext_devt_idr, NULL, blk_mangle_minor(MINOR(devt)));
+		spin_unlock_bh(&ext_devt_lock);
+	}
+}
+
 static char *bdevt_str(dev_t devt, char *buf)
 {
 	if (MAJOR(devt) <= 0xff && MINOR(devt) <= 0xff) {
@@ -791,6 +803,13 @@ void del_gendisk(struct gendisk *disk)
 
 	if (!(disk->flags & GENHD_FL_HIDDEN))
 		blk_unregister_region(disk_devt(disk), disk->minors);
+	/*
+	 * Remove gendisk pointer from idr so that it cannot be looked up
+	 * while RCU period before freeing gendisk is running to prevent
+	 * use-after-free issues. Note that the device number stays
+	 * "in-use" until we really free the gendisk.
+	 */
+	blk_invalidate_devt(disk_devt(disk));
 
 	kobject_put(disk->part0.holder_dir);
 	kobject_put(disk->slave_dir);
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 1ee3e1d1bc2a..7cf769103a25 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -288,6 +288,13 @@ void delete_partition(struct gendisk *disk, int partno)
 	kobject_put(part->holder_dir);
 	device_del(part_to_dev(part));
 
+	/*
+	 * Remove gendisk pointer from idr so that it cannot be looked up
+	 * while RCU period before freeing gendisk is running to prevent
+	 * use-after-free issues. Note that the device number stays
+	 * "in-use" until we really free the gendisk.
+	 */
+	blk_invalidate_devt(part_devt(part));
 	hd_struct_kill(part);
 }
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 06c0fd594097..69db1affedb0 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -610,6 +610,7 @@ struct unixware_disklabel {
 
 extern int blk_alloc_devt(struct hd_struct *part, dev_t *devt);
 extern void blk_free_devt(dev_t devt);
+extern void blk_invalidate_devt(dev_t devt);
 extern dev_t blk_lookup_devt(const char *name, int partno);
 extern char *disk_name (struct gendisk *hd, int partno, char *buf);
 
-- 
2.16.2.dirty

