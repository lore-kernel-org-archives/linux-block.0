Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4BB481D0
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 05:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675203; cv=none; b=Q1kVIA9AQVCWnRxWUpb291LOD/0hjFyrptIrAR/IqwP4bETkzIadxBqVBRXIMDhAjlyjCwLuIhQCrifWocwmHPCXJV5CouW+gHMvV3xqL5ehX6ly/jvoV4kDb4jO/RkH/Ft1Z4V3ROojfJFeqw0H3T12RO2oszwjPJCgpKNH44I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675203; c=relaxed/simple;
	bh=AvXmO+bnNEExcJCNQyqjp41KfNDmj+iPpFXZj6A9wEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=smaohl4xinofRf5pYmV+Xmu0062XAshKjIDQgOZHF2uumJd6asIjBE8RBWD5JMMqQxpDWlRoamDjqn/VD/0fTY+yYMOp+CymQrB26QI96yNRI7Oybwn1vICj4MsK4/NFqdB9YkSlhxhMXel8L6mH/reoyS+4oegb21WiHyJAsF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KWf3ggpS; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KWf3ggpS"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240711051952epoutp01cdb0667e1e724a0d8442da1c003220f4~hEPiwiaEJ0469004690epoutp01c
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 05:19:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240711051952epoutp01cdb0667e1e724a0d8442da1c003220f4~hEPiwiaEJ0469004690epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720675192;
	bh=pVN6VV19La9OgYSxXF6ch81THofOyutT3GKJ567Zqqk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=KWf3ggpSAaALQjYS9xIx/iCB2mUe3Lk3+jiDQW8obDsyZlWX6Csfs6jnTFMQdf98O
	 ta/fmxchNYtyxAsn/NjS9Kay1j5oE1uQo8XvryoGYQVdecFal+aRN85pgvL6lvuUP+
	 A5DQE0zfJbgN8F6cJrgjygP0cTBTeKkgq/+pw0J8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240711051952epcas5p1df4db03f198affaa9b49cd74aebe4d10~hEPiOtWqT2024020240epcas5p11;
	Thu, 11 Jul 2024 05:19:52 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WKNMV1TBSz4x9Q0; Thu, 11 Jul
	2024 05:19:50 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	70.AB.09989.67B6F866; Thu, 11 Jul 2024 14:19:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240711051521epcas5p348f2cd84a1a80577754929143255352b~hELmDv63C1516315163epcas5p3s;
	Thu, 11 Jul 2024 05:15:21 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240711051521epsmtrp1230ef802321b4ba5e50e9563465bac10~hELmC1iMp1252312523epsmtrp1u;
	Thu, 11 Jul 2024 05:15:21 +0000 (GMT)
X-AuditID: b6c32a4a-e57f970000002705-b0-668f6b76983b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	86.9D.19057.96A6F866; Thu, 11 Jul 2024 14:15:21 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240711051519epsmtip10fbe0f42fa01c3c009b824c238dec9e1~hELkJ3pDk2962729627epsmtip1w;
	Thu, 11 Jul 2024 05:15:19 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v8 0/5] block: add larger order folio instead of pages
