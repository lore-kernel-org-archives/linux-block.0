Return-Path: <linux-block-owner@vger.kernel.org>
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:50382 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbcEJQdI (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 12:33:08 -0400
Received: from g1t5424.austin.hp.com (g1t5424.austin.hp.com [15.216.225.54])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hp.com (Postfix) with ESMTPS id 8FDEF6101C
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 16:33:07 +0000 (UTC)
From: Toshi Kani <toshi.kani@hpe.com>
To: dan.j.williams@intel.com, jack@suse.cz, david@fromorbit.com,
	viro@zeniv.linux.org.uk
Cc: axboe@fb.com, hch@infradead.org, boaz@plexistor.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, ross.zwisler@linux.intel.com,
	toshi.kani@hpe.com, micah.parrish@hpe.com,
	linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/6] ext4: Add alignment check for DAX mount
Date: Tue, 10 May 2016 10:23:54 -0600
Message-Id: <1462897437-16626-4-git-send-email-toshi.kani@hpe.com>
In-Reply-To: <1462897437-16626-1-git-send-email-toshi.kani@hpe.com>
References: <1462897437-16626-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When a partition is not aligned by 4KB, mount -o dax succeeds,
but any read/write access to the filesystem fails, except for
metadata update.

Call bdev_dax_supported() to perform proper precondition checks
which includes this partition alignment check.

Reported-by: Micah Parrish <micah.parrish@hpe.com>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Boaz Harrosh <boaz@plexistor.com>
---
 fs/ext4/super.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 304c712..6925e86 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3416,16 +3416,9 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	if (sbi->s_mount_opt & EXT4_MOUNT_DAX) {
-		if (blocksize != PAGE_SIZE) {
-			ext4_msg(sb, KERN_ERR,
-					"error: unsupported blocksize for dax");
-			goto failed_mount;
-		}
-		if (!sb->s_bdev->bd_disk->fops->direct_access) {
-			ext4_msg(sb, KERN_ERR,
-					"error: device does not support dax");
+		err = bdev_dax_supported(sb, blocksize);
+		if (err)
 			goto failed_mount;
-		}
 	}
 
 	if (ext4_has_feature_encrypt(sb) && es->s_encryption_level) {
