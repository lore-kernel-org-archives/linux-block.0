Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A3628
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 05:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718860656; cv=none; b=O3PNqPdMkCx6ipp00RmVml74TWY4+HJXn48rOhnnqFdAi/hvHzidf6UK2N969jqwCYuRNSDfnoVf8Oxy1+jY23zOhJ4BAgQhjdwkSB8bQ1G55IpbmsfowYw9pkSCLsf8rmiduhHJ3pSV283zRwmsVYNOyz9oViwn2Sv7k85+vLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718860656; c=relaxed/simple;
	bh=ABP+ovlp0dRl2e1LGFVyFpWEVC4hloWrOSc/eAFEdRo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=mdNMnK2Cfww2hqh/YrdJZClWjKi+n2ftD/9gnQYKWV+pM/Y0ugzESGBrfBENlMhYiNKkp6D0Ht/pcJqOkRM6+c+bcfrKRxTUFUM8NnMJ2UXRwZHrIQWIZiLeEBzzySBFjX4gfdtXN3OGj+ZpQmLDt+OntV2Nj/i8HeVpU8RbQgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tt06Yl0T; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tt06Yl0T"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240620051727epoutp02bcfd0dd808dce6dfbf72a5d15be663bf~anqbyIxuR3147931479epoutp02A
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 05:17:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240620051727epoutp02bcfd0dd808dce6dfbf72a5d15be663bf~anqbyIxuR3147931479epoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718860647;
	bh=SSOTuHu0ZyIeO8i84SzRXbtSng+WYY8Wmydp5b58418=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tt06Yl0TwiF5qczxsORZjdRxHem62zSiXOCcuyZ///IWcu15ooznipW2ZtnfCJGeZ
	 CEJtSVJBmW2lWzXYnO8Oo+V5GrMIQmPNouOtUtf2rsU6NjGvr/C6r9S7wFeKFYJ2sO
	 WhICOtSszAsDNvaDDgn/GxTQJhZ8QeiuIn1ssxzE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240620051727epcas5p13d29710198453474491b89846f41b48a~anqbVlkdT1005710057epcas5p1L;
	Thu, 20 Jun 2024 05:17:27 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4W4TJN4xGVz4x9QB; Thu, 20 Jun
	2024 05:17:24 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	47.42.09989.46BB3766; Thu, 20 Jun 2024 14:17:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240620045555epcas5p37ed60a0e2076c698e86f3467d94b8c02~anXoSiHJy0656306563epcas5p3R;
	Thu, 20 Jun 2024 04:55:55 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240620045555epsmtrp242a5524c4cacb308cd191da7f61dd484~anXoRmKxO2371023710epsmtrp2W;
	Thu, 20 Jun 2024 04:55:55 +0000 (GMT)
X-AuditID: b6c32a4a-bffff70000002705-a8-6673bb641951
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F0.9C.19057.B56B3766; Thu, 20 Jun 2024 13:55:55 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240620045553epsmtip141e3c4646695604953c499c7e09307ee~anXmgeVoB0858308583epsmtip1t;
	Thu, 20 Jun 2024 04:55:53 +0000 (GMT)
Date: Thu, 20 Jun 2024 10:18:42 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: Hannes Reinecke <hare@suse.de>
Cc: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v5 2/3] block: add folio awareness instead of looping
 through pages
