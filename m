Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013D11ACDE3
	for <linux-block@vger.kernel.org>; Tue,  1 Oct 2024 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767641; cv=none; b=O7nji39lwRmIREMlfotbLfvD+2WtoiIolv/57pFEkcu3HB7i4GeT+A9P5ZCgMwkK28kFJiRcvAS/cuCseSEqaZgO7UyIpF9pfRlgrxqUHR87ZZhJdBhMFvzSE5iDSd+ahRQmF433FiSNT1PCgJJbCovemkz1+HEY009r055iHzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767641; c=relaxed/simple;
	bh=huOa6NuruS0bLWEdZlZXh7cUUuwkMz2dpcR/TeJ2o9g=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=rQkrb7agi8LdjlD11lIno4AvXftA4sJnpD4wtvag0ZQZtkNUOlmvxJ9qTwrF/2+HPKayWeJ9Hz7nkE/ETlTgOp2tDVTOwtpOkdGlm97gF+GsIa+yRGokejYx2awl7akgJf9iA4YI5pxHwTgeGFKmXfrdfArQIRp4ZY+a7ZmyMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=h/DNvQZR; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h/DNvQZR"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241001072710euoutp02aa2dc51347341f7568f22380cc59a6f8~6Q4GXpPKF2853428534euoutp02G
	for <linux-block@vger.kernel.org>; Tue,  1 Oct 2024 07:27:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241001072710euoutp02aa2dc51347341f7568f22380cc59a6f8~6Q4GXpPKF2853428534euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727767630;
	bh=huOa6NuruS0bLWEdZlZXh7cUUuwkMz2dpcR/TeJ2o9g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=h/DNvQZRJgN4jVD94+jJlgImWYNOMmm3pnI/ncDhQnpaIzYpIaBBRn9cdcV8goWBa
	 VKA6ikEEZx1c4KrLfIn452GBKKIRPKK2UzDeksmue67ur4zIYi4jbKetzlm+eL7CJf
	 uKCel51sRxn44BH4PTQyXwzP9uA9kxGIo7Xpg6HU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241001072710eucas1p20b496d1bed6fdf8cb33ebd16fa0313c4~6Q4F9SpCL2239722397eucas1p2d;
	Tue,  1 Oct 2024 07:27:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 0C.D7.09624.E44ABF66; Tue,  1
	Oct 2024 08:27:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241001072710eucas1p1f2372e94fefcd3da33e2f4c65f97e0e6~6Q4FhC3Jl3189131891eucas1p11;
	Tue,  1 Oct 2024 07:27:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241001072709eusmtrp19ec853e71631de93b69a3e841b79548f~6Q4Ffu6Nh1359313593eusmtrp1B;
	Tue,  1 Oct 2024 07:27:09 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-32-66fba44e688e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 95.18.14621.D44ABF66; Tue,  1
	Oct 2024 08:27:09 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241001072709eusmtip2f84c243bf2788663b53806aa66cf34e3~6Q4FQsxIg2445324453eusmtip2d;
	Tue,  1 Oct 2024 07:27:09 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 1 Oct 2024 08:27:08 +0100
Date: Tue, 1 Oct 2024 09:27:08 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
	<axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
	<gost.dev@samsung.com>, Chinmay Gameti <c.gameti@samsung.com>
Subject: Re: [PATCH v2 2/3] block: support PI at non-zero offset within
 metadata
