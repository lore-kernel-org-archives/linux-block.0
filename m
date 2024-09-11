Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8139614D6EE
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043895; cv=none; b=jY1vsQpJ3Lg+kcAMwyG1O2AdQCNFGk0op8fyWJTU5Nweh0tfAlIsE+PaPScEpG//2IzPq9nVoZss+MdhjqBZAPiUwx+lCsEtU5d242FyL0DUB1+p2N/2yZ1WeQSbgTDadW6lz/KV07XXYpOKifSQSKZbuYLFqt+H9/b0FJNI/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043895; c=relaxed/simple;
	bh=281L76LiRlzv+7HnQIL/+y5U64j3MwfziK7i0xWEKFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Q5zwtKgWnjbcs/9AkTa+ZlX/WA1H9LSQw9t8IHoc2izMLPi+870mUcWJzRRB4IzrIQUGikwaeu7utoYExCgu7QKSvVF87Pt1s5ZTirpC9BnCt4C6C9qrgs9QqYxAks8uRKq321RCc9gxoZhu7xEx2AxWPmokIpt+pzbPfuARuHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BfdMyzgu; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BfdMyzgu"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240911083804epoutp044f3ad6e8610f52ee6b21246ed12d850e~0I8S1i7v_1126711267epoutp04Q
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 08:38:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240911083804epoutp044f3ad6e8610f52ee6b21246ed12d850e~0I8S1i7v_1126711267epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726043884;
	bh=w0DkT3MZgDJDDYa3BYK93s3eviGkD4jwmbiQmjJsfb0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=BfdMyzguQzy9sv7vUcL2YakWl4EDxPxqPDtjfLz+Oyha8nTnDStp4MYJZAzo4qjl+
	 zi9rhF6UzpUB5BJwkohERIC5BvyxWfz5K5trBR6rEzDdfOkFulq4ssvHKVLTbp9tPA
	 ZlUnpWw5VLr2UVzNeMu2ApFYS7YzHXRFlDw7AXrQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240911083804epcas5p3569a254653eaed01ae3cf07ffd0168ff~0I8SGDPIj0138001380epcas5p3U;
	Wed, 11 Sep 2024 08:38:04 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4X3YqZ3KVzz4x9Q3; Wed, 11 Sep
	2024 08:38:02 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	79.90.08855.AE651E66; Wed, 11 Sep 2024 17:38:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240911065712epcas5p3611d5bddac1828e54c5628a2536ef7dc~0HkOEgykV0425404254epcas5p3P;
	Wed, 11 Sep 2024 06:57:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240911065712epsmtrp136f181e632ecbbc39f8e4ec5ce93e469~0HkODa1n21549315493epsmtrp17;
	Wed, 11 Sep 2024 06:57:12 +0000 (GMT)
X-AuditID: b6c32a44-107ff70000002297-e5-66e156ea548c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	82.2A.08964.84F31E66; Wed, 11 Sep 2024 15:57:12 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240911065710epsmtip1af0ad1adbd7ea8015d24826c2165b617~0HkMAAXCl0661206612epsmtip1P;
	Wed, 11 Sep 2024 06:57:10 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	vishak.g@samsung.com, gost.dev@samsung.com, Kundan Kumar
	<kundan.kumar@samsung.com>
