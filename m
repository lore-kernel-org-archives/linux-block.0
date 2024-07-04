Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E3A1A38F2
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080122; cv=none; b=FU3Srcq9TcROhsYN5T9C9gBmySFDWmQcR12RogttoZ5OCBSAx9SQwTlYEh89K0lEZCkRof/117R745bIDRV/Tc64MXq/ACxHh/tW0m4s8FwJQDR2JNl5U9m2BPHpA/nKGO/FvRaa+UjHMqqz8Uba32k1sl3ZE/rX6QjaKVKlXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080122; c=relaxed/simple;
	bh=fq7zgWlz5sDpxQ9s9+qF8GvD+zbVTJ6QXqLNq8SmQZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=U8p7KV+7Hwf8lr1rGZ99xzvtJeW79D7G5LKCX6dCBqlycuRGWRa1aawUG91H2qbSAMA7gH+z/QsYrdT1am5gcXaLVSPaAkyp8uUzIooQVeq73Ge8hKTEfeOfR/YscT7pjqanyhfeL5KRckf2MirbtyrqYbnASxKlfJyKP6gQYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UJ1G7B7C; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UJ1G7B7C"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240704080156epoutp04511d38146d7a998a855a1e2a8122ff61~e88C2-meB0486404864epoutp04D
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 08:01:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240704080156epoutp04511d38146d7a998a855a1e2a8122ff61~e88C2-meB0486404864epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720080116;
	bh=QOixrzwVrv4H25tDvuWLd+MpqSzVmD+dRtwld7j8Wjw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=UJ1G7B7CA1wtRrRGloKAcrQUxt95lP9A/7oQB4X4M7m9VqvYJRFESknyNk5xs0kCs
	 Cr6sUfUfWRX/AG4q4JfNXOX8eLt/+WtzQPajhVDRkYX/9k+VQvHuBjDl0UdMzEWgFz
	 5WjrBDiY6wHQ6OsiPqt6QoaF+nLoX+Oj7VsdtVKo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240704080156epcas5p4b5b712a658c21ba0a9fa03c0c1951dcf~e88CU6JSh1450414504epcas5p4g;
	Thu,  4 Jul 2024 08:01:56 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WF8Hj1cFcz4x9QB; Thu,  4 Jul
	2024 08:01:53 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0D.64.07307.0F656866; Thu,  4 Jul 2024 17:01:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240704071118epcas5p141ef3c2cbcde0ce31d342b5743a7dcf1~e8P1AQZDA0634606346epcas5p1c;
	Thu,  4 Jul 2024 07:11:18 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240704071118epsmtrp19c533f9363cc5c416e17e0f272700259~e8P0_TFb40702607026epsmtrp1K;
	Thu,  4 Jul 2024 07:11:18 +0000 (GMT)
X-AuditID: b6c32a44-18dff70000011c8b-c4-668656f09e43
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	28.C8.19057.51B46866; Thu,  4 Jul 2024 16:11:18 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240704071116epsmtip2e8ab24703509c03211466e8be6ccc0fc~e8Py_wU4X1402714027epsmtip2U;
	Thu,  4 Jul 2024 07:11:15 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v7 0/4] block: add larger order folio instead of pages
