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
Subject: [PATCH V6 27/30] block: kill bio_for_each_segment_all()
Date: Sat,  9 Jun 2018 20:30:11 +0800
Message-Id: <20180609123014.8861-28-ming.lei@redhat.com>
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
References: <20180609123014.8861-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

No one uses it any more, so kill it now.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bio.h  | 5 +----
 include/linux/bvec.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index c22b8be961ce..69ef05dc7019 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -165,11 +165,8 @@ static inline bool bio_full(struct bio *bio)
  * drivers should _never_ use the all version - the bio may have been split
  * before it got to the driver and the driver won't own all of it
  */
-#define bio_for_each_segment_all(bvl, bio, i)				\
-	for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
-
 #define bio_for_each_chunk_all(bvl, bio, i)		\
-	bio_for_each_segment_all(bvl, bio, i)
+	for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
 
 #define chunk_for_each_segment(bv, bvl, i, citer)			\
 	for (bv = bvec_init_chunk_iter(&citer);				\
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index d4eaa0c26bb5..58267bde111e 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -47,7 +47,7 @@
  *   page, so we keep the sp interface not changed, for example,
  *   bio_for_each_segment() still returns bvec with single page
  *
- * - bio_for_each_segment_all() will be changed to return singlepage
+ * - bio_for_each_chunk_all() will be changed to return singlepage
  *   bvec too
  *
  * - during iterating, iterator variable(struct bvec_iter) is always
-- 
2.9.5
