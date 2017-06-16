Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/11] xfs: add support for passing in write hints for buffered writes
Date: Fri, 16 Jun 2017 11:24:41 -0600
Message-Id: <1497633883-21230-10-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497633883-21230-1-git-send-email-axboe@kernel.dk>
References: <1497633883-21230-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_aops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 09af0f7cd55e..040789c51930 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -505,6 +505,7 @@ xfs_submit_ioend(
 		return status;
 	}
 
+	ioend->io_bio->bi_opf |= write_hint_to_opf(inode_write_hint(ioend->io_inode));
 	submit_bio(ioend->io_bio);
 	return 0;
 }
@@ -564,6 +565,7 @@ xfs_chain_bio(
 	bio_chain(ioend->io_bio, new);
 	bio_get(ioend->io_bio);		/* for xfs_destroy_ioend */
 	ioend->io_bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
+	ioend->io_bio->bi_opf |= write_hint_to_opf(inode_write_hint(ioend->io_inode));
 	submit_bio(ioend->io_bio);
 	ioend->io_bio = new;
 }
-- 
2.7.4
