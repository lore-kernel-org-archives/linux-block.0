Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BEB146D6D
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494063; cv=none; b=m415QrduOBhsKLP08W4PqDAoQ3zB6cCSqdvlOj/p5MAT86Ai/REBRxFhDzQ8ZM2GtCoCTUPB3vkI+XoYW5stLPNNixiP2VCkyb+km2TxlW9kNyMGVg/1owSi9uMAU2ocgMlUIWsVMJLhYO2oFHibQB4uOAuV77y/6hIcsGkftWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494063; c=relaxed/simple;
	bh=Flao6phTR9c24fGmU5OZKmo2wLm+3dPH9ZxebZS4kcs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=jENJTVYjcb3KkTKEuul1kWBRJ8KoTaZudGpISCtjec6xOklgE1/xtXeI0taJFQLl1DQWrhRBdWdsWsorheMXosmFflTBGyBKQ0m0q3Za0PVheGp09DNe0xOTCmzT5bqBw16GqYbytelTxeOTAA6zAhZSkEXpr2QwKAgZ/AuTzrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QC2Ebdb1; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QC2Ebdb1"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240627131411epoutp01ac3892d54e8f759258300dd44d6c9b98~c3rq8KUk11698516985epoutp01g
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 13:14:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240627131411epoutp01ac3892d54e8f759258300dd44d6c9b98~c3rq8KUk11698516985epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719494051;
	bh=wgXVbnzcj5t9PSJxv52vGypzxjxZWEQ5VUwg0rAR7xo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=QC2Ebdb1f+xUbPNWFG1KzpU9QSRo+yEYXIxhAt+BxnMp/jSg6Iy8t8NYmhzfYoe3z
	 A840FvPvQcrA3uICrXxQozgjFyeABudoOuwRgRlX/ci2dgtpS3E4FOVPoVI2NC1JwU
	 YmozsaXNlF94vYGqpQkxcWJU+qRM8UWU3B60Dr3Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240627131410epcas5p16b606a9abc25fa96336dd3d2d12fd0dc~c3rqbaZ3w2151921519epcas5p1g;
	Thu, 27 Jun 2024 13:14:10 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4W8zYF1MVrz4x9Pr; Thu, 27 Jun
	2024 13:14:09 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D8.98.11095.1A56D766; Thu, 27 Jun 2024 22:14:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240627105359epcas5p47eb8839f9e77c85cb737be9434cb2570~c1xQytpOW0555705557epcas5p45;
	Thu, 27 Jun 2024 10:53:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240627105359epsmtrp1a1510cdbbdc604a3d6dc57fe0997a9bb~c1xQx5nQ80705607056epsmtrp1S;
	Thu, 27 Jun 2024 10:53:59 +0000 (GMT)
X-AuditID: b6c32a49-423b770000012b57-f6-667d65a143ca
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D0.3F.29940.7C44D766; Thu, 27 Jun 2024 19:53:59 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240627105357epsmtip160ad6ed72f758bebd680edd2bb67da5f~c1xO-tpip2915729157epsmtip11;
	Thu, 27 Jun 2024 10:53:57 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v6 0/3] block: add larger order folio instead of pages
