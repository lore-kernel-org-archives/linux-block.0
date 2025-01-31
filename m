Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F19169397
	for <linux-block@vger.kernel.org>; Fri, 31 Jan 2025 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738319703; cv=none; b=EBGK8R1FXDAAuAM1ruvVrucJNuuZRuZ+dxuuANa0y7fol7MeMV4rcM6HuFPGZ8SQZGwNzvjBemGAVsfKjDBqlwIw0RwgiIek+9wTnmdAQU3C0vKYEEZzUS6J22inL7pAdoJ4C+dw60GNfXA+MEVIq/MFX3BLYfShIjGsyvpJQoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738319703; c=relaxed/simple;
	bh=03wGxsZMevi5RQw/iRWukhEIhc3ISanviRV49S7yMrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=NkQZ2ZsFlj7qTiZKH6XXx6Ml9NcjQEcpLLgQ8oN6Q5VF10TnMjbcrK49hDCiYimsjDAqMHyXWDQaRXw+aCKF6zJIOPOENZ6stuuFIP5bbvjbPBWR80iV9IrBPUq9NEzJUh8Uc5EDzYQr9HCQFb72c4/jkYt+UcvIWjmpMSxMbo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XiLdFO+V; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XiLdFO+V"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250131103457epoutp013e6fcaa4dfe240baa859a6a08702db77~fwI4Q2Mjq0281102811epoutp01W
	for <linux-block@vger.kernel.org>; Fri, 31 Jan 2025 10:34:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250131103457epoutp013e6fcaa4dfe240baa859a6a08702db77~fwI4Q2Mjq0281102811epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738319697;
	bh=t73VKDgkZv6vx4SIzDI6kPeuW3CzLCaVmR8NxPgGiok=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=XiLdFO+VLfKwflEMdhYyWJLAEwTQ1f9tuz9fTQwjQ1pdZ/zUvkYpQvcgd1Nqt5gIY
	 pFbg/fJH5y4eb1R9DaVa4APV91UhyDy51qx4IQZ0AQZGVZcHBUt/NYq0GYqjSFwuNi
	 eLq4OQH8N2CMTuNxOsXBqEoPfXXPkEHy3OXgUoa4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250131103457epcas5p30716995a9f403fa10bfaa4f6ecd02ae6~fwI4EsKtO2123121231epcas5p31;
	Fri, 31 Jan 2025 10:34:57 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Ykshw144tz4x9Pr; Fri, 31 Jan
	2025 10:34:56 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A1.98.29212.F47AC976; Fri, 31 Jan 2025 19:34:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250131103455epcas5p2237bfeccbb98bd5a2dcc8fb8e920a9b1~fwI2V_CsY2128421284epcas5p2H;
	Fri, 31 Jan 2025 10:34:55 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250131103455epsmtrp1437aa1f179fca346897a113bec04696c~fwI2VWklW0511905119epsmtrp11;
	Fri, 31 Jan 2025 10:34:55 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-bb-679ca74f1c75
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	23.40.23488.F47AC976; Fri, 31 Jan 2025 19:34:55 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250131103454epsmtip2fcee3afe667503ce27813f07999a40de~fwI1VsO8n2665626656epsmtip2j;
	Fri, 31 Jan 2025 10:34:54 +0000 (GMT)