Subject: [PATCH v10 0/4] block: add larger order folio instead of pages
Date: Wed, 11 Sep 2024 12:19:31 +0530
Message-Id: <20240911064935.5630-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmlu6rsIdpBl+u81k0TfjLbLH6bj+b
	xfftfSwWNw/sZLJYufook8XR/2/ZLCYdusZosfXLV1aLvbe0LW5MeMpose33fGaL87PmsFv8
	/jGHzYHXY/MKLY/LZ0s9Nq3qZPPYfbOBzaNvyypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPS
	bZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DOVFIoS8wpBQoFJBYXK+nb2RTll5ak
	KmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ2x/dJyl4J1yxeHuLSwNjG9l
	uhg5OSQETCSOPO1mA7GFBHYzSsyd49TFyAVkf2KU2HV4FSuE841RYsK2bmaYjq8v/rNBJPYC
	deyeCVX1mVFi0fStjF2MHBxsAroSP5pCQRpEBNwlpr58xAhSwyzwlFHiypefrCAJYaDEuuWb
	2UFsFgFViRuPbjOB2LwCNhLNO85DbZOXmHnpOztEXFDi5MwnLCA2M1C8eetsZpChEgJ/2SUm
	zpkP1eAisbhvJiuELSzx6vgWdghbSuJlfxuUnS1xqHEDE4RdIrHzSANU3F6i9VQ/M8gDzAKa
	Eut36UOEZSWmnlrHBLGXT6L39xOoVl6JHfNgbDWJOe+mskDYMhILL82AintI3FneywgJ31iJ
	d3NWs05glJ+F5J1ZSN6ZhbB5ASPzKkbJ1ILi3PTUZNMCw7zUcnjEJufnbmIEp1Ytlx2MN+b/
	0zvEyMTBeIhRgoNZSYS33+5emhBvSmJlVWpRfnxRaU5q8SFGU2AYT2SWEk3OByb3vJJ4QxNL
	AxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamDo96jZJ/nud1i8sJtrJfa/U
	WiX+il/ijVY7v+9TQ6emu5xO4fgWdJF5Wpdb2OQY7l/zWB7sZuu5WGNx4LWvb66NVtYqxiWr
	G3+W5arx1PWpMrXOf//V0Gppyd39zo/nz2XNO8+T4lVyfeGlNV5fVbJad5a3LOv21Y9eWjBL
	f5K/aJTonuUtZ0RkZxxiNYjgcTh47V3irbrWN7MPXz97TyPXrnGHfVjewx35wu6qHN9eSM0r
	f50lpVFVJHDY5sOD2qnzpe8kZ5RWhEy6aKo8L8mh+Whogrz/3yf+K9Kmr4r2vZh05v/d39M3
	b1awV/A8mb9riZbG/xPneH5dOrBH6KWpUIv8lh67ean/Khn2KbEUZyQaajEXFScCAEBnn+s2
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSnK6H/cM0g+9LJSyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF+Vlz2C1+
	/5jD5sDrsXmFlsfls6Uem1Z1snnsvtnA5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZ2x8d
	Zyl4p1xxuHsLSwPjW5kuRk4OCQETia8v/rN1MXJxCAnsZpRYvO8+K0RCRmL33Z1QtrDEyn/P
	2UFsIYGPjBLvd1t3MXJwsAnoSvxoCgUJiwj4SizY8JwRxGYWeM8ocXuJNIgtLOAusW75ZrBW
	FgFViRuPbjOB2LwCNhLNO84zQ4yXl5h56Ts7RFxQ4uTMJywQc+QlmrfOZp7AyDcLSWoWktQC
	RqZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBIa6luYNx+6oPeocYmTgYDzFKcDAr
	ifD2291LE+JNSaysSi3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cA0
	S4rnzoQ5+VEPeKrf/f7m9VWcX/2+1/0NNwrexMl/iWyQdWCVsy0+0rHq0vxuc5+1We67nh5d
	dXjtY1/bn7I8hs9X7vvX4Omh33D/eyejgblZqb+atKBm7hVfpzrlbUlKXvytiYybNaXfWEyc
	dv0xf3aWafB/6fNdmRJTFrJ7/WD4b8cT9qJOvqXLdPvOX68nrj7a+bP0no5gpuCiVvlrc+9u
	uBYhanj/ifOvPFf93l3TrVPkGSsURCyllpUVczbd8OXMq+D+v72X603IDI6QSfNvLGC86W5l
	njiHO0vOJydm6iN53+QT7850Xjkg7eNwK9mN8Woe31KHOcmP0p5vFJB+vn9ujMZ5Nq+GQiWW
	4oxEQy3mouJEAB3fW8fgAgAA
X-CMS-MailID: 20240911065712epcas5p3611d5bddac1828e54c5628a2536ef7dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240911065712epcas5p3611d5bddac1828e54c5628a2536ef7dc
References: <CGME20240911065712epcas5p3611d5bddac1828e54c5628a2536ef7dc@epcas5p3.samsung.com>

Hi Jens,

These patches have got the reviews and tested-by.
Please consider the series for inclusion.

-----
User space memory is mapped in kernel in form of pages array. These pages
are iterated and added to BIO. In process, pages are also checked for
contiguity and merged.