Message-ID: <20240620044842.oxbryv2i7q4muiwf@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c29524a5-f3c7-4236-968c-58b5f3004b66@suse.de>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmhm7K7uI0gzNn2S2aJvxltlh9t5/N
	4vv2PhaLmwd2MlnsWTSJyWLl6qNMFkf/v2WzmHToGqPF3lvaFjcmPGW02PZ7PrPF7x9z2Bx4
	PDav0PK4fLbUY9OqTjaP3Tcb2Dz6tqxi9Nh8utrj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRb
	Je/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoCuVFMoSc0qBQgGJxcVK+nY2RfmlJakK
	GfnFJbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZT/6fYy2Y5lox48Jf1gbG4wZd
	jJwcEgImEm0n/rB0MXJxCAnsZpRY9/AfK4TziVGivW0SlPONUeLh5JvMMC0PNk1jhkjsZZRY
	9HQdE0hCSOAZo8SXfaEgNouAqsTPtu9A3RwcbAK6Ej+awMIiAkoSH9sPsYP0Mgu8ZpSYd+0s
	I0hCWCBS4v7KD2ALeAXMJI7vng9lC0qcnPmEBcTmFLCWeN90nQ3EFhWQkZix9CvYERICezgk
	zt96wApxnYvE8Qc/2SBsYYlXx7ewQ9hSEp/f7YWKZ0scatzABGGXSOw80gBVYy/ReqqfGeRo
	ZoEMiabHQhBhWYmppyB+ZBbgk+j9/QSqlVdixzwYW01izrupLBC2jMTCSzOg4h4SD6a1I0Jx
	Y/9ttgmM8rOQ/DYLYd0ssBVWEp0fmlghbHmJ5q2zmSFKpCWW/+OAMDUl1u/SX8DItopRMrWg
	ODc9tdi0wCgvtRwe98n5uZsYwelZy2sH48MHH/QOMTJxMB5ilOBgVhLhfd5VlCbEm5JYWZVa
	lB9fVJqTWnyI0RQYbROZpUST84EZIq8k3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU7NTU
	gtQimD4mDk6pBiZb9ttGeuIbwh7sYH+2e+5U/bw+l9oAngM/3qY0pc5s+sn3XyPL9oyt07I3
	sz70KU6zvjx72pmzG1LFlzlY7mvIl7L9yl31c/LM0r4temlFNVd25QTNff4uNkfZIy5DMu3i
	+9xNMx858D113rvux+EAa9sTDYu/tTQfrStTaJlw9H3p/xm2T2YE/gvYWFbR6TAzaPr77N5V
	omc/sa8tYDL6ahfeyPhv/+W1hk9f/Wb/tuPeo13xZ82kj+uYStk+DeV/uH3Z5rUfDO9Y1F6Z
	cl783nelyjv/ShV7Xf3sdUMdXsexTluxd9/erRNXmHQ+yH7ts6GYyWzBjXVHojIrT75ovZf8
	7jnLb9Nvm3LW+Sa1KrEUZyQaajEXFScCAEbf+x9YBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSnG70tuI0g3mTBCyaJvxltlh9t5/N
	4vv2PhaLmwd2MlnsWTSJyWLl6qNMFkf/v2WzmHToGqPF3lvaFjcmPGW02PZ7PrPF7x9z2Bx4
	PDav0PK4fLbUY9OqTjaP3Tcb2Dz6tqxi9Nh8utrj8ya5APYoLpuU1JzMstQifbsErowFXeoF
	y50q2na0szQwftXtYuTkkBAwkXiwaRpzFyMXh5DAbkaJFRdPMkIkZCR2393JCmELS6z895wd
	ougJo0TL7cMsIAkWAVWJn23fgYo4ONgEdCV+NIWChEUElCQ+th8Cq2cWeM0oMe/aWbChwgKR
	EvdXfmAGsXkFzCSO754PZgsJfGOUePBAFSIuKHFy5hOw+cxANfM2P2QGmc8sIC2x/B8HRFhe
	onnrbLBWTgFrifdN19lAbFGgm2cs/co8gVFoFpJJs5BMmoUwaRaSSQsYWVYxSqYWFOem5xYb
	FhjlpZbrFSfmFpfmpesl5+duYgTHm5bWDsY9qz7oHWJk4mA8xCjBwawkwvu8qyhNiDclsbIq
	tSg/vqg0J7X4EKM0B4uSOO+3170pQgLpiSWp2ampBalFMFkmDk6pBqZLdnmH/iz5u3TqvZBC
	1hQZpqyGLW/exh1jOme85/AP9olu1q+Fnfa1fzD9JREgePIS37xb25yemRrJ2G+9cczBxbv/
	7f9KQ53OHOavrUX3i77IVUZeK5oibpmwVHYB634N84+3HU5c/C+vcmd90iGhvxpXPD2KMxNM
	PPI5J/tf8pFx2N4fdnBe/qTsC18l9jluLDl/oshwd12me8zafZxG+eKmmzh1jcX42T6Gq6Qs
	LtX0ai6qFYq4s21N0NpPbXdnZjTrxTCyzlxr5HKu315uzzzeD6F+OTeuvZz36YauBouKyLqZ
	Zr7C+Trz/spXvT246g9nRjh/xhdz/d3HLt9m3hh1c6OrNteV0O2vbyixFGckGmoxFxUnAgAt
	voM4JgMAAA==
