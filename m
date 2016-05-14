Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:34601 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932178AbcENAE3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Fri, 13 May 2016 20:04:29 -0400
From: Jon Derrick <jonathan.derrick@intel.com>
To: linux-block@vger.kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	"Jens Axboe" <axboe@fb.com>,
	"Alexander Viro" <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	"Dan Williams" <dan.j.williams@intel.com>,
	"Jeff Moyer" <jmoyer@redhat.com>,
	"Stephen Bates" <stephen.bates@microsemi.com>,
	"Keith Busch" <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	"Christoph Hellwig" <hch@infradead.org>
Subject: [RFCv2 1/3] block: allow other bd i_node flags when DAX is disabled
Date: Fri, 13 May 2016 18:02:46 -0600
Message-Id: <1463184168-3381-2-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1463184168-3381-1-git-send-email-jonathan.derrick@intel.com>
References: <1463184168-3381-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When DAX is not compiled into the kernel or the device does not support
direct-access, the block device file's inode flags are fully cleared.
This patch changes it to only clear the S_DAX flag when DAX is disabled.

This reverts to i_flags behavior prior to
bbab37ddc20bae4709bca8745c128c4f46fe63c5

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 fs/block_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 20a2c02..d4fa725 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1208,7 +1208,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 		if (IS_ENABLED(CONFIG_BLK_DEV_DAX) && disk->fops->direct_access)
 			bdev->bd_inode->i_flags = S_DAX;
 		else
-			bdev->bd_inode->i_flags = 0;
+			bdev->bd_inode->i_flags &= ~S_DAX;
 
 		if (!partno) {
 			ret = -ENXIO;
-- 
1.8.3.1

