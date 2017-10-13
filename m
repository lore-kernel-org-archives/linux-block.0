Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:57207 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753413AbdJMMrJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id l68so21508094wmd.5
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:09 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 02/58] lightnvm: prevent bd removal if busy
Date: Fri, 13 Oct 2017 14:45:51 +0200
Message-Id: <20171013124647.32668-3-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

When a virtual block device is formatted and mounted after creating
with "nvme lnvm create... -t pblk", a removal from "nvm lnvm remove"
would result in this:

446416.309757] bdi-block not registered
[446416.309773] ------------[ cut here ]------------
[446416.309780] WARNING: CPU: 3 PID: 4319 at fs/fs-writeback.c:2159
  __mark_inode_dirty+0x268/0x340

Ideally removal should return -EBUSY as block device is mounted after
formatting.  This patch tries to address this checking if whole device
or any partition of it already mounted or not before removal.

Whole device is checked using "bd_super" member of block device.  This
member is always set once block device has been mounted using a
filesystem.  Another member "bd_part_count" takes care of checking any
if any partitions are under use.  "bd_part_count" is only updated
under locks when partitions are opened or closed (first open and last
release).  This at least does take care sending -EBUSY if removal is
being attempted while whole block device or any partition is mounted.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 60e163b..c490711 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -373,6 +373,7 @@ static void __nvm_remove_target(struct nvm_target *t)
 static int nvm_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
 {
 	struct nvm_target *t;
+	struct block_device *bdev;
 
 	mutex_lock(&dev->mlock);
 	t = nvm_find_target(dev, remove->tgtname);
@@ -380,6 +381,19 @@ static int nvm_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
 		mutex_unlock(&dev->mlock);
 		return 1;
 	}
+	bdev = bdget_disk(t->disk, 0);
+	if (!bdev) {
+		pr_err("nvm: removal failed, allocating bd failed\n");
+		mutex_unlock(&dev->mlock);
+		return -ENOMEM;
+	}
+	if (bdev->bd_super || bdev->bd_part_count) {
+		pr_err("nvm: removal failed, block device busy\n");
+		bdput(bdev);
+		mutex_unlock(&dev->mlock);
+		return -EBUSY;
+	}
+	bdput(bdev);
 	__nvm_remove_target(t);
 	mutex_unlock(&dev->mlock);
 
-- 
2.9.3
