Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D31D5CFA
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887921; cv=none; b=Ws9oItiOa2rGlPRaTLcK1Ed2OzgVFc7xku1SpbBjeDKhDD3uPn5lrmo2I8LNij0sP2y4Ve5nNudgxniygHB/7sTSpvDN28hEU7ysLMyDrnRHIj3scR3+RDkrvt56FDx6xz7jIfBd0uzlUWgIC7mA20N9goF9v4S2r2YO43aHsW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887921; c=relaxed/simple;
	bh=CbtIIlOalWoomClYcmeYszbfkivmKDbVuMxmAuoT1yY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=UUHPHJfqkzoFYmIqjXi2r1jRgHPln/In/HPr20nBXnblnn0WZkLzHFeuVR/zJcyiFU4o00q3dgdWGTgwy+t4GbbuGaXxQdH/M6dEeyXEw/LUgtYrxzQJpMdYlpVOAhfvlw4jQTxU9X/bfZzcerbxhP2krR2NGbl+464GvumszfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LqU21TvB; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LqU21TvB"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241106101155epoutp025021eb1652cb273d295695e0a4d55dc7~FWWOLOC_U2671626716epoutp02P
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 10:11:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241106101155epoutp025021eb1652cb273d295695e0a4d55dc7~FWWOLOC_U2671626716epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730887915;
	bh=T8eXRjI6ItEdhUKQVHBIA1CMr1wfrzGQ5QpcSzcbt6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LqU21TvBexo4qy6C5G5DiEraZjak+hNKMGpxzP9fKfW9lmBsngPmFS5XLFXG4PAU9
	 s99IZCKpYQdEcDsi2VR6LQUXxIBxoRsSUf/dHNPdnUsxn18ejqQxu0lLF57eVg1YFj
	 nOS2GdHQFP/3/rNiG4W6UFmK4HWW+Oi0uE+TkJfI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241106101155epcas5p18d8cabc20cafc2494d012e65f51f3ca5~FWWN6L1uY0163101631epcas5p1C;
	Wed,  6 Nov 2024 10:11:55 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Xk1G16skhz4x9Pv; Wed,  6 Nov
	2024 10:11:53 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F7.5A.09770.9E04B276; Wed,  6 Nov 2024 19:11:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241106101119epcas5p474ef1db0344f36c701535643af318f2a~FWVse8Kin3262132621epcas5p4l;
	Wed,  6 Nov 2024 10:11:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241106101119epsmtrp239f45520fbaf80981a237d15ece64d12~FWVsdo9cF1163111631epsmtrp2F;
	Wed,  6 Nov 2024 10:11:19 +0000 (GMT)
X-AuditID: b6c32a4a-bbfff7000000262a-8a-672b40e9d390
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	27.B6.35203.7C04B276; Wed,  6 Nov 2024 19:11:19 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241106101119epsmtip1e42c645ae5ba7819c9c4b940cb8d959f~FWVr2TVPZ2380523805epsmtip1J;
	Wed,  6 Nov 2024 10:11:18 +0000 (GMT)
