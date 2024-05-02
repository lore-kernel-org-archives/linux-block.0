Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB6016FF3E
	for <linux-block@vger.kernel.org>; Thu,  2 May 2024 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672554; cv=none; b=lFhpsV24XJSNNMhwqt0vmBRfWYksUIQn/KltD2k7eMHOl+dDeMP5tM6Vr+TAP6+o1W+z8HyvuJP+krncbirllbXjvobEy8NAhmsRWSGxlZ03JOD/u9+c/jkMbU1ofLnL9ys+ApRpySYoKn5k+ec+JwZki+kZYRbctyGeKfYzXNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672554; c=relaxed/simple;
	bh=KqMW6zx58Ur2C44v2hyh6H9Wx2tddAMcq+u7Msrae8I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=R4WhEBMiybDgideR68Aa6MpUCdmI5TKRSmqp8omfCG/NRIiXCd7LfkyU0gXKuE+qkR7ULWx6iIqRE1Z72hUApv36GPpJGgE1w0rDVWhlO7gTEh8u1/MgubKtGB86QqD4i4dypkNGHQ0fBiP90XjNhVtj+M/zt3bVxn2qd2lBWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pw8JLP5G; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pw8JLP5G"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240502175540epoutp03094c2d6382ec071452aa0939b903a258~LvZdaPfnF0717307173epoutp03F
	for <linux-block@vger.kernel.org>; Thu,  2 May 2024 17:55:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240502175540epoutp03094c2d6382ec071452aa0939b903a258~LvZdaPfnF0717307173epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714672540;
	bh=/0LmGPFqpDUKhCziBxs3O/yAGrSgXC1wkL8qkZhV78I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pw8JLP5Gn64zmEImZBv/8IMVzUz+DqG1KTg1eBJYUoUj4ZWrJWVXG47DnWS7/m/yp
	 wZN1SBj4EpUl7LavmvaBVeMuQ3eYhHMwQpytii7Mj3F6HdIZmFUmWLJHO2cniWpL/u
	 pZ0L1A/ZPUwoq7mLGLrZkcgZJu0/p+Ea2Y468k8g=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240502175539epcas5p2baac5b977114f4cb88d0c5f675770db7~LvZcjz2Ct1165611656epcas5p2q;
	Thu,  2 May 2024 17:55:39 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VVhRt11MYz4x9Pq; Thu,  2 May
	2024 17:55:38 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	88.F7.09688.993D3366; Fri,  3 May 2024 02:55:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240502115908epcas5p341eeafd7a80cdd854d86109cb960dfcb~LqiKNf1gF1009910099epcas5p3w;
	Thu,  2 May 2024 11:59:08 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240502115908epsmtrp1510f98b53006de3ed058851493569f8f~LqiKMrpNV1659616596epsmtrp1w;
	Thu,  2 May 2024 11:59:08 +0000 (GMT)
X-AuditID: b6c32a4a-837fa700000025d8-dd-6633d3991f3c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	70.F5.19234.C0083366; Thu,  2 May 2024 20:59:08 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240502115906epsmtip143a0c3d36e12a95662e35caa7146c836~LqiIoiamO0219402194epsmtip1B;
	Thu,  2 May 2024 11:59:06 +0000 (GMT)
