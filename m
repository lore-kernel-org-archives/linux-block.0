Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/12] btrfs: add support for passing in write hints for buffered writes
Date: Thu, 15 Jun 2017 10:42:09 -0600
Message-Id: <1497544930-19174-12-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497544930-19174-1-git-send-email-axboe@kernel.dk>
References: <1497544930-19174-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/btrfs/extent_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d3619e010005..2bc2dfca87c2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2826,6 +2826,7 @@ static int submit_extent_page(int op, int op_flags, struct extent_io_tree *tree,
 	bio_add_page(bio, page, page_size, offset);
 	bio->bi_end_io = end_io_func;
 	bio->bi_private = tree;
+	op_flags |= bio_op_write_hint(inode_write_hint(page->mapping->host));
 	bio_set_op_attrs(bio, op, op_flags);
 	if (wbc) {
 		wbc_init_bio(wbc, bio);
-- 
2.7.4
