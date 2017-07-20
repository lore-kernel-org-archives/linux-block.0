Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtpbg65.qq.com ([103.7.28.233]:53251 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933142AbdGTKQ4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2017 06:16:56 -0400
From: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To: linux-block@vger.kernel.org
Cc: axboe@fb.com, liuyun01@kylinos.cn
Subject: [PATCH] block/brd: add a numa_node module parameter
Date: Thu, 20 Jul 2017 18:16:37 +0800
Message-Id: <1500545797-13183-1-git-send-email-liuzhengyuan@kylinos.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Provide user a way to control which NUMA node the memory for ram
device is allocated from. The default memory allocation can fall
into more than one numa node for one raw device, with this patch
you can specify one device just allocting from one node, if not
exceed the node's total memory, and another device from a different
node as the parameter is writable.

Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 drivers/block/brd.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 17723fd5..a9e5867 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -56,10 +56,28 @@ struct brd_device {
 	struct radix_tree_root	brd_pages;
 };
 
+static DEFINE_MUTEX(brd_mutex);
+
+static int rd_numa_node = NUMA_NO_NODE;
+
+static int set_rd_numa_node(const char *val, struct kernel_param *kp)
+{
+	int ret = param_set_int(val, kp);
+	if (ret)
+		return ret;
+	mutex_lock(&brd_mutex);
+	if (rd_numa_node < NUMA_NO_NODE)
+		rd_numa_node = NUMA_NO_NODE;
+	else if (rd_numa_node > num_online_nodes() - 1)
+		rd_numa_node = num_online_nodes() - 1;
+	pr_info("setting rd_numa_node to (%d)\n", rd_numa_node);
+	mutex_unlock(&brd_mutex);
+	return 0;
+}
+
 /*
  * Look up and return a brd's page for a given sector.
  */
-static DEFINE_MUTEX(brd_mutex);
 static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 {
 	pgoff_t idx;
@@ -114,7 +132,7 @@ static struct page *brd_insert_page(struct brd_device *brd, sector_t sector)
 #ifndef CONFIG_BLK_DEV_RAM_DAX
 	gfp_flags |= __GFP_HIGHMEM;
 #endif
-	page = alloc_page(gfp_flags);
+	page = alloc_pages_node(rd_numa_node, gfp_flags, 0);
 	if (!page)
 		return NULL;
 
@@ -413,14 +431,14 @@ static struct brd_device *brd_alloc(int i)
 	struct brd_device *brd;
 	struct gendisk *disk;
 
-	brd = kzalloc(sizeof(*brd), GFP_KERNEL);
+	brd = kzalloc_node(sizeof(*brd), GFP_KERNEL, rd_numa_node);
 	if (!brd)
 		goto out;
 	brd->brd_number		= i;
 	spin_lock_init(&brd->brd_lock);
 	INIT_RADIX_TREE(&brd->brd_pages, GFP_ATOMIC);
 
-	brd->brd_queue = blk_alloc_queue(GFP_KERNEL);
+	brd->brd_queue = blk_alloc_queue_node(GFP_KERNEL, rd_numa_node);
 	if (!brd->brd_queue)
 		goto out_free_dev;
 
@@ -434,7 +452,7 @@ static struct brd_device *brd_alloc(int i)
 	 *  is harmless)
 	 */
 	blk_queue_physical_block_size(brd->brd_queue, PAGE_SIZE);
-	disk = brd->brd_disk = alloc_disk(max_part);
+	disk = brd->brd_disk = alloc_disk_node(max_part, rd_numa_node);
 	if (!disk)
 		goto out_free_queue;
 	disk->major		= RAMDISK_MAJOR;
@@ -593,6 +611,10 @@ static void __exit brd_exit(void)
 	pr_info("brd: module unloaded\n");
 }
 
+module_param_call(rd_numa_node, set_rd_numa_node, param_get_int,
+		&rd_numa_node, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(rd_numa_node, "Numa node to which memeory alloc from");
+
 module_init(brd_init);
 module_exit(brd_exit);
 
-- 
2.7.4
