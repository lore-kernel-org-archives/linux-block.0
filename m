Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 40/45] block: kill bio_for_each_page_all()
Date: Mon, 18 Dec 2017 20:22:42 +0800
Message-Id: <20171218122247.3488-41-ming.lei@redhat.com>
In-Reply-To: <20171218122247.3488-1-ming.lei@redhat.com>
References: <20171218122247.3488-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

No one uses it any more, so kill it and we can reuse this helper
name.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bio.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 899db6701f0d..05027f0df83f 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -155,8 +155,10 @@ static inline void *bio_data(struct bio *bio)
 /*
  * drivers should _never_ use the all version - the bio may have been split
  * before it got to the driver and the driver won't own all of it
+ *
+ * This helper iterates bio segment by segment.
  */
-#define bio_for_each_page_all(bvl, bio, i)				\
+#define bio_for_each_segment_all(bvl, bio, i)				\
 	for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
 
 static inline void __bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
@@ -221,9 +223,6 @@ static inline bool bio_rewind_iter(struct bio *bio, struct bvec_iter *iter,
 #define bio_for_each_segment(bvl, bio, iter)			\
 	__bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
 
-#define bio_for_each_segment_all(bvl, bio, i) \
-	bio_for_each_page_all((bvl), (bio), (i))
-
 /*
  * This helper returns singlepage bvec to caller, and the sp bvec is
  * generated in-flight from multipage bvec stored in bvec table. So we
-- 
2.9.5
