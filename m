Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v2 45/51] f2fs: convert to bio_for_each_segment_all_sp()
Date: Mon, 26 Jun 2017 20:10:28 +0800
Message-Id: <20170626121034.3051-46-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/f2fs/data.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 622c44a1be78..57d5a2760bf1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -54,6 +54,7 @@ static void f2fs_read_end_io(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all bia;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	/*
@@ -75,7 +76,7 @@ static void f2fs_read_end_io(struct bio *bio)
 		}
 	}
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 		struct page *page = bvec->bv_page;
 
 		if (!bio->bi_status) {
@@ -95,8 +96,9 @@ static void f2fs_write_end_io(struct bio *bio)
 	struct f2fs_sb_info *sbi = bio->bi_private;
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 		struct page *page = bvec->bv_page;
 		enum count_type type = WB_DATA_TYPE(page);
 
@@ -256,6 +258,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
 	struct bio_vec *bvec;
 	struct page *target;
 	int i;
+	struct bvec_iter_all bia;
 
 	if (!io->bio)
 		return false;
@@ -263,7 +266,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
 	if (!inode && !ino)
 		return true;
 
-	bio_for_each_segment_all(bvec, io->bio, i) {
+	bio_for_each_segment_all_sp(bvec, io->bio, i, bia) {
 
 		if (bvec->bv_page->mapping)
 			target = bvec->bv_page;
-- 
2.9.4