Message-ID: <20241001072708.tgdmbi56vofjkluc@ArmHalley.local>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <yq1ttdx81ub.fsf@ca-mkp.ca.oracle.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djP87p+S36nGTxcLWqx+m4/m8XK1UeZ
	LCYdusZosfeWtsX8ZU/ZLZYf/8dkse71exYHdo/z9zayeFw+W+qxaVUnm8fmJfUeu282sHl8
	fHqLxePzJrkA9igum5TUnMyy1CJ9uwSujP9XXzAWLOaoWP2lia2B8RJbFyMnh4SAicTCi1tZ
	uxi5OIQEVjBKnGv6B+V8YZSYPu8nI4TzmVHiy6lpzDAtk27egKpazijxZMFXNriqIwsvskA4
	mxklur88ZQVpYRFQkXj/4yQjiM0mYC9xadktsFEiAqYSkz9tBetmFmhmkpi3YRkLSEJYIEhi
	y+MeJhCbV8BWovXxTTYIW1Di5MwnYDXMAlYSnR+agBZwANnSEsv/cYCEOQWMJRZ+3csOcaqS
	xOMXbxkh7FqJU1tuMYHskhD4wCExu7cBKuEi8WruZiYIW1ji1fEtUM0yEqcn97BA2NUSDSdP
	QDW3MEq0dmwFWywhYC3RdyYHosZRYnbfJkaIMJ/EjbeCEGfySUzaNp0ZIswr0dEmBFGtJrH6
	3huWCYzKs5A8NgvJY7MQHlvAyLyKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMPmc/nf8
	0w7Gua8+6h1iZOJgPMQowcGsJMJ779DPNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qinyqUIC
	6YklqdmpqQWpRTBZJg5OqQYmY95m2bkZF74+f7PeXEt5bVTm/SW+Hbd1Ph9KbrZWy6jquxh9
	OnK9yceMQ+wTvpc9uF+4nOmOQtqck221f625U6+/+na+4/HvcxOnOHJEZV/N7C1iWjbN/fmc
	g2c1fz0SU3sf+7H/WO4VoaS1a6P+9gjrT991SYCh5txcn1VtJ19a/Ohfv8fk0Q4VgWWBns+S
	BDd+neP40aY64xX7zHtdN0XKP7PeSP8oGxvdILnSonjVn1bxPodTab1NK38xtRWa1bd1Xdl9
	Rr8nTtVt+qoaE2meFWv8w27NE0o7UJJqNm/aJfbCv9nW0d9f9S9+UjllzbwlU/4U3wq1cm7/
	9u56m3/J1oUfJopGBe1ULHY7oMRSnJFoqMVcVJwIAIAiBjGtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7q+S36nGWzeb2yx+m4/m8XK1UeZ
	LCYdusZosfeWtsX8ZU/ZLZYf/8dkse71exYHdo/z9zayeFw+W+qxaVUnm8fmJfUeu282sHl8
	fHqLxePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
	1CJ9uwS9jP9XXzAWLOaoWP2lia2B8RJbFyMnh4SAicSkmzdYuxi5OIQEljJK/FnTywiRkJHY
	+OUqK4QtLPHnWhdYg5DAR0aJH4sVIBo2M0o8PnqWGSTBIqAi8f7HSbBmNgF7iUvLboHFRQRM
	JSZ/2soG0sAs0MwkMW/DMhaQhLBAkMSWxz1MIDavgK1E6+ObUBsmMEv8WeEFEReUODnzCVg9
	s4CFxMz554EWcADZ0hLL/3GAhDkFjCUWft3LDnGoksTjF2+hHqiV+Pz3GeMERuFZSCbNQjJp
	FsKkBYzMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQIjcNuxn5t3MM579VHvECMTB+MhRgkO
	ZiUR3nuHfqYJ8aYkVlalFuXHF5XmpBYfYjQFBsVEZinR5HxgCsgriTc0MzA1NDGzNDC1NDNW
	Eud1u3w+TUggPbEkNTs1tSC1CKaPiYNTqoFJbcPTudZyAmvXNrBOT9gboraca1HO8a6HMra/
	zt7kea0r9d//kPwtX57GJc8NONuqnz9rtrVoUVg/8+aDUNvaq2Z1sx7FnjytWCyqLSBsdTjI
	/sa2pT//KMjz/1PZquGd/sW+I1TlF18uQ7CAX/LHaS9ihVh+zolL1mk0Enea/tizeZ7Ti++t
	zS3npBuWLVovsknNdvnVaoe24zWWEpctnjFrp4i2mYTXXzg1KbFpVuqXC3xuTKZnW4+LrTj9
	kL9iS5Ou5OWNaVJKayJeihQb+ZY6LDa/n8lp/yGN+fHWgC6HF+f3s31R/+S4xCD9xIsXXed7
	sxmvBvLc3T+zyPRlKcecmXKf+Pced+7xtVJiKc5INNRiLipOBACCluacSQMAAA==
X-CMS-MailID: 20241001072710eucas1p1f2372e94fefcd3da33e2f4c65f97e0e6
X-Msg-Generator: CA
X-RootMTR: 20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d
References: <20240201130126.211402-1-joshi.k@samsung.com>
	<CGME20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d@epcas5p1.samsung.com>
	<20240201130126.211402-3-joshi.k@samsung.com> <ZvV4uCUXp9_4x5ct@kbusch-mbp>
	<8ed2637b-559e-3f27-3d1f-84a4718475fb@samsung.com>
	<ZvWSFvI-OJ2NP_m0@kbusch-mbp>
	<165deefb-a8b3-594e-9bfb-b3bcd588d23f@samsung.com>
	<yq1ttdx81ub.fsf@ca-mkp.ca.oracle.com>

On 30.09.2024 13:57, Martin K. Petersen wrote:
>
>Kanchan,
>
>> I spent a good deal of time on this today. I was thinking to connect
>> block read_verify/write_generate knobs to influence things at nvme level
>> (those PRCHK flags). But that will not be enough. Because with those
>> knobs block-layer will not attach meta-buffer, which is still needed.
>>
>> The data was written under the condition when nvme driver set the
>> pi_type to 0 (even though at device level it was non-zero) during
>> integrity registration.
>>
>> Thinking whether it will make sense to have a knob at the block-layer
>> level to do something like that i.e., override the set
>> integrity-profile with nop.
>
>SCSI went to great lengths to ensure that invalid protection information
>would never be written during normal operation, regardless of whether
>the host sent PI or not. And thus the only time one would anticipate a
>PI error was if the data had actually been corrupted.
>

Is this something we should work on bringin to the NVMe TWG?

Javier
