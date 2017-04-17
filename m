Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Subject: [resend PATCH v2 16/33] block,
 dax: convert bdev_dax_supported() to dax_direct_access()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org, hch@lst.de
Date: Mon, 17 Apr 2017 12:10:16 -0700
Message-ID: <149245621655.10206.6212373965558626649.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <149245612770.10206.15496018295337908594.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <149245612770.10206.15496018295337908594.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Kill of the final user of bdev_direct_access() and struct blk_dax_ctl.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/block_dev.c |   48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 2f7885712575..ecbdc8f9f718 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -788,35 +788,43 @@ EXPORT_SYMBOL(bdev_dax_pgoff);
  */
 int bdev_dax_supported(struct super_block *sb, int blocksize)
 {
-	struct blk_dax_ctl dax = {
-		.sector = 0,
-		.size = PAGE_SIZE,
-	};
-	int err;
+	struct block_device *bdev = sb->s_bdev;
+	struct dax_device *dax_dev;
+	pgoff_t pgoff;
+	int err, id;
+	void *kaddr;
+	pfn_t pfn;
+	long len;
 
 	if (blocksize != PAGE_SIZE) {
 		vfs_msg(sb, KERN_ERR, "error: unsupported blocksize for dax");
 		return -EINVAL;
 	}
 
-	err = bdev_direct_access(sb->s_bdev, &dax);
-	if (err < 0) {
-		switch (err) {
-		case -EOPNOTSUPP:
-			vfs_msg(sb, KERN_ERR,
-				"error: device does not support dax");
-			break;
-		case -EINVAL:
-			vfs_msg(sb, KERN_ERR,
-				"error: unaligned partition for dax");
-			break;
-		default:
-			vfs_msg(sb, KERN_ERR,
-				"error: dax access failed (%d)", err);
-		}
+	err = bdev_dax_pgoff(bdev, 0, PAGE_SIZE, &pgoff);
+	if (err) {
+		vfs_msg(sb, KERN_ERR, "error: unaligned partition for dax");
 		return err;
 	}
 
+	dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
+	if (!dax_dev) {
+		vfs_msg(sb, KERN_ERR, "error: device does not support dax");
+		return -EOPNOTSUPP;
+	}
+
+	id = dax_read_lock();
+	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
+	dax_read_unlock(id);
+
+	put_dax(dax_dev);
+
+	if (len < 1) {
+		vfs_msg(sb, KERN_ERR,
+				"error: dax access failed (%d)", len);
+		return len < 0 ? len : -EIO;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(bdev_dax_supported);