Message-ID: <3e7a79d7-b5ed-4ad2-a2d2-84c2c6cda757@samsung.com>
Date: Fri, 31 Jan 2025 16:04:53 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: in-kernel verification of user PI?
To: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250129124648.GA24891@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmlm7A8jnpBqedLJom/GW2WH23n81i
	5eqjTBaTDl1jtNh7S9ti+fF/TA5sHpfPlnpsWtXJ5rH7ZgObx8ent1g8+rasYvT4vEkugC0q
	2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AYlhbLE
	nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG
	hAlLmArmsFRcPVXdwLiOuYuRk0NCwETi4+2n7F2MXBxCAnsYJU5862QBSQgJfGKUOLpJESLx
	jVHi4o1tLDAd655sZIJI7GWUuHZoHjtEx1tGifcvYroYOTh4Bewk3jy1AQmzCKhKTDvYCLaN
	V0BQ4uTMJ2BzRAXkJe7fmgHWKiygL7HpYy9YXESgSqJ92UFWEJtZIEHi35JzTBC2uMStJ/OZ
	QMazCWhKXJhcChLmFNCRuLzmECNEibzE9rdzmEFOkxDo5JD4+3gGG8TNLhKHbh+Gul9Y4tXx
	LewQtpTEy/42KDtb4sGjB1A1NRI7NvexQtj2Eg1/brCC7GUG2rt+lz7ELj6J3t9PwM6REOCV
	6GgTgqhWlLg36SlUp7jEwxlLoGwPiZNbNjJDAqpeovPuCpYJjAqzkAJlFpInZyH5ZhbC4gWM
	LKsYpVILinPTU5NNCwx181LL4ZGdnJ+7iRGcPLUCdjCu3vBX7xAjEwfjIUYJDmYlEd7YczPS
	hXhTEiurUovy44tKc1KLDzGaAqNnIrOUaHI+MH3nlcQbmlgamJiZmZlYGpsZKonzNu9sSRcS
	SE8sSc1OTS1ILYLpY+LglGpgWrza6MbTmGfvnzzWmBhnWyPy0Gn99tOpXbE3NduK1h09aH5W
	evMWv6fFLu6Kp/VVroTqMgQ6+lXtKZNY0v6297SQ3e0GZrlKo9cdCf6ny4Pa0+pUdnpaeEVv
	cnxnfmLn15KK1k2zp+5RiftSfz08fPOaUhvhgrCjZx8v/GHZEHPuYea90w8szqgXaiXWBj3f
	t0LUQGflW5VVLuK23PU/3GNWhhqxeKs/jLrIbPhgTewXp+ttKv8/SFwQ9ZuZdDosgU1j+ZKe
	i5rdfV7rC/9e3Dvt4lf5T2+WMG7WbjFasKVR4nFIySuWrKcnOuKu2nlujItJ4Stfp7dvWbdg
	0/yc/U5JT9fz//nddnqFjlKDEktxRqKhFnNRcSIANNqiMicEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvK7/8jnpBicfSFo0TfjLbLH6bj+b
	xcrVR5ksJh26xmix95a2xfLj/5gc2Dwuny312LSqk81j980GNo+PT2+xePRtWcXo8XmTXABb
	FJdNSmpOZllqkb5dAlfGhAlLmArmsFRcPVXdwLiOuYuRk0NCwERi3ZONTF2MXBxCArsZJTb8
	W8sEkRCXaL72gx3CFpZY+e85O0TRa0aJvRemMHYxcnDwCthJvHlqA1LDIqAqMe1gI9hQXgFB
	iZMzn7CA2KIC8hL3b80AmyMsoC+x6WMvWFxEoEpi4dY9bCA2s0CCxI/9OxlBbCGBeok957+w
	Q8TFJW49mc8EsopNQFPiwuRSkDCngI7E5TWHGCFKzCS6tnZB2fIS29/OYZ7AKDQLyRWzkEya
	haRlFpKWBYwsqxglUwuKc9Nzkw0LDPNSy/WKE3OLS/PS9ZLzczcxgqNFS2MH47tvTfqHGJk4
	GA8xSnAwK4nwxp6bkS7Em5JYWZValB9fVJqTWnyIUZqDRUmcd6VhRLqQQHpiSWp2ampBahFM
	lomDU6qBqdtnfzbT9Lk6q47oCq3IVzr2QMJNouHP/R/SIgpbrkRv/CX9rFlN5rPncV0eiVOW
	Xzz67q4685wj8Zfhw986DwScWC9e9o0Xz7eaFnRveuuHilUHZuVLWJnHeRhVPEuZ3VTMZVe8
	72ZUw6M52zt02TKupjsXzUydXbtNRShDkO3OUseJPaEV8zOPbIi54tW9ePf+6jtlE++9PbeG
	6/QDLd5Vu56aHLutp/wovS5w6/3bQgw2/rckqy++V3iSkeIiv2GpYnrjwyOans/XN7r7FKf9
	rKusEfvdcDwvfevmXWFJq9+EnNI4PJF3joDnRU2vlVdWx5zZGOJmr6j6t71r57H+1uCtZfoT
	DW/8eLtJT4mlOCPRUIu5qDgRAB9G+coFAwAA
X-CMS-MailID: 20250131103455epcas5p2237bfeccbb98bd5a2dcc8fb8e920a9b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129124655epcas5p39750f07e5015f1dd5e198c72cca0aa4e
References: <CGME20250129124655epcas5p39750f07e5015f1dd5e198c72cca0aa4e@epcas5p3.samsung.com>
	<20250129124648.GA24891@lst.de>

On 1/29/2025 6:16 PM, Christoph Hellwig wrote:
> Also another thing is that right now the holder of a path or fd has no
> idea what metadata it is supposed to pass.  For block device special
> files find the right sysfs directory is relatively straight forward
> (but still annoying), but one a file is on a file systems that becomes
> impossible.  I think we'll need an ioctl that exposes the equivalent
> of the integrity sysfs directory to make this usable by applications.

Are you thinking this ioctl to be on a regular file?
