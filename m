Return-Path: <linux-block-owner@vger.kernel.org>
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:50389 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbcEJQdN (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 12:33:13 -0400
Received: from g1t5424.austin.hp.com (g1t5424.austin.hp.com [15.216.225.54])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hp.com (Postfix) with ESMTPS id 2D91761232
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 16:33:12 +0000 (UTC)
From: Toshi Kani <toshi.kani@hpe.com>
To: dan.j.williams@intel.com, jack@suse.cz, david@fromorbit.com,
	viro@zeniv.linux.org.uk
Cc: axboe@fb.com, hch@infradead.org, boaz@plexistor.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, ross.zwisler@linux.intel.com,
	toshi.kani@hpe.com, micah.parrish@hpe.com,
	linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] xfs: Add alignment check for DAX mount
Date: Tue, 10 May 2016 10:23:56 -0600
Message-Id: <1462897437-16626-6-git-send-email-toshi.kani@hpe.com>
In-Reply-To: <1462897437-16626-1-git-send-email-toshi.kani@hpe.com>
References: <1462897437-16626-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When a partition is not aligned by 4KB, mount -o dax succeeds,
but any read/write access to the filesystem fails, except for
metadata update.

Call bdev_dax_supported() to perform proper precondition checks
which includes this partition alignment check.

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Boaz Harrosh <boaz@plexistor.com>
---
 fs/xfs/xfs_super.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 187e14b..39f4e6a 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1558,14 +1558,12 @@ xfs_fs_fill_super(
 
 	if (mp->m_flags & XFS_MOUNT_DAX) {
 		xfs_warn(mp,
-	"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
-		if (sb->s_blocksize != PAGE_SIZE) {
-			xfs_alert(mp,
-		"Filesystem block size invalid for DAX Turning DAX off.");
-			mp->m_flags &= ~XFS_MOUNT_DAX;
-		} else if (!sb->s_bdev->bd_disk->fops->direct_access) {
+		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
+
+		error = bdev_dax_supported(sb, sb->s_blocksize);
+		if (error) {
 			xfs_alert(mp,
-		"Block device does not support DAX Turning DAX off.");
+			"DAX unsupported by block device. Turning off DAX.");
 			mp->m_flags &= ~XFS_MOUNT_DAX;
 		}
 	}
