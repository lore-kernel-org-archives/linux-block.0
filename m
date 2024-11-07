Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD44193060
	for <linux-block@vger.kernel.org>; Fri,  8 Nov 2024 03:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731037325; cv=none; b=dNLO8pYzrHGN1qSQHvLh/Fj9ZY93jUaucAN5MHvHrofKInmbd5HqtX7kmxNnAKyHt9CNI1KJGdAc0B/ZfUBrmPVB4+zg9R6b9ivMEkxOBWE6k3/pwZik1jKDnNJXw81aZ+VPS/jlM4Ed9kGrzQwJbgzCRLCVoEpPNO2qY4/Rim8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731037325; c=relaxed/simple;
	bh=GqJYpryisikuCyVQGu+5VoSiEybc2rT1WyOB4k67mOk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=JgVzAupLi4uztEzxuyESe4vPseXpvKam1ZpnFnPIiNIlWbuRV5wqyzP/LZVCLSsriUpuay3F0MzcnXTbzFIM/BRbrXXc2beiL6DyJshLr//68IeajcKvIp/N2y/LrY2giyiQ73jdgmHSUWIFPOtGwbxvAWylvpPjMzDPJ8v1Foc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XAi2p4u9; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XAi2p4u9"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241108034159epoutp0327ac338b92584f5c98d3e0124c1c4ff1~F4UVPISCa0486204862epoutp03-
	for <linux-block@vger.kernel.org>; Fri,  8 Nov 2024 03:41:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241108034159epoutp0327ac338b92584f5c98d3e0124c1c4ff1~F4UVPISCa0486204862epoutp03-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731037319;
	bh=fa1ahyFot+Xq1W8QWKjaZxAd6TVT7Sfwwn6d3A1tHhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XAi2p4u9YjQdyCyxoPhkP7RKU5t9IyuRFYLrZpXrVAFvcOmzNTQy15Da9tMVDSuK4
	 gxNy7vsPJVCVmoFsBOHvK+kbfvkWWrxZyi7IRh1CLSGv5hCa/FympnqBvCENYSH8Dw
	 eoI2abt6s+UritN5Efv4OZVwvHvlfBPInhC7fIw0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241108034159epcas5p204d2639f7bca4e4f414e28e50b6fc7f1~F4UVCWngU1290312903epcas5p2i;
	Fri,  8 Nov 2024 03:41:59 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Xl4W94MVQz4x9Q8; Fri,  8 Nov
	2024 03:41:57 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	48.DC.08574.5888D276; Fri,  8 Nov 2024 12:41:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241107091829epcas5p13ad0ec21580a2eed4e8ca26cbc4644c5~FpQ2uMShP2419824198epcas5p1j;
	Thu,  7 Nov 2024 09:18:29 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241107091829epsmtrp20bfed0e01b23ac154dd1fdaffb890b5e~FpQ2tlI301431414314epsmtrp2R;
	Thu,  7 Nov 2024 09:18:29 +0000 (GMT)
X-AuditID: b6c32a44-93ffa7000000217e-1e-672d8885f761
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D9.4D.07371.5E58C276; Thu,  7 Nov 2024 18:18:29 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241107091829epsmtip1c17fcfd8ef5c36b4253026342657860d~FpQ2AP_hl1924519245epsmtip1l;
	Thu,  7 Nov 2024 09:18:29 +0000 (GMT)
