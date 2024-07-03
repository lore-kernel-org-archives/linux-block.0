Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C38316D4CD
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009167; cv=none; b=Q/CdA03jOxLTh3lQ0xxvnSGsj3luzRmuTHviBHoqVz7zmFw10fg+6PUNK5UnLpJZOLU65X/lFMfGcBEvP//EapF3CkKAuBA1oyplK9UdKIHVL00tDTIRvcFsjTwi4c5Ba8CXrvejNlmoiWk9mW2Wc6cYspsD1aBE5YNIn3NobH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009167; c=relaxed/simple;
	bh=yz0lxWYvjt0+Kt6xnP7GZDgunD9hVcWJYLBk9I4hKWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=SOHIz5NatTiCpcF+eZwGeS5AunIo7DlKdV0kb2ceAFYEBI7yi/mpb8Intipk12FCVXfE8yHicZMxvoutO982Myyc7Wt+poLjmtiynn6i62jLowt/cvD2n1dy7eb4JtiPsBSwaOmVk0/bjTWasOq5atajOyGSVw+2PvNitOYyNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=u4s5NA7m; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="u4s5NA7m"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240703121916epoutp02ff9247672445b14aa00d5a1fcfb68afa~eszbqyqV-1118011180epoutp02y
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 12:19:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240703121916epoutp02ff9247672445b14aa00d5a1fcfb68afa~eszbqyqV-1118011180epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720009156;
	bh=yz0lxWYvjt0+Kt6xnP7GZDgunD9hVcWJYLBk9I4hKWw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=u4s5NA7mgAYdvn/J7PPR5XTSE6+B2THvzhsHuQsuiRLX4KZ5Uoyg4eSGQPSho2LtR
	 KUoByPNEfONR4Tfk31VKuR2hHD7/3n0P5M9W8dqjlkAl46RPFe2MRGNggA5M/q7lBk
	 q0RzgubRU4MINoENJx/9vUqY0iSenHi2loaqcTL4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240703121915epcas5p13510e40fccf3c4204ad1ae5bed86fbea~eszbJGomQ0273202732epcas5p1B;
	Wed,  3 Jul 2024 12:19:15 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WDf3564ZGz4x9Pt; Wed,  3 Jul
	2024 12:19:13 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2A.D6.09989.1C145866; Wed,  3 Jul 2024 21:19:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240703121913epcas5p35477f0a1e821d9dff05c6344a558e66b~eszY6YSEg0893108931epcas5p3a;
	Wed,  3 Jul 2024 12:19:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240703121913epsmtrp293ffe805ac7fd9cccc1750fed9d36101~eszY5Tniu2729527295epsmtrp2m;
	Wed,  3 Jul 2024 12:19:13 +0000 (GMT)
X-AuditID: b6c32a4a-bffff70000002705-89-668541c186ff
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2B.E3.29940.1C145866; Wed,  3 Jul 2024 21:19:13 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240703121912epsmtip1139a025c80e4da635fd9ad775ce74d4d~eszYAU0su2571525715epsmtip1S;
	Wed,  3 Jul 2024 12:19:12 +0000 (GMT)