Date: Thu, 2 May 2024 17:22:00 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: Hannes Reinecke <hare@suse.de>
Cc: axboe@kernel.dk, hch@lst.de, willy@infradead.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: block : add larger order folio size instead of pages
Message-ID: <20240502115200.alktwt5w5h3lzegq@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <317ce09b-5fec-4ed2-b32c-d098767956d0@suse.de>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmhu7My8ZpBpfvWVs0TfjLbLH6bj+b
	xfftfSwWNw/sZLLYs2gSk8XK1UeZLI7+f8tmsfeWtsWNCU8ZLbb9ns9s8fvHHDYHbo/NK7Q8
	Lp8t9di0qpPNY/fNBjaPvi2rGD02n672+LxJLoA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON45
	3tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hAJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmt
	UmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xvXfu5gKPrlV7H3UyNzA+Mmii5GTQ0LA
	RGLXnnVMXYxcHEICuxklflyYxA7hfGKUOP/3F4LzYuZxZpiWDz/eQLXsZJS4NOcDG4TzjFFi
	7vdWFpAqFgEVibn/NjB2MXJwsAnoSvxoCgUJiwgoSXxsPwQ2lVngBqPEpBl72EESwgKOEtOa
	3rGC2LwCZhLH2v9C2YISJ2c+AZvJKWAtsX7hczBbVEBGYsbSr1AXreSQWH2dFWSXhICLxNpO
	O4iwsMSr41vYIWwpiZf9bVB2tsShxg1MEHaJxM4jDVBxe4nWU/3MIGOYBTIkLvXEQ4RlJaae
	WgdWzizAJ9H7+wlUK6/EjnkwtprEnHdTWSBsGYmFl2ZAxT0krqy5xgwJnoNA7z7/yTKBUX4W
	ks9mIaybBbbCSqLzQxMrhC0v0bx1NjNEibTE8n8cEKamxPpd+gsY2VYxSqYWFOempxabFhjl
	pZbDoz45P3cTIzgla3ntYHz44IPeIUYmDsZDjBIczEoivNqTjdOEeFMSK6tSi/Lji0pzUosP
	MZoCI20is5Rocj4wK+SVxBuaWBqYmJmZmVgamxkqifO+bp2bIiSQnliSmp2aWpBaBNPHxMEp
	1cCk8uD8aTfRlRs//RWWuiZ2tynHfYGzK+uCDh6msEtszBdO/Dhw6Pz203f45Upzt95kZm2Z
	Z2L+7GCZ+eqiJybcmomTPLJjPxm6rv/Tc897Qlpv9tI1V9N5whZUGbqc7mBT/snUxPpo1Qzz
	aTsfmW/hUZ65WaVrgliqU/fek9s+JW148j3gyrbZDk2d5o8C7zQeuMvDote94R/b6YqmtX8Z
	V/1/e5PT6cyl/3pzfxqvf/82a2OcyLnAKjv7ow1au+9MWZf1wzN4Kq/5530vhT7O0f2oEXzz
	IkfaUfXnWWs+c3id+Jxbm/xNwDQsZmq6Tar0a0cOpdML9iyz/iVi9+kl2+cr/o4PWAVqmT/M
	cX4ho8RSnJFoqMVcVJwIAB0sRo1SBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJTpenwTjNYO0PSYumCX+ZLVbf7Wez
	+L69j8Xi5oGdTBZ7Fk1isli5+iiTxdH/b9ks9t7Strgx4Smjxbbf85ktfv+Yw+bA7bF5hZbH
	5bOlHptWdbJ57L7ZwObRt2UVo8fm09UenzfJBbBHcdmkpOZklqUW6dslcGVMO+lX0OxS0bff
	voFxgVkXIyeHhICJxIcfb5i6GLk4hAS2M0pMX9fGBpGQkdh9dycrhC0ssfLfc3aIoieMEs/f
	/mYGSbAIqEjM/beBsYuRg4NNQFfiR1MoSFhEQEniY/shsHpmgRuMEpNm7GEHSQgLOEpMa3oH
	NpRXwEziWPtfVoihBxklVp7dxAKREJQ4OfMJmM0MVDRv80NmkAXMAtISy/9xQITlJZq3zga7
	gVPAWmL9wudg5aJAR89Y+pV5AqPQLCSTZiGZNAth0iwkkxYwsqxiFE0tKM5Nz00uMNQrTswt
	Ls1L10vOz93ECI4uraAdjMvW/9U7xMjEwXiIUYKDWUmEd8pC/TQh3pTEyqrUovz4otKc1OJD
	jNIcLErivMo5nSlCAumJJanZqakFqUUwWSYOTqkGpoT8XZJzTuepn1Q5yP+5Y3/h86AEVect
	0lMZJrmyPJny1b/lyaeptWbn9VkOC+387G4rH1zIaM15ac+vr2Znpj5wuVMd0T+rI8TDteb4
	2iZelf7nPzTfhNhvvsj4iIczV9VxlfLLkA8XtqUKz7RMqLyWPl3se+T67HO33r//Lsk6UY3d
	seliTSfLzMYMHv7nx/syTad7tD7zXfdmr72+jLDBWeFF///Pb71h3aV1uOZXEvPVXbzv1a9+
	S770yp/nm5F6ymvpX7adpu9YZCNfrg62+Pyo/Fhzh0Dvk1Nm6eUx1UkV7Hsnf2vfpGArH1C1
	dTa3tT23lPIVHu9fbjFqz84eOMQa3pZza+HZTqMIJZbijERDLeai4kQADghIkB0DAAA=
