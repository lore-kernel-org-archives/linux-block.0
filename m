Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755054AbdCTW7D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2017 18:59:03 -0400
From: Ming Lin <mlin@kernel.org>
To: nbd-general@lists.sourceforge.net, Josef Bacik <jbacik@fb.com>,
        Ratna Manoj Bolla <manoj.br@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jianshu.ljs@alibaba-inc.com, xiongwei.jiang@alibaba-inc.com,
        james.liu@alibaba-inc.com, Markus Pargmann <mpa@pengutronix.de>
Subject: [RFC PATCH 1/1] nbd: replace kill_bdev() with __invalidate_device()
Date: Mon, 20 Mar 2017 15:58:49 -0700
Message-Id: <1490050729-3578-2-git-send-email-mlin@kernel.org>
In-Reply-To: <1490050729-3578-1-git-send-email-mlin@kernel.org>
References: <1490050729-3578-1-git-send-email-mlin@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Ratna Manoj Bolla <manoj.br@gmail.com>

When a filesystem is mounted on a nbd device and on a disconnect, because
of kill_bdev(), and resetting bdev size to zero, buffer_head mappings are
getting destroyed under mounted filesystem.

After a bdev size reset(i.e bdev->bd_inode->i_size = 0) on a disconnect,
followed by a sys_umount(),
        generic_shutdown_super()->...
        ->__sync_blockdev()->...
        -blkdev_writepages()->...
        ->do_invalidatepage()->...
        -discard_buffer()   is discarding superblock buffer_head assumed
to be in mapped state by ext4_commit_super().

[mlin: ported to 4.11-rc2]
Signed-off-by: Ratna Manoj Bolla <manoj.br@gmail.com
---
 drivers/block/nbd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index cb4ccfc..a6a3643 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -125,7 +125,8 @@ static const char *nbdcmd_to_ascii(int cmd)
 
 static int nbd_size_clear(struct nbd_device *nbd, struct block_device *bdev)
 {
-	bd_set_size(bdev, 0);
+	if (bdev->bd_openers <= 1)
+		bd_set_size(bdev, 0);
 	set_capacity(nbd->disk, 0);
 	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 
@@ -603,6 +604,8 @@ static void nbd_reset(struct nbd_device *nbd)
 
 static void nbd_bdev_reset(struct block_device *bdev)
 {
+	if (bdev->bd_openers > 1)
+		return;
 	set_device_ro(bdev, false);
 	bdev->bd_inode->i_size = 0;
 	if (max_part > 0) {
@@ -666,7 +669,8 @@ static int nbd_clear_sock(struct nbd_device *nbd, struct block_device *bdev)
 {
 	sock_shutdown(nbd);
 	nbd_clear_que(nbd);
-	kill_bdev(bdev);
+
+	__invalidate_device(bdev, true);
 	nbd_bdev_reset(bdev);
 	/*
 	 * We want to give the run thread a chance to wait for everybody
-- 
1.8.3.1
