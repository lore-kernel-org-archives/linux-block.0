Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889F16E873
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007157; cv=none; b=pUjQpWUYoy/OqDFWA6XQo1Es11kngXEcPhHJmVjnPGCtQj0QnGk7gkj2j3cdzgck2sddILdYjlR+X0vebiWz28tUMlLG4RTswYEBUtMFXStKOJ47dg8nPgNJxIHh4n4uD5WSmKXOhujzijsleYje8dikfkJQFL7BunwR/dodARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007157; c=relaxed/simple;
	bh=FzDebbn3A0SU+NwcQ/pyPp9+tHchP7XUmK6E90SNY+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ixSlOLhmVTGCk11al8TFRkGQvl/+G1I1r5gD3SYQHT7cRZg55ansk2kL6dpjh/E7ZxoxDmqS4cJPcMNZ2wnOGiUiZGrmN2V8INmUQUUwJ6PXOZZJbjaBd++HDrwU4wBunmMNt2wmj/UuqDANOWEdbLRnWvr6NIvsJe7m+75uEus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=R1CEZ9ym; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R1CEZ9ym"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240830083906epoutp02ba2484fc6cc624d64c2fc39f87cca651~wdNw75A7M2607026070epoutp02b
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 08:39:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240830083906epoutp02ba2484fc6cc624d64c2fc39f87cca651~wdNw75A7M2607026070epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725007146;
	bh=CbHVLyS+sezflNoPRRub2lX2SRyfNJdla8/W5sNyvw4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=R1CEZ9ymMD/CHXhazZGdAsJYQJOzPUhciSDUZFamE4PuSp0njuE0eRW+o/7M56l1S
	 3Cz+mTpjuVGDe4on9CRCko0rrTRSbKaH1je51HiwYHs088Ng/Ofcru1al6vBLHagpa
	 LA7f6+2Cw6IMyYAW0SmvfXj0eCGc0gb6382zPA00=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240830083906epcas5p146378fef3c446ca5300eb635ab9a5b67~wdNwhiLLI1546615466epcas5p1s;
	Fri, 30 Aug 2024 08:39:06 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WwBQH2WnYz4x9Q1; Fri, 30 Aug
	2024 08:39:03 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	30.F8.19863.52581D66; Fri, 30 Aug 2024 17:39:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240830080040epcas5p18bb4d0b9cf6896d806ea45db71814045~wcsNXvvSZ2687626876epcas5p1u;
	Fri, 30 Aug 2024 08:00:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240830080040epsmtrp2683836a66f4a52bb042448e7ab34468f~wcsNW0nbZ0971409714epsmtrp2H;
	Fri, 30 Aug 2024 08:00:40 +0000 (GMT)
X-AuditID: b6c32a50-ef5fe70000004d97-27-66d18525dac1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3B.33.08964.82C71D66; Fri, 30 Aug 2024 17:00:40 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240830080037epsmtip271d1a17615917afc1391d6f1ffcf9ed7~wcsK6s_qz2504325043epsmtip2d;
	Fri, 30 Aug 2024 08:00:37 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	vishak.g@samsung.com, gost.dev@samsung.com, Kundan Kumar
	<kundan.kumar@samsung.com>
