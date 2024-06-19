Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49651E878
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 04:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718769635; cv=none; b=VRGHyEtzAqOgmyw8KoyCOzkmg1AK39BGt0EBQu+sWpQ3WFpZZcs221ww7Y/07wMFxAQPiE50EfstNNu+eOzFS2vEuyfVi8yjCle/xf9EgJtThf0vj16/Nd3/gQJ8GidDA7ZCWNuqAcovKMbMhRzVmVTlOMznBcPzUKjAUgvA1hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718769635; c=relaxed/simple;
	bh=yh714mMjhBzx083r6+ngC/PU0ZhtaKddSeV6+SjZw8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=TCmWAO74Q6/8pksIYrHZJ2mJxgPF9Y/AYTRLon+a2vl0pOpiVz49HVqFSasI3wRSM1oXbdLhyfRCQRI4bSbcGfqZtDnHB/7Uyg25emHYlqB1ej4t+FL9lZ9GoX2lnR69onFvBl7pA79+UwL9Hu/lsNSgo0gqvnhA3bux8rQv9z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=A+O+7ami; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A+O+7ami"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240619040031epoutp01516cd9d8ccdba7e9584b715c2c9fe8dc~aS9_CFA-Y1249412494epoutp01b
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 04:00:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240619040031epoutp01516cd9d8ccdba7e9584b715c2c9fe8dc~aS9_CFA-Y1249412494epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718769631;
	bh=gTaEFuMQdfljl8wzbgFV7DjFGFvYaSv9FTBFs1jOmgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+O+7amiP1zUc3ncARLdPui6FB6SGxhn2/V/4rjSAGUcDOa925wWHJr4uIszefrsL
	 viHQ9/C7sveHuzZsRsKzoE6sM9hrGmE7/zOhybadZ1Fk3iFea6wvR5LFQo+m9NDWTI
	 bYCyO0WP9CGGBq3BPj+1pUqyarIhuZuheLyJ77wI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240619040030epcas5p1eddd02c57896a8495bfeecd845ae4703~aS99ilRTA2658426584epcas5p1B;
	Wed, 19 Jun 2024 04:00:30 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4W3qf45m02z4x9QB; Wed, 19 Jun
	2024 04:00:28 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B9.8B.10047.CD752766; Wed, 19 Jun 2024 13:00:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240619024150epcas5p267bd3cbd24061e723a7b632746de92d6~aR5RtXtty2382823828epcas5p2m;
	Wed, 19 Jun 2024 02:41:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240619024150epsmtrp22795ceb696a7d2c3118ffa4e19de1a8b~aR5RsecYX0340503405epsmtrp2k;
	Wed, 19 Jun 2024 02:41:50 +0000 (GMT)
X-AuditID: b6c32a49-1d5fa7000000273f-13-667257dc2c5b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	78.9A.29940.E6542766; Wed, 19 Jun 2024 11:41:50 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240619024148epsmtip27ea1bf4604f93039e7a1f56d305b23c7~aR5P_-8yA0156201562epsmtip26;
	Wed, 19 Jun 2024 02:41:48 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v5 2/3] block: add folio awareness instead of looping
 through pages
