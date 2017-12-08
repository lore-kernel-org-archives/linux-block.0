Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752470AbdLHNPD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:03 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 03/10] fs: convert to bio_last_bvec()
Date: Fri,  8 Dec 2017 21:14:02 +0800
Message-Id: <20171208131409.11889-4-ming.lei@redhat.com>
In-Reply-To: <20171208131409.11889-1-ming.lei@redhat.com>
References: <20171208131409.11889-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch convers 3 users to bio_last_bvec(), so that we can go ahread
to convert to multipage bvec.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/btrfs/compression.c | 2 +-
 fs/btrfs/extent_io.c   | 2 +-
 fs/buffer.c            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index fc0386c18574..726e1b5b06fe 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -411,7 +411,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 
 static u64 bio_end_offset(struct bio *bio)
 {
-	struct bio_vec *last = &bio->bi_io_vec[bio->bi_vcnt - 1];
+	struct bio_vec *last = bio_last_bvec(bio);
 
 	return page_offset(last->bv_page) + last->bv_len + last->bv_offset;
 }
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 012d63870b99..6f6669f93beb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2724,7 +2724,7 @@ static int __must_check submit_one_bio(struct bio *bio, int mirror_num,
 				       unsigned long bio_flags)
 {
 	blk_status_t ret = 0;
-	struct bio_vec *bvec = bio->bi_io_vec + bio->bi_vcnt - 1;
+	struct bio_vec *bvec = bio_last_bvec(bio);
 	struct page *page = bvec->bv_page;
 	struct extent_io_tree *tree = bio->bi_private;
 	u64 start;
diff --git a/fs/buffer.c b/fs/buffer.c
index 0736a6a2e2f0..ceb705ba939f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3014,7 +3014,7 @@ static void end_bio_bh_io_sync(struct bio *bio)
 void guard_bio_eod(int op, struct bio *bio)
 {
 	sector_t maxsector;
-	struct bio_vec *bvec = &bio->bi_io_vec[bio->bi_vcnt - 1];
+	struct bio_vec *bvec = bio_last_bvec(bio);
 	unsigned truncated_bytes;
 	struct hd_struct *part;
 
-- 
2.9.5
