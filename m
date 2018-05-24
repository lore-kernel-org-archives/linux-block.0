Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 24/33] f2fs: conver to bio_for_each_page_all2
Date: Thu, 24 May 2018 17:01:29 +0800
Message-Id: <20180524090139.2150-25-ming.lei@redhat.com>
In-Reply-To: <20180524090139.2150-1-ming.lei@redhat.com>
References: <20180524090139.2150-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

bio_for_each_page_all() can't be used any more after multipage bvec is
enabled, so we have to convert to bio_for_each_page_all2().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/f2fs/data.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 89da84b0f0bd..924284e2f358 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -54,6 +54,7 @@ static void f2fs_read_end_io(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all bia;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(F2FS_P_SB(bio_first_page_all(bio)), FAULT_IO)) {
@@ -71,7 +72,7 @@ static void f2fs_read_end_io(struct bio *bio)
 		}
 	}
 
-	bio_for_each_page_all(bvec, bio, i) {
+	bio_for_each_page_all2(bvec, bio, i, bia) {
 		struct page *page = bvec->bv_page;
 
 		if (!bio->bi_status) {
@@ -91,8 +92,9 @@ static void f2fs_write_end_io(struct bio *bio)
 	struct f2fs_sb_info *sbi = bio->bi_private;
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all bia;
 
-	bio_for_each_page_all(bvec, bio, i) {
+	bio_for_each_page_all2(bvec, bio, i, bia) {
 		struct page *page = bvec->bv_page;
 		enum count_type type = WB_DATA_TYPE(page);
 
@@ -267,6 +269,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
 	struct bio_vec *bvec;
 	struct page *target;
 	int i;
+	struct bvec_iter_all bia;
 
 	if (!io->bio)
 		return false;
@@ -274,7 +277,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
 	if (!inode && !ino)
 		return true;
 
-	bio_for_each_page_all(bvec, io->bio, i) {
+	bio_for_each_page_all2(bvec, io->bio, i, bia) {
 
 		if (bvec->bv_page->mapping)
 			target = bvec->bv_page;
-- 
2.9.5
