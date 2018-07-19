Return-Path: <mwilck@suse.com>
From: Martin Wilck <mwilck@suse.com>
To: Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>,
	Jan Kara <jack@suse.com>
Cc: Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-block@vger.kernel.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v3 1/3] block: bio_iov_iter_get_pages: fix size of last iovec
Date: Thu, 19 Jul 2018 23:01:56 +0200
Message-Id: <20180719210158.25923-2-mwilck@suse.com>
In-Reply-To: <20180719210158.25923-1-mwilck@suse.com>
References: <20180719210158.25923-1-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

If the last page of the bio is not "full", the length of the last
vector slot needs to be corrected. This slot has the index
(bio->bi_vcnt - 1), but only in bio->bi_io_vec. In the "bv" helper
array, which is shifted by the value of bio->bi_vcnt at function
invocation, the correct index is (nr_pages - 1).

v2: improved readability following suggestions from Ming Lei.
v3: followed a formatting suggestion from Christoph Hellwig.

Fixes: 2cefe4dbaadf ("block: add bio_iov_iter_get_pages()")
Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 67eff5e..489a430 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -912,16 +912,16 @@ EXPORT_SYMBOL(bio_add_page);
  */
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
-	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
+	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt, idx;
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
-	size_t offset, diff;
+	size_t offset;
 	ssize_t size;
 
 	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
-	nr_pages = (size + offset + PAGE_SIZE - 1) / PAGE_SIZE;
+	idx = nr_pages = (size + offset + PAGE_SIZE - 1) / PAGE_SIZE;
 
 	/*
 	 * Deep magic below:  We need to walk the pinned pages backwards
@@ -934,17 +934,15 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	bio->bi_iter.bi_size += size;
 	bio->bi_vcnt += nr_pages;
 
-	diff = (nr_pages * PAGE_SIZE - offset) - size;
-	while (nr_pages--) {
-		bv[nr_pages].bv_page = pages[nr_pages];
-		bv[nr_pages].bv_len = PAGE_SIZE;
-		bv[nr_pages].bv_offset = 0;
+	while (idx--) {
+		bv[idx].bv_page = pages[idx];
+		bv[idx].bv_len = PAGE_SIZE;
+		bv[idx].bv_offset = 0;
 	}
 
 	bv[0].bv_offset += offset;
 	bv[0].bv_len -= offset;
-	if (diff)
-		bv[bio->bi_vcnt - 1].bv_len -= diff;
+	bv[nr_pages - 1].bv_len -= nr_pages * PAGE_SIZE - offset - size;
 
 	iov_iter_advance(iter, size);
 	return 0;
-- 
2.17.1
