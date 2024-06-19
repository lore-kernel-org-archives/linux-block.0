Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550591E878
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 04:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718769632; cv=none; b=tcmQOTXcXXi9/VY5QRCgqNTQudjRe8mJAcKcRAp0uKlTgXBBc606Eke0fktuK8xpmbaonrE40f5U9JSX92WiHTqRIdOP347Wf8MAn9eeYVXwIgFe+6RtCZjJqQiKb0J0MH73futnJqnSw0dhl2RR/usEZMKVpT5xTW1yOLWFW80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718769632; c=relaxed/simple;
	bh=Dty6Muhy93bnBD0w2QhxKWFpbJ1kai9+DXKWwXRFk7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=nXgSw2f/puhfer3+tY/nDWe5n5jwSfqz6JT4xkPqkuFoe/4xbKyOskvNGNy4wuiCPMxYR26ukAJcbYtyTbcG2CoGJDs1ghyVMSfnnV6Lpl5hFStdhAhmvOOiLLWEnuViCv5XOF7Qn9yOq6Q3TnupCS/DhpNOgupz/sinT6w7en4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=B+bsHoMo; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B+bsHoMo"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240619040025epoutp019965fe9d277733b715516621a3ffbd0e~aS95QNjW21024910249epoutp01g
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 04:00:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240619040025epoutp019965fe9d277733b715516621a3ffbd0e~aS95QNjW21024910249epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718769626;
	bh=TQaVw7s1V3aRkAqV4VL+XKdNQi1zJuRj9oTGP0QaS04=;
	h=From:To:Cc:Subject:Date:References:From;
	b=B+bsHoMoIT9mCQin8DTGmJSzB5eXUJd2cfm7UMuCjEEYoY/AFbmRkV+0eBd6jcL5L
	 +BU+tIHIMGAN56cVm/hOyjoLmYbHE6xuE3+YWntqoDr6KASpaGFdYVFzynU53a+CUR
	 4uhbj9MUuP/QWI5RQp5PyRTsWTz7c1T4OtIdO1Tk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240619040025epcas5p3fd2f021a118a172ade979ce5d5a59f02~aS94vWI8m3100531005epcas5p3E;
	Wed, 19 Jun 2024 04:00:25 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4W3qdz2RvBz4x9Q3; Wed, 19 Jun
	2024 04:00:23 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.43.09989.7D752766; Wed, 19 Jun 2024 13:00:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240619024142epcas5p22b2e0f83e526fc74fda62a4837bed544~aR5JsIykP2261722617epcas5p2j;
	Wed, 19 Jun 2024 02:41:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240619024141epsmtrp111e4d78877031b4a73d1c19ee9bb0fcc~aR5JrWgbq0144501445epsmtrp11;
	Wed, 19 Jun 2024 02:41:41 +0000 (GMT)
X-AuditID: b6c32a4a-bffff70000002705-0e-667257d71578
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	55.9A.29940.56542766; Wed, 19 Jun 2024 11:41:41 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240619024140epsmtip2616fbf988cbd07f10846c3a98bfe0508~aR5H_gXto0602806028epsmtip2w;
	Wed, 19 Jun 2024 02:41:40 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v5 0/3] block: add larger order folio instead of pages
