Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/11] btrfs: add support for passing in stream information for buffered writes
Date: Wed, 14 Jun 2017 13:05:33 -0600
Message-Id: <1497467134-6323-11-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
References: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/btrfs/extent_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d3619e010005..b245085e8f10 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2827,6 +2827,7 @@ static int submit_extent_page(int op, int op_flags, struct extent_io_tree *tree,
 	bio->bi_end_io = end_io_func;
 	bio->bi_private = tree;
 	bio_set_op_attrs(bio, op, op_flags);
+	bio_set_streamid(bio, inode_streamid(page->mapping->host));
 	if (wbc) {
 		wbc_init_bio(wbc, bio);
 		wbc_account_io(wbc, page, page_size);
-- 
2.7.4
