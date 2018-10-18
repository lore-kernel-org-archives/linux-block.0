Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Dave Chinner <dchinner@redhat.com>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"Darrick J . Wong" <darrick.wong@oracle.com>,
	xfs@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 4/5] block: introduce helpers for allocating IO buffers from slab
Date: Thu, 18 Oct 2018 21:18:16 +0800
Message-Id: <20181018131817.11813-5-ming.lei@redhat.com>
In-Reply-To: <20181018131817.11813-1-ming.lei@redhat.com>
References: <20181018131817.11813-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

One big issue is that the allocated buffer from slab has to respect
the queue DMA alignment limit.

This patch supports to create one kmem_cache for less-than PAGE_SIZE
allocation, and makes sure that the allocation is aligned with queue
DMA alignment.

For >= PAGE_SIZE allocation, it should be done via buddy directly.

Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: xfs@vger.kernel.org
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/Makefile              |   3 +-
 block/blk-core.c            |   2 +
 block/blk-sec-buf.c         | 144 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-sec-buf.h |  43 +++++++++++++
 include/linux/blkdev.h      |   5 ++
 5 files changed, 196 insertions(+), 1 deletion(-)
 create mode 100644 block/blk-sec-buf.c
 create mode 100644 include/linux/blk-sec-buf.h

diff --git a/block/Makefile b/block/Makefile
index 27eac600474f..74f3ed6ef954 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -9,7 +9,8 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-tag.o blk-sysfs.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
 			genhd.o partition-generic.o ioprio.o \
-			badblocks.o partitions/ blk-rq-qos.o
+			badblocks.o partitions/ blk-rq-qos.o \
+			blk-sec-buf.o
 
 obj-$(CONFIG_BOUNCE)		+= bounce.o
 obj-$(CONFIG_BLK_SCSI_REQUEST)	+= scsi_ioctl.o
diff --git a/block/blk-core.c b/block/blk-core.c
index cdfabc5646da..02fe17dd5e67 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1079,6 +1079,8 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
 	if (blkcg_init_queue(q))
 		goto fail_ref;
 
+	mutex_init(&q->blk_sec_buf_slabs_mutex);
+
 	return q;
 
 fail_ref:
