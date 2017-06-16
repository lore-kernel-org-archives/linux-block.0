Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/11] btrfs: add support for passing in write hints for buffered writes
Date: Fri, 16 Jun 2017 11:24:42 -0600
Message-Id: <1497633883-21230-11-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497633883-21230-1-git-send-email-axboe@kernel.dk>
References: <1497633883-21230-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/btrfs/extent_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d3619e010005..92e75e4014ea 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2826,6 +2826,7 @@ static int submit_extent_page(int op, int op_flags, struct extent_io_tree *tree,
 	bio_add_page(bio, page, page_size, offset);
 	bio->bi_end_io = end_io_func;
 	bio->bi_private = tree;
+	op_flags |= write_hint_to_opf(inode_write_hint(page->mapping->host));
 	bio_set_op_attrs(bio, op, op_flags);
 	if (wbc) {
 		wbc_init_bio(wbc, bio);
-- 
2.7.4
