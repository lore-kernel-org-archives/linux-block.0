Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Toshi Kani <toshi.kani@hpe.com>
To: dan.j.williams@intel.com, jack@suse.cz, david@fromorbit.com,
	viro@zeniv.linux.org.uk
Cc: axboe@fb.com, hch@infradead.org, boaz@plexistor.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, ross.zwisler@linux.intel.com,
	toshi.kani@hpe.com, micah.parrish@hpe.com,
	linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] Add alignment check for DAX mount
Date: Tue, 10 May 2016 10:23:51 -0600
Message-Id: <1462897437-16626-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

When a partition is not aligned by 4KB, mount -o dax succeeds,
but any read/write access to the filesystem fails, except for
metadata update.  Add alignment check to ext4, ext2, and xfs.

- Patch 1-2 add bdev_dax_supported() which performs all the checks
  necessary for dax mount.
- Patch 3-5 change fillesystems to call bdev_dax_supported().
- Patch 6 is a cleanup to keep dax capability checks consistent.

v4:
 - blkdev_dax_capable() is similar to bdev_dax_supported().
   Manage them consistently. (Dan Williams, Dave Chinner)

v3:
 - Remove boilerplate code from filesytems (Christoph Hellwig)
 - Add a helper function to perform all checks (Dave Chinner)

v2:
 - Use a helper function via ->direct_access for the check.
   (Christoph Hellwig)
 - Call bdev_direct_access() with sector 0 for the check.
   (Boaz Harrosh)

---
Toshi Kani (6):
 1/6 block: Add vfs_msg() interface
 2/6 block: Add bdev_dax_supported() for dax mount checks
 3/6 ext4: Add alignment check for DAX mount
 4/6 ext2: Add alignment check for DAX mount
 5/6 xfs: Add alignment check for DAX mount
 6/6 block: Update blkdev_dax_capable() for consistency

---
 block/ioctl.c          | 30 ----------------
 fs/block_dev.c         | 96 ++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/ext2/super.c        | 11 ++----
 fs/ext4/super.c        | 11 ++----
 fs/xfs/xfs_super.c     | 12 +++----
 include/linux/blkdev.h | 13 +++++++
 include/linux/fs.h     |  8 -----
 7 files changed, 116 insertions(+), 65 deletions(-)
