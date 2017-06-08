Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Omar Sandoval <osandov@fb.com>,
	Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv8 1/2] loop: Remove unused 'bdev' argument from loop_set_capacity
Date: Thu,  8 Jun 2017 13:46:44 +0200
Message-Id: <1496922405-38302-2-git-send-email-hare@suse.de>
In-Reply-To: <1496922405-38302-1-git-send-email-hare@suse.de>
References: <1496922405-38302-1-git-send-email-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 28d9329..fc706ad 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1303,7 +1303,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	return err;
 }
 
-static int loop_set_capacity(struct loop_device *lo, struct block_device *bdev)
+static int loop_set_capacity(struct loop_device *lo)
 {
 	if (unlikely(lo->lo_state != Lo_bound))
 		return -ENXIO;
@@ -1366,7 +1366,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_SET_CAPACITY:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
-			err = loop_set_capacity(lo, bdev);
+			err = loop_set_capacity(lo);
 		break;
 	case LOOP_SET_DIRECT_IO:
 		err = -EPERM;
-- 
1.8.5.6