Date: Thu, 27 Jun 2024 16:15:49 +0530
Message-Id: <20240627104552.11177-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmhu7C1No0gzubWS2aJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF7x9z2Bx4
	PDav0PK4fLbUY9OqTjaP3Tcb2Dz6tqxi9Pi8SS6ALSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzje
	Od7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoQiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJ
	rVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsa/9m7WgjMSFT/vT2VsYDwg3MXIySEh
	YCLR1neNsYuRi0NIYDejxMY1Z1ghnE+MEgueXmaGcL4xStydMp0dpuXG4a1sILaQwF5GiX1P
	giCKPjNKLJ16Baidg4NNQFfiR1MoSI2IgLvE1JePwFYwC5xllDgx9RELSEJYwE3i4uy/rCA2
	i4CqxJJLv8CG8grYSuxasoQZYpm8xMxL39kh4oISJ2c+AetlBoo3b50Ndp2EwE92iSsLPrJA
	NLhITD3zlRHCFpZ4dXwL1NVSEi/726DsbIlDjRuYIOwSiZ1HGqDi9hKtp/qZQR5gFtCUWL9L
	HyIsKzH11DomiL18Er2/n0C18krsmAdjq0nMeTcV6gQZiYWXZkDFPSQu7f7PAgmsWIn+Z/+Z
	JjDKz0Lyziwk78xC2LyAkXkVo2RqQXFuemqxaYFhXmo5PGKT83M3MYITqpbnDsa7Dz7oHWJk
	4mA8xCjBwawkwhtaUpUmxJuSWFmVWpQfX1Sak1p8iNEUGMYTmaVEk/OBKT2vJN7QxNLAxMzM
	zMTS2MxQSZz3devcFCGB9MSS1OzU1ILUIpg+Jg5OqQYm/genzJvNbooHL204xH4w6WL67Ihd
	lgr3+7Tzomo4Hzn3z/c3MWezNviqKczcqGVyby57Fmd4Vk/kwVXrtmnWTzl98Gi3ic3eHC3j
	M2K1OxudK81vSTVXHtF7Wa7wO8f73H++45XWcswKn/Xj8tMes4uo/Thd3lkmtnSzztIdSwSP
	zHyY/vKT5NHrc6Rkt69NOrvKerFK+YIpsdpc8if/RyzdtOJFyaHKd4cKKv00S+Ul5K7fEdhj
	/m2XZdnuJ3cud1geEzvvFvCoY0We/dkJ9yMjT2iHLmbYsP8zv1KdSJTjx8OrMnzCry8quBEe
	HnE5vXda1oY7vHscHuaoZm38eOvDywt11ifZDZOSI5cqsRRnJBpqMRcVJwIA6RFzjTEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSnO5xl9o0g08nRSyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF7x9z2Bx4
	PDav0PK4fLbUY9OqTjaP3Tcb2Dz6tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEr4197N2vBGYmK
	n/enMjYwHhDuYuTkkBAwkbhxeCtbFyMXh5DAbkaJRQd72CASMhK77+5khbCFJVb+e84OYgsJ
	fGSU+D3FqIuRg4NNQFfiR1MoSFhEwFdiwYbnjCBzmAWuM0rcmL6VGSQhLOAmcXH2X7A5LAKq
	Eksu/QKbzytgK7FryRJmiPnyEjMvfWeHiAtKnJz5hAXEZgaKN2+dzTyBkW8WktQsJKkFjEyr
	GCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCQ1tLcwfj9lUf9A4xMnEwHmKU4GBWEuEN
	LalKE+JNSaysSi3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cDEv4v3
	teyeVL71V6xnlp17qtO2qDtKekrWpttVh7MfuyooGt1Zcee/Rv0xk9CJGxMr3HtdBS6V6ty6
	z3/1ZIrMg0VRYpNO/dS77BucneYdeqRXJGJRuWB9dcom42k87x8/21H5Tki4hHdufvZLI477
	Qau8vG6tnfn0o/idbHPerPbWo33v7T9Odi7Yt+fN6ebA+j072PhzlS29lMK23c/YyK/P7GDX
	XPng9ocg451lH86ozZH0+LOu0/U0X+fTiKV+nvJVe4/mP6/9sf5Z2MT8sNT8+oJlVipX21Rr
	shntjOZENottkvuuL5Dk8/ZLm+xtl2fH3v2ekFTbdP8LK0d2YmdO8m5x+/c3tPkDtZVYijMS
	DbWYi4oTAT0RFzncAgAA
X-CMS-MailID: 20240627105359epcas5p47eb8839f9e77c85cb737be9434cb2570
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240627105359epcas5p47eb8839f9e77c85cb737be9434cb2570
References: <CGME20240627105359epcas5p47eb8839f9e77c85cb737be9434cb2570@epcas5p4.samsung.com>

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
    1.26%     -0.27%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
    1.78%             [kernel.kallsyms]  [k] bvec_try_merge_page
Perf diff for read I/O with 128K block size:
    3.90%     -1.51%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
    5.12%             [kernel.kallsyms]  [k] bvec_try_merge_page

Patch 1: Adds folio-lized version of bio_add_hw_page()
Patch 2: Adds changes to add larger order folio to BIO
Patch 3: Unpin user pages belonging to folio at once

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

Kundan Kumar (3):
  block: Added folio-lized version of bio_add_hw_page()
  block: introduce folio awareness and add a bigger size from folio
  block: unpin user pages belonging to a folio at once

 block/bio.c        | 116 ++++++++++++++++++++++++++++++++++-----------
 block/blk.h        |  11 +++++
 include/linux/mm.h |   1 +
 mm/gup.c           |  13 +++++
 4 files changed, 114 insertions(+), 27 deletions(-)

-- 
2.25.1