Date: Wed, 19 Jun 2024 08:04:17 +0530
Message-Id: <20240619023420.34527-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmlu718KI0gw+NAhZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO6P7032mghviFbe7e5gbGG8KdTFycEgI
	mEh8v1/TxcjFISSwm1FietcmVgjnE6PErnsPWSCcb4wSnw/sYO5i5ATruL5uBVRiL6PEvrsr
	2CCcz4wSF04eYwKZyyagK/GjKRSkQUTAXWLqy0eMIDXMAmcZJU5MfcQCkhAWcJPYvfcI2FQW
	AVWJTyfWM4LYvAK2EvM3dTBCbJOXmHnpOztEXFDi5MwnYL3MQPHmrbOZQYZKCPxll/i26wtU
	g4vEtJZtLBC2sMSr41vYIWwpiZf9bVB2tsShxg1MEHaJxM4jDVBxe4nWU/3MIA8wC2hKrN+l
	DxGWlZh6ah0TxF4+id7fT6BaeSV2zIOx1STmvJsKtVZGYuGlGVBxD4lDvyaAjRcSiJX4cus0
	4wRG+VlI3pmF5J1ZCJsXMDKvYpRMLSjOTU8tNi0wyksth0dscn7uJkZwQtXy2sH48MEHvUOM
	TByMhxglOJiVRHidpuWlCfGmJFZWpRblxxeV5qQWH2I0BYbxRGYp0eR8YErPK4k3NLE0MDEz
	MzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qBSSOu595GrS01fzinzNeefOjLaXGf
	/eah6oU7049nR85q3tKsdCAt+YLk1V39S3qeFifFvBK47iI+1chDQvzIjQ+8v82cWmpu7OB1
	WHPk4x49hb0Xb5t83su2JlvnWLnWsxVJftsUfn3Il71mEMOeYfdZ8nXCBcaSBcd26Eu+7ZGo
	3WHit/uo9h6hp5dbL1jcC9v+1vHOtoKeObO5OfW3/8yY5/h/W7fLxqTFu94FrDp9N3LxGqZ7
	iSa37yzi1XA637kmvHPNb9PT7p/0LG6miP+0KhXite3b8S3fdgXfre1Sx9pUzY/v0pBcwru6
	/3iS8oXZquuv/356bOlLm2/W3jVvTGf6C5XcYl9yrztljoUSS3FGoqEWc1FxIgDomn1yMQQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvG6qa1GawaVFphZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CV0f3pPlPBDfGK
	2909zA2MN4W6GDk5JARMJK6vW8HSxcjFISSwm1Hi6KR5zBAJGYndd3eyQtjCEiv/PWeHKPrI
	KLG/7RaQw8HBJqAr8aMpFKRGRMBXYsGG54wgNcwC1xklbkzfCjZIWMBNYvfeI2A2i4CqxKcT
	6xlBbF4BW4n5mzoYIRbIS8y89J0dIi4ocXLmExYQmxko3rx1NvMERr5ZSFKzkKQWMDKtYpRM
	LSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDm4tzR2M21d90DvEyMTBeIhRgoNZSYTXaVpe
	mhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe8Re9KUIC6YklqdmpqQWpRTBZJg5OqQamNENZuSeP
	NU4dUNhdM3XX+1vCASXHXkzbefGZ2fFjdRN2vbLXCOFROMNaljY/fPPXKacvVZ37qxzloqF3
	e/tupkO5h0Tuf3t1one/0PYz2480Nn9QijjHzL9aNtCP8Vh8vPD7eWJ9x1dfjaz/rp5pqpOQ
	8dTou3Xb5LmtLJVlIakv/NOuRBiYT9157c+RyRNl5WS/tk1Tbb66/s+lPZ4JLz7u/P7L9Yc5
	UyPfu+sBE5jUrpc8fX5caErv10xzz/8HX3y7eWLZvEyGgoyKOLML1lzzHxl1rV50JV3vwNyo
	S3PSNqz5Ett5n+mP1+wOISZLX6PlPzaVBeltcWeWET1QxLnr7PtDu5hX7f2wyijozEIlluKM
	REMt5qLiRADe3ayH3QIAAA==
X-CMS-MailID: 20240619024142epcas5p22b2e0f83e526fc74fda62a4837bed544
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240619024142epcas5p22b2e0f83e526fc74fda62a4837bed544
References: <CGME20240619024142epcas5p22b2e0f83e526fc74fda62a4837bed544@epcas5p2.samsung.com>

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

perf diff before and after this change:

Perf diff for write I/O with 128K block size:
     1.16%     -0.18%  [kernel.kallsyms]     [k] bio_iov_iter_get_pages
     1.72%             [kernel.kallsyms]     [k] bvec_try_merge_page
Perf diff for read I/O with 128K block size:
     3.76%     -1.25%  [kernel.kallsyms]     [k] bio_iov_iter_get_pages
     4.96%             [kernel.kallsyms]     [k] bvec_try_merge_page

Patch 1: Adds folio-lized version of bio_add_hw_page()
Patch 2: Adds changes to add larger order folio to BIO.
Patch 3: If a large folio gets added, the subsequent pages of the folio are
released. This helps to avoid calculations at I/O completion.

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

Kundan Kumar (3):
  block: Added folio-lized version of bio_add_hw_page()
  block: add folio awareness instead of looping through pages
  block: unpin user pages belonging to a folio

 block/bio.c        | 123 +++++++++++++++++++++++++++++++++------------
 block/blk.h        |  11 ++++
 include/linux/mm.h |   1 +
 mm/gup.c           |  13 +++++
 4 files changed, 116 insertions(+), 32 deletions(-)

--
2.25.1

