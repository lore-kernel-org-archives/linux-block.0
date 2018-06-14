Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Mel Gorman <mgorman@suse.com>,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH] brd: Allow ramdisk to be allocated on selected NUMA node
Date: Thu, 14 Jun 2018 15:38:32 +0200
Message-Id: <20180614133832.110947-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

For performance reasons we should be able to allocate all memory
from a given NUMA node, so this patch adds a new parameter
'rd_numa_node' to allow the user to specify the NUMA node id.
When restricing fio to use the same NUMA node I'm seeing a performance
boost of more than 200%.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/block/brd.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index bb976598ee43..7142d836539e 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -36,6 +36,7 @@
  */
 struct brd_device {
 	int		brd_number;
+	int		brd_numa_node;
 
 	struct request_queue	*brd_queue;
 	struct gendisk		*brd_disk;
@@ -103,7 +104,7 @@ static struct page *brd_insert_page(struct brd_device *brd, sector_t sector)
 	 * restriction might be able to be lifted.
 	 */
 	gfp_flags = GFP_NOIO | __GFP_ZERO;
-	page = alloc_page(gfp_flags);
+	page = alloc_pages_node(brd->brd_numa_node, gfp_flags, 0);
 	if (!page)
 		return NULL;
 
@@ -342,6 +343,10 @@ static int max_part = 1;
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
 
+static int rd_numa_node = NUMA_NO_NODE;
+module_param(rd_numa_node, int, 0444);
+MODULE_PARM_DESC(rd_numa_node, "NUMA node number to allocate RAM disk on.");
+
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);
 MODULE_ALIAS("rd");
@@ -363,7 +368,7 @@ __setup("ramdisk_size=", ramdisk_size);
 static LIST_HEAD(brd_devices);
 static DEFINE_MUTEX(brd_devices_mutex);
 
-static struct brd_device *brd_alloc(int i)
+static struct brd_device *brd_alloc(int i, int node)
 {
 	struct brd_device *brd;
 	struct gendisk *disk;
@@ -372,10 +377,11 @@ static struct brd_device *brd_alloc(int i)
 	if (!brd)
 		goto out;
 	brd->brd_number		= i;
+	brd->brd_numa_node = node;
 	spin_lock_init(&brd->brd_lock);
 	INIT_RADIX_TREE(&brd->brd_pages, GFP_ATOMIC);
 
-	brd->brd_queue = blk_alloc_queue(GFP_KERNEL);
+	brd->brd_queue = blk_alloc_queue_node(GFP_KERNEL, node, NULL);
 	if (!brd->brd_queue)
 		goto out_free_dev;
 
@@ -434,7 +440,7 @@ static struct brd_device *brd_init_one(int i, bool *new)
 			goto out;
 	}
 
-	brd = brd_alloc(i);
+	brd = brd_alloc(i, rd_numa_node);
 	if (brd) {
 		add_disk(brd->brd_disk);
 		list_add_tail(&brd->brd_list, &brd_devices);
@@ -495,7 +501,7 @@ static int __init brd_init(void)
 		max_part = 1;
 
 	for (i = 0; i < rd_nr; i++) {
-		brd = brd_alloc(i);
+		brd = brd_alloc(i, rd_numa_node);
 		if (!brd)
 			goto out_free;
 		list_add_tail(&brd->brd_list, &brd_devices);
-- 
2.12.3
