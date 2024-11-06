Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18F21DC730
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887531; cv=none; b=F0PNv/q88bAibWFRiw/m+awXszdP7wPm4a4MLHCg8qDwZoWPymgw46lcPZqhyr1GKBthsb+HPUf4CMCz7L7IQNKHmrLgRWtNho9F7LBww2+KiCrjMQnLC+ezufiZxxOXbV2R5myopHFxww8lriEwMMCtTh95MQesR9tQ0rKthl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887531; c=relaxed/simple;
	bh=gwonmytKap5Qvx7ZSfleEltk/ocqcA6VW/v++DMxJIw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=Gy8GpTDwL911pkFgoZkks7WBv/Lqktp19IpPA/iU3zT2q+aK/vRgpcapDaDx8l2JyqFgefPSaTab7Mn+WXFonV/3pWjGNlt8S5JzvCmL1VbX5HuTq2FkhqtupscktIYuoxUgTR9gqR2WzVfMGlBt6CUBAIni2vYwoHLFfN0qCu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=B24m+CNU; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B24m+CNU"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241106100525epoutp01eb3d536d08b396de23da06d68ceb3bcd~FWQiwLfBa2581825818epoutp01R
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 10:05:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241106100525epoutp01eb3d536d08b396de23da06d68ceb3bcd~FWQiwLfBa2581825818epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730887525;
	bh=gwonmytKap5Qvx7ZSfleEltk/ocqcA6VW/v++DMxJIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B24m+CNUO4ZUFmB5iysQsSl7P99eG4Y5mdp5sqWVu4yImUATOZws+b7WpithVwTGO
	 dd9RXVQVIf1OfGG7mRoqCFcFBTezJck9jzA50s8W233/MaMspXn0r77axHTW/LeLm6
	 PUc7q5dTHEdmhgpA3W/jxVCPdh1MZTudibZcF7jo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241106100525epcas5p4709979fdd61463010ea7250448203019~FWQibOjxA2135721357epcas5p4f;
	Wed,  6 Nov 2024 10:05:25 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Xk16W4Tk1z4x9Q4; Wed,  6 Nov
	2024 10:05:23 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.55.09420.26F3B276; Wed,  6 Nov 2024 19:05:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241106100237epcas5p4a714ae4a9122bac0f5fdaf6d2f6d6eb2~FWOGN_SHf0345003450epcas5p4F;
	Wed,  6 Nov 2024 10:02:37 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241106100237epsmtrp10687ba48edf30a45750c25bbb8c74f5a~FWOGNV2sp0097900979epsmtrp1w;
	Wed,  6 Nov 2024 10:02:37 +0000 (GMT)
X-AuditID: b6c32a49-33dfa700000024cc-2d-672b3f62aa09
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F6.87.08227.DBE3B276; Wed,  6 Nov 2024 19:02:37 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241106100236epsmtip15c9235395901b11d8b127757e726d551~FWOFjOj881931619316epsmtip1W;
	Wed,  6 Nov 2024 10:02:36 +0000 (GMT)