Date: Thu,  4 Jul 2024 12:33:53 +0530
Message-Id: <20240704070357.1993-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmhu6HsLY0g4Nr+SyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF7x9z2Bx4
	PDav0PK4fLbUY9OqTjaP3Tcb2Dz6tqxi9Pi8SS6ALSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzje
	Od7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoQiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJ
	rVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsb6eauZCxqlKx5fvMvSwHhctIuRk0NC
	wESi9+Quxi5GLg4hgd2MEtfXXWGBcD4xSvTMus0O4XxjlHjzbzYjTMu9JYtZIRJ7GSU2vN7B
	BOF8ZpQ4f24TWxcjBwebgK7Ej6ZQkAYRAXeJqS8fge1gFjjLKHFi6iMWkISwgJvEzovf2UFs
	FgFViZmbprCC2LwCNhJTPs5mhtgmLzHzEkQNr4CgxMmZT8B6mYHizVtBariAan6yS/T/mgN1
	novE0gmL2SBsYYlXx7ewQ9hSEi/726DsbIlDjRuYIOwSiZ1HGqDi9hKtp/qZQR5gFtCUWL9L
	HyIsKzH11DomiL18Er2/n0C18krsmAdjq0nMeTeVBcKWkVh4aQZU3EPi0YMPYHEhgViJdb9f
	MU1glJ+F5J1ZSN6ZhbB5ASPzKkbJ1ILi3PTUZNMCw7zUcnjMJufnbmIEp1Qtlx2MN+b/0zvE
	yMTBeIhRgoNZSYRX6n1zmhBvSmJlVWpRfnxRaU5q8SFGU2AYT2SWEk3OByb1vJJ4QxNLAxMz
	MzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamCyWr0xTfp/d0BRyaOLLlZplStsf
	3HnN8anlyBLNe3/uixemtYW+0zwZkPsjqfrY7it/J4n96Lr4em+de93Rc2xWXl+5uFdN0NrM
	3Wc740Mtx6T8U79vfntmtvnFjjtT7LdOvclvpdfz10t/jZNTa+Th90o866RLPzi//V+jk3Zf
	wVa76cYKhvr3x47LedbsYfNPmdz4b+3iHbbubEI/vnr88TsYrrjzRrRHmb36dx0ZE+MCociK
	hOqwAonWs/ctxK5Mi1kWeGbPC2tO5ef5KnMP3hJ81SY52zpBfcabV/YT35988k+q5rV5Nu+1
	/bec1FZcPHCkekeVo8jSh6anxCsdq28+O2Q69cWaQ3ssnTmUWIozEg21mIuKEwHblXmQMgQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSvK6Yd1uawZRpjBZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVsX7eauaCRumK
	xxfvsjQwHhftYuTkkBAwkbi3ZDEriC0ksJtR4uBsXoi4jMTuuztZIWxhiZX/nrN3MXIB1Xxk
	lLj04jdTFyMHB5uArsSPplCQGhEBX4kFG54zgtQwC1xnlLgxfSszSEJYwE1i58Xv7CA2i4Cq
	xMxNU8CG8grYSEz5OJsZYoG8xMxLEDW8AoISJ2c+YQGxmYHizVtnM09g5JuFJDULSWoBI9Mq
	RsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg0NbS2sG4Z9UHvUOMTByMhxglOJiVRHil
	3jenCfGmJFZWpRblxxeV5qQWH2KU5mBREuf99ro3RUggPbEkNTs1tSC1CCbLxMEp1cCk4eqi
	3nfDo6GRn3uKd2/yKc5HH0NLFKe/2mQz9dqiLfKthTweLZPOzv+j+fqtlfjsUxzGbp6VgVGZ
	XfXThZJspnxcujjgh6Nqcny5Udsvw8cbXXbcNDuxPbT8iF385RfLTI45Nd1MYYpY3NOyep+9
	C5Ok/dt7Slv3z5+tIO0rdNhULU05nVPoze0H99pS13vtdVHcknm/m6mS+YSiv6hJk/V3Z6vw
	3hdTDVyD98/N9VXlWSdz84tc17H4ew+dGWYWKKblyizf7KoWtl61JFsq1sDB/9NMlYtZXNvU
	VLkSOibNyaoyEuuZI1mV/fjJhSufD4VM0Dx8Szoq7z3n/uDjYsy71YtUX97jd/vxQYmlOCPR
	UIu5qDgRAJrvYGTcAgAA
X-CMS-MailID: 20240704071118epcas5p141ef3c2cbcde0ce31d342b5743a7dcf1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240704071118epcas5p141ef3c2cbcde0ce31d342b5743a7dcf1
References: <CGME20240704071118epcas5p141ef3c2cbcde0ce31d342b5743a7dcf1@epcas5p1.samsung.com>

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

Patch 1: Adds folio-lized version of bvec_try_merge_hw_page()
Patch 2: Adds folio-lized version of bio_add_hw_page()
Patch 3: Adds bigger size from folio to BIO
Patch 4: Unpin user pages belonging to folio at once

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
  block: Added folio-lized version of bvec_try_merge_hw_page()
  block: Added folio-lized version of bio_add_hw_page()
  block: introduce folio awareness and add a bigger size from folio
  block: unpin user pages belonging to a folio at once

 block/bio.c        | 133 ++++++++++++++++++++++++++++++++++++---------
 block/blk.h        |  15 +++++
 include/linux/mm.h |   1 +
 mm/gup.c           |  13 +++++
 4 files changed, 135 insertions(+), 27 deletions(-)

-- 
2.25.1

