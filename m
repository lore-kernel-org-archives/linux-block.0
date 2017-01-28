Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Subject: [RFC PATCH 04/17] dax: introduce dax_operations
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: snitzer@redhat.com, toshi.kani@hpe.com, mawilcox@microsoft.com,
        linux-block@vger.kernel.org, jmoyer@redhat.com,
        linux-fsdevel@vger.kernel.org, ross.zwisler@linux.intel.com,
        hch@lst.de
Date: Sat, 28 Jan 2017 00:36:26 -0800
Message-ID: <148559258599.11180.15865082041593158216.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <148559256378.11180.8957776806175202312.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <148559256378.11180.8957776806175202312.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Track a set of dax_operations per dax_inode that can be set at
alloc_dax_inode() time. These operations will be used to stop the abuse
of block_device_operations for communicating dax capabilities to
filesystems. It will also be used to replace the "pmem api" and move
pmem-specific cache maintenance, and other dax-driver-specific
filesystem-dax operations, to dax inode methods. In particular this
allows us to stop abusing __copy_user_nocache(), via memcpy_to_pmem(),
with a driver specific replacement.

This is a standalone introduction of the operations. Follow on patches
convert each dax-driver and teach fs/dax.c to use ->direct_access() from
dax_operations instead of block_device_operations.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/dax.h    |    4 +++-
 drivers/dax/device.c |    6 +++++-
 drivers/dax/super.c  |    6 +++++-
 include/linux/dax.h  |    5 +++++
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/dax.h b/drivers/dax/dax.h
index f33c16ed2ec6..aeb1d49aafb8 100644
--- a/drivers/dax/dax.h
+++ b/drivers/dax/dax.h
@@ -13,7 +13,9 @@
 #ifndef __DAX_H__
 #define __DAX_H__
 struct dax_inode;
-struct dax_inode *alloc_dax_inode(void *private, const char *host);
+struct dax_operations;
+struct dax_inode *alloc_dax_inode(void *private, const char *host,
+		const struct dax_operations *ops);
 void put_dax_inode(struct dax_inode *dax_inode);
 bool dax_inode_alive(struct dax_inode *dax_inode);
 void kill_dax_inode(struct dax_inode *dax_inode);
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 6d0a3241a608..c3d9405ec285 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -560,7 +560,11 @@ struct dax_dev *devm_create_dax_dev(struct dax_region *dax_region,
 		goto err_id;
 	}
 
-	dax_inode = alloc_dax_inode(dax_dev, NULL);
+	/*
+	 * No 'host' or dax_operations since there is no access to this
+	 * device outside of mmap of the resulting character device.
+	 */
+	dax_inode = alloc_dax_inode(dax_dev, NULL, NULL);
 	if (!dax_inode)
 		goto err_inode;
 
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 7ac048f94b2b..eb844ffea3cf 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -17,6 +17,7 @@
 #include <linux/cdev.h>
 #include <linux/hash.h>
 #include <linux/slab.h>
+#include <linux/dax.h>
 #include <linux/fs.h>
 
 static int nr_dax = CONFIG_NR_DEV_DAX;
@@ -61,6 +62,7 @@ struct dax_inode {
 	const char *host;
 	void *private;
 	bool alive;
+	const struct dax_operations *ops;
 };
 
 bool dax_inode_alive(struct dax_inode *dax_inode)
@@ -204,7 +206,8 @@ static void dax_add_host(struct dax_inode *dax_inode, const char *host)
 	spin_unlock(&dax_host_lock);
 }
 
-struct dax_inode *alloc_dax_inode(void *private, const char *__host)
+struct dax_inode *alloc_dax_inode(void *private, const char *__host,
+		const struct dax_operations *ops)
 {
 	struct dax_inode *dax_inode;
 	const char *host;
@@ -225,6 +228,7 @@ struct dax_inode *alloc_dax_inode(void *private, const char *__host)
 		goto err_inode;
 
 	dax_add_host(dax_inode, host);
+	dax_inode->ops = ops;
 	dax_inode->private = private;
 	return dax_inode;
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 8fe19230e118..def9a9d118c9 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -7,6 +7,11 @@
 #include <asm/pgtable.h>
 
 struct iomap_ops;
+struct dax_inode;
+struct dax_operations {
+	long (*direct_access)(struct dax_inode *, phys_addr_t, void **,
+			pfn_t *, long);
+};
 
 int dax_read_lock(void);
 void dax_read_unlock(int id);

