Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEAB225AA
	for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321895; cv=none; b=JyP0LV7dEyLyEn43YyyTlglqkTwpPENiS57BK1WBYBZj5akEVfaUlxRh7QAjfjMKowzf5S6sv/vlAQcigQXCwd2Qkc+mz2M11WxyvdIslq7EtWbPGN+fWRHZSywHcZYh+evPZTlD+hw+vW1QiwKRnM8ZgkSyAWr9JGXarTo3Vkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321895; c=relaxed/simple;
	bh=SrpAlDerfFLkXrbpZx+vPED/Hpmx9KxCtHsXzYA4wyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JEtiED/y7YkMidsyQ67/l/+tnXb2Sv2XK4lGAT/7gHSu+O2YSA9OsMEHnSnoLEsiU2+PKEkWjYa+qQV7ebuEvVJii5uMSpFYHEUR43fbzzL0BA1Vd//aR2k1E+53mHxcw0AgriImrbIFFzYNgO7Bpd0LZm6rfej+zjESAb+xJzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 42D9NvGO050337;
	Wed, 13 Mar 2024 17:23:57 +0800 (+08)
	(envelope-from Zhengxu.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TvlR54CsRz2L5H2j;
	Wed, 13 Mar 2024 17:22:41 +0800 (CST)
Received: from tj06287pcu.spreadtrum.com (10.5.32.43) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 13 Mar 2024 17:23:55 +0800
From: Zhengxu Zhang <zhengxu.zhang@unisoc.com>
To: <axboe@kernel.dk>, <bvanassche@acm.org>
CC: <linux-block@vger.kernel.org>, <hongyu.jin.cn@gmail.com>,
        <zhiguo.niu@unisoc.com>, <niuzhiguo84@gmail.com>,
        <hongyu.jin@unisoc.com>, <yunlongxing23@gmail.com>,
        <char.zzx@gmail.com>, <zhengxu.zhang@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH] block: Minimize the number of requests in Direct I/O when bio get pages.
Date: Wed, 13 Mar 2024 17:23:46 +0800
Message-ID: <20240313092346.1304889-1-zhengxu.zhang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 42D9NvGO050337

We find that when direct io is decomposed into requests,
there are often have some requests size that are less than the maximum
size of a request, which increases the number of requests for a direct io
 and slows down the speed.

We try to let bio determine how many pages canbe obtained by dividing it
by the maximum request through bio_export_page
when obtaining a set of pages. Then try to obtain
as many pages as possible.

Of course, if the last page obtained by
bio is less than the maximum number that bio can obtain,
it will also be added to that bio (if the bio have enough vector)
or the next bio.

Device info: ufs RAM:6GB kernel:6.6 improve seq read 5%
Device info: emmc RAM:4GB kernel:5.15 improve seq read 10%

1.androidbench test result(ufs RAM:6GB kernel6.6):

before:								 avg
seq read	1812	1735	1879	1887	1817	1849	1829
seq write	1271	1294	1287	1305	1296	1296	1291
ram read	301	298	297	297	295	294	297
ram write	343	342	344	351	349	345	345
sql insert	2773	2779	2856	2801	2932	2913	2842
sql update	2819	2888	3009	2953	2961	2974	2934
sql delete	4117	4004	4121	4158	4088	4071	4093

after:								 avg
seq read	1923	1919	1946	1921	1953	1937	1933	+5.65%
seq write	1277	1301	1301	1296	1291	1299	1294	+0.21%
ram read	302	301	302	306	301	297	301	+1.52%
ram write	350	359	350	339	351	356	350	+1.49%
sql insert	2788	2935	3011	3022	3069	3037	2977	+4.74%
sql update	2991	3123	3125	3070	3087	3132	3088	+5.25%
sql delete	4157	4174	4173	4177	4297	4246	4204	+2.71%

seq read avg: 1933MB/s better than 1829MB/s (up about 5.65%)

2.trace:
before:   lots of (2048+x),it will product 2+1 requests,
           the "1" will lead speed down.

	block_bio_queue: 179,0 R 84601376 + 2064 [Thread-2]
	block_bio_queue: 179,0 R 84603440 + 2048 [Thread-2]
	block_bio_queue: 179,0 R 84605488 + 2072 [Thread-2]
	block_bio_queue: 179,0 R 84607560 + 2064 [Thread-2]
	block_bio_queue: 179,0 R 84609624 + 2064 [Thread-2]