Subject: [PATCH v9 0/4] block: add larger order folio instead of pages
Date: Fri, 30 Aug 2024 13:22:53 +0530
Message-Id: <20240830075257.186834-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmpq5q68U0g1//pSyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF+Vlz2C1+
	/5jD5sDrsXmFlsfls6Uem1Z1snnsvtnA5tG3ZRWjx+dNcgFsUdk2GamJKalFCql5yfkpmXnp
	tkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBnKimUJeaUAoUCEouLlfTtbIryS0tS
	FTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM9bPdymYo1jR+LiggfGIVBcj
	J4eEgIlEV8McZhBbSGAPo8T3g75djFxA9idGiSdHn7BAON8YJTY33GWH6ejeMIUVIrGXUWLC
	vj3MEM5nRom9DZMZuxg5ONgEdCV+NIWCNIgIuEtMffmIEaSGWeApo8SVLz9ZQRLCAm4Sm491
	gU1lEVCVeHO4ESzOK2An8aJrOhPENnmJmZe+s0PEBSVOzgQ5iRNokLxE89bZYIslBP6ySyzY
	PoMNosFFYsmH5SwQtrDEq+NboM6Wkvj8bi9UTbbEocYNUAtKJHYeaYCqsZdoPdXPDPIAs4Cm
	xPpd+hBhWYmpp9YxQezlk+j9/QSqlVdixzwYW01izrupUGtlJBZemgEV95DoOQhhCwnESjTd
	/8s8gVF+FpJ3ZiF5ZxbC5gWMzKsYpVILinPTU5NNCwx181LL4fGanJ+7iRGcWLUCdjCu3vBX
	7xAjEwfjIUYJDmYlEd4Tx8+mCfGmJFZWpRblxxeV5qQWH2I0BQbyRGYp0eR8YGrPK4k3NLE0
	MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qBKUW8K21ihWhJvukx8QcTDvY9
	LeqqUNrw99+lXT9vHt/sm3s8RVFj4vfX8RFtv678OsOxgLFtYjcLK/eUjT4/TN27G891dcY0
	zRcMkns8q6i7zfRI1YlJiz0+NS61KRf6LXd78aP7ZzkW8+1LW/hB9qm5iZ7m8Rz+JalbhLYf
	+brgE+ckJv36Gfait3c8KeOW5QldevbL/r9xnBIHbba13f+cuOULi0hq6U2X8pOcl7wsQ/NX
	CK75lrHo0JZjdzuf/CtavH79uXebpmnfvltxJODsjBPiLGsf1Bx/eupNb4n0dI1m503V4dq3
	BCcc3PE8/76tj36uw9TVf4S+JLR1TW5esditkbdvz9rCg0+iF/ApsRRnJBpqMRcVJwIActCb
	yzUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSvK5GzcU0g4c3ZSyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF+Vlz2C1+
	/5jD5sDrsXmFlsfls6Uem1Z1snnsvtnA5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZ6+e7
	FMxRrGh8XNDAeESqi5GTQ0LARKJ7wxTWLkYuDiGB3YwS8980skMkZCR2393JCmELS6z89xws
	LiTwkVFi/2ezLkYODjYBXYkfTaEgYREBX4kFG54zgtjMAu8ZJW4vkQaxhQXcJDYf6wJrZRFQ
	lXhzuBFsJK+AncSLrulMEOPlJWZe+s4OEReUODnzCQvEHHmJ5q2zmScw8s1CkpqFJLWAkWkV
	o2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZweGtp7mDcvuqD3iFGJg7GQ4wSHMxKIrwn
	jp9NE+JNSaysSi3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cA0rXP2
	G2vBGQXtGbk7Iiec45V+afbAWXNz4KUyyYu2i5+9yni67oi4bJjjlWUlp/kifygHSwYGZCTs
	VVkhziX9/9zzdR6Ncg2/nSTurXy4Zpp9yIXPsixSnwOMXf+ZfN9ivd/sITtLD0dw7JNih/lG
	8vKTXRM4/FsOzNNVTVSMEX9y6OS8jgfb2A17OaYof9zhqFyv/FHw9rzQTmenndoLAoqkyx7u
	+vXOZfmi+AeR8/bK71/mffz+5b2HHkWo1+RnMkgtl9K7dfvzwqD5k3b3i4iqcLa31n1yteLV
	SFm4buJSx5UGK993p286nDz7f8yL7eu/rFxgfzonwMuws15vn9Lv0x2T1zWyHzBkjPqjxFKc
	kWioxVxUnAgAgywlk94CAAA=
X-CMS-MailID: 20240830080040epcas5p18bb4d0b9cf6896d806ea45db71814045
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240830080040epcas5p18bb4d0b9cf6896d806ea45db71814045
References: <CGME20240830080040epcas5p18bb4d0b9cf6896d806ea45db71814045@epcas5p1.samsung.com>

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
    4.29%     -2.51%  [kernel.kallsyms]     [k] bio_iov_iter_get_pages
    1.99%             [kernel.kallsyms]     [k] bvec_try_merge_page
Perf diff for read I/O with 128K block size:
    4.99%     -2.90%  [kernel.kallsyms]     [k] bio_iov_iter_get_pages
    2.31%             [kernel.kallsyms]     [k] bvec_try_merge_page

Without mTHP, these patches when tested with Large block sizes(LBS),
provided WAF and alignment benefits.

Patch 1: Adds folio-ized version of bio_add_hw_page()
Patch 2: Adds bigger size from folio to BIO
Patch 3: Adds mm function to release n pages of folio
Patch 4: Unpin user pages belonging to folio at once using the mm
function

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

 block/bio.c        | 108 +++++++++++++++++++++++++++++++++++----------
 block/blk.h        |   4 ++
 include/linux/mm.h |   1 +
 mm/gup.c           |  13 ++++++
 4 files changed, 103 insertions(+), 23 deletions(-)

-- 
2.25.1

