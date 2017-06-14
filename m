Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/10] ext4: add support for passing in stream information for buffered writes
Date: Tue, 13 Jun 2017 22:01:56 -0600
Message-Id: <1497412919-19400-8-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/ext4/page-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 1a82138ba739..033b5bfa4e0b 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -350,6 +350,7 @@ void ext4_io_submit(struct ext4_io_submit *io)
 		int io_op_flags = io->io_wbc->sync_mode == WB_SYNC_ALL ?
 				  REQ_SYNC : 0;
 		bio_set_op_attrs(io->io_bio, REQ_OP_WRITE, io_op_flags);
+		bio_set_streamid(io->io_bio, inode_streamid(io->io_end->inode));
 		submit_bio(io->io_bio);
 	}
 	io->io_bio = NULL;
@@ -396,6 +397,7 @@ static int io_submit_add_bh(struct ext4_io_submit *io,
 		ret = io_submit_init_bio(io, bh);
 		if (ret)
 			return ret;
+		bio_set_streamid(io->io_bio, inode_streamid(inode));
 	}
 	ret = bio_add_page(io->io_bio, page, bh->b_size, bh_offset(bh));
 	if (ret != bh->b_size)
-- 
2.7.4
