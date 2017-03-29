Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33825 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756082AbdC2K4d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2017 06:56:33 -0400
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.cz>, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 13/25] mtd: Convert to dynamically allocated bdi infrastructure
Date: Wed, 29 Mar 2017 12:56:11 +0200
Message-Id: <20170329105623.18241-14-jack@suse.cz>
In-Reply-To: <20170329105623.18241-1-jack@suse.cz>
References: <20170329105623.18241-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

MTD already allocates backing_dev_info dynamically. Convert it to use
generic infrastructure for this including proper refcounting. We drop
mtd->backing_dev_info as its only use was to pass mtd_bdi pointer from
one file into another and if we wanted to keep that in a clean way, we'd
have to make mtd hold and drop bdi reference as needed which seems
pointless for passing one global pointer...

CC: David Woodhouse <dwmw2@infradead.org>
CC: Brian Norris <computersforpeace@gmail.com>
CC: linux-mtd@lists.infradead.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/mtd/mtdcore.c   | 23 ++++++++++++-----------
 drivers/mtd/mtdsuper.c  |  7 ++++++-
 include/linux/mtd/mtd.h |  5 -----
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 66a9dedd1062..23e2e56ca54e 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -46,7 +46,7 @@
 
 #include "mtdcore.h"
 
-static struct backing_dev_info *mtd_bdi;
+struct backing_dev_info *mtd_bdi;
 
 #ifdef CONFIG_PM_SLEEP
 
@@ -496,11 +496,9 @@ int add_mtd_device(struct mtd_info *mtd)
 	 * mtd_device_parse_register() multiple times on the same master MTD,
 	 * especially with CONFIG_MTD_PARTITIONED_MASTER=y.
 	 */
-	if (WARN_ONCE(mtd->backing_dev_info, "MTD already registered\n"))
+	if (WARN_ONCE(mtd->dev.type, "MTD already registered\n"))
 		return -EEXIST;
 
-	mtd->backing_dev_info = mtd_bdi;
-
 	BUG_ON(mtd->writesize == 0);
 	mutex_lock(&mtd_table_mutex);
 
@@ -1775,13 +1773,18 @@ static struct backing_dev_info * __init mtd_bdi_init(char *name)
 	struct backing_dev_info *bdi;
 	int ret;
 
-	bdi = kzalloc(sizeof(*bdi), GFP_KERNEL);
+	bdi = bdi_alloc(GFP_KERNEL);
 	if (!bdi)
 		return ERR_PTR(-ENOMEM);
 
-	ret = bdi_setup_and_register(bdi, name);
+	bdi->name = name;
+	/*
+	 * We put '-0' suffix to the name to get the same name format as we
+	 * used to get. Since this is called only once, we get a unique name. 
+	 */
+	ret = bdi_register(bdi, NULL, "%.28s-0", name);
 	if (ret)
-		kfree(bdi);
+		bdi_put(bdi);
 
 	return ret ? ERR_PTR(ret) : bdi;
 }
@@ -1813,8 +1816,7 @@ static int __init init_mtd(void)
 out_procfs:
 	if (proc_mtd)
 		remove_proc_entry("mtd", NULL);
-	bdi_destroy(mtd_bdi);
-	kfree(mtd_bdi);
+	bdi_put(mtd_bdi);
 err_bdi:
 	class_unregister(&mtd_class);
 err_reg:
@@ -1828,8 +1830,7 @@ static void __exit cleanup_mtd(void)
 	if (proc_mtd)
 		remove_proc_entry("mtd", NULL);
 	class_unregister(&mtd_class);
-	bdi_destroy(mtd_bdi);
-	kfree(mtd_bdi);
+	bdi_put(mtd_bdi);
 	idr_destroy(&mtd_idr);
 }
 
diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index 20c02a3b7417..e69e7855e31f 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -18,6 +18,7 @@
 #include <linux/ctype.h>
 #include <linux/slab.h>
 #include <linux/major.h>
+#include <linux/backing-dev.h>
 
 /*
  * compare superblocks to see if they're equivalent
@@ -38,6 +39,8 @@ static int get_sb_mtd_compare(struct super_block *sb, void *_mtd)
 	return 0;
 }
 
+extern struct backing_dev_info *mtd_bdi;
+
 /*
  * mark the superblock by the MTD device it is using
  * - set the device number to be the correct MTD block device for pesuperstence
@@ -49,7 +52,9 @@ static int get_sb_mtd_set(struct super_block *sb, void *_mtd)
 
 	sb->s_mtd = mtd;
 	sb->s_dev = MKDEV(MTD_BLOCK_MAJOR, mtd->index);
-	sb->s_bdi = mtd->backing_dev_info;
+	sb->s_bdi = bdi_get(mtd_bdi);
+	sb->s_iflags |= SB_I_DYNBDI;
+
 	return 0;
 }
 
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index eebdc63cf6af..79b176eca04a 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -334,11 +334,6 @@ struct mtd_info {
 	int (*_get_device) (struct mtd_info *mtd);
 	void (*_put_device) (struct mtd_info *mtd);
 
-	/* Backing device capabilities for this device
-	 * - provides mmap capabilities
-	 */
-	struct backing_dev_info *backing_dev_info;
-
 	struct notifier_block reboot_notifier;  /* default mode before reboot */
 
 	/* ECC status information */
-- 
2.10.2
