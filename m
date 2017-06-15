Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/11] fs: add O_DIRECT support for sending down bio stream information
Date: Wed, 14 Jun 2017 21:45:07 -0600
Message-Id: <1497498312-17704-7-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 2 ++
 fs/direct-io.c | 2 ++
 fs/iomap.c     | 1 +
 3 files changed, 5 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 519599dddd36..de4301168710 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -239,6 +239,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 			should_dirty = true;
 	} else {
 		bio.bi_opf = dio_bio_write_op(iocb);
+		bio.bi_opf |= bio_op_write_hint(iocb_write_hint(iocb));
 		task_io_account_write(ret);
 	}
 
@@ -374,6 +375,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 				bio_set_pages_dirty(bio);
 		} else {
 			bio->bi_opf = dio_bio_write_op(iocb);
+			bio->bi_opf |= bio_op_write_hint(iocb_write_hint(iocb));
 			task_io_account_write(bio->bi_iter.bi_size);
 		}
 
diff --git a/fs/direct-io.c b/fs/direct-io.c
index a04ebea77de8..98874478ec8a 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -386,6 +386,8 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	else
 		bio->bi_end_io = dio_bio_end_io;
 
+	bio->bi_opf |= bio_op_write_hint(iocb_write_hint(dio->iocb));
+
 	sdio->bio = bio;
 	sdio->logical_offset_in_bio = sdio->cur_page_fs_offset;
 }
diff --git a/fs/iomap.c b/fs/iomap.c
index 4b10892967a5..7e18e760e421 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -804,6 +804,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 
 		if (dio->flags & IOMAP_DIO_WRITE) {
 			bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_SYNC | REQ_IDLE);
+			bio->bi_opf |= bio_op_write_hint(inode_write_hint(inode));
 			task_io_account_write(bio->bi_iter.bi_size);
 		} else {
 			bio_set_op_attrs(bio, REQ_OP_READ, 0);
-- 
2.7.4