Date: Wed, 19 Jun 2024 08:04:19 +0530
Message-Id: <20240619023420.34527-3-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240619023420.34527-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmlu6d8KI0g7YVOhZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+P5m8MsBRf1Ko7eXs/WwNgt18XIySEh
	YCJx4tNUdhBbSGA3o8TDK7VdjFxA9idGif6Dj1ghnG+MEo8/PmWC6djZfJ4RIrGXUWLnvYvM
	EM5nRon3M2cCZTg42AR0JX40hYI0iAi4S0x9+QisgVngLKPEiamPWEASwgKhEvcOLgWbyiKg
	KtF54x8ziM0rYCvx7MUPdoht8hIzL31nB5nJKWAn8fOKNUSJoMTJmU/AxjADlTRvnQ12g4TA
	RA6Jpk39jBC9LhJzrl9hgbCFJV4d3wI1U0ri87u9bBB2tsShxg1Qn5VI7DzSAFVjL9F6qp8Z
	ZC+zgKbE+l36EGFZiamn1jFB7OWT6P39BKqVV2LHPBhbTWLOu6lQa2UkFl6aARX3kHgwrR0a
	ohMZJf6+esQ0gVFhFpJ/ZiH5ZxbC6gWMzKsYJVMLinPTU4tNCwzzUsvhkZycn7uJEZxotTx3
	MN598EHvECMTB+MhRgkOZiURXqdpeWlCvCmJlVWpRfnxRaU5qcWHGE2B4T2RWUo0OR+Y6vNK
	4g1NLA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamAqPr0gzYQ55YHi9fBz
	b3MrBGxnKy1aJihn91Ak/9K6i77njIVmxf6/n/vs5MeJl075JLAnHFOJ9gu0KLxjnVS7v0jM
	uuKXt/uRrRt/XVRsCXjwQZGL7YL91YSSdq8L7qvuqu7Kvly6x7Ul6Abnx8pXKj6zE45PqC/f
	aS3+xtPo5KzqsPBfwtkvazPvzwtZ4tlp1VwjZXSUN0TiWSv/jYj7F+7c4FzDfiSOc7Fn84xJ
	s/7pK3/Prz3rULfrrd2CgyVPrk24oszMerH30wQl2xVGCa+3CPpuNfjUpGxw9EH/DrXpfMl2
	LxczmXdsOCFtJntEXvd3CPcxzml1sq/Oxj0yDT14P+Zof2414/r/tcJKLMUZiYZazEXFiQC1
	HgzYPQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvG6ea1GaQct9GYumCX+ZLVbf7Wez
	+L69j8Xi5oGdTBYrVx9lsjj6/y2bxaRD1xgttn75ymqx95a2xY0JTxkttv2ez2zx+8ccNgce
	j80rtDwuny312LSqk81j980GNo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKeP7mMEvBRb2K
	o7fXszUwdst1MXJySAiYSOxsPs/YxcjFISSwm1Hiy7mDbBAJGYndd3eyQtjCEiv/PWeHKPrI
	KHF62RqgDg4ONgFdiR9NoSA1IgK+Egs2PAcbxCxwnVHixvStzCA1wgLBEqebk0FqWARUJTpv
	/GMGsXkFbCWevfjBDjFfXmLmpe/sIOWcAnYSP69Yg4SFgEr6VnxggSgXlDg58wmYzQxU3rx1
	NvMERoFZSFKzkKQWMDKtYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjgQtzR2M21d9
	0DvEyMTBeIhRgoNZSYTXaVpemhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe8Re9KUIC6Yklqdmp
	qQWpRTBZJg5OqQamC4ZcL5x//WZ/Hed3PNuk+qD21nBjzzvPzvPclpyctLd89SGdvU5Zb/+z
	/S3PzbnS5fbk163JBwKue+asC39wzqFpd7rztw/bW+3aTnVVF3TzCJR8MNRZ/jTEmm3DV4GF
	20++2L111Z8pDo9kXzHbfWszD+oszvLT04j8OF1dPTZJYcETY8WbiVPMZ59eUlcYEHbippmA
	TOj1Gb0P7dauEk+49rC/ljMz5YFd4ToLq7nGzsICFVc/ctbH8zKtcwq6tWJNokBD9aPrLztj
	dp9omW7xv6Yn+P41vvs8H5MPftt9uK6FxefBcbPNT7Ifye1v6XVLOlkg4DA7+aXBnyW1Ytwd
	np8/8ZzRkdvXbvlfiaU4I9FQi7moOBEAkpeSy/MCAAA=
X-CMS-MailID: 20240619024150epcas5p267bd3cbd24061e723a7b632746de92d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240619024150epcas5p267bd3cbd24061e723a7b632746de92d6
References: <20240619023420.34527-1-kundan.kumar@samsung.com>
	<CGME20240619024150epcas5p267bd3cbd24061e723a7b632746de92d6@epcas5p2.samsung.com>

Add a bigger size from folio to bio and skip merge processing for pages.

Fetch the offset of page within a folio. Depending on the size of folio
and folio_offset, fetch a larger length. This length may consist of
multiple contiguous pages if folio is multiorder.

Using the length calculate number of pages which will be added to bio and
increment the loop counter to skip those pages.

Using a helper function check if pages are contiguous and belong to same
folio, this is done as a COW may happen and change contiguous mapping of
pages of folio.