diff --git a/block/blk-sec-buf.c b/block/blk-sec-buf.c
new file mode 100644
index 000000000000..2842a913a3d1
--- /dev/null
+++ b/block/blk-sec-buf.c
@@ -0,0 +1,144 @@
+/*
+ * Sector size level IO buffer allocation helpers for less-than PAGE_SIZE
+ * allocation.
+ *
+ * Controllers may has DMA alignment requirement, meantime filesystem or
+ * other upper layer component may allocate IO buffer via slab and submit
+ * bio with this buffer directly. Then DMA alignment limit can't be
+ * repectected.
+ *
+ * Create DMA aligned slab, and allocate this less-than PAGE_SIZE IO buffer
+ * from the created slab for above users.
+ *
+ * Copyright (C) 2018 Ming Lei <ming.lei@redhat.com>
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/blk-sec-buf.h>
+
+static void __blk_destroy_sec_buf_slabs(struct blk_sec_buf_slabs *slabs)
+{
+	int i;
+
+	if (!slabs)
+		return;
+
+	for (i = 0; i < BLK_NR_SEC_BUF_SLAB; i++)
+		kmem_cache_destroy(slabs->slabs[i]);
+	kfree(slabs);
+}
+
+void blk_destroy_sec_buf_slabs(struct request_queue *q)
+{
+	mutex_lock(&q->blk_sec_buf_slabs_mutex);
+	if (q->sec_buf_slabs && !--q->sec_buf_slabs->ref_cnt) {
+		__blk_destroy_sec_buf_slabs(q->sec_buf_slabs);
+		q->sec_buf_slabs = NULL;
+	}
+	mutex_unlock(&q->blk_sec_buf_slabs_mutex);
+}
+EXPORT_SYMBOL_GPL(blk_destroy_sec_buf_slabs);
+
+int blk_create_sec_buf_slabs(char *name, struct request_queue *q)
+{
+	struct blk_sec_buf_slabs *slabs;
+	char *slab_name;
+	int i;
+	int nr_slabs = BLK_NR_SEC_BUF_SLAB;
+	int ret = -ENOMEM;
+
+	/* No need to create kmem_cache if kmalloc is fine */
+	if (!q || queue_dma_alignment(q) < ARCH_KMALLOC_MINALIGN)
+		return 0;
+
+	slab_name = kmalloc(strlen(name) + 5, GFP_KERNEL);
+	if (!slab_name)
+		return ret;
+
+	mutex_lock(&q->blk_sec_buf_slabs_mutex);
+	if (q->sec_buf_slabs) {
+		q->sec_buf_slabs->ref_cnt++;
+		ret = 0;
+		goto out;
+	}
+
+	slabs = kzalloc(sizeof(*slabs), GFP_KERNEL);
+	if (!slabs)
+		goto out;
+
+	for (i = 0; i < nr_slabs; i++) {
+		int size = (i == nr_slabs - 1) ? PAGE_SIZE - 512 : (i + 1) << 9;
+
+		sprintf(slab_name, "%s-%d", name, i);
+		slabs->slabs[i] = kmem_cache_create(slab_name, size,
+				queue_dma_alignment(q) + 1,
+				SLAB_PANIC, NULL);
+		if (!slabs->slabs[i])
+			goto fail;
+	}
+
+	slabs->ref_cnt = 1;
+	q->sec_buf_slabs = slabs;
+	ret = 0;
+	goto out;
+
+ fail:
+	__blk_destroy_sec_buf_slabs(slabs);
+ out:
+	mutex_unlock(&q->blk_sec_buf_slabs_mutex);
+	kfree(slab_name);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blk_create_sec_buf_slabs);
+
+void *blk_alloc_sec_buf(struct request_queue *q, int size, gfp_t flags)
+{
+	int i;
+
+	/* We only serve less-than PAGE_SIZE alloction */
+	if (size >= PAGE_SIZE)
+		return NULL;
+
+	/*
+	 * Fallback to kmalloc if no queue is provided, or kmalloc is
+	 * enough to respect the queue dma alignment
+	 */
+	if (!q || queue_dma_alignment(q) < ARCH_KMALLOC_MINALIGN)
+		return kmalloc(size, flags);
+
+	if (WARN_ON_ONCE(!q->sec_buf_slabs))
+		return NULL;
+
+	i = round_up(size, 512) >> 9;
+	i = i < BLK_NR_SEC_BUF_SLAB ? i : BLK_NR_SEC_BUF_SLAB;
+
+	return kmem_cache_alloc(q->sec_buf_slabs->slabs[i - 1], flags);
+}
+EXPORT_SYMBOL_GPL(blk_alloc_sec_buf);
+
+void blk_free_sec_buf(struct request_queue *q, void *buf, int size)
+{
+	int i;
+
+	/* We only serve less-than PAGE_SIZE alloction */
+	if (size >= PAGE_SIZE)
+		return;
+
+	/*
+	 * Fallback to kmalloc if no queue is provided, or kmalloc is
+	 * enough to respect the queue dma alignment
+	 */
+	if (!q || queue_dma_alignment(q) < ARCH_KMALLOC_MINALIGN) {
+		kfree(buf);
+		return;
+	}
+
+	if (WARN_ON_ONCE(!q->sec_buf_slabs))
+		return;
+
+	i = round_up(size, 512) >> 9;
+	i = i < BLK_NR_SEC_BUF_SLAB ? i : BLK_NR_SEC_BUF_SLAB;
+
+	kmem_cache_free(q->sec_buf_slabs->slabs[i - 1], buf);
+}
+EXPORT_SYMBOL_GPL(blk_free_sec_buf);
diff --git a/include/linux/blk-sec-buf.h b/include/linux/blk-sec-buf.h
new file mode 100644
index 000000000000..dc81d8fc0d68
--- /dev/null
+++ b/include/linux/blk-sec-buf.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_BLK_SEC_BUF_H
+#define _LINUX_BLK_SEC_BUF_H
+
+#include <linux/slab.h>
+#include <linux/blkdev.h>
+
+#define  BLK_NR_SEC_BUF_SLAB   ((PAGE_SIZE >> 9) > 128 ? 128 : (PAGE_SIZE >> 9))
+struct blk_sec_buf_slabs {
+	int ref_cnt;
+	struct kmem_cache *slabs[BLK_NR_SEC_BUF_SLAB];
+};
+
+int blk_create_sec_buf_slabs(char *name, struct request_queue *q);
+void blk_destroy_sec_buf_slabs(struct request_queue *q);
+
+void *blk_alloc_sec_buf(struct request_queue *q, int size, gfp_t flags);
+void blk_free_sec_buf(struct request_queue *q, void *buf, int size);
+
+static inline int bdev_create_sec_buf_slabs(struct block_device *bdev)
+{
+	char *name = bdev->bd_disk ? bdev->bd_disk->disk_name : "unknown";
+
+	return blk_create_sec_buf_slabs(name, bdev->bd_queue);
+}
+
+static inline void bdev_destroy_sec_buf_slabs(struct block_device *bdev)
+{
+	blk_destroy_sec_buf_slabs(bdev->bd_queue);
+}
+
+static inline void *bdev_alloc_sec_buf(struct block_device *bdev, int size,
+		gfp_t flags)
+{
+	return blk_alloc_sec_buf(bdev->bd_queue, size, flags);
+}
+static inline void bdev_free_sec_buf(struct block_device *bdev, void *buf,
+		int size)
+{
+	blk_free_sec_buf(bdev->bd_queue, buf, size);
+}
+
+#endif
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index be938a31bc2e..30f5324d1f95 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -27,6 +27,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
+#include <linux/blk-sec-buf.h>
 
 struct module;
 struct scsi_ioctl_command;
@@ -523,6 +524,10 @@ struct request_queue {
 	 */
 	gfp_t			bounce_gfp;
 
+	/* for allocate less-than PAGE_SIZE io buffer */
+	struct blk_sec_buf_slabs *sec_buf_slabs;
+	struct mutex		blk_sec_buf_slabs_mutex;
+
 	/*
 	 * protects queue structures from reentrancy. ->__queue_lock should
 	 * _never_ be used directly, it is queue private. always use
-- 
2.9.5