Message-ID: <c65db889-a5c9-2ece-4f08-46960a692545@samsung.com>
Date: Wed, 3 Jul 2024 17:49:11 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 5/6] block: don't free submitter owned integrity payload
 on I/O completion
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240702151047.1746127-6-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTS/egY2uaweGfBhZNE/4yW6y+289m
	sXL1USaLvbe0LZYf/8fkwOpx+Wypx+6bDWweH5/eYvHo27KK0ePzJrkA1qhsm4zUxJTUIoXU
	vOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg1UoKZYk5pUChgMTiYiV9
	O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IyvrS9ZCxYxV2zq
	e8rUwHiWqYuRg0NCwETi5PSiLkYuDiGB3YwSbY+OsEA4nxglXi1czQjhfGOUWPtjK3sXIydY
	x6djD1khEnsZJdbM+gjlvGWUOPz8LiNIFa+AncTarxfYQGwWARWJj7v2Q8UFJU7OfMICYosK
	JEv87DoAViMskCCx7eFcsBpmAXGJW0/mM4HYIgIOErM3LGWDiFdITL33jA3kbjYBTYkLk0tB
	wpwCRhLfX/yDKpGX2P52DjPIPRICP9klJl3ewwZxtYvE7ykbmCBsYYlXx7dAfSMl8fndXqia
	bIkHjx6wQNg1Ejs297FC2PYSDX9usILsZQbau36XPsQuPone30+gwcgr0dEmBFGtKHFv0lOo
	TnGJhzOWQNkeEpembWGGBNVaRok953rYJjAqzEIKlVlIvp+F5J1ZCJsXMLKsYpRMLSjOTU8t
	Ni0wyksth8d3cn7uJkZwwtTy2sH48MEHvUOMTByMhxglOJiVRHil3jenCfGmJFZWpRblxxeV
	5qQWH2I0BUbPRGYp0eR8YMrOK4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQim
	j4mDU6qBacfsVrEinaI9wRsC509NVtTWWZDxM5jzm9MPK8lNml7Stcev1F199HbH6+XdNwqu
	H2Ksr4ppXmsqoj9nOrODiajjp2P3bkXyhvGHrunzuT87skCmvik4brt4yc/NHE3XBVcvupRh
	ZV6zt6J2vbjG2tdckx/6fprFX1DsILzcdxmzQ9SWzPPPnnDYTvk+pe+nRoHQfiPTu5a3Ei/H
	MqjkMU8P409R1O2cvP7dPEvHuJju+xlPKj5bPLx8XjJzv+CsG1G3Jwbw9p5X32Q2I1Tv188W
	3hMPD19+9PJlZ+r670nGx94y5Bc6HH1uFnIz31LWoyNoy0xxOx/v/IXTPRmMkud535/y6pi6
	cvp5p5X7lViKMxINtZiLihMBIaYMfCEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSnO5Bx9Y0gzffWS2aJvxltlh9t5/N
	YuXqo0wWe29pWyw//o/JgdXj8tlSj903G9g8Pj69xeLRt2UVo8fnTXIBrFFcNimpOZllqUX6
	dglcGV9bX7IWLGKu2NT3lKmB8SxTFyMnh4SAicSnYw9Zuxi5OIQEdjNKPPs1kxUiIS7RfO0H
	O4QtLLHy33N2iKLXjBK7fx1hAUnwCthJrP16gQ3EZhFQkfi4az8jRFxQ4uTMJ2A1ogLJEi//
	TAQbJCyQILHt4VywGmagBbeezAe7QkTAQWL2hqVAcziA4hUSd1YWQuxayyhxbuI0FpA4m4Cm
	xIXJpSDlnAJGEt9f/GODGGMm0bW1C2qkvMT2t3OYJzAKzUJyxSwk22YhaZmFpGUBI8sqRsnU
	guLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzg6NDS3MG4fdUHvUOMTByMhxglOJiVRHil3jen
	CfGmJFZWpRblxxeV5qQWH2KU5mBREucVf9GbIiSQnliSmp2aWpBaBJNl4uCUamDy/OcmsX/v
	8d1ZYlZfe7vt7CcGrrjtwOvy6f2Pj5pMm11ZJczjQor/H1xyLs1uRpFKTM3bSZafft+esML3
	1I4s+Vsq+y4XH01v5n2hy9S4Tb3wyL43+5h+pjbPTwp/z2VstbovLuNA4sOJU+dxb3uy7tvJ
	T9WVTsptppcFnV+793aIO+luX9EmX/e9KGzC/olXjafzb9lddj/03x6NX7FNvQm/OW6y1taF
	/V/acEPz+hrFw+uNz/5Ii5/cHnF04r23QdXLzDzZ70du81bUvHqo2mJF/e298geSGf+sbl97
	9uP0f8dL7uTd6/mpdd/V5f7LXWKHVQulX0o9+8VhuvH2G7H0Pu6H5quPeTIsmf/mvBJLcUai
	oRZzUXEiAOR3ylj9AgAA
X-CMS-MailID: 20240703121913epcas5p35477f0a1e821d9dff05c6344a558e66b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240702151114epcas5p2f520898aab2b720f2ea00b352fb40439
References: <20240702151047.1746127-1-hch@lst.de>
	<CGME20240702151114epcas5p2f520898aab2b720f2ea00b352fb40439@epcas5p2.samsung.com>
	<20240702151047.1746127-6-hch@lst.de>

On 7/2/2024 8:40 PM, Christoph Hellwig wrote:
> + * Integrity payloads can either be owned by the submitter, in which case
> + * bio_uninit will free them, or owned and generated by the block layer,
> + * in which case we'll verify them here (for reads) and free them before
> + * the bio is handed back to the submitted.

s/submitted/submitter?

With that
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

