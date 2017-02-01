Return-Path: <prvs=32056f8120=jbacik@fb.com>
From: Josef Bacik <jbacik@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH] nbd: use an idr to keep track of nbd devices
Date: Wed, 1 Feb 2017 16:11:40 -0500
Message-ID: <1485983500-3830-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

To prepare for dynamically adding new nbd devices to the system switch
from using an array for the nbd devices and instead use an idr.  This
copies what loop does for keeping track of its devices.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 213 ++++++++++++++++++++++++++++------------------------
 1 file changed, 115 insertions(+), 98 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 9fe9763..96f7681 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -41,6 +41,9 @@
 
 #include <linux/nbd.h>
 
+static DEFINE_IDR(nbd_index_idr);
+static DEFINE_MUTEX(nbd_index_mutex);
+
 struct nbd_sock {
 	struct socket *sock;
 	struct mutex tx_lock;
@@ -89,9 +92,9 @@ static struct dentry *nbd_dbg_dir;
 #define NBD_MAGIC 0x68797548
 
 static unsigned int nbds_max = 16;
-static struct nbd_device *nbd_dev;
 static int max_part;
 static struct workqueue_struct *recv_workqueue;
+static int part_shift;
 
 static inline struct device *nbd_to_dev(struct nbd_device *nbd)
 {
@@ -997,6 +1000,103 @@ static struct blk_mq_ops nbd_mq_ops = {
 	.timeout	= nbd_xmit_timeout,
 };
 
+static void nbd_dev_remove(struct nbd_device *nbd)
+{
+	struct gendisk *disk = nbd->disk;
+	nbd->magic = 0;
+	if (disk) {
+		del_gendisk(disk);
+		blk_cleanup_queue(disk->queue);
+		blk_mq_free_tag_set(&nbd->tag_set);
+		put_disk(disk);
+	}
+	kfree(nbd);
+}
+
+static int nbd_dev_add(int index)
+{
+	struct nbd_device *nbd;
+	struct gendisk *disk;
+	struct request_queue *q;
+	int err = -ENOMEM;
+
+	nbd = kzalloc(sizeof(struct nbd_device), GFP_KERNEL);
+	if (!nbd)
+		goto out;
+
+	disk = alloc_disk(1 << part_shift);
+	if (!disk)
+		goto out_free_nbd;
+
+	if (index >= 0) {
+		err = idr_alloc(&nbd_index_idr, nbd, index, index + 1,
+				GFP_KERNEL);
+		if (err == -ENOSPC)
+			err = -EEXIST;
+	} else {
+		err = idr_alloc(&nbd_index_idr, nbd, 0, 0, GFP_KERNEL);
+		if (err >= 0)
+			index = err;
+	}
+	if (err < 0)
+		goto out_free_disk;
+
+	nbd->disk = disk;
+	nbd->tag_set.ops = &nbd_mq_ops;
+	nbd->tag_set.nr_hw_queues = 1;
+	nbd->tag_set.queue_depth = 128;
+	nbd->tag_set.numa_node = NUMA_NO_NODE;
+	nbd->tag_set.cmd_size = sizeof(struct nbd_cmd);
+	nbd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
+		BLK_MQ_F_SG_MERGE | BLK_MQ_F_BLOCKING;
+	nbd->tag_set.driver_data = nbd;
+
+	err = blk_mq_alloc_tag_set(&nbd->tag_set);
+	if (err)
+		goto out_free_idr;
+
+	q = blk_mq_init_queue(&nbd->tag_set);
+	if (IS_ERR(q)) {
+		err = PTR_ERR(q);
+		goto out_free_tags;
+	}
+	disk->queue = q;
+
+	/*
+	 * Tell the block layer that we are not a rotational device
+	 */
+	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, disk->queue);
+	queue_flag_clear_unlocked(QUEUE_FLAG_ADD_RANDOM, disk->queue);
+	disk->queue->limits.discard_granularity = 512;
+	blk_queue_max_discard_sectors(disk->queue, UINT_MAX);
+	disk->queue->limits.discard_zeroes_data = 0;
+	blk_queue_max_hw_sectors(disk->queue, 65536);
+	disk->queue->limits.max_sectors = 256;
+
+	nbd->magic = NBD_MAGIC;
+	mutex_init(&nbd->config_lock);
+	disk->major = NBD_MAJOR;
+	disk->first_minor = index << part_shift;
+	disk->fops = &nbd_fops;
+	disk->private_data = nbd;
+	sprintf(disk->disk_name, "nbd%d", index);
+	init_waitqueue_head(&nbd->recv_wq);
+	nbd_reset(nbd);
+	add_disk(disk);
+	return index;
+
+out_free_tags:
+	blk_mq_free_tag_set(&nbd->tag_set);
+out_free_idr:
+	idr_remove(&nbd_index_idr, index);
+out_free_disk:
+	put_disk(disk);
+out_free_nbd:
+	kfree(nbd);
+out:
+	return err;
+}
+
 /*
  * And here should be modules and kernel interface 
  *  (Just smiley confuses emacs :-)
@@ -1004,9 +1104,7 @@ static struct blk_mq_ops nbd_mq_ops = {
 
 static int __init nbd_init(void)
 {
-	int err = -ENOMEM;
 	int i;
-	int part_shift;
 
 	BUILD_BUG_ON(sizeof(struct nbd_request) != 28);
 
@@ -1040,114 +1138,33 @@ static int __init nbd_init(void)
 	if (!recv_workqueue)
 		return -ENOMEM;
 
-	nbd_dev = kcalloc(nbds_max, sizeof(*nbd_dev), GFP_KERNEL);
-	if (!nbd_dev) {
-		destroy_workqueue(recv_workqueue);
-		return -ENOMEM;
-	}
-
-	for (i = 0; i < nbds_max; i++) {
-		struct request_queue *q;
-		struct gendisk *disk = alloc_disk(1 << part_shift);
-		if (!disk)
-			goto out;
-		nbd_dev[i].disk = disk;
-
-		nbd_dev[i].tag_set.ops = &nbd_mq_ops;
-		nbd_dev[i].tag_set.nr_hw_queues = 1;
-		nbd_dev[i].tag_set.queue_depth = 128;
-		nbd_dev[i].tag_set.numa_node = NUMA_NO_NODE;
-		nbd_dev[i].tag_set.cmd_size = sizeof(struct nbd_cmd);
-		nbd_dev[i].tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
-			BLK_MQ_F_SG_MERGE | BLK_MQ_F_BLOCKING;
-		nbd_dev[i].tag_set.driver_data = &nbd_dev[i];
-
-		err = blk_mq_alloc_tag_set(&nbd_dev[i].tag_set);
-		if (err) {
-			put_disk(disk);
-			goto out;
-		}
-
-		/*
-		 * The new linux 2.5 block layer implementation requires
-		 * every gendisk to have its very own request_queue struct.
-		 * These structs are big so we dynamically allocate them.
-		 */
-		q = blk_mq_init_queue(&nbd_dev[i].tag_set);
-		if (IS_ERR(q)) {
-			blk_mq_free_tag_set(&nbd_dev[i].tag_set);
-			put_disk(disk);
-			goto out;
-		}
-		disk->queue = q;
-
-		/*
-		 * Tell the block layer that we are not a rotational device
-		 */
-		queue_flag_set_unlocked(QUEUE_FLAG_NONROT, disk->queue);
-		queue_flag_clear_unlocked(QUEUE_FLAG_ADD_RANDOM, disk->queue);
-		disk->queue->limits.discard_granularity = 512;
-		blk_queue_max_discard_sectors(disk->queue, UINT_MAX);
-		disk->queue->limits.discard_zeroes_data = 0;
-		blk_queue_max_hw_sectors(disk->queue, 65536);
-		disk->queue->limits.max_sectors = 256;
-	}
-
-	if (register_blkdev(NBD_MAJOR, "nbd")) {
-		err = -EIO;
-		goto out;
-	}
-
-	printk(KERN_INFO "nbd: registered device at major %d\n", NBD_MAJOR);
+	if (register_blkdev(NBD_MAJOR, "nbd"))
+		return -EIO;
 
 	nbd_dbg_init();
 
