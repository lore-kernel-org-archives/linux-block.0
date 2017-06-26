Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	hch@lst.de,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/9] ext4: add support for passing in write hints for buffered writes
Date: Mon, 26 Jun 2017 09:37:57 -0600
Message-Id: <1498491480-16306-7-git-send-email-axboe@kernel.dk>
In-Reply-To: <1498491480-16306-1-git-send-email-axboe@kernel.dk>
References: <1498491480-16306-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/ext4/page-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 930ca0fc9a0f..02e5a7b8d60b 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -350,6 +350,7 @@ void ext4_io_submit(struct ext4_io_submit *io)
 	if (bio) {
 		int io_op_flags = io->io_wbc->sync_mode == WB_SYNC_ALL ?
 				  REQ_SYNC : 0;
+		io_op_flags |= inode_hint_to_opf(io->io_end->inode);
 		bio_set_op_attrs(io->io_bio, REQ_OP_WRITE, io_op_flags);
 		submit_bio(io->io_bio);
 	}
@@ -397,6 +398,7 @@ static int io_submit_add_bh(struct ext4_io_submit *io,
 		ret = io_submit_init_bio(io, bh);
 		if (ret)
 			return ret;
+		io->io_bio->bi_opf |= inode_hint_to_opf(inode);
 	}
 	ret = bio_add_page(io->io_bio, page, bh->b_size, bh_offset(bh));
 	if (ret != bh->b_size)
-- 
2.7.4
