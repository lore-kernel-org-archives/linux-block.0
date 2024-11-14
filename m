Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DF813AD29
	for <linux-block@vger.kernel.org>; Thu, 14 Nov 2024 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598534; cv=none; b=pjACywUiUZcR69I8qkkImc7sPmVybaE+l5425519HG3/cAw09HI9CtfOuOcJa5vF49CHHgrPuwE59WXYozFDkfe9UQxQ2hpl5EEpM9xecjHBPI83amctMy9lbHS7jkIdeKrLiUIUzI9MjkCgE48gkT4tF/konB18kKII49mT1M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598534; c=relaxed/simple;
	bh=4zs128LUBDj7XsOD8LNRkK4zmh5JWjA6YdC+VH9sLro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=htD7EQ+hYBUZFXoMBOeCjQmunh277peBj/znzro1uuMwHuw9I035c63ZzNF/ZiMVIGSQQhaAQPCc7E0InymvS9we672irKuo9fTUPi4ltEFGJ6ArElVCcqTy8OrccbOtxvoZJw7h0Yxk1bBNLZliNtmj6TIOMZ0M5Q+oDj/QWy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=msmfToNQ; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="msmfToNQ"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241114153528epoutp0429cbe9228f7a39d53a459a41569a0591~H36-wiqD90746907469epoutp04e
	for <linux-block@vger.kernel.org>; Thu, 14 Nov 2024 15:35:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241114153528epoutp0429cbe9228f7a39d53a459a41569a0591~H36-wiqD90746907469epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731598528;
	bh=I/8QpnNSm4kGQ/QDUMy40Nd0FDDop1BRMxWKEsznZiY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=msmfToNQtgDMikALiqwnso3rOVeIfQp12hUe9+siG/hQuwhX8e+ttv3LXqg6GkJhl
	 XYVfe5WKQyvurv9PzbOt/VSouB6lLZ1vkKrb1BqG7z8IJ6unLbyT3YU0gyqlOxZdLE
	 aWmftTBE9LheG815XS7DvMfXNMX6Uo9v9zAvyCZI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241114153527epcas5p409bdee378af76f3598475b778ef1696f~H36-OjwVU1297012970epcas5p4D;
	Thu, 14 Nov 2024 15:35:27 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Xq43f2Xzdz4x9Pr; Thu, 14 Nov
	2024 15:35:26 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	20.85.15219.EB816376; Fri, 15 Nov 2024 00:35:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241114140134epcas5p3474e82266c4c117919a920d1dd4ed410~H2pAcj32R2582125821epcas5p3Q;
	Thu, 14 Nov 2024 14:01:34 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241114140134epsmtrp1a9436982252c6e38c04f321cbc61e19e~H2pAb0sUi2972229722epsmtrp1G;
	Thu, 14 Nov 2024 14:01:34 +0000 (GMT)
X-AuditID: b6c32a50-1f9ff70000023b73-39-673618beb732
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A4.36.07371.EB206376; Thu, 14 Nov 2024 23:01:34 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241114140132epsmtip1eb2a916422b7a21fd4ef5790ce8b1199~H2o_zPRC71199611996epsmtip1U;
	Thu, 14 Nov 2024 14:01:32 +0000 (GMT)
From: Chinmay Gameti <c.gameti@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	joshi.k@samsung.com, anuj20.g@samsung.com, nj.shetty@samsung.com,
	kundan.kumar@samsung.com, gost.dev@samsung.com, Chinmay Gameti
	<c.gameti@samsung.com>
Subject: [PATCH] block: add larger order folio instead of pages for
 passthrough I/O
