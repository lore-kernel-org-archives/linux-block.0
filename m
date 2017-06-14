Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/10] fs: add O_DIRECT support for sending down bio stream information
Date: Tue, 13 Jun 2017 22:01:54 -0600
Message-Id: <1497412919-19400-6-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 2 ++
 fs/direct-io.c | 2 ++
 fs/iomap.c     | 1 +
 3 files changed, 5 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 519599dddd36..284b8a786283 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -227,6 +227,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	bio.bi_iter.bi_sector = pos >> 9;
 	bio.bi_private = current;
 	bio.bi_end_io = blkdev_bio_end_io_simple;
+	bio.bi_stream = iocb_streamid(iocb);
 
 	ret = bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
@@ -360,6 +361,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		bio->bi_iter.bi_sector = pos >> 9;
 		bio->bi_private = dio;
 		bio->bi_end_io = blkdev_bio_end_io;
+		bio->bi_stream = iocb_streamid(iocb);
 
 		ret = bio_iov_iter_get_pages(bio, iter);
 		if (unlikely(ret)) {
diff --git a/fs/direct-io.c b/fs/direct-io.c
index a04ebea77de8..c9c8b9fd4329 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -386,6 +386,8 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	else
 		bio->bi_end_io = dio_bio_end_io;
 
+	bio->bi_stream = iocb_streamid(dio->iocb);
+
 	sdio->bio = bio;
 	sdio->logical_offset_in_bio = sdio->cur_page_fs_offset;
 }
diff --git a/fs/iomap.c b/fs/iomap.c
index 4b10892967a5..fa7d29632fbc 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -804,6 +804,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 
 		if (dio->flags & IOMAP_DIO_WRITE) {
 			bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_SYNC | REQ_IDLE);
+			bio_set_streamid(bio, inode_streamid(inode));
 			task_io_account_write(bio->bi_iter.bi_size);
 		} else {
 			bio_set_op_attrs(bio, REQ_OP_READ, 0);
-- 
2.7.4