Date: Thu, 7 Nov 2024 14:40:43 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: share more code for bio addition helpers
Message-ID: <20241107091043.dblanxy65gojsooh@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241107072053.GA4112@lst.de>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmlm5rh266wc+rshar7/azWaxcfZTJ
	Yu8tbQdmj8tnSz1232xg8/i8SS6AOSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DS
	wlxJIS8xN9VWycUnQNctMwdojZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRA
	rzgxt7g0L10vL7XEytDAwMgUqDAhO+PS9JNMBZt4KyZulGlgbOTuYuTkkBAwkZjXvJy5i5GL
	Q0hgN6PEl8vbmUESQgKfGCVOf/SBSHxjlFjeuooRpuPyl0+MEIm9jBK3Vixgh3CeMUps7ell
	AqliEVCRWPm0h7WLkYODTUBX4kdTKEhYREBJ4umrs2CDmAVsJX4fOcoCYgsLeEi8mPGHFcTm
	FTCTmNLWxQRhC0qcnPkErIZTQFti4qUFYDWiAjISM5Z+BTtbQuAUu8SxJd+YIK5zkdg86SXU
	pcISr45vYYewpSQ+v9vLBmFnSxxq3ABVXyKx80gDVI29ROupfmaI4zIkZq+aADVHVmLqqXVM
	EHE+id7fT6B6eSV2zIOx1STmvJvKAmHLSCy8NAMq7iFx//onVkgAfWeUeDall3kCo/wsJM/N
	QrIPwraS6PzQxDoLGHbMAtISy/9xQJiaEut36S9gZF3FKJlaUJybnppsWmCYl1oOj+/k/NxN
	jOBEqOWyg/HG/H96hxiZOBgPMUpwMCuJ8PpHaacL8aYkVlalFuXHF5XmpBYfYjQFxtVEZinR
	5HxgKs4riTc0sTQwMTMzM7E0NjNUEud93To3RUggPbEkNTs1tSC1CKaPiYNTqoHJ2tk8YdFl
	9SyZbSm/2WpvH5mr8k0353ruie9TMg3vLFPpE5587M2dR1djjUv4X0tddi78cz7USOmL0UwO
	PcGmlLcPcjLev36mqV7Yrr137eydKU3Tlu7qubelZmn/6qAezfOvnn7S7ZFcKW25t+hRc6xd
	unFL2zJH67BCu60as7hqLu843JQW/pbz2BFJ57ZY06sz/h1+fV9ku8+2PIkHV323vE6dO1u4
	wGvFrXcca//Oun406LKbWuge9wfeUa+3+LKuYpkbcSNkR6JaJ1PmP7eWmK0Lz5desWb7P1N2
	ptOa82/kwnK3x387mR/w4WhboDnPjpNl9mFZxZNXfryg8evVjkO5ayaf8DTYFHKtWomlOCPR
	UIu5qDgRAAhky3ENBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSnO7TVp10g6vzzSxW3+1ns1i5+iiT
	xd5b2g7MHpfPlnrsvtnA5vF5k1wAcxSXTUpqTmZZapG+XQJXxvvbt5kLnnBVXL3dxdbAeJaj
	i5GTQ0LAROLyl0+MILaQwG5GifeznCHiMhK77+5khbCFJVb+e87excgFVPOEUWL1qalsIAkW
	ARWJlU97gIo4ONgEdCV+NIWChEUElCSevjoLNpNZwFbi95GjLCC2sICHxIsZf8Bm8gqYSUxp
	62KCmPmTUaL35C92iISgxMmZT1ggms0k5m1+yAwyn1lAWmL5P7CbOQW0JSZeWgA2RxTozhlL
	vzJPYBSchaR7FpLuWQjdCxiZVzFKphYU56bnJhsWGOallusVJ+YWl+al6yXn525iBAewlsYO
	xnvz/+kdYmTiYDzEKMHBrCTC6x+lnS7Em5JYWZValB9fVJqTWnyIUZqDRUmc13DG7BQhgfTE
	ktTs1NSC1CKYLBMHp1QD07YIwydla05Liq7KW1K1X4ZNZq9F56uIs9/uf0jz3nbvLkM7D5vu
	5YYUVr2KBU8uZnl4MDzMytOKLprke+O+yFRng4iUdQc5mq8tnCC1nJVT8YjKRHdZGbYlE+3a
	99zqKBS8rizxVYXfZZGfXk3oMbHpOxwagv9oHtrNtUpN3or1YesKtxu5JUpMobEFxvy/+5Nf
	+V/Vnf9i4q6n//bkuFlnbw/bk1tbLfopvO3uva6MzITg52dfn9r3o61p7u74w6yqbNuPXcuU
	dtLl7am/9m7+9J2csZZ3bx81/73q1W7vuuMvczRDjAwsQn50M8V+XWi/e5VL0puDLG/rnp8s
	/xb81i59ms7jiZvDnuveVWIpzkg01GIuKk4EAMUG+xPPAgAA
X-CMS-MailID: 20241107091829epcas5p13ad0ec21580a2eed4e8ca26cbc4644c5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----4Q1Zi_KIf9_.4xoFwoas6UvdQHcFnkls7nqrl97Ci5BoFZ08=_ad7b8_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241106101119epcas5p474ef1db0344f36c701535643af318f2a
References: <20241105155235.460088-1-hch@lst.de>
	<20241105155235.460088-3-hch@lst.de>
	<CGME20241106101119epcas5p474ef1db0344f36c701535643af318f2a@epcas5p4.samsung.com>
	<20241106100338.35xxy2mcpp4u36xl@green245> <20241107072053.GA4112@lst.de>

------4Q1Zi_KIf9_.4xoFwoas6UvdQHcFnkls7nqrl97Ci5BoFZ08=_ad7b8_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 07/11/24 08:20AM, Christoph Hellwig wrote:
>On Wed, Nov 06, 2024 at 03:33:38PM +0530, Kundan Kumar wrote:
>>> -int bio_add_page(struct bio *bio, struct page *page,
>>> -		 unsigned int len, unsigned int offset)
>>> +static int bio_do_add_page(struct bio *bio, struct page *page,
>>> +		 unsigned int len, unsigned int offset, bool *same_page)
>>
>> As we are passing length within a folio, values will reach near UINT_MAX.
>> It will be better to make len and offset as size_t, also to add a check like :
>> if (len > UINT_MAX || offset > UINT_MAX)
>> 		return 0;
>
>Not sure what the point is.  IFF we get folio sizes overflowing an
>unsigned int we'll have a massive problem as it will overflow the
>bv_offset and bv_len fields.  So we'd need to address that first before
>doing anything else.

In my opinion, there isn't a current use case where it overflows, but
its better to include a check for the future. WARN_ON is also an option
as used in bio_add_folio_nofail()

>
>>> {
>>> -	bool same_page = false;
>>
>> nit: extra line got added
>
>Yes, the previous code was missing the empty line after the variable
>declaration, so this got fixed.
>

Actually the extra line got introduced at the beginning of function
definition of bio_do_add_page().

Otherwise the code looks good. 

Reviewed-by: Kundan Kumar <kundan.kumar@samsung.com>

------4Q1Zi_KIf9_.4xoFwoas6UvdQHcFnkls7nqrl97Ci5BoFZ08=_ad7b8_
Content-Type: text/plain; charset="utf-8"


------4Q1Zi_KIf9_.4xoFwoas6UvdQHcFnkls7nqrl97Ci5BoFZ08=_ad7b8_--