This technique helps to avoid overhead of merging pages which belong to
same large order folio.

Also folio-lize the functions bio_iov_add_page() and
bio_iov_add_zone_append_page()

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 block/bio.c | 72 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index c8914febb16e..3e75b5b0eb6e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1224,7 +1224,7 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
        bio_set_flag(bio, BIO_CLONED);
 }

-static int bio_iov_add_page(struct bio *bio, struct page *page,
+static int bio_iov_add_folio(struct bio *bio, struct folio *folio,
                unsigned int len, unsigned int offset)
 {
        bool same_page = false;
@@ -1234,30 +1234,60 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,

        if (bio->bi_vcnt > 0 &&
            bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
-                               page, len, offset, &same_page)) {
+                               folio_page(folio, 0), len, offset,
+                               &same_page)) {
                bio->bi_iter.bi_size += len;
                if (same_page)
-                       bio_release_page(bio, page);
+                       bio_release_page(bio, folio_page(folio, 0));
                return 0;
        }
-       __bio_add_page(bio, page, len, offset);
+       bio_add_folio_nofail(bio, folio, len, offset);
        return 0;
 }

-static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
+static int bio_iov_add_zone_append_folio(struct bio *bio, struct folio *folio,
                unsigned int len, unsigned int offset)
 {
        struct request_queue *q = bdev_get_queue(bio->bi_bdev);
        bool same_page = false;

-       if (bio_add_hw_page(q, bio, page, len, offset,
+       if (bio_add_hw_folio(q, bio, folio, len, offset,
                        queue_max_zone_append_sectors(q), &same_page) != len)
                return -EINVAL;
        if (same_page)
-               bio_release_page(bio, page);
+               bio_release_page(bio, folio_page(folio, 0));
        return 0;
 }

+static unsigned int get_contig_folio_len(int *num_pages, struct page **pages,
+                                        int i, struct folio *folio,
+                                        ssize_t left, size_t offset)
+{
+       ssize_t bytes = left;
+       size_t contig_sz = min_t(size_t,  PAGE_SIZE - offset, bytes);
+       unsigned int j;
+
+       /*
+        * We might COW a single page in the middle of
+        * a large folio, so we have to check that all
+        * pages belong to the same folio.
+        */
+       bytes -= contig_sz;
+       for (j = i + 1; j < i + *num_pages; j++) {
+               size_t next = min_t(size_t, PAGE_SIZE, bytes);
+
+               if (page_folio(pages[j]) != folio ||
+                   pages[j] != pages[j - 1] + 1) {
+                       break;
+               }
+               contig_sz += next;
+               bytes -= next;
+       }
+       *num_pages = j - i;
+
+       return contig_sz;
+}
+
 #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))

 /**
@@ -1277,9 +1307,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
        unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
        struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
        struct page **pages = (struct page **)bv;
-       ssize_t size, left;
-       unsigned len, i = 0;
-       size_t offset;
+       ssize_t size, left, len;
+       unsigned int i = 0, num_pages;
+       size_t offset, folio_offset;
        int ret = 0;

        /*
@@ -1321,15 +1351,29 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)

        for (left = size, i = 0; left > 0; left -= len, i++) {
                struct page *page = pages[i];
+               struct folio *folio = page_folio(page);
+
+               folio_offset = (folio_page_idx(folio, page) << PAGE_SHIFT) +
+                               offset;
+
+               len = min_t(size_t, (folio_size(folio) - folio_offset), left);
+
+               num_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
+
+               if (num_pages > 1)
+                       len = get_contig_folio_len(&num_pages, pages, i,
+                                                  folio, left, offset);

-               len = min_t(size_t, PAGE_SIZE - offset, left);
                if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-                       ret = bio_iov_add_zone_append_page(bio, page, len,
-                                       offset);
+                       ret = bio_iov_add_zone_append_folio(bio, folio, len,
+                                       folio_offset);
                        if (ret)
                                break;
                } else
-                       bio_iov_add_page(bio, page, len, offset);
+                       bio_iov_add_folio(bio, folio, len, folio_offset);
+
+               /* Skip the pages which got added */
+               i = i + (num_pages - 1);

                offset = 0;
        }
--
2.25.1