after:   we make size of bio can divide by request_max_size.
       and then do not product the "1", minimize one direct-io requests  ,
       and minimize the number of bio as soon as possible at the same time.

	block_bio_queue: 179,0 R 69829456 + 2048 [Thread-3]
	block_bio_queue: 179,0 R 69831504 + 3072 [Thread-3]
	block_bio_queue: 179,0 R 69834576 + 4096 [Thread-3]
	block_bio_queue: 179,0 R 69838672 + 5120 [Thread-3]

	block_bio_queue: 8,0 WFS 153795416 + 5120 [Thread-11]
	block_bio_queue: 8,0 WFS 153800536 + 7168 [Thread-11]
	block_bio_queue: 8,0 WFS 153807704 + 9216 [Thread-11]
	block_bio_queue: 8,0 WFS 153816920 + 10240 [Thread-11]
	block_bio_queue: 8,0 WFS 153827160 + 8192 [Thread-11]

Signed-off-by: Zhengxu Zhang <Zhengxu.Zhang@unisoc.com>
---
 block/bio.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b9642a41f286..f821a5fb72bd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -903,6 +903,70 @@ static inline bool bio_full(struct bio *bio, unsigned len)
 	return false;
 }
 
+/**
+ * bio_export_pages - calculate how many pages does this bio needs,
+ * in order to minimize the number of requests the bio needs to split.
+ * @bio:        bio to check
+ * @page_total: total number of pages need to be added. If no page_total,
+ *              it can be used by UINT_MAX.
+ *
+ * Return the page numbers can be added to this bio.
+ * If return 0 means do not suggest add page in this bio,
+ * lead to add more requests in direct-io.
+ */
+static unsigned int bio_export_pages(struct bio *bio, unsigned int page_total)
+{
+	unsigned int request_max_size;
+	unsigned int request_max_pages;
+	unsigned short bio_export_pages;
+	unsigned int last_request_size;
+	unsigned int nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
+
+	/*
+	 * The number of pages that need to add is less than the pages that bio can be get,
+	 * we can get whole pages directly.
+	 */
+	if (page_total < nr_pages)
+		return page_total;
+
+	if (bio->bi_bdev) {
+		request_max_size = queue_max_bytes(bdev_get_queue(bio->bi_bdev));
+		/* request_max_size >> PAGE_SHIFT should equals 2^n */
+		request_max_pages = request_max_size >> PAGE_SHIFT;
+		last_request_size = bio->bi_iter.bi_size & (request_max_size - 1);
+
+		/*
+		 * when bio->bi_iter.bi_size % request_max_size = 0, we need confirm if
+		 * we still need to add a page to bio, because now the bio size is best for request.
+		 *
+		 * If bio can get the max number of pages is less than the number of
+		 * one complete request, we should still get pages if possible.
+		 *
+		 * If the bio can not get the size of one complete request that we badly think
+		 * the page physical addresses are not contiguous.
+		 * we suggest this bio do not add pages, the pages maybe break
+		 *  "bio->bi_iter.bi_size % request_max_size = 0", and then make a litte request.
+		 * the next bio continues maybe better.
+		 */
+		if (last_request_size == 0 && bio->bi_max_vecs > request_max_pages &&
+			nr_pages < request_max_pages)
+			return 0;
+
+		/*
+		 * base on the bio->vcnt, we confirm the max number of pages that can keep
+		 *  bio->bi_iter.bi_size % request_max_size = 0 when we can get,
+		 * note: the sum of the pages size maybe equals more than one request size.
+		 */
+		bio_export_pages = (request_max_size - last_request_size) >> PAGE_SHIFT;
+		if (!bio_export_pages)
+			bio_export_pages = request_max_pages;
+		if (nr_pages > bio_export_pages)
+			nr_pages -= nr_pages & (request_max_pages - 1);
+	}
+
+	return nr_pages;
+}
+
 static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
 		unsigned int len, unsigned int off, bool *same_page)
 {
@@ -1228,16 +1292,16 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
  * __bio_iov_iter_get_pages - pin user or kernel pages and add them to a bio
  * @bio: bio to add pages to
  * @iter: iov iterator describing the region to be mapped
+ * @nr_pages: the number of pages that bio want to get.
  *
  * Extracts pages from *iter and appends them to @bio's bvec array.  The pages
  * will have to be cleaned up in the way indicated by the BIO_PAGE_PINNED flag.
  * For a multi-segment *iter, this function only adds pages from the next
  * non-empty segment of the iov iterator.
  */
-static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
+static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter, unsigned short nr_pages)
 {
 	iov_iter_extraction_t extraction_flags = 0;
-	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
 	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
@@ -1329,6 +1393,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	int ret = 0;
+	unsigned short nr_pages;
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return -EIO;
@@ -1342,7 +1407,10 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	if (iov_iter_extract_will_pin(iter))
 		bio_set_flag(bio, BIO_PAGE_PINNED);
 	do {
-		ret = __bio_iov_iter_get_pages(bio, iter);
+		nr_pages = bio_export_pages(bio, iov_iter_count(iter));
+		if (!nr_pages)
+			break;
+		ret = __bio_iov_iter_get_pages(bio, iter, nr_pages);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
 
 	return bio->bi_vcnt ? 0 : ret;
-- 
2.25.1

