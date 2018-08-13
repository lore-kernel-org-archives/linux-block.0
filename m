Return-Path: <prvs=7568bcc2f=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Matias Bjorling <mb@lightnvm.io>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] block: Introduce alloc_disk_node_attr()
Date: Mon, 13 Aug 2018 10:25:30 -0700
Message-Id: <20180813172531.7451-2-bart.vanassche@wdc.com>
In-Reply-To: <20180813172531.7451-1-bart.vanassche@wdc.com>
References: <20180813172531.7451-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch does not change the behavior of any existing code but
introduces a function that will be used by the next patch.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Matias Bjorling <mb@lightnvm.io>
Cc: <stable@vger.kernel.org>
---
 block/genhd.c         | 26 ++++++++++++++++++++++++--
 include/linux/genhd.h | 13 +++++++++++--
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 8cc719a37b32..3b643152907d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1413,10 +1413,20 @@ dev_t blk_lookup_devt(const char *name, int partno)
 }
 EXPORT_SYMBOL(blk_lookup_devt);
 
-struct gendisk *__alloc_disk_node(int minors, int node_id)
+/**
+ * __alloc_disk_node - allocate a gendisk structure and initialize it
+ * @minors: number of partitions to allocate memory for
+ * @node_id: NUMA node to allocate memory from
+ * @ag: NULL or pointer to a NULL-terminated array with attribute groups that
+ *	must be attached to the disk_to_dev() of the allocated disk structure
+ */
+struct gendisk *__alloc_disk_node(int minors, int node_id,
+				  const struct attribute_group **ag)
 {
 	struct gendisk *disk;
 	struct disk_part_tbl *ptbl;
+	const struct attribute_group **agp;
+	int num_groups = 0;
 
 	if (minors > DISK_MAX_PARTS) {
 		printk(KERN_ERR
@@ -1425,7 +1435,15 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 		minors = DISK_MAX_PARTS;
 	}
 
-	disk = kzalloc_node(sizeof(struct gendisk), GFP_KERNEL, node_id);
+	if (ag) {
+		for (agp = ag; *agp; agp++)
+			num_groups++;
+		/* Only count the terminating NULL if the array is not empty. */
+		if (num_groups)
+			num_groups++;
+	}
+	disk = kzalloc_node(struct_size(disk, ag, num_groups), GFP_KERNEL,
+			    node_id);
 	if (disk) {
 		if (!init_part_stats(&disk->part0)) {
 			kfree(disk);
@@ -1461,6 +1479,10 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 		rand_initialize_disk(disk);
 		disk_to_dev(disk)->class = &block_class;
 		disk_to_dev(disk)->type = &disk_type;
+		if (num_groups) {
+			memcpy(disk->ag, ag, num_groups * sizeof(ag));
+			disk_to_dev(disk)->groups = disk->ag;
+		}
 		device_initialize(disk_to_dev(disk));
 	}
 	return disk;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 57864422a2c8..50ab6cf77fdf 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -211,6 +211,11 @@ struct gendisk {
 	int node_id;
 	struct badblocks *bb;
 	struct lockdep_map lockdep_map;
+	/*
+	 * Storage space for NULL-terminated attribute group array for
+	 * disk_to_dev() of this gendisk structure.
+	 */
+	const struct attribute_group *ag[0];
 };
 
 static inline struct gendisk *part_to_disk(struct hd_struct *part)
@@ -608,7 +613,8 @@ extern void __delete_partition(struct percpu_ref *);
 extern void delete_partition(struct gendisk *, int);
 extern void printk_all_partitions(void);
 
-extern struct gendisk *__alloc_disk_node(int minors, int node_id);
+extern struct gendisk *__alloc_disk_node(int minors, int node_id,
+					 const struct attribute_group **ag);
 extern struct kobject *get_disk_and_module(struct gendisk *disk);
 extern void put_disk(struct gendisk *disk);
 extern void put_disk_and_module(struct gendisk *disk);
@@ -634,6 +640,9 @@ extern ssize_t part_fail_store(struct device *dev,
 #endif /* CONFIG_FAIL_MAKE_REQUEST */
 
 #define alloc_disk_node(minors, node_id)				\
+	alloc_disk_node_attr(minors, node_id, NULL)
+
+#define alloc_disk_node_attr(minors, node_id, ag)			\
 ({									\
 	static struct lock_class_key __key;				\
 	const char *__name;						\
@@ -641,7 +650,7 @@ extern ssize_t part_fail_store(struct device *dev,
 									\
 	__name = "(gendisk_completion)"#minors"("#node_id")";		\
 									\
-	__disk = __alloc_disk_node(minors, node_id);			\
+	__disk = __alloc_disk_node(minors, node_id, ag);		\
 									\
 	if (__disk)							\
 		lockdep_init_map(&__disk->lockdep_map, __name, &__key, 0); \
-- 
2.18.0