X-CMS-MailID: 20240502115908epcas5p341eeafd7a80cdd854d86109cb960dfcb
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_d572e_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240430175735epcas5p103ac74e1482eda3e393c0034cea8e9ff
References: <CGME20240430175735epcas5p103ac74e1482eda3e393c0034cea8e9ff@epcas5p1.samsung.com>
	<20240430175014.8276-1-kundan.kumar@samsung.com>
	<317ce09b-5fec-4ed2-b32c-d098767956d0@suse.de>

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_d572e_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 02/05/24 08:45AM, Hannes Reinecke wrote:
>On 4/30/24 19:50, Kundan Kumar wrote:
>>When mTHP is enabled, IO can contain larger folios instead of pages.
>>In such cases add a larger size to the bio instead of looping through
>>pages. This reduces the overhead of iterating through pages for larger
>>block sizes. perf diff before and after this change:
>>
>>Perf diff for write I/O with 128K block size:
>>	1.26%     -1.04%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
>>	1.74%             [kernel.kallsyms]  [k] bvec_try_merge_page
>>Perf diff for read I/O with 128K block size:
>>	4.40%     -3.63%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
>>	5.60%             [kernel.kallsyms]  [k] bvec_try_merge_page
>>
>>Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
>>---
>>Changes since v1:
>>https://lore.kernel.org/all/20240419091721.1790-1-kundan.kumar@samsung.com/
>>- Changed functions bio_iov_add_page() and bio_iov_add_zone_append_page() to
>>   accept a folio
>>- Removed branching and now calculate folio_offset and len in same fashion for
>>   both 0 order and larger folios
>>- Added change in NVMe driver to use nvme_setup_prp_simple() by ignoring
>>   multiples of NVME_CTRL_PAGE_SIZE in offset
>>- Added change to unpin_user_pages which were added as folios. Also stopped
>>   the unpin of pages one by one from __bio_release_pages()(Suggested by
>>   Keith)
>>
>>  block/bio.c             | 48 +++++++++++++++++++++++++----------------
>>  drivers/nvme/host/pci.c |  3 ++-
>>  2 files changed, 31 insertions(+), 20 deletions(-)
>>
>>diff --git a/block/bio.c b/block/bio.c
>>index 38baedb39c6f..0ec453ad15b3 100644
>>--- a/block/bio.c
>>+++ b/block/bio.c
>>@@ -1155,7 +1155,6 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
>>  	bio_for_each_folio_all(fi, bio) {
>>  		struct page *page;
>>-		size_t nr_pages;
>>  		if (mark_dirty) {
>>  			folio_lock(fi.folio);
>>@@ -1163,11 +1162,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
>>  			folio_unlock(fi.folio);
>>  		}
>>  		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
>>-		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
>>-			   fi.offset / PAGE_SIZE + 1;
>>-		do {
>>-			bio_release_page(bio, page++);
>>-		} while (--nr_pages != 0);
>>+		bio_release_page(bio, page);
>
>Errm. I guess you need to call 'folio_put()' here, otherwise the page 
>reference counting will be messed up.

Though we call bio_release_page() the actual ref counting is working on folios.
We can keep it like:
+               bio_release_page(bio, &fi.folio->page);
which will avoid a call to folio_page. Also will take care of flag 
BIO_PAGE_PINNED.

>
>>  	}
>>  }
>>  EXPORT_SYMBOL_GPL(__bio_release_pages);
>>@@ -1192,7 +1187,7 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
>>  	bio_set_flag(bio, BIO_CLONED);
>>  }
>>-static int bio_iov_add_page(struct bio *bio, struct page *page,
>>+static int bio_iov_add_folio(struct bio *bio, struct folio *folio,
>>  		unsigned int len, unsigned int offset)
>>  {
>>  	bool same_page = false;
>>@@ -1202,27 +1197,26 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
>>  	if (bio->bi_vcnt > 0 &&
>>  	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
>>-				page, len, offset, &same_page)) {
>>+				&folio->page, len, offset, &same_page)) {
>>  		bio->bi_iter.bi_size += len;
>>  		if (same_page)
>>-			bio_release_page(bio, page);
>>+			bio_release_page(bio, &folio->page);
>>  		return 0;
>>  	}
>>-	__bio_add_page(bio, page, len, offset);
>>+	bio_add_folio_nofail(bio, folio, len, offset);
>>  	return 0;
>>  }
>
>That is not a valid conversion.
>bvec_try_to_merge_pages() will try to merge a page with an existing
>bvec. If the logic is switch to folios you would need to iterate over
>all pages in a folio, and call bvec_try_to_merge_pages() for each page
>in the folio.
>Or convert / add a function 'bvec_try_to_merge_folio()'.
>But with the above patch it will only ever try to merge the first page
>in the folio.
>

