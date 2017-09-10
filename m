Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:48052 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750789AbdIJTHQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Sep 2017 15:07:16 -0400
Date: Sun, 10 Sep 2017 22:07:14 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH V2] lightnvm: prevent bd removal if busy
Message-ID: <20170910190712.GA7010@hercules.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When a virtual block device is formatted and mounted after creating
with "nvme lnvm create... -t pblk", a removal from "nvm lnvm remove"
would result in this:

446416.309757] bdi-block not registered
[446416.309773] ------------[ cut here ]------------
[446416.309780] WARNING: CPU: 3 PID: 4319 at fs/fs-writeback.c:2159 __mark_inode_dirty+0x268/0x340

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
---

V2: Take a different approach. Instead of checking bd_openers use
bd_super and bd_part_count.  This should address the removal of bdevs
which are mounted from removal.

 drivers/lightnvm/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index c39f87d..9f9a137 100644
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
2.7.4
