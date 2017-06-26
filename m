Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	hch@lst.de,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/9] fs: add O_DIRECT support for sending down write life time hints
Date: Mon, 26 Jun 2017 09:37:55 -0600
Message-Id: <1498491480-16306-5-git-send-email-axboe@kernel.dk>
In-Reply-To: <1498491480-16306-1-git-send-email-axboe@kernel.dk>
References: <1498491480-16306-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 2 ++
 fs/direct-io.c | 2 ++
 fs/iomap.c     | 5 ++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index dd91c99e9ba0..30e1fb65c2fa 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -183,6 +183,8 @@ static unsigned int dio_bio_write_op(struct kiocb *iocb)
 	/* avoid the need for a I/O completion work item */
 	if (iocb->ki_flags & IOCB_DSYNC)
 		op |= REQ_FUA;
+
+	op |= write_hint_to_opf(iocb_write_hint(iocb));
 	return op;
 }
 
diff --git a/fs/direct-io.c b/fs/direct-io.c
index c87077d1dc33..5fea570551e5 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -385,6 +385,8 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	else
 		bio->bi_end_io = dio_bio_end_io;
 
+	bio->bi_opf |= write_hint_to_opf(iocb_write_hint(dio->iocb));
+
 	sdio->bio = bio;
 	sdio->logical_offset_in_bio = sdio->cur_page_fs_offset;
 }
diff --git a/fs/iomap.c b/fs/iomap.c
index c71a64b97fba..42d4ecf3ba54 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -803,7 +803,10 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 		}
 
 		if (dio->flags & IOMAP_DIO_WRITE) {
-			bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_SYNC | REQ_IDLE);
+			bio_set_op_attrs(bio, REQ_OP_WRITE,
+						REQ_SYNC | REQ_IDLE);
+			bio->bi_opf |=
+				write_hint_to_opf(iocb_write_hint(dio->iocb));
 			task_io_account_write(bio->bi_iter.bi_size);
 		} else {
 			bio_set_op_attrs(bio, REQ_OP_READ, 0);
-- 
2.7.4