This logic is to merge contiguous pages. In case the new folio to be added
is contiguous to the existing bvec, this will merge the new folio also.
We need not iterate over the pages one by one as pages in folio will be
contiguous. The folio_offset does the job, if folio_offset is 0 then
we check if the first page of folio is contiguous to existing bvec. 

>>-static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
>>+static int bio_iov_add_zone_append_folio(struct bio *bio, struct folio *folio,
>>  		unsigned int len, unsigned int offset)
>>  {
>>  	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>>  	bool same_page = false;
>>-
>>-	if (bio_add_hw_page(q, bio, page, len, offset,
>>+	if (bio_add_hw_page(q, bio, &folio->page, len, offset,
>>  			queue_max_zone_append_sectors(q), &same_page) != len)
>
>Wouldn't this just try to add the first page in a folio?
>

Yes or no, depends on offset passed here. This will try to add the first page,
with an offset which can be multiple of pages also. Say if we add 4th page in
folio the offset becomes 4096*3 = 12288.

>>  		return -EINVAL;
>>  	if (same_page)
>>-		bio_release_page(bio, page);
>>+		bio_release_page(bio, &folio->page);
>>  	return 0;
>>  }
>>@@ -1247,8 +1241,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>>  	struct page **pages = (struct page **)bv;
>>  	ssize_t size, left;
>>  	unsigned len, i = 0;
>>-	size_t offset;
>>+	size_t offset, folio_offset, size_folio;
>>  	int ret = 0;
>>+	int num_pages;
>>+	struct folio *folio;
>>  	/*
>>  	 * Move page array up in the allocated memory for the bio vecs as far as
>>@@ -1289,16 +1285,30 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>>  	for (left = size, i = 0; left > 0; left -= len, i++) {
>>  		struct page *page = pages[i];
>>+		folio = page_folio(page);
>>+
>>+		/* See the offset in folio and the size */
>>+		folio_offset = (folio_page_idx(folio, page)
>>+				<< PAGE_SHIFT) + offset;
>>+		size_folio = folio_size(folio);
>>+
>>+		/* Calculate the length of folio to be added */
>>+		len = min_t(size_t, (size_folio - folio_offset), left);
>>+
>>+		num_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
>>-		len = min_t(size_t, PAGE_SIZE - offset, left);
>>  		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
>>-			ret = bio_iov_add_zone_append_page(bio, page, len,
>>-					offset);
>>+			ret = bio_iov_add_zone_append_folio(bio, folio, len,
>>+					folio_offset);
>>  			if (ret)
>>  				break;
>>  		} else
>>-			bio_iov_add_page(bio, page, len, offset);
>>+			bio_iov_add_folio(bio, folio, len, folio_offset);
>>+		/* Skip the pages which got added */
>>+		if (bio_flagged(bio, BIO_PAGE_PINNED) && num_pages > 1)
>>+			unpin_user_pages(pages + i, num_pages - 1);
>>+		i = i + (num_pages - 1);
>>  		offset = 0;
>>  	}
>I would rather use folio as an argument here ...
>

I didnt understand which exact line number here.

For extracting the pages, as of now we are dependent on pin_user_pages and
iov_iter_extract_pages kind of functions which work on pages. There is an
overhead because of pinning and unpinning every page. As suggested
by Christoph "in the long run we really need a folio version of pin_user_pages
and iov_iter_extract_pages."

>>diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>index 8e0bb9692685..7c07b0582cae 100644
>>--- a/drivers/nvme/host/pci.c
>>+++ b/drivers/nvme/host/pci.c
>>@@ -778,7 +778,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>>  		struct bio_vec bv = req_bvec(req);
>>  		if (!is_pci_p2pdma_page(bv.bv_page)) {
>>-			if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
>>+			if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1))
>>+				+ bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
>>  				return nvme_setup_prp_simple(dev, req,
>>  							     &cmnd->rw, &bv);
>
>In general I'm in favour of moving the block layer over to folios, but 
>then we should do it by adding a folio-based version of the functions,
>and the gradually convert the callers over to those functions.
>
>Trying to slide it in via folio->page or page_folio() things is not
>the way to do it as they are not equivalent transformations.
>
>Cheers,
>
>Hannes
>-- 
>Dr. Hannes Reinecke                  Kernel Storage Architect
>hare@suse.de                                +49 911 74053 688
>SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
>HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
>

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_d572e_
Content-Type: text/plain; charset="utf-8"


------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_d572e_--
