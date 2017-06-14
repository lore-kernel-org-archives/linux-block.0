Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/11] xfs: add support for passing in stream information for buffered writes
Date: Wed, 14 Jun 2017 13:05:32 -0600
Message-Id: <1497467134-6323-10-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
References: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_aops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 09af0f7cd55e..9770be0140ad 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -505,6 +505,7 @@ xfs_submit_ioend(
 		return status;
 	}
 
+	bio_set_streamid(ioend->io_bio, inode_streamid(ioend->io_inode));
 	submit_bio(ioend->io_bio);
 	return 0;
 }
@@ -564,6 +565,7 @@ xfs_chain_bio(
 	bio_chain(ioend->io_bio, new);
 	bio_get(ioend->io_bio);		/* for xfs_destroy_ioend */
 	ioend->io_bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
+	bio_set_streamid(ioend->io_bio, inode_streamid(ioend->io_inode));
 	submit_bio(ioend->io_bio);
 	ioend->io_bio = new;
 }
-- 
2.7.4
