Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC19714273
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 05:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715146669; cv=none; b=m6MXOi/7Ygjkkb2AKTTL8Pbim/h+hE3eAkSWxMqzv4TW8t9Dmf02NvbtpwqCvCMvhVJRnF6FG8mCAymkNPbHPY1+nC4AbP0ErVKYHWnKI/6jCoP9Y10zBTZnRRELboYcN3DLqaVMElT2TbfxLhXef1Fp6zMF0Zab0gdMDxxA4+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715146669; c=relaxed/simple;
	bh=RrwhV9wI5t2iPVtGGb01nOvzSeBF+YBhtXJrOl5dCR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=mn4UVUeX/5z+soaZ56dBdtbj1HfpjY69GQ+BSEPs2spzIM/iXF51/Kw7BiPsTTL1hBBPPhR9h9FgtjBtPdxZIjvRIUEkD6nrb+zumw8QmWF5sbhjFaoyK0D7LWvUNxeXuQKemxdHbcLuYI/6hI6KUE+GMrCNsbDOPqxQVgqJQwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Taw+KeoN; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Taw+KeoN"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240508053738epoutp01fb0854a219b0b10b94b92ce544e66fe0~NbMyDlsfN2166721667epoutp01o
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 05:37:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240508053738epoutp01fb0854a219b0b10b94b92ce544e66fe0~NbMyDlsfN2166721667epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715146658;
	bh=lMKoTuW498udd4sb4rpdpBjxl9EL7fK/db3c2eR17zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Taw+KeoN3Hy7JmcwF6PC9tawTaX+MnjzHRavuq5VXc8H6PYjTJknMhxKRsDltUhRQ
	 rspCnJiDWKua6sxim94O5vwQnDEtKjfZmroMjLm52f1RGB+a6FO7y+slo2nicYeT5C
	 2R3x71gPguR2BLWLWVav/Go2jscAVu5WZ7VuJV8Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240508053738epcas5p4b52b57c77208ec01ed70f8bc1ce5b285~NbMxwylxz0993109931epcas5p44;
	Wed,  8 May 2024 05:37:38 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VZ3nX5Xr8z4x9Q5; Wed,  8 May
	2024 05:37:36 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	75.AE.08600.0AF0B366; Wed,  8 May 2024 14:37:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240507145251epcas5p29e95da982219c6a1c196182fe70a45f5~NPIQpFEfj3003330033epcas5p2i;
	Tue,  7 May 2024 14:52:51 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240507145251epsmtrp12d9d0c8e2e166c3ac5a14d7f36c52ed9~NPIQoUmz90625406254epsmtrp14;
	Tue,  7 May 2024 14:52:51 +0000 (GMT)
X-AuditID: b6c32a44-921fa70000002198-e6-663b0fa0f5b4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	24.4D.09238.3404A366; Tue,  7 May 2024 23:52:51 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240507145249epsmtip1c3faac5b537feaa70de3c0587ba03e18~NPIPD_g2z2861028610epsmtip11;
	Tue,  7 May 2024 14:52:49 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v3 1/3] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in
 offset