Date: Thu, 14 Nov 2024 19:23:35 +0530
Message-Id: <20241114135335.21327-1-c.gameti@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmlu4+CbN0g4YNvBZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1ti8u75rBZbPs9n9mB2+Py2VKP
	Tas62Tx232xg8+jbsorR4/MmuQDWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sL
	cyWFvMTcVFslF58AXbfMHKDDlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6
	xYm5xaV56Xp5qSVWhgYGRqZAhQnZGV2fbjEXPFGtWDVjJlMD4ySZLkZODgkBE4lr19ewdzFy
	cQgJ7GGUeHGhnxXC+cQocePGZCYI5xujxJo3s5lgWp5Oew7VspdR4ujCRywQzmdGiX//9rOB
	VLEJaEv8W7mOHcQWETCS2P/pJNhcZoE7jBLX5n9iBUkIC4RKTHo7E8xmEVCVaD90gxnE5hWw
	lGg/eZMZYp28xMxL39kh4oISJ2c+YQGxmYHizVtnM4MMlRB4xC5x9+M+RogGF4mf+x+yQNjC
	Eq+Ob2GHsKUkXva3AdkcQHa+xJ9FSRDhEomeXTPZIGx7idZT/cwgJcwCmhLrd+lDhGUlpp5a
	xwSxlk+i9/cTaEjwSuyYB2MrSSzd9QHqZAmJpZ/7WCFsD4k163aAXSYkECvx6WMHywRG+VlI
	vpmF5JtZCJsXMDKvYpRKLSjOTU9NNi0w1M1LLYdHbXJ+7iZGcArVCtjBuHrDX71DjEwcjIcY
	JTiYlUR4TzkbpwvxpiRWVqUW5ccXleakFh9iNAWG8URmKdHkfGASzyuJNzSxNDAxMzMzsTQ2
	M1QS533dOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgWnWX9tLoqVZ7UWcli+faO7wZubri5surb9n
	32k71s3NC9k4Es+en9/vt2/Rqldv78t3GQYoSvSktnmVSEwTuZYeftz94rpJLtPVLgWVzX+o
	+uj0z/sptzcLBJpOMGHk2rS1yeCf4CqXKR9TazuvG4fMvR77zvHoWYbAI71pfCftFrI/Vud1
	sv5R8fFEgHt+k+g03w+/uOfs6Gnma7366Mjm6UXxMoeDHQsXa+l2uL76V1JbEp5fE/jY5m5u
	1jwbrRqblhv3Cru+uV+rK1hVzf/fkjv5mpCs5pItR2d5XVeLbdm7p2Mhb3iVTLNNbdC+feY1
	xydPO6yz+kHhVZv23d7vLArnpvf93XqU7eQKYyWW4oxEQy3mouJEAMaZKpUqBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWy7bCSnO4+JrN0g0832SyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFpd3zWGz2PZ7PrMDt8fls6Ue
	m1Z1snnsvtnA5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZXZ9uMRc8Ua1YNWMmUwPjJJku
	Rk4OCQETiafTnrN3MXJxCAnsZpS4cL+ZHSIhIfH2+lFmCFtYYuU/mKKPjBLXbi9hBUmwCWhL
	/Fu5DqxBRMBMYunhNSwgNrPAE0aJHd8rQWxhgWCJZWe3gNWzCKhKtB+6ATaUV8BSov3kTagF
	8hIzL31nh4gLSpyc+QRqjrxE89bZzBMY+WYhSc1CklrAyLSKUTK1oDg3PTfZsMAwL7Vcrzgx
	t7g0L10vOT93EyM4lLU0djDem/9P7xAjEwfjIUYJDmYlEd5TzsbpQrwpiZVVqUX58UWlOanF
	hxilOViUxHkNZ8xOERJITyxJzU5NLUgtgskycXBKNTBdjW33aGcWnHvHSeTJj8przKtDljVv
	/WJrnrrmw+VN81gzUk+6Ppo6W2zNbC/HE7O5E7aUW0y0CV8q/0Bh5u6IY057530K3v3JdVEZ
	o/3zevn6WxcunTifN4m/n/t7D9/SJXmFgls+HSzrStml9fmDR+P1X5IOy/49Vu57Zbrwr9P2
	jpjYaj5b/dd7zRe+FpOOfKw0Qe/ardrNrt3z3wq9eKcbx7rGdPaLtwGhnBwfeE60PNKNZiti
	vhUo8+P6jAB+3yd8f4ovNxqfLzlzUvF7mmaqyxG3bVZSpbpatdOXvJl3ft9FhUaBFYzzHpl9
	7gmYrMPzUGUGX5nKynCeyRPMZ9WK/u1Y6nlfr2zfZbN1SizFGYmGWsxFxYkAb57SqdQCAAA=
X-CMS-MailID: 20241114140134epcas5p3474e82266c4c117919a920d1dd4ed410
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241114140134epcas5p3474e82266c4c117919a920d1dd4ed410
References: <CGME20241114140134epcas5p3474e82266c4c117919a920d1dd4ed410@epcas5p3.samsung.com>

This patch supports adding a large folio to bio for passthrough I/Os,
when mTHP is enabled. Similar to block I/O folio changes [1].

These changes reduce the overhead incurred by bio_map_user_iov for
passthrough I/O.