Date: Wed, 6 Nov 2024 15:33:38 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: share more code for bio addition helpers
Message-ID: <20241106100338.35xxy2mcpp4u36xl@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241105155235.460088-3-hch@lst.de>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmuu5LB+10g0m/TCxW3+1ns1i5+iiT
	xd5b2g7MHpfPlnrsvtnA5vF5k1wAc1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGl
	hbmSQl5ibqqtkotPgK5bZg7QGiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmB
	XnFibnFpXrpeXmqJlaGBgZEpUGFCdkbf2UesBfMFK2a9ms3UwLiKr4uRk0NCwERiw+cHLF2M
	XBxCArsZJV7OWc8E4XxilNj5YAMzhPONUWLbjmOMMC0L5l+DqtrLKHH4dxsbSEJI4BmjxIU/
	fiA2i4CKxMW1fUBxDg42AV2JH02hIGERASWJp6/Ogs1hFrCV+H3kKAuILSzgIfFixh9WkHJe
	ATOJiVNVQMK8AoISJ2c+ASvhFDCUuPj3NyuILSogIzFj6Vew2yQELrFL9HxdyQ7SKyHgItH4
	Iw7iTGGJV8e3sEPYUhKf3+1lg7CzJQ41bmCCsEskdh5pgKqxl2g91c8MMoZZIEPiY4MlRFhW
	YuqpdUwQF/NJ9P5+AtXKK7FjHoytJjHn3VQWCFtGYuGlGVBxD4n71z+xQkJqNaPE3s8bmScw
	ys9C8toshHWzwFZYSXR+aGKFCEtLLP/HAWFqSqzfpb+AkXUVo2RqQXFuemqxaYFRXmo5PLKT
	83M3MYJToJbXDsaHDz7oHWJk4mA8xCjBwawkwjsvVT1diDclsbIqtSg/vqg0J7X4EKMpMJ4m
	MkuJJucDk3BeSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9TBycUg1Mtds+
	FOoZTss1vrj52sLKB/sflz079CipbuLMxV+aP/3N212Z3dKmW5zwVpjd6bitvf965nusAuo7
	/XUX+9VzH5xzyrtYTGDlqVTV/RvKNDMfFPo58Jc6npzVMrO5W9JZYo/svk837APPvJYRlE6y
	tVp+b6m85Nxn8v93fd220jNuVcr51thXM5j10oLuHMyds26byDx2n1xT19i/283KH++drbTA
	PvfEfNWNb1levFx702+hPEtA5I3fW37Z+xgHWyfeccwNCVzqcOIu7/+Zi60V362+9o47z4Wx
	8f7jH0YGG7TdqjWzW5VUtcT+/Xv9otBgInf1XAvTsi0aPnLmnr6MZRnP9NUFtzUX3jujxFKc
	kWioxVxUnAgAg7g1jAoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnO5xB+10g8nvlS1W3+1ns1i5+iiT
	xd5b2g7MHpfPlnrsvtnA5vF5k1wAcxSXTUpqTmZZapG+XQJXxq+Ve9kKLvJV3Hg1iaWB8Rt3
	FyMnh4SAicSC+deYuhi5OIQEdjNKXJj1hBUiISOx++5OKFtYYuW/5+wQRU8YJZ5vfM8EkmAR
	UJG4uLaPrYuRg4NNQFfiR1MoSFhEQEni6auzjCA2s4CtxO8jR1lAbGEBD4kXM/6wgpTzCphJ
	TJyqAhIWEgiXmDxxGzuIzSsgKHFy5hMWiFYziXmbHzKDlDMLSEss/8cBEuYUMJS4+Pc32GWi
	QFfOWPqVeQKj4Cwk3bOQdM9C6F7AyLyKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4
	fLU0dzBuX/VB7xAjEwfjIUYJDmYlEd55qerpQrwpiZVVqUX58UWlOanFhxilOViUxHnFX/Sm
	CAmkJ5akZqemFqQWwWSZODilGpgmfvpjUrTPes8fu4hejwD/VzN22pZvvMh92rw2qiVF8bB4
	wa6UNR9nRTUHzjKUi5wx/1ahsLL6Cp/qLN4pt67f55u/s+rsT4eqP5l/P+i4Mj186Tzrc8lk
	vXszb31aFOx+r6JCdkdg6oX42q+ucvYZr/ee95/sePGKqVF93/X1R44e+7Q6zpjVoSD2fcbK
	ZVlirVe2zg2Ytzrzvdd69vCqwzvOZ/m2K1Y/SLt5Ulb+gNbVvWskgg9cuL2nqiEuc59vD9O/
	NPW/fAFJMZ8eiln9OW8vGP+90fWf5vb9QkonEn+U7z+bmGoeFsv0QLf+3e1juxjVrVeKSmtl
	OJ3Z0BJwo2zfoWAW3VrrJEVnt59KLMUZiYZazEXFiQBO7wCgzgIAAA==
X-CMS-MailID: 20241106101119epcas5p474ef1db0344f36c701535643af318f2a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_a86bb_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241106101119epcas5p474ef1db0344f36c701535643af318f2a
References: <20241105155235.460088-1-hch@lst.de>
	<20241105155235.460088-3-hch@lst.de>
	<CGME20241106101119epcas5p474ef1db0344f36c701535643af318f2a@epcas5p4.samsung.com>

------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_a86bb_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 05/11/24 04:52PM, Christoph Hellwig wrote:
>__bio_iov_iter_get_pages currently open codes adding pages to the bio,
>which duplicates a lot of code from bio_add_page.  Add a lower level
>bio_do_add_page helpers that passes down the same_page output argument
>so that __bio_iov_iter_get_pages can reuse the code and also check
>for the error return from it - while no error should happen due to
>how the bvec space is used for the pin_user_space result I'd rather
>be safe than sorry and actually check for these impossible errors.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>---
> block/bio.c | 66 ++++++++++++++++++++++++-----------------------------
> 1 file changed, 30 insertions(+), 36 deletions(-)
>
>diff --git a/block/bio.c b/block/bio.c
>index 1f6ac44b4881..bc3bca5f0686 100644
>--- a/block/bio.c
>+++ b/block/bio.c
>@@ -1063,20 +1063,9 @@ void __bio_add_page(struct bio *bio, struct page *page,
> }
> EXPORT_SYMBOL_GPL(__bio_add_page);
>
>-/**
>- *	bio_add_page	-	attempt to add page(s) to bio
>- *	@bio: destination bio
>- *	@page: start page to add
>- *	@len: vec entry length, may cross pages
>- *	@offset: vec entry offset relative to @page, may cross pages
>- *
>- *	Attempt to add page(s) to the bio_vec maplist. This will only fail
>- *	if either bio->bi_vcnt == bio->bi_max_vecs or it's a cloned bio.
>- */
>-int bio_add_page(struct bio *bio, struct page *page,
>-		 unsigned int len, unsigned int offset)
>+static int bio_do_add_page(struct bio *bio, struct page *page,
>+		 unsigned int len, unsigned int offset, bool *same_page)

As we are passing length within a folio, values will reach near UINT_MAX.
It will be better to make len and offset as size_t, also to add a check like :
if (len > UINT_MAX || offset > UINT_MAX)
		return 0; 

> {
>-	bool same_page = false;

nit: extra line got added


------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_a86bb_
Content-Type: text/plain; charset="utf-8"


------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_a86bb_--
