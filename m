Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759228AbdLRM3k (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Dec 2017 07:29:40 -0500
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
Subject: [PATCH V4 26/45] block: introduce bio_segments()
Date: Mon, 18 Dec 2017 20:22:28 +0800
Message-Id: <20171218122247.3488-27-ming.lei@redhat.com>
In-Reply-To: <20171218122247.3488-1-ming.lei@redhat.com>
References: <20171218122247.3488-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

There are still cases in which we need to use bio_segments() for get the
number of segment, so introduce it.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bio.h | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 2dd1ca0285e1..205a914ee3c0 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -223,9 +223,9 @@ static inline bool bio_rewind_iter(struct bio *bio, struct bvec_iter *iter,
 
 #define bio_iter_last(bvec, iter) ((iter).bi_size == (bvec).bv_len)
 
-static inline unsigned bio_pages(struct bio *bio)
+static inline unsigned __bio_elements(struct bio *bio, bool seg)
 {
-	unsigned segs = 0;
+	unsigned elems = 0;
 	struct bio_vec bv;
 	struct bvec_iter iter;
 
@@ -245,10 +245,25 @@ static inline unsigned bio_pages(struct bio *bio)
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