Perf diff before and after this change:

perf diff for write I/O with 64K block size:
        0.84%   -0.49%  [kernel.kallsyms]       [k] bio_map_user_iov
        1.23%           [kernel.kallsyms]       [k] bvec_try_merge_page
        0.88%           [kernel.kallsyms]       [k] bvec_try_merge_hw_page
perf diff for read I/O with 64K block size:
        1.74%   -1.1%   [kernel.kallsyms]       [k] bio_map_user_iov
        2.39%           [kernel.kallsyms]       [k] bvec_try_merge_page
        1.74%           [kernel.kallsyms]       [k] bvec_try_merge_hw_page

perf diff for write I/O with 128K block size:
        0.84%   -0.6%   [kernel.kallsyms]       [k] bio_map_user_iov
        1.49%           [kernel.kallsyms]       [k] bvec_try_merge_page
        1.19%           [kernel.kallsyms]       [k] bvec_try_merge_hw_page
perf diff for read I/O with 128K block size:
        2.35%   -1.56%  [kernel.kallsyms]       [k] bio_map_user_iov
        4.53%           [kernel.kallsyms]       [k] bvec_try_merge_page
        3.39%           [kernel.kallsyms]       [k] bvec_try_merge_hw_page

[1] commit ed9832bc08db ("block: introduce folio awareness and add a
bigger size from folio")

Signed-off-by: Chinmay Gameti <c.gameti@samsung.com>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 block/bio.c         |  8 ++++----
 block/blk-map.c     | 31 +++++++++++++++++++++++--------
 include/linux/bio.h |  4 ++++
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 699a78c85c75..50e8b565f368 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1203,10 +1203,10 @@ static int bio_iov_add_folio(struct bio *bio, struct folio *folio, size_t len,
 	return 0;
 }
 
-static unsigned int get_contig_folio_len(unsigned int *num_pages,
-					 struct page **pages, unsigned int i,
-					 struct folio *folio, size_t left,
-					 size_t offset)
+unsigned int get_contig_folio_len(unsigned int *num_pages,
+				  struct page **pages, unsigned int i,
+				  struct folio *folio, size_t left,
+				  size_t offset)
 {
 	size_t bytes = left;
 	size_t contig_sz = min_t(size_t, PAGE_SIZE - offset, bytes);
diff --git a/block/blk-map.c b/block/blk-map.c
index b5fd1d857461..216d08c8b0de 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -295,8 +295,9 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		struct page *stack_pages[UIO_FASTIOV];
 		struct page **pages = stack_pages;
 		ssize_t bytes;
-		size_t offs;
 		int npages;
+		unsigned int num_pages;
+		size_t offs, folio_offset, len;
 
 		if (nr_vecs > ARRAY_SIZE(stack_pages))
 			pages = NULL;
@@ -313,21 +314,35 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		if (unlikely(offs & queue_dma_alignment(rq->q)))
 			j = 0;
 		else {
-			for (j = 0; j < npages; j++) {
+			for (j = 0; j < npages; j += num_pages) {
 				struct page *page = pages[j];
-				unsigned int n = PAGE_SIZE - offs;
+				struct folio *folio = page_folio(page);
 				bool same_page = false;
 
-				if (n > bytes)
-					n = bytes;
 
-				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
-						     max_sectors, &same_page))
+				folio_offset = ((size_t)folio_page_idx(folio,
+						page) << PAGE_SHIFT) + offs;
+
+				len = min(folio_size(folio) - folio_offset,
+					  (size_t)bytes);
+
+				num_pages = DIV_ROUND_UP(offs + len,
+							 PAGE_SIZE);
+
+				if (num_pages > 1)
+					len = get_contig_folio_len(
+							&num_pages, pages, j,
+							folio, (size_t)bytes,
+							offs);
+
+				if (!bio_add_hw_folio(rq->q, bio, folio, len,
+						      folio_offset, max_sectors,
+						      &same_page))
 					break;
 
 				if (same_page)
 					bio_release_page(bio, page);
-				bytes -= n;
+				bytes -= len;
 				offs = 0;
 			}
 		}
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 60830a6a5939..1e5fbc875ecc 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -422,6 +422,10 @@ void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
 			  size_t off);
+unsigned int get_contig_folio_len(unsigned int *num_pages,
+				  struct page **pages, unsigned int i,
+				  struct folio *folio, size_t left,
+				  size_t offset);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
 void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
-- 
2.34.1

