Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	hch@lst.de,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/9] xfs: add support for passing in write hints for buffered writes
Date: Mon, 26 Jun 2017 09:37:58 -0600
Message-Id: <1498491480-16306-8-git-send-email-axboe@kernel.dk>
In-Reply-To: <1498491480-16306-1-git-send-email-axboe@kernel.dk>
References: <1498491480-16306-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_aops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 76b6f988e2fa..ceb124bd8f80 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -506,6 +506,7 @@ xfs_submit_ioend(
 		return status;
 	}
 
+	ioend->io_bio->bi_opf |= inode_hint_to_opf(ioend->io_inode);
 	submit_bio(ioend->io_bio);
 	return 0;
 }
@@ -565,6 +566,7 @@ xfs_chain_bio(
 	bio_chain(ioend->io_bio, new);
 	bio_get(ioend->io_bio);		/* for xfs_destroy_ioend */
 	ioend->io_bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
+	ioend->io_bio->bi_opf |= inode_hint_to_opf(ioend->io_inode);
 	submit_bio(ioend->io_bio);
 	ioend->io_bio = new;
 }
-- 
2.7.4
