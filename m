Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE SYSTEM)
Subject: [PATCH 54/60] f2fs: convert to bio_for_each_segment_all_rd()
Date: Sat, 29 Oct 2016 16:08:53 +0800
Message-Id: <1477728600-12938-55-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/f2fs/data.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 24f6f6977d37..04b1a5caf2d6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -33,6 +33,7 @@ static void f2fs_read_end_io(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all bia;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	/*
@@ -52,7 +53,7 @@ static void f2fs_read_end_io(struct bio *bio)
 		}
 	}
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_rd(bvec, bio, i, bia) {
 		struct page *page = bvec->bv_page;
 
 		if (!bio->bi_error) {
@@ -72,8 +73,9 @@ static void f2fs_write_end_io(struct bio *bio)
 	struct f2fs_sb_info *sbi = bio->bi_private;
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_rd(bvec, bio, i, bia) {
 		struct page *page = bvec->bv_page;
 
 		fscrypt_pullback_bio_page(&page, true);
@@ -145,6 +147,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
 	struct bio_vec *bvec;
 	struct page *target;
 	int i;
+	struct bvec_iter_all bia;
 
 	if (!io->bio)
 		return false;
@@ -152,7 +155,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
 	if (!inode && !page && !ino)
 		return true;
 
-	bio_for_each_segment_all(bvec, io->bio, i) {
+	bio_for_each_segment_all_rd(bvec, io->bio, i, bia) {
 
 		if (bvec->bv_page->mapping)
 			target = bvec->bv_page;
-- 
2.7.4

