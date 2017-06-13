Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/11] btrfs: add support for passing in stream information for buffered writes
Date: Tue, 13 Jun 2017 11:15:22 -0600
Message-Id: <1497374123-15286-11-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/btrfs/extent_io.c | 1 +
 fs/btrfs/inode.c     | 1 +
 2 files changed, 2 insertions(+)

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
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ef3c98c527c1..db0558a19f65 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8608,6 +8608,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 	atomic_set(&dip->pending_bios, 0);
 	btrfs_bio = btrfs_io_bio(io_bio);
 	btrfs_bio->logical = file_offset;
+	bio_set_streamid(io_bio, bio_stream(dio_bio));
 
 	if (write) {
 		io_bio->bi_end_io = btrfs_endio_direct_write;
-- 
2.7.4
