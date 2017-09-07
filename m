Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:11022 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755053AbdIGOFd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Sep 2017 10:05:33 -0400
Date: Thu, 7 Sep 2017 16:58:27 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH] lightnvm: prevent bd removal if busy
Message-ID: <20170907135825.GA44302@dhcp-216.srv.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Removal of virtual block device by "nvm lnvm remove..." undergoing IO
and created by "nvme lnvm create... -t pblk" results in following and
is annoying.

446416.309757] bdi-block not registered
[446416.309773] ------------[ cut here ]------------
[446416.309780] WARNING: CPU: 3 PID: 4319 at fs/fs-writeback.c:2159 __mark_inode_dirty+0x268/0x340
.....

This patch solves this by checking bd_openers for each partition
before removal can continue.  Note that this isn't full proof as
device can become busy as soon as it's bd_mutex is unlocked but it
needn't be full proof either.  It does work for general case where
device is mounted and removal can be prevented.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/core.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index bbea2c8..cff91c7 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -369,6 +369,10 @@ static void __nvm_remove_target(struct nvm_target *t)
 static int nvm_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
 {
 	struct nvm_target *t;
+	struct gendisk *tdisk;
+	struct disk_part_iter piter;
+	struct hd_struct *part;
+	int err;
 
 	mutex_lock(&dev->mlock);
 	t = nvm_find_target(dev, remove->tgtname);
@@ -376,10 +380,48 @@ static int nvm_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
 		mutex_unlock(&dev->mlock);
 		return 1;
 	}
+
+	/*
+	 * Lets make sure device is not in use.  Note that this isn't full proof
+	 * in anyway (as devices can become busy after unlock) but it is useful
+	 * for preventing removal of devices which are open and undergoing IO.
+	 */
+	tdisk = t->disk;
+	disk_part_iter_init(&piter, tdisk,
+			DISK_PITER_INCL_EMPTY | DISK_PITER_INCL_PART0 |
+			DISK_PITER_INCL_EMPTY_PART0);
+	while ((part = disk_part_iter_next(&piter))) {
+		struct block_device *bdev;
+
+		bdev = bdget(part_devt(part));
+		if (!bdev) {
+			err = -ENOMEM;
+			pr_err("nvm: removal failed, allocating bd failed\n");
+			goto err_out;
+		}
+		mutex_lock(&bdev->bd_mutex);
+		if (bdev->bd_openers) {
+			mutex_unlock(&bdev->bd_mutex);
+			bdput(bdev);
+			err = -EBUSY;
+			pr_err("nvm: removal failed, block device busy\n");
+			goto err_out;
+		}
+		mutex_unlock(&bdev->bd_mutex);
+		bdput(bdev);
+	}
+	disk_part_iter_exit(&piter);
+
 	__nvm_remove_target(t);
 	mutex_unlock(&dev->mlock);
 
 	return 0;
+err_out:
+	disk_part_iter_exit(&piter);
+	disk_put_part(part);
+	mutex_unlock(&dev->mlock);
+
+	return err;
 }
 
 static int nvm_register_map(struct nvm_dev *dev)
-- 
2.7.4