Date: Wed, 6 Nov 2024 15:24:49 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: remove bio_add_hw_folio
Message-ID: <20241106095449.esrfogbmy54mu66k@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241105155235.460088-2-hch@lst.de>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmum6SvXa6wdV7Nhar7/azWaxcfZTJ
	Yu8tbQdmj8tnSz1232xg8/i8SS6AOSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DS
	wlxJIS8xN9VWycUnQNctMwdojZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRA
	rzgxt7g0L10vL7XEytDAwMgUqDAhO+Pk5BOMBRNYK+7tmcrUwHiEpYuRk0NCwETi/N5v7F2M
	XBxCArsZJSYsX88G4XxilPj1u4cZwvnGKDFr8m9GmJbu231Qib2MEv9bd7OCJIQEnjFK3P7P
	BWKzCKhIHH5+GWgHBwebgK7Ej6ZQkLCIgJLE01dnweYwC9hK/D5yFKxEWMBc4vEja5Awr4CZ
	xNfps5khbEGJkzOfgF3KKWAo0bvrOpgtKiAjMWPpV7ATJATOsUvM774PdZuLxKV1IB+A2MIS
	r45vYYewpSRe9rdB2dkShxo3MEHYJRI7jzRAxe0lWk/1M0PcliHRd6QDGkSyElNPrWOCiPNJ
	9P5+AtXLK7FjHoytJjHn3VSoehmJhZdmMIH8JSHgITFvgwokqFYzSixf28A8gVF+FpLfZiFZ
	B2FbSXR+aGKdBdTOLCAtsfwfB4SpKbF+l/4CRtZVjJKpBcW56anFpgWGeanl8OhOzs/dxAhO
	g1qeOxjvPvigd4iRiYPxEKMEB7OSCO+8VPV0Id6UxMqq1KL8+KLSnNTiQ4ymwJiayCwlmpwP
	TMR5JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeWpGanphakFsH0MXFwSjUwmZwsYLfamKg7
	vaEk5Ewr4xc5Q0btb7cPSP68nXMieeLJC0bMoscYwue0lZ5Qckwt3yjMs6vQyXi++gGZ57ND
	a7gm7dkxgVv4ElObdlLy15z+K1JL97jeydSPikqoDUmKeOZb63BgCeMpryWcC1/9c6jTEV47
	9wXfo7eH53xefPtxh0xInqnx/fr7vWZrJM53J/srnJzofyNEO+be7rSjUh4+nIEV5+o0u/qP
	/pq1rWaHT9w1d/t8p4wvyfOz2q4ZFT042v6mIuWvaZvzdL+wxouL28y3rhE+e0nQRFtgyvP6
	K60Rb85K3KwtWbog7PX+8iceq/NU/XqPCjdO4DNMKptsPvV/fNxpk4qLMwyVWIozEg21mIuK
	EwH8olSJDAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnO5eO+10gyf3JS1W3+1ns1i5+iiT
	xd5b2g7MHpfPlnrsvtnA5vF5k1wAcxSXTUpqTmZZapG+XQJXRsuGTywFh5gqLu89y9rAOIGp
	i5GTQ0LARKL7dh9zFyMXh5DAbkaJJedPskIkZCR2390JZQtLrPz3nB2i6AmjxOGeJWwgCRYB
	FYnDzy+zdDFycLAJ6Er8aAoFCYsIKEk8fXWWEcRmFrCV+H3kKFiJsIC5xONH1iBhXgEzia/T
	ZzOD2EIC4RIr9l5mhIgLSpyc+YQFotVMYt7mh8wgrcwC0hLL/3GAhDkFDCV6d10HKxEFunLG
	0q/MExgFZyHpnoWkexZC9wJG5lWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMHhq6W1
	g3HPqg96hxiZOBgPMUpwMCuJ8M5LVU8X4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvvtdW+KkEB6
	YklqdmpqQWoRTJaJg1OqgckpaM6eqYsjbx8Ouat7aLKeYZ1Bw5e3K9WFPx1faC7VzFRi+eVI
	B7PUwU9pnbI79jgzmT/bH/6Yt5Lr19LofrX//sfvq8/5N+lgMePe1BtXpp3Py/6WbzL969xj
	T6d92HDkkElz1+K4u/ah0ZeLzGbzhzoVXG/PcV79m9XYPvzSnmtNc7xuxz72mLo021FKb99z
	TbdSrwaup5X/c4+35V46K7PkiXBrtV7K5GP/pM7tWfLebK4On2PeG9ZVgfbV3rM+bfu2+9Ie
	JVuuhJqLPHF8SywcZVxzlv4y0v655MTGLdOC+RYpJG3yuqVy7seZpPZ+nnXdftwrFs5l/K+/
	4pj6A5n8yyHV219cbOwRD7ujxFKckWioxVxUnAgAHXscQs4CAAA=
X-CMS-MailID: 20241106100237epcas5p4a714ae4a9122bac0f5fdaf6d2f6d6eb2
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_a8b9d_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241106100237epcas5p4a714ae4a9122bac0f5fdaf6d2f6d6eb2
References: <20241105155235.460088-1-hch@lst.de>
	<20241105155235.460088-2-hch@lst.de>
	<CGME20241106100237epcas5p4a714ae4a9122bac0f5fdaf6d2f6d6eb2@epcas5p4.samsung.com>

------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_a8b9d_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 05/11/24 04:52PM, Christoph Hellwig wrote:
>The only user of bio_add_hw_folio was removed in commit cafd00d0e909
>("block: remove zone append special casing from the direct I/O path"),
>so remove it as well.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kundan Kumar <kundan.kumar@samsung.com>

------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_a8b9d_
Content-Type: text/plain; charset="utf-8"


------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_a8b9d_--