X-CMS-MailID: 20240620045555epcas5p37ed60a0e2076c698e86f3467d94b8c02
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_9f737_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240619024150epcas5p267bd3cbd24061e723a7b632746de92d6
References: <20240619023420.34527-1-kundan.kumar@samsung.com>
	<CGME20240619024150epcas5p267bd3cbd24061e723a7b632746de92d6@epcas5p2.samsung.com>
	<20240619023420.34527-3-kundan.kumar@samsung.com>
	<c29524a5-f3c7-4236-968c-58b5f3004b66@suse.de>

------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_9f737_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 19/06/24 09:47AM, Hannes Reinecke wrote:
>On 6/19/24 04:34, Kundan Kumar wrote:
>>Add a bigger size from folio to bio and skip merge processing for pages.
>>
>>Fetch the offset of page within a folio. Depending on the size of folio
>>and folio_offset, fetch a larger length. This length may consist of
>>multiple contiguous pages if folio is multiorder.
>>
>>Using the length calculate number of pages which will be added to bio and
>>increment the loop counter to skip those pages.
>>
>>Using a helper function check if pages are contiguous and belong to same
>>folio, this is done as a COW may happen and change contiguous mapping of
>>pages of folio.
>>
>>This technique helps to avoid overhead of merging pages which belong to
>>same large order folio.
>>
>>Also folio-lize the functions bio_iov_add_page() and
>>bio_iov_add_zone_append_page()
>>
>>Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
>>---
>>  block/bio.c | 72 ++++++++++++++++++++++++++++++++++++++++++-----------
>>  1 file changed, 58 insertions(+), 14 deletions(-)
>>
>>diff --git a/block/bio.c b/block/bio.c
>>index c8914febb16e..3e75b5b0eb6e 100644
>>--- a/block/bio.c
>>+++ b/block/bio.c
>>@@ -1224,7 +1224,7 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
>>         bio_set_flag(bio, BIO_CLONED);
>>  }
>>
>>-static int bio_iov_add_page(struct bio *bio, struct page *page,
>>+static int bio_iov_add_folio(struct bio *bio, struct folio *folio,
>>                 unsigned int len, unsigned int offset)
>>  {
>>         bool same_page = false;
>>@@ -1234,30 +1234,60 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
>>
>>         if (bio->bi_vcnt > 0 &&
>>             bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
>>-                               page, len, offset, &same_page)) {
>>+                               folio_page(folio, 0), len, offset,
>>+                               &same_page)) {
>>                 bio->bi_iter.bi_size += len;
>>                 if (same_page)
>>-                       bio_release_page(bio, page);
>>+                       bio_release_page(bio, folio_page(folio, 0));
>>                 return 0;
>>         }
>>-       __bio_add_page(bio, page, len, offset);
>>+       bio_add_folio_nofail(bio, folio, len, offset);
>>         return 0;
>>  }
>>
>>-static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
>>+static int bio_iov_add_zone_append_folio(struct bio *bio, struct folio *folio,
>>                 unsigned int len, unsigned int offset)
>>  {
>>         struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>>         bool same_page = false;
>>
>>-       if (bio_add_hw_page(q, bio, page, len, offset,
>>+       if (bio_add_hw_folio(q, bio, folio, len, offset,
>>                         queue_max_zone_append_sectors(q), &same_page) != len)
>>                 return -EINVAL;
>>         if (same_page)
>>-               bio_release_page(bio, page);
>>+               bio_release_page(bio, folio_page(folio, 0));
>>         return 0;
>>  }
>>
>>+static unsigned int get_contig_folio_len(int *num_pages, struct page **pages,
>>+                                        int i, struct folio *folio,
>>+                                        ssize_t left, size_t offset)
>>+{
>>+       ssize_t bytes = left;
>>+       size_t contig_sz = min_t(size_t,  PAGE_SIZE - offset, bytes);
>>+       unsigned int j;
>>+
>>+       /*
>>+        * We might COW a single page in the middle of
>>+        * a large folio, so we have to check that all
>>+        * pages belong to the same folio.
>>+        */
>>+       bytes -= contig_sz;
>>+       for (j = i + 1; j < i + *num_pages; j++) {
>>+               size_t next = min_t(size_t, PAGE_SIZE, bytes);
>>+
>>+               if (page_folio(pages[j]) != folio ||
>>+                   pages[j] != pages[j - 1] + 1) {
>>+                       break;
>>+               }
>>+               contig_sz += next;
>>+               bytes -= next;
>>+       }
>>+       *num_pages = j - i;
>>+
>>+       return contig_sz;
>>+}
>>+
>>  #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
>>
>>  /**
>>@@ -1277,9 +1307,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>>         unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
>>         struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>>         struct page **pages = (struct page **)bv;
>>-       ssize_t size, left;
>>-       unsigned len, i = 0;
>>-       size_t offset;
>>+       ssize_t size, left, len;
>>+       unsigned int i = 0, num_pages;
>>+       size_t offset, folio_offset;
>>         int ret = 0;
>>
>>         /*
>>@@ -1321,15 +1351,29 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>>
>>         for (left = size, i = 0; left > 0; left -= len, i++) {
>>                 struct page *page = pages[i];
>>+               struct folio *folio = page_folio(page);
>>+
>>+               folio_offset = (folio_page_idx(folio, page) << PAGE_SHIFT) +
>>+                               offset;
>>+
>>+               len = min_t(size_t, (folio_size(folio) - folio_offset), left);
>>+
>>+               num_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
>>+
>>+               if (num_pages > 1)
>>+                       len = get_contig_folio_len(&num_pages, pages, i,
>>+                                                  folio, left, offset);
>>
>>-               len = min_t(size_t, PAGE_SIZE - offset, left);
>>                 if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
>>-                       ret = bio_iov_add_zone_append_page(bio, page, len,
>>-                                       offset);
>>+                       ret = bio_iov_add_zone_append_folio(bio, folio, len,
>>+                                       folio_offset);
>>                         if (ret)
>>                                 break;
>>                 } else
>>-                       bio_iov_add_page(bio, page, len, offset);
>>+                       bio_iov_add_folio(bio, folio, len, folio_offset);
>>+
>>+               /* Skip the pages which got added */
>>+               i = i + (num_pages - 1);
>>
>>                 offset = 0;
>>         }
>>--
>>2.25.1
>>
>>
>
>Well. The issue here is that bvecs really only use the 'struct page' 
>entry as an address to the data; the page size itself is completely
>immaterial. So from that perspective it doesn't really matter whether
>we use 'struct page' or 'struct folio' to get to that address.
>However, what matters is whether we _iterate_ over pages or folios.
>The current workflow is to first allocate an array of pages,
>call one of the _get_pages() variants, and the iterate over all
>pages.
>What we should be doing is to add _get_folios() variants, working
>on folio batches and not pre-allocated arrays.

The XXX_get_pages() functions do page table walk and fill the pages
corresponding to a user space addr in pages array. The _get_folios()
variants shall return a folio_vec, rather than folio array, as every folio
entry will need a folio_offset and len per folio. If we convert to
_get_folios() variants, number of folios may be lesser than number of
pages. But we will need allocation of folio_vec array as a replacement
of pages array.

Am I missing something?

Down in the page table walk (gup_fast_pte_range), we fill the pages array
addr -> pte -> page. This shall be modified to fill a folio_vec array. The
page table walk also deals with huge pages, and looks like huge page
functions shall also be modified to fill folio_vec array. Also handling
the gup slow path will need a modification to fill the folio_vec array.
--
Kundan

>Then we could iterate over all folios in the batch, and can modify
>the 'XXX_get_pages()' variants to extract pages from the folio batch.
>And then gradually move over all callers to work on folio batches.
>
>Tall order, but I fear this is the best way going forward.
>Matthew? Christoph? Is that what you had in mind?
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

------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_9f737_
Content-Type: text/plain; charset="utf-8"


------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_9f737_--
