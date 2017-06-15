Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/11] ext4: add support for passing in write hints for buffered writes
Date: Wed, 14 Jun 2017 21:45:09 -0600
Message-Id: <1497498312-17704-9-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/ext4/page-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 1a82138ba739..764bf0ddecd4 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -349,6 +349,7 @@ void ext4_io_submit(struct ext4_io_submit *io)
 	if (bio) {
 		int io_op_flags = io->io_wbc->sync_mode == WB_SYNC_ALL ?
 				  REQ_SYNC : 0;
+		io_op_flags |= bio_op_write_hint(inode_write_hint(io->io_end->inode));
 		bio_set_op_attrs(io->io_bio, REQ_OP_WRITE, io_op_flags);
 		submit_bio(io->io_bio);
 	}
@@ -396,6 +397,7 @@ static int io_submit_add_bh(struct ext4_io_submit *io,
 		ret = io_submit_init_bio(io, bh);
 		if (ret)
 			return ret;
+		io->io_bio->bi_opf |= bio_op_write_hint(inode_write_hint(inode));
 	}
 	ret = bio_add_page(io->io_bio, page, bh->b_size, bh_offset(bh));
 	if (ret != bh->b_size)
-- 
2.7.4
