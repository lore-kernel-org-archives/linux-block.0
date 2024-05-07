Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B014273
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 05:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715146660; cv=none; b=t9DjpKcejhbJRevxIPJetgN3MFk0PPtowFj2tI4/CWY3Nkx4VjKyZcyaNuJrYhmK4GC9EvMMDou5pusu8IK7Bry20fRNfMFxyj1qucoMmyPfKXDmqbCO+aAbWbgI1qytOPhPPAADrNtbX7TSeAZe1Df19sJcznhxlwS8u+yDFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715146660; c=relaxed/simple;
	bh=O0jLFBJ8UXW4a0+9UA6V0nLgZlmzrpM0VVESkDqhyiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=VExny1PIYx6XIDnwXUPOdAnzwTN8GlYxVJWdlFfpCfYJPY7fJPAiI5yGJU6Q0OjdahCIWUHyQjDiu0M7eEy5fO75+e8iUnQKc4CBw6qKX2fX0ImGa1t4sbvclTiAMr3Ryhl07bUc8fVMH+UkXfHI+MSID1Sz8kYoZWA3CKTqb5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jFFmo2x8; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jFFmo2x8"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240508053735epoutp0216c472947376e3fa1c73e7b1b3d8c105~NbMuyYUQl1312113121epoutp02q
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 05:37:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240508053735epoutp0216c472947376e3fa1c73e7b1b3d8c105~NbMuyYUQl1312113121epoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715146655;
	bh=ty7CCCnUcpWQh1sgBg+mOgUpAIak77Fu+sq7/BWxxtM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=jFFmo2x8D2UkDDxkdQTwpVKrLVLPxop/uLVEsdaSNHduZ8bDOn0gT1DwmPLLUGPqp
	 Iezl46TziJmDd8vZNfuIiyGGeciVjvWPnnuhiFFoIyODYp6NTyIkGev4JRgQRmPybd
	 9MLtQ0WmtiCDVHCvnQjU9kPRxatgeWGx6isvvtwU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240508053734epcas5p3f31a2e9a74d0a751a05cb40276128903~NbMuWiGIr1929419294epcas5p3e;
	Wed,  8 May 2024 05:37:34 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VZ3nS5wBzz4x9Q2; Wed,  8 May
	2024 05:37:32 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1D.49.19431.C9F0B366; Wed,  8 May 2024 14:37:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240507145232epcas5p481986099a82b1880758b7770cdeaf2d2~NPH-UEGO93095830958epcas5p4U;
	Tue,  7 May 2024 14:52:32 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240507145232epsmtrp1547e7b2554334d5dafe904093145e2b0~NPH-TC_tH0625406254epsmtrp1w;
	Tue,  7 May 2024 14:52:32 +0000 (GMT)
X-AuditID: b6c32a50-ccbff70000004be7-dc-663b0f9c22c7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C2.4D.09238.0304A366; Tue,  7 May 2024 23:52:32 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240507145230epsmtip116f7dfb5eeb5ff994f7ca9251b4efd81~NPH9k6x4h2861028610epsmtip1z;
	Tue,  7 May 2024 14:52:30 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v3 0/3] block: add larger order folio instead of pages