Date: Thu, 11 Jul 2024 10:37:45 +0530
Message-Id: <20240711050750.17792-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmum5Zdn+awZR9LBZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2Ph1b2sBZ9kK84sesTawPhKvIuRk0NC
	wERixZbdLF2MXBxCArsZJR5fXsIG4XxilPh0bC9U5hujxLXGbywwLTf+/oRK7GWUWDlhExOE
	85lR4ueBE0D9HBxsAroSP5pCQRpEBNwlpr58xAhSwyxwllHixNRHYJOEBdwkOpseMIPYLAKq
	Eu1fOhhBbF4BW4lXp/YzQ2yTl5h56Ts7RFxQ4uTMJ2C9zEDx5q2zmUGGSgj8ZZdYv30SK8hi
	CQEXifYTTBC9whKvjm9hh7ClJF72t0HZ2RKHGjdA1ZRI7DzSABW3l2g91c8MMoZZQFNi/S59
	iLCsxNRT65gg1vJJ9P5+AtXKK7FjHoytJjHn3VRoAMlILLw0AyruIbFy33+wt4QEYiVO/mth
	mcAoPwvJN7OQfDMLYfMCRuZVjJKpBcW56anFpgVGeanl8IhNzs/dxAhOqFpeOxgfPvigd4iR
	iYPxEKMEB7OSCO/8G91pQrwpiZVVqUX58UWlOanFhxhNgUE8kVlKNDkfmNLzSuINTSwNTMzM
	zEwsjc0MlcR5X7fOTRESSE8sSc1OTS1ILYLpY+LglGpgyi6qv71nkeqSPQtYJj9tc1t407Gw
	7H3hw7BY7el7LZl94r6z66f9Up1vyxB1fFn12scVTcYuks+qHabO4uC6ER3zl1ORt3Vi7veO
	hSXOXnPCp6536Yp6zviDP3GB57ojByYWvr3k+Ek0QfqlOLvgmpWSJkkLbWutuo+yh8nOefNd
	McpvSYhmmU3QlihtM4UYuedmNxL5etZHpLOnH3x87u3nzHNWU8qn3nI0XBz6Ztqxg67nPhS6
	n7rL+KpQt0Netyrj5o5Pd1YmW9q4Com+mM87b+WRdqOdgicETsfdEuyaMu/ONM2Dqz58KZ8S
	veb+jGfmC+ZIygstXrX66sndsgdMEmabzXd/1eDw/R8fixJLcUaioRZzUXEiAPVi2dkxBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSnG5mVn+awepbUhZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVsfDqXtaCT7IV
	ZxY9Ym1gfCXexcjJISFgInHj70+WLkYuDiGB3YwSh48/YINIyEjsvruTFcIWllj57zk7RNFH
	RokTV/YDdXBwsAnoSvxoCgWpERHwlViw4TkjSA2zwHVGiRvTtzKDJIQF3CQ6mx6A2SwCqhLt
	XzoYQWxeAVuJV6f2M0MskJeYeek7O0RcUOLkzCcsIDYzULx562zmCYx8s5CkZiFJLWBkWsUo
	mVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERzcWlo7GPes+qB3iJGJg/EQowQHs5II7/wb
	3WlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb+97k0REkhPLEnNTk0tSC2CyTJxcEo1MB1PCH5z
	oVniqNXloJ/6F+ufcfFYzXmxZqkKa0PQDgdN4bUBu5aG3v7r/oTp7MnWysm/5zv+ejp7m8Su
	1w5nvl0NrD7VyHVQ3l9g9a+Vk19GM/1lYzroac6hJXjttU8c28FHc6X5HadWPnoQfSdi5h6D
	2y9bkyMKTQ9/KLNfo7Lp3+f2mtMpO3dFdrybuvGp5xfdnJmJGVEKPn4idfxT1h0yXpp/POrU
	StUrRze+v7iz3sB4ybpnDbxSC5klpx7ae3eabvvFi20vv+RnZfQtfmyY4cOTpqN5yWFi+cM5
	0wSqvZLYl02Iebftl9SPj1N+3n0vcdanbI+p15Sok8KRAa4rrGYJ5n6wWLtNY3JbnFm6Ektx
	RqKhFnNRcSIA0iVZ/d0CAAA=
X-CMS-MailID: 20240711051521epcas5p348f2cd84a1a80577754929143255352b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240711051521epcas5p348f2cd84a1a80577754929143255352b
References: <CGME20240711051521epcas5p348f2cd84a1a80577754929143255352b@epcas5p3.samsung.com>

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
    1.24%     -0.20%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
    1.71%             [kernel.kallsyms]  [k] bvec_try_merge_page
Perf diff for read I/O with 128K block size:
    4.03%     -1.59%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
    5.14%             [kernel.kallsyms]  [k] bvec_try_merge_page

Patch 1: Adds folio-ized version of bvec_try_merge_hw_page()
Patch 2: Adds folio-ized version of bio_add_hw_page()
Patch 3: Adds bigger size from folio to BIO
Patch 4: Adds mm function to release n pages of folio
Patch 5: Unpin user pages belonging to folio at once using the mm
function

Changes since v7:
- corrected issue found by kernel robot, fixed by avoiding updating
  same_page for different pages of folio
- changed folio-lise to folio-ize
- corrected order with wrapper definition after the guts
- removed check for BIO_PAGE_PINNED
- separated mm related implementation in different patch

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

Kundan Kumar (5):
  block: Added folio-ized version of bvec_try_merge_hw_page()
  block: Added folio-ized version of bio_add_hw_page()
  block: introduce folio awareness and add a bigger size from folio
  mm: release number of pages of a folio
  block: unpin user pages belonging to a folio at once

 block/bio.c        | 156 ++++++++++++++++++++++++++++++++++-----------
 block/blk.h        |  14 ++++
 include/linux/mm.h |   1 +
 mm/gup.c           |  13 ++++
 4 files changed, 147 insertions(+), 37 deletions(-)

-- 
2.25.1