When mTHP is enabled the pages generally belong to larger order folio. This
patch series enables adding large folio to bio. It fetches folio for
page in the page array. The page might start from an offset in the folio
which could be multiples of PAGE_SIZE. Subsequent pages in page array
might belong to same folio. Using the length of folio, folio_offset and
remaining size, determine length in folio which can be added to the bio.
Check if pages are contiguous and belong to same folio. If yes then skip
further processing for the contiguous pages.

This complete scheme reduces the overhead of iterating through pages.

perf diff before and after this change(with mTHP enabled):

Perf diff for write I/O with 128K block size:
4.36%     -2.63%  [kernel.kallsyms]     [k] bio_iov_iter_get_pages
           2.00%  [kernel.kallsyms]     [k] bvec_try_merge_page
Perf diff for read I/O with 128K block size:
4.96%     -3.04%  [kernel.kallsyms]     [k] bio_iov_iter_get_pages
           2.39%  [kernel.kallsyms]     [k] bvec_try_merge_page

Without mTHP also, these patches when tested with Large block sizes(LBS),
provided WAF and alignment benefits[1].
[1] https://lore.kernel.org/linux-block/Zr_7YERr75vHbknA@bombadil.infradead.org/

Patch 1: Adds folio-ized version of bio_add_hw_page()
Patch 2: Adds bigger size from folio to BIO
Patch 3: Adds mm function to release n pages of folio
Patch 4: Unpin user pages belonging to folio at once using the mm
function

Changes since v9:
- changed min_t to min as all arguments of same type
- converted bio_release_page() to unpin_user_folio() at couple of places

Changes since v8:
- moved i+=num_pages to beginning of loop
- reversed the wrapper and made bio_add_hw_folio() a wrapper around
  bio_add_hw_page()
- removed bvec_try_merge_hw_folio() change from this series
- explained removal of BIO_PAGE_PINNED check in commit description
- removed function bio_release_folio() and calling unpin_user_folio()
  function directly
- corrected same_page logic to accept bigger folio offset

Changes since v7:
- changed folio-lise to folio-ize
- corrected order with wrapper definition after the guts
- removed check for BIO_PAGE_PINNED
- separated mm related implementation in different patch
- corrected issue found by kernel robot

Changes since v6:
- folio-lize bvec_try_merge_hw_page() to bvec_try_merge_hw_folio()
- restructured the code as per comments
- typecast with size_t while calculating the offset in folio.

Changes since v5:
- Made offset and len as size_t in function bio_add_hw_folio()
- Avoid unpinning skipped pages at submission, rather unpin all pages at
  once on IO completion

Changes since v4:
- folio-lize bio_add_hw_page() to bio_add_hw_folio()
- make bio_add_hw_page() as a wrapper around bio_add_hw_folio()
- make new functions bio_release_folio() and unpin_user_folio()
- made a helper function to check for contiguous pages of folio
- changed &folio->page to folio_page(folio, 0)
- reworded comments

Changes since v3:
- Added change to see if pages are contiguous and belong to same folio.
  If not then avoid skipping of pages.(Suggested by Matthew Wilcox)

Changes since v2:
- Made separate patches
- Corrected code as per kernel coding style
- Removed size_folio variable

Changes since v1:
- Changed functions bio_iov_add_page() and bio_iov_add_zone_append_page()
  to accept a folio
- Removed branch and calculate folio_offset and len in same fashion for
  both 0 order and larger folios
- Added change in NVMe driver to use nvme_setup_prp_simple() by
  ignoring multiples of PAGE_SIZE in offset
- Added a change to unpin_user_pages which were added as folios. Also
  stopped the unpin of pages one by one from __bio_release_pages()
  (Suggested by Keith)

Kundan Kumar (4):
  block: Added folio-ized version of bio_add_hw_page()
  block: introduce folio awareness and add a bigger size from folio
  mm: release number of pages of a folio
  block: unpin user pages belonging to a folio at once

 block/bio.c        | 112 +++++++++++++++++++++++++++++++++++----------
 block/blk.h        |   4 ++
 include/linux/mm.h |   1 +
 mm/gup.c           |  13 ++++++
 4 files changed, 105 insertions(+), 25 deletions(-)

-- 
2.25.1

