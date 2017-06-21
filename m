Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/9] fs: add O_DIRECT support for sending down write life time hints
Date: Tue, 20 Jun 2017 18:22:01 -0600
Message-Id: <1498004526-4543-5-git-send-email-axboe@kernel.dk>
In-Reply-To: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 2 ++
 fs/direct-io.c | 2 ++
 fs/iomap.c     | 1 +
 3 files changed, 5 insertions(+)

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
index c71a64b97fba..9c9f8406018b 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -804,6 +804,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 
 		if (dio->flags & IOMAP_DIO_WRITE) {
 			bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_SYNC | REQ_IDLE);
+			bio->bi_opf |= write_hint_to_opf(inode_write_hint(inode));
 			task_io_account_write(bio->bi_iter.bi_size);
 		} else {
 			bio_set_op_attrs(bio, REQ_OP_READ, 0);
-- 
2.7.4
