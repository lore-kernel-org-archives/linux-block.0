Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Omar Sandoval <osandov@fb.com>,
	Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv7 1/2] loop: Remove unused 'bdev' argument from loop_set_capacity
Date: Fri,  7 Apr 2017 12:50:56 +0200
Message-Id: <1491562257-82574-2-git-send-email-hare@suse.de>
In-Reply-To: <1491562257-82574-1-git-send-email-hare@suse.de>
References: <1491562257-82574-1-git-send-email-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cc981f3..81b3900 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1307,7 +1307,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	return err;
 }
 
-static int loop_set_capacity(struct loop_device *lo, struct block_device *bdev)
+static int loop_set_capacity(struct loop_device *lo)
 {
 	if (unlikely(lo->lo_state != Lo_bound))
 		return -ENXIO;
@@ -1370,7 +1370,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
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
