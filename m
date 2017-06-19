Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/9] xfs: add support for passing in write hints for buffered writes
Date: Mon, 19 Jun 2017 11:05:00 -0600
Message-Id: <1497891902-25737-8-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497891902-25737-1-git-send-email-axboe@kernel.dk>
References: <1497891902-25737-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_aops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 76b6f988e2fa..e4d9d470402c 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -506,6 +506,7 @@ xfs_submit_ioend(
 		return status;
 	}
 
+	ioend->io_bio->bi_opf |= write_hint_to_opf(inode_write_hint(ioend->io_inode));
 	submit_bio(ioend->io_bio);
 	return 0;
 }
@@ -565,6 +566,7 @@ xfs_chain_bio(
 	bio_chain(ioend->io_bio, new);
 	bio_get(ioend->io_bio);		/* for xfs_destroy_ioend */
 	ioend->io_bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
+	ioend->io_bio->bi_opf |= write_hint_to_opf(inode_write_hint(ioend->io_inode));
 	submit_bio(ioend->io_bio);
 	ioend->io_bio = new;
 }
-- 
2.7.4
