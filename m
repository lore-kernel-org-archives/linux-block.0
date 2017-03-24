Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Ratna Manoj Bolla <manoj.br@gmail.com>
Subject: [PATCH 4/4] nbd: replace kill_bdev() with __invalidate_device()
Date: Fri, 24 Mar 2017 14:08:29 -0400
Message-Id: <1490378909-4056-5-git-send-email-josef@toxicpanda.com>
In-Reply-To: <1490378909-4056-1-git-send-email-josef@toxicpanda.com>
References: <1490378909-4056-1-git-send-email-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

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
Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b0003da..d8a2356 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -126,7 +126,8 @@ static const char *nbdcmd_to_ascii(int cmd)
 
 static int nbd_size_clear(struct nbd_device *nbd, struct block_device *bdev)
 {
-	bd_set_size(bdev, 0);
+	if (bdev->bd_openers <= 1)
+		bd_set_size(bdev, 0);
 	set_capacity(nbd->disk, 0);
 	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 
@@ -665,6 +666,8 @@ static void nbd_reset(struct nbd_device *nbd)
 
 static void nbd_bdev_reset(struct block_device *bdev)
 {
+	if (bdev->bd_openers > 1)
+		return;
 	set_device_ro(bdev, false);
 	bdev->bd_inode->i_size = 0;
 	if (max_part > 0) {
@@ -728,7 +731,8 @@ static int nbd_clear_sock(struct nbd_device *nbd, struct block_device *bdev)
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
2.7.4