-	for (i = 0; i < nbds_max; i++) {
-		struct gendisk *disk = nbd_dev[i].disk;
-		nbd_dev[i].magic = NBD_MAGIC;
-		mutex_init(&nbd_dev[i].config_lock);
-		disk->major = NBD_MAJOR;
-		disk->first_minor = i << part_shift;
-		disk->fops = &nbd_fops;
-		disk->private_data = &nbd_dev[i];
-		sprintf(disk->disk_name, "nbd%d", i);
-		init_waitqueue_head(&nbd_dev[i].recv_wq);
-		nbd_reset(&nbd_dev[i]);
-		add_disk(disk);
-	}
+	mutex_lock(&nbd_index_mutex);
+	for (i = 0; i < nbds_max; i++)
+		nbd_dev_add(i);
+	mutex_unlock(&nbd_index_mutex);
+	return 0;
+}
 
+static int nbd_exit_cb(int id, void *ptr, void *data)
+{
+	struct nbd_device *nbd = ptr;
+	nbd_dev_remove(nbd);
 	return 0;
-out:
-	while (i--) {
-		blk_mq_free_tag_set(&nbd_dev[i].tag_set);
-		blk_cleanup_queue(nbd_dev[i].disk->queue);
-		put_disk(nbd_dev[i].disk);
-	}
-	kfree(nbd_dev);
-	destroy_workqueue(recv_workqueue);
-	return err;
 }
 
 static void __exit nbd_cleanup(void)
 {
-	int i;
-
 	nbd_dbg_close();
 
-	for (i = 0; i < nbds_max; i++) {
-		struct gendisk *disk = nbd_dev[i].disk;
-		nbd_dev[i].magic = 0;
-		if (disk) {
-			del_gendisk(disk);
-			blk_cleanup_queue(disk->queue);
-			blk_mq_free_tag_set(&nbd_dev[i].tag_set);
-			put_disk(disk);
-		}
-	}
+	idr_for_each(&nbd_index_idr, &nbd_exit_cb, NULL);
+	idr_destroy(&nbd_index_idr);
 	destroy_workqueue(recv_workqueue);
 	unregister_blkdev(NBD_MAJOR, "nbd");
-	kfree(nbd_dev);
-	printk(KERN_INFO "nbd: unregistered device at major %d\n", NBD_MAJOR);
 }
 
 module_init(nbd_init);
-- 
2.7.4