Date: Tue,  7 May 2024 20:15:06 +0530
Message-Id: <20240507144509.37477-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmpu4cfus0gzlTdC2aJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFlu/fGW12HtL2+LGhKeMFtt+z2e2+P1jDpsDt8fmFVoe
	l8+Wemxa1cnmsftmA5tH35ZVjB6fN8kFsEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
	6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
	KTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM5YMOcwU8FH0YozhyYwNzAeEOxi5OSQEDCR2HP1
	KFMXIxeHkMAeRolzl9czgySEBD4xSnz5GQSR+MYo8fVROwtMx+PJ79khEnsZJaaffAHV/plR
	YtbNI0AZDg42AV2JH02hIA0iQA0vV95mBKlhFjjLKHFi6iOwScICbhKdC7aBrWMRUJXY/2oH
	O4jNK2ArcWHKTnaIbfISMy99h4oLSpyc+QSslxko3rx1NjNEzUd2iUfPy0D2Sgi4SLTfkoUI
	C0u8Or4FaoyUxMv+Nig7W+JQ4wYmCLtEYueRBqi4vUTrqX5mkDHMApoS63fpQ4RlJaaeWscE
	sZVPovf3E6hWXokd82BsNYk576ZCw0dGYuGlGVBxD4k5n5oZIQEaK3FgTTvrBEb5WUiemYXk
	mVkImxcwMq9ilEotKM5NT002LTDUzUsth8drcn7uJkZwEtUK2MG4esNfvUOMTByMhxglOJiV
	RHiPtpunCfGmJFZWpRblxxeV5qQWH2I0BQbxRGYp0eR8YBrPK4k3NLE0MDEzMzOxNDYzVBLn
	fd06N0VIID2xJDU7NbUgtQimj4mDU6qBaR6n70bTKymP/yvWT5rtVrdqxZmNhzIu9dVO9L5z
	y9tYtzfaOC6Q6/6EzR+qTntd0fFYGWga8N6gY/uFX0unTPc47W/NybYoPdZn6+Jl5V+6lz63
	CDgqtfOk74vYdzmMQa43L11Tv9OTOHnh8WUPpR5/NRGqb8yqLs57u9p1OpfPJs/QbqlohUM1
	BawNZbuvTGCV7FjdEBKkuOGvxa29jy7K3Qt9aK5YkaiwifFF7La7fPv1m3da8/xy05FwyjV5
	+9fRXX3Lk6uGfz3OzbBjsplReXORxj4Fp8rf/TZ3HWYyOc1NOn5z5ZrbVm2vAhVygh/cePHR
	9GHcpRgnCcmrPOze07VXX9HicZ5ydavYTCWW4oxEQy3mouJEANxBCaErBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnK6Bg1WawZ9edYumCX+ZLVbf7Wez
	+L69j8Xi5oGdTBYrVx9lsjj6/y2bxdYvX1kt9t7Strgx4Smjxbbf85ktfv+Yw+bA7bF5hZbH
	5bOlHptWdbJ57L7ZwObRt2UVo8fnTXIBbFFcNimpOZllqUX6dglcGQvmHGYq+ChacebQBOYG
	xgOCXYycHBICJhKPJ79n72Lk4hAS2M0ocffbF0aIhIzE7rs7WSFsYYmV/55DFX1klHg66xBQ
	goODTUBX4kdTKEiNiICFxPPm5UwgNcwC1xklbkzfygySEBZwk+hcsA3MZhFQldj/agc7iM0r
	YCtxYcpOdogF8hIzL32HigtKnJz5hAXEZgaKN2+dzTyBkW8WktQsJKkFjEyrGCVTC4pz03OT
	DQsM81LL9YoTc4tL89L1kvNzNzGCQ1pLYwfjvfn/9A4xMnEwHmKU4GBWEuE92m6eJsSbklhZ
	lVqUH19UmpNafIhRmoNFSZzXcMbsFCGB9MSS1OzU1ILUIpgsEwenVAPT+Xm8fe9y5rldPt0V
	Gh1Yt0hTbFFg1r4dfSx3bFjeaBQ0++g/Ypk4UTb+uMBTBc1L5RPmXK+/q8ce8Pxx+675Gb8P
	Kguvy8vqkeDYdX692+prMXc7TraL7prFdELVs3WlRc/pEoVEzSMLyz47WIrViTRsD5bYb5wg
	wsKdu/mB0k6j9s1Nm/9ONH1VfP/ewpPFjl7Wm/5t7eWzPBX6/JC9+Itgq+/7+j12G04w/ziv
	fk7Y76DonMnJp1Qv3F+7UimtS+79ma7Jh68n3y+sLuP9O2PeVrEaOe4729V8L+i+/rFxUdun
	pIqPQelNFcniP83MlxwwyV6evC77kfvr3w8UJXsuSH/rS+fSm86jm7daiaU4I9FQi7moOBEA
	yaSED9gCAAA=
X-CMS-MailID: 20240507145232epcas5p481986099a82b1880758b7770cdeaf2d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240507145232epcas5p481986099a82b1880758b7770cdeaf2d2
References: <CGME20240507145232epcas5p481986099a82b1880758b7770cdeaf2d2@epcas5p4.samsung.com>

User space memory is mapped in kernel in form of pages array. These pages
are iterated and added to BIO. In process, pages are also checked for
contiguity and merged.

When mTHP is enabled the pages generally belong to larger order folio. The
pages from larger order folio need not be checked for contiguity and can be
added directly as a big chunk.

This patch series enables adding large folio to bio. It fetches folio for
page in the page array. The page might start from an offset in the folio
which could be multiples of PAGE_SIZE. Subsequent pages in page array
might belong to same folio. Using the length of folio, folio_offset and
remaining size, determine length in folio which shall be added to the
bio. Further processing is skipped for these pages. This reduces the
overhead of iterating through pages.

perf diff before and after this change:

Perf diff for write I/O with 128K block size:
        1.26%     -1.04%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
        1.74%             [kernel.kallsyms]  [k] bvec_try_merge_page
Perf diff for read I/O with 128K block size:
        4.40%     -3.63%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
        5.60%             [kernel.kallsyms]  [k] bvec_try_merge_page

Patch 1: Ignores bigger offset and helps driver to keep using PRP for I/Os
if length is one or two PRPs
Patch 2: Adds changes to add larger order folio to BIO.
Patch 3: If a large folio gets added, the subsequent pages of the folio are
released. This helps to avoid calculations at I/O completion.

Previous Postings
-----------------
v1: https://lore.kernel.org/all/20240419091721.1790-1-kundan.kumar@samsung.com/
v2: https://lore.kernel.org/linux-block/33717b97-8986-4d6e-aa10-47393b810ea2@suse.de/T/#m31564a9c6ae30e32e560dd8c76d26a3290a875aa

Changes since v2:
- Made separate patches
- Corrected code as per kernel coding style
- Removed size_folio variable

Changes since v1:
- Changed functions bio_iov_add_page() and bio_iov_add_zone_append_page() to
  accept a folio
- Removed branch and calculate folio_offset and len in same fashion for both
  0 order and larger folios
- Added change in NVMe driver to use nvme_setup_prp_simple() by
  ignoring multiples of PAGE_SIZE in offset
- Added a change to unpin_user_pages which were added as folios. Also stopped
  the unpin of pages one by one from __bio_release_pages()(Suggested by
  Keith)

Kundan Kumar (3):
  nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset
  block: add folio awareness instead of looping through pages
  block: unpin user pages belonging to a folio

 block/bio.c             | 50 +++++++++++++++++++++++------------------
 drivers/nvme/host/pci.c |  3 ++-
 2 files changed, 30 insertions(+), 23 deletions(-)

-- 
2.25.1

