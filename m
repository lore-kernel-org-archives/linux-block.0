Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V7 08/24] block: bio_set_pages_dirty can't see NULL bv_page in a valid bio_vec
Date: Wed, 27 Jun 2018 20:45:32 +0800
Message-Id: <20180627124548.3456-9-ming.lei@redhat.com>
In-Reply-To: <20180627124548.3456-1-ming.lei@redhat.com>
References: <20180627124548.3456-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>

So don't bother handling it.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 77f991688810..de6cbaedfb65 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1557,10 +1557,8 @@ void bio_set_pages_dirty(struct bio *bio)
 	int i;
 
 	bio_for_each_segment_all(bvec, bio, i) {
-		struct page *page = bvec->bv_page;
-
-		if (page && !PageCompound(page))
-			set_page_dirty_lock(page);
+		if (!PageCompound(bvec->bv_page))
+			set_page_dirty_lock(bvec->bv_page);
 	}
 }
 EXPORT_SYMBOL_GPL(bio_set_pages_dirty);
-- 
2.9.5
