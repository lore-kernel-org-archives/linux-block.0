Return-Path: <linux-block-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:45456 "EHLO
        prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbdGUJS1 (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Fri, 21 Jul 2017 05:18:27 -0400
From: Guoqing Jiang <gqjiang@suse.com>
To: linux-block@vger.kernel.org
Cc: axboe@fb.com, Guoqing Jiang <gqjiang@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] block: use bio_io_error directly
Date: Fri, 21 Jul 2017 17:26:24 +0800
Message-Id: <20170721092624.7144-1-gqjiang@suse.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

bio_io_error is capable of replacing the two lines.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
---
 drivers/block/drbd/drbd_int.h | 3 +--
 drivers/md/dm-mpath.c         | 3 +--
 drivers/nvme/target/io-cmd.c  | 3 +--
 fs/block_dev.c                | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index d17b6e6..dd21a1b 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1630,8 +1630,7 @@ static inline void drbd_generic_make_request(struct drbd_device *device,
 	__release(local);
 	if (!bio->bi_bdev) {
 		drbd_err(device, "drbd_generic_make_request: bio->bi_bdev == NULL\n");
-		bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
+		bio_io_error(bio);
 		return;
 	}
 
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index 0e8ab5b..aa6dcc4 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -623,8 +623,7 @@ static void process_queued_bios(struct work_struct *work)
 		r = __multipath_map_bio(m, bio, get_mpio_from_bio(bio));
 		switch (r) {
 		case DM_MAPIO_KILL:
-			bio->bi_status = BLK_STS_IOERR;
-			bio_endio(bio);
+			bio_io_error(bio);
 			break;
 		case DM_MAPIO_REQUEUE:
 			bio->bi_status = BLK_STS_DM_REQUEUE;
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 3b4d47a..46baf19 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -145,8 +145,7 @@ static void nvmet_execute_discard(struct nvmet_req *req)
 		bio->bi_private = req;
 		bio->bi_end_io = nvmet_bio_done;
 		if (status) {
-			bio->bi_status = BLK_STS_IOERR;
-			bio_endio(bio);
+			bio_io_error(bio);
 		} else {
 			submit_bio(bio);
 		}
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9941dc8..3ceb8f4 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -370,8 +370,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 
 		ret = bio_iov_iter_get_pages(bio, iter);
 		if (unlikely(ret)) {
-			bio->bi_status = BLK_STS_IOERR;
-			bio_endio(bio);
+			bio_io_error(bio);
 			break;
 		}
 
-- 
2.10.0