Date: Tue,  7 May 2024 20:15:07 +0530
Message-Id: <20240507144509.37477-2-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507144509.37477-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmuu4Cfus0gyMz1C2aJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFlu/fGW12HtL2+LGhKeMFtt+z2e2+P1jDpsDt8fmFVoe
	l8+Wemxa1cnmsftmA5tH35ZVjB6fN8kFsEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
	6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
	KTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM6Y3vObrWAWZ8XKO7tYGhiPsncxcnJICJhI/Nzf
	x9rFyMUhJLCbUeL64uPMEM4nRolpM+exglQJCXxjlFi52wGmo239OxaIor1ARY0X2SGcz4wS
	3+aBzOXgYBPQlfjRFArSIALU8HLlbUaQGmaBs4wSJ6Y+YgFJCAsESrzeuwTsDhYBVYmdB7vA
	bF4BW4k3j/ewQmyTl5h56TtYnFPATqJvzQNGiBpBiZMzn4DNYQaqad46G+xsCYFODom7q35A
	NbtIrFgE86iwxKvjW6BsKYmX/W1QdrbEocYNTBB2icTOIw1QcXuJ1lP9zCDPMAtoSqzfpQ8R
	lpWYemodE8RePone30+gWnkldsyDsdUk5rybygJhy0gsvDQDKu4hMevBWmjITWSUmHejn3kC
	o8IsJP/MQvLPLITVCxiZVzFKphYU56anJpsWGOallsNjOTk/dxMjOMFquexgvDH/n94hRiYO
	xkOMEhzMSiK8R9vN04R4UxIrq1KL8uOLSnNSiw8xmgIDfCKzlGhyPjDF55XEG5pYGpiYmZmZ
	WBqbGSqJ875unZsiJJCeWJKanZpakFoE08fEwSnVwLQxN3LnJDfNmfHbDl20zDM+sITh5H2e
	pSqP060eVa2V2v9LUGHDDtElP+ZPDp7n1bPiRchrpsXnjz7Nu3zmxqMln+01XIJzZr885vXI
	YOb5gydfP1ObbppxN6TMW+N9OcNmltdrv+bK5SyfdmUiq66QyFeeDWct57lET1neuJCn6579
	1+0yzm8F7bnP/PrMbitwvGT7ar8N10/sauPcetSDuz9G93he9Bcvw0vXlyknRrx/etSnQsZc
	mfnY5LmMl3LCL7+9vHCj+r1Jir0XJXryxEOemdypyQu0SJXaWetpNN9Q20Z5MltFdWielWaY
	b084x+J96TrmLumHdkpOdd6hk3/6k+CBeZ9Tz0vmciUqsRRnJBpqMRcVJwIAvrxcgzkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSnK6zg1Wawc4OMYumCX+ZLVbf7Wez
	+L69j8Xi5oGdTBYrVx9lsjj6/y2bxdYvX1kt9t7Strgx4Smjxbbf85ktfv+Yw+bA7bF5hZbH
	5bOlHptWdbJ57L7ZwObRt2UVo8fnTXIBbFFcNimpOZllqUX6dglcGdN7frMVzOKsWHlnF0sD
	41H2LkZODgkBE4m29e9Yuhi5OIQEdjNKPHjZzwKRkJHYfXcnK4QtLLHy33N2iKKPjBKd5/6x
	dTFycLAJ6Er8aAoFqRERsJB43rycCaSGWeA6o8SN6VuZQRLCAv4SiyZuAtvGIqAqsfNgF5jN
	K2Ar8ebxHqgF8hIzL30Hi3MK2En0rXnACGILAdXc/rqWDaJeUOLkzCdgxzED1Tdvnc08gVFg
	FpLULCSpBYxMqxglUwuKc9Nzkw0LDPNSy/WKE3OLS/PS9ZLzczcxgmNAS2MH4735//QOMTJx
	MB5ilOBgVhLhPdpunibEm5JYWZValB9fVJqTWnyIUZqDRUmc13DG7BQhgfTEktTs1NSC1CKY
	LBMHp1QDE2/11zuxvhOWnGq2MBUyLu+zlvOp79R6uLYl8veHvTKq9befnd3Z6+m0ZZJi5zYl
	o9aNDDrcd923ZrgqXMibtT6DO/FNh+JWVbPGmw767ky6JVxqvtp33ZcUcvs8//v1zNvO11z3
	LjvtZdNV2aq9VO4ad26SlO2zE24bzAqsv2r4hna8ePde5XrVas1Ni5Z/8j6klsljNP3E9k8P
	zHSXvclbyLuYv2xn1+Rnpq7nY94eXeE6Y/tm3Zcuj2pyZRrXPGNRiC0sXunS94VvUlPtyYSn
	8+VmG7qxd8jMn89gwy6n/Zw/gHP5xeTpj5J0Q37s2H/j4LEAVsn31yI2We6ZMunc7ofWby9Y
	/vdcqKvWrcRSnJFoqMVcVJwIAK8/EFrwAgAA
X-CMS-MailID: 20240507145251epcas5p29e95da982219c6a1c196182fe70a45f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240507145251epcas5p29e95da982219c6a1c196182fe70a45f5
References: <20240507144509.37477-1-kundan.kumar@samsung.com>
	<CGME20240507145251epcas5p29e95da982219c6a1c196182fe70a45f5@epcas5p2.samsung.com>

bio_vec start offset may be relatively large particularly when large
folio was added to the bio. A bigger offset will result in avoiding the
single-segment mapping optimization and end up using expensive
mempool_alloc further.

Rather than using absolute value, adjust bv_offset by
NVME_CTRL_PAGE_SIZE while checking if segment can be fitted into one/two
PRP entries.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8e0bb9692685..c6408871466f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -778,7 +778,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
+			if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
+			     bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
-- 
2.25.1

