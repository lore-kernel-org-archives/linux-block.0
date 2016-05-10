Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Toshi Kani <toshi.kani@hpe.com>
To: dan.j.williams@intel.com, jack@suse.cz, david@fromorbit.com,
	viro@zeniv.linux.org.uk
Cc: axboe@fb.com, hch@infradead.org, boaz@plexistor.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, ross.zwisler@linux.intel.com,
	toshi.kani@hpe.com, micah.parrish@hpe.com,
	linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] ext2: Add alignment check for DAX mount
Date: Tue, 10 May 2016 10:23:55 -0600
Message-Id: <1462897437-16626-5-git-send-email-toshi.kani@hpe.com>
In-Reply-To: <1462897437-16626-1-git-send-email-toshi.kani@hpe.com>
References: <1462897437-16626-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

When a partition is not aligned by 4KB, mount -o dax succeeds,
but any read/write access to the filesystem fails, except for
metadata update.

Call bdev_dax_supported() to perform proper precondition checks
which includes this partition alignment check.

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Boaz Harrosh <boaz@plexistor.com>
---
 fs/ext2/super.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index b78caf2..1d93795 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -922,16 +922,9 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
 
 	if (sbi->s_mount_opt & EXT2_MOUNT_DAX) {
-		if (blocksize != PAGE_SIZE) {
-			ext2_msg(sb, KERN_ERR,
-					"error: unsupported blocksize for dax");
+		err = bdev_dax_supported(sb, blocksize);
+		if (err)
 			goto failed_mount;
-		}
-		if (!sb->s_bdev->bd_disk->fops->direct_access) {
-			ext2_msg(sb, KERN_ERR,
-					"error: device does not support dax");
-			goto failed_mount;
-		}
 	}
 
 	/* If the blocksize doesn't match, re-read the thing.. */
