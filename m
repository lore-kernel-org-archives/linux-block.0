Return-Path: <sth@linux.vnet.ibm.com>
From: Stefan Haberland <sth@linux.vnet.ibm.com>
To: hch@infradead.org, damien.lemoal@wdc.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: hoeppner@linux.vnet.ibm.com, sebott@linux.vnet.ibm.com
Subject: [v2] block: check partition alignment
Date: Mon, 19 Dec 2016 17:15:50 +0100
In-Reply-To: <20161219161550.55414-1-sth@linux.vnet.ibm.com>
References: <20161219161550.55414-1-sth@linux.vnet.ibm.com>
In-Reply-To: <88308b2d-de52-b97a-2001-96da7e9f5d1f@wdc.com>
References: <88308b2d-de52-b97a-2001-96da7e9f5d1f@wdc.com>
Message-Id: <20161219161550.55414-2-sth@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

Partitions that are not aligned to the blocksize of a device may cause
invalid I/O requests because the blocklayer cares only about alignment
within the partition when building requests on partitions.

device
|--------4096--------|--------4096--------|--------4096--------|
partition offset 512byte
|-512-|--------4096--------|--------4096--------|--------4096--------|

When reading/writing one 4k block of the partition this maps to
reading/writing with an offset of 512 byte of the device leading to
unaligned requests for the device which in turn may cause unexpected
behavior of the device driver.

For DASD devices we have to translate the block number into a cylinder,
head, record format. The unaligned requests lead to wrong calculation
and therefore to misdirected I/O. In a "good" case this leads to I/O
errors because the underlying hardware detects the wrong addressing.
In a worst case scenario this might destroy data on the device.

To prevent partitions that are not aligned to the physical blocksize
of a device check for the alignment in the blkpg_ioctl.

Signed-off-by: Stefan Haberland <sth@linux.vnet.ibm.com>
---
 block/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 755119c..36b5c21 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -45,6 +45,9 @@ static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user
 				    || pstart < 0 || plength < 0 || partno > 65535)
 					return -EINVAL;
 			}
+			/* check if partition is aligned to blocksize */
+			if (p.start & (bdev_logical_block_size(bdev) - 1))
+				return -EINVAL;
 
 			mutex_lock(&bdev->bd_mutex);
 
-- 
2.8.4
