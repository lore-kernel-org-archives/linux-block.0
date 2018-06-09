Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 23/30] f2fs: conver to bio_for_each_chunk_segment_all
Date: Sat,  9 Jun 2018 20:30:07 +0800
Message-Id: <20180609123014.8861-24-ming.lei@redhat.com>
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
References: <20180609123014.8861-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

bio_for_each_page_all() can't be used any more after multipage bvec is
enabled, so we have to convert to bio_for_each_chunk_segment_all().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/f2fs/data.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 02237d4d91f5..00ee386b902c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -54,6 +54,7 @@ static void f2fs_read_end_io(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_chunk_iter citer;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(F2FS_P_SB(bio_first_page_all(bio)), FAULT_IO)) {
@@ -71,7 +72,7 @@ static void f2fs_read_end_io(struct bio *bio)
 		}
 	}
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_chunk_segment_all(bvec, bio, i, citer) {
 		struct page *page = bvec->bv_page;
 
 		if (!bio->bi_status) {
@@ -91,8 +92,9 @@ static void f2fs_write_end_io(struct bio *bio)
 	struct f2fs_sb_info *sbi = bio->bi_private;
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_chunk_iter citer;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_chunk_segment_all(bvec, bio, i, citer) {
 		struct page *page = bvec->bv_page;
 		enum count_type type = WB_DATA_TYPE(page);
 
@@ -267,6 +269,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
 	struct bio_vec *bvec;
 	struct page *target;
 	int i;
+	struct bvec_chunk_iter citer;
 
 	if (!io->bio)
 		return false;
@@ -274,7 +277,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
 	if (!inode && !ino)
 		return true;
 
-	bio_for_each_segment_all(bvec, io->bio, i) {
+	bio_for_each_chunk_segment_all(bvec, io->bio, i, citer) {
 
 		if (bvec->bv_page->mapping)
 			target = bvec->bv_page;
-- 
2.9.5
