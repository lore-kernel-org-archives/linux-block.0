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
        Ming Lei <ming.lei@redhat.com>
Subject: [RESEND PATCH V5 12/33] block: introduce bio_segments()
Date: Fri, 25 May 2018 11:46:00 +0800
Message-Id: <20180525034621.31147-13-ming.lei@redhat.com>
In-Reply-To: <20180525034621.31147-1-ming.lei@redhat.com>
References: <20180525034621.31147-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

There are still cases in which we need to use bio_segments() for get the
number of segment, so introduce it.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bio.h | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 08af9272687f..b24c00f99c9c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -227,9 +227,9 @@ static inline bool bio_rewind_iter(struct bio *bio, struct bvec_iter *iter,
 
 #define bio_iter_last(bvec, iter) ((iter).bi_size == (bvec).bv_len)
 
-static inline unsigned bio_pages(struct bio *bio)
+static inline unsigned __bio_elements(struct bio *bio, bool seg)
 {
-	unsigned segs = 0;
+	unsigned elems = 0;
 	struct bio_vec bv;
 	struct bvec_iter iter;
 
@@ -249,10 +249,25 @@ static inline unsigned bio_pages(struct bio *bio)
 		break;
 	}
 
-	bio_for_each_page(bv, bio, iter)
-		segs++;
+	if (!seg) {
+		bio_for_each_page(bv, bio, iter)
+			elems++;
+	} else {
+		bio_for_each_segment(bv, bio, iter)
+			elems++;
+	}
+
+	return elems;
+}
+
+static inline unsigned bio_pages(struct bio *bio)
+{
+	return __bio_elements(bio, false);
+}
 
-	return segs;
+static inline unsigned bio_segments(struct bio *bio)
+{
+	return __bio_elements(bio, true);
 }
 
 /*
-- 
2.9.5
