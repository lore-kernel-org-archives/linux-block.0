Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com
Subject: [PATCH v2 44/51] gfs2: convert to bio_for_each_segment_all_sp()
Date: Mon, 26 Jun 2017 20:10:27 +0800
Message-Id: <20170626121034.3051-45-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Cc: Steven Whitehouse <swhiteho@redhat.com>
Cc: Bob Peterson <rpeterso@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/gfs2/lops.c    | 3 ++-
 fs/gfs2/meta_io.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index d62939f00d53..294f1926d9be 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -206,11 +206,12 @@ static void gfs2_end_log_write(struct bio *bio)
 	struct bio_vec *bvec;
 	struct page *page;
 	int i;
+	struct bvec_iter_all bia;
 
 	if (bio->bi_status)
 		fs_err(sdp, "Error %d writing to log\n", bio->bi_status);
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 		page = bvec->bv_page;
 		if (page_has_buffers(page))
 			gfs2_end_log_write_bh(sdp, bvec, bio->bi_status);
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index fabe1614f879..6879b0103539 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -190,8 +190,9 @@ static void gfs2_meta_read_endio(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 		struct page *page = bvec->bv_page;
 		struct buffer_head *bh = page_buffers(page);
 		unsigned int len = bvec->bv_len;
-- 
2.9.4
