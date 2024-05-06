Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D163B782
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714999622; cv=none; b=uAF9tGGqPnCrurO7MCL9mQzQAhLV82Eg5AYDg6wh+YYrFaPJNWFhbQrlBFQaRGZTcgOsJETlTqj3WxIVUkeGM5AUq5/WWv7GzDNEWhx60X/s8GKgjpJSBprTqg5ph/fVII2HNqIcH4ha8OodcIVpn0KSOl8lEst/329QS5hFcDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714999622; c=relaxed/simple;
	bh=rCM7TpCO3g1NEitOvnXOlxTKqXQ6BmllP7OAbSQ5fvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=gazGkkx79/C0apPqf1u7gq+gtZUqEAPmURM+Lceh7SFfGlxLcKJ9nBkSGprAdS2x1xdTto4ZsJSk+Wtqzi8fSIhoiLhsfnAsFqfcUfYedTidjTF0VFrF5M5s3PwLQjY+w/IvNil7W/EQrhnQqqSrXjztp/04plTidfHot543g8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WAymltFl; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WAymltFl"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240506124649epoutp038cc19ab305ad0c9aaa067f083addeb06~M5w78m34o2149021490epoutp03c
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 12:46:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240506124649epoutp038cc19ab305ad0c9aaa067f083addeb06~M5w78m34o2149021490epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714999609;
	bh=t4Alnv8GEQOeeYQ9its3uejabJfVgWjTGCz5jpePwpc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=WAymltFllI2CphJbT9a+xUbCZycPyzYkzfqs6fPg/ZV1jw63+doiNt7xcQmG4H1eG
	 9VjdUwAkoHuDzqgnje84nuaKLNS7gIcKes7Mn/VT+zPNPVqniyfA/ULHchmYSRn20c
	 GWPgNof28ABdkhjLSIRuMWtuDOyrqqVP83GEcTX8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240506124649epcas5p1fc7d2a8a28f8e548254746e40c5bd1f3~M5w7tbE012855428554epcas5p1e;
	Mon,  6 May 2024 12:46:49 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VY1Pg5qSmz4x9Pv; Mon,  6 May
	2024 12:46:47 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	63.57.09665.731D8366; Mon,  6 May 2024 21:46:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240506124647epcas5p2376606df3b00b93c435795d20dd11402~M5w51Fj_c0394003940epcas5p2b;
	Mon,  6 May 2024 12:46:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240506124647epsmtrp11e33abc40f51b6cf32b45cb9e5f29d5a~M5w50fxDM2309023090epsmtrp1F;
	Mon,  6 May 2024 12:46:47 +0000 (GMT)
X-AuditID: b6c32a4b-5cdff700000025c1-4c-6638d1375ac2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.DC.08924.731D8366; Mon,  6 May 2024 21:46:47 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240506124646epsmtip111513d54abd02fd73d9548c14d4acd55~M5w41MSvv0876508765epsmtip1p;
	Mon,  6 May 2024 12:46:46 +0000 (GMT)
Message-ID: <9ce1c36d-67e5-b287-5faf-667844f8c2a8@samsung.com>
Date: Mon, 6 May 2024 18:16:45 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] block: streamline meta bounce buffer handling
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, anuj20.g@samsung.com
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240506060509.GA5362@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmlq75RYs0g6bXmhZNE/4yW6y+289m
	sXL1USaLSYeuMVrsvaVtsfz4PyYHNo/LZ0s9Nq3qZPPYfbOBzePj01ssHn1bVjF6fN4kF8AW
	lW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SEkkJZ
	Yk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE7
	48H096wFK3gqdl++x9zA2MHVxcjJISFgIjH9xlMmEFtIYDejxO6NuV2MXED2J0aJqzOfsEM4
	3xgluqavZITp2PHmLyNEYi+jxLffl9kgnLeMEvdO/ACbxStgJ3Hpx1HWLkYODhYBFYlPS1wh
	woISJ2c+YQGxRQWSJX52HWADsYUFnCTWHbwGFmcWEJe49WQ+2BgRASWJp6/OMkLEyyX2Hv7K
	AjKSTUBT4sLkUpAwp4C2xJs3/6FK5CW2v53DDHKOhEArh8TD8+9ZII52kTj4cTGULSzx6vgW
	dghbSuJlfxuUnSxxaeY5Jgi7ROLxnoNQtr1E66l+ZpC9zEB71+/Sh9jFJ9H7+wkTSFhCgFei
	o00IolpR4t6kp6wQtrjEwxlLoGwPicYnC6DhuYpR4vjXP4wTGBVmIYXKLCTfz0LyziyEzQsY
	WVYxSqYWFOempxabFhjnpZbDozs5P3cTIziFannvYHz04IPeIUYmDsZDjBIczEoivEfbzdOE
	eFMSK6tSi/Lji0pzUosPMZoCY2cis5Rocj4wieeVxBuaWBqYmJmZmVgamxkqifO+bp2bIiSQ
	nliSmp2aWpBaBNPHxMEp1cC0OCUyc4lfZfPW22LPfV5Ys/k9t5vMYf5DcXvepZTVC8J4qw+q
	c9258DUgXzJe9NuttxN5a/8u4z2wqHqLxWGtkLfpFYyrPa8+fOjd5frrFPNBXfmwfSbXX/yc
	l3MmdEER/xar+JBXAlcSd897VxJzVl2X2/Pz8R/7F3Uf5T7Q+na715bJzJJbty270LNvZ8K/
	mToa722nuSbG93wRDGCft3Vx8rzDovrJPdNzihgEJ+wpEdpYv88ncHnJ36u7nCJX3jv34MqZ
	Vet9jjjHK3+z9eU//dJNb0ncOX7l7KyV8o1r1y2a9TYkss7Ma5dwyzuOxpZeDdNPi3smn0sX
	LWPIfaGlw5vLtllYPeBgYM4dJZbijERDLeai4kQA1Hc0TSoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSnK75RYs0gxVPhCyaJvxltlh9t5/N
	YuXqo0wWkw5dY7TYe0vbYvnxf0wObB6Xz5Z6bFrVyeax+2YDm8fHp7dYPPq2rGL0+LxJLoAt
	issmJTUnsyy1SN8ugSvjwfT3rAUreCp2X77H3MDYwdXFyMkhIWAisePNX8YuRi4OIYHdjBLn
	XsxhhkiISzRf+8EOYQtLrPz3nB2i6DWjxKHHc1hBErwCdhKXfhwFsjk4WARUJD4tcYUIC0qc
	nPmEBcQWFUiWePlnItgcYQEniXUHr4HFmYHm33oynwnEFhFQknj66iwjRLxcYv2LpWwgtpDA
	KkaJLxtjQMazCWhKXJhcChLmFNCWePPmP1S5mUTX1i4oW15i+9s5zBMYhWYhuWIWkm2zkLTM
	QtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcLxoae5g3L7qg94hRiYOxkOM
	EhzMSiK8R9vN04R4UxIrq1KL8uOLSnNSiw8xSnOwKInzir/oTRESSE8sSc1OTS1ILYLJMnFw
	SjUw1WsdqLdScOriUOSvc5r4/LDX20kVC5Zf321b/pxlblToYist98yDnl8f/thz3u0Q3zpl
	H7dFbkuC2O4xrnkhbjp9ocm9xWuSj1eE30/WrAm+9u/qwqjvfCy8J9p1q6Su3dWVZ3sqv/Lk
	y9W51jdmfnQ5fEqytUSjXCAjavrBBP5JB7uWcLYs3LxG8FdxZLn9A9G0nRvniXjpxSQFm0Sn
	JTLoPT4j4yPmtd8gRNdSpM/qoeuHAl9x6U96h580zJJ+oZRZvlZp6quWRau/5+aqccy3WX52
	/7Wzy1sr2xd9tPy93ezO3vtSK1enLZK5L7lNrnW56JeTwodO75Q9szXVL0XL9mNp7e2uo0+D
	6n4WKrEUZyQaajEXFScCAKmZ/3UGAwAA
X-CMS-MailID: 20240506124647epcas5p2376606df3b00b93c435795d20dd11402
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240506051751epcas5p1ed84e21495e12c7bf41e94827aa85e33
References: <CGME20240506051751epcas5p1ed84e21495e12c7bf41e94827aa85e33@epcas5p1.samsung.com>
	<20240506051047.4291-1-joshi.k@samsung.com> <20240506060509.GA5362@lst.de>

On 5/6/2024 11:35 AM, Christoph Hellwig wrote:
> Can we take a step back first?
> 
> Current the blk-map user buffer handling decided to either pin
> the memory and use that directly or use the normal user copy helpers
> through copy_page_to_iter/copy_page_from_iter.
> 
> Why do we even pin the memory here to then do an in-kernel copy instead
> of doing the copy_from/to_user which is going to be a lot more efficient?

Many good reasons for that. Keeping the user meta memory pinned allows 
to update it nicely during completion. Otherwise, it required using 
task-work, lots of bookkeeping in driver (nvme), and all that was pretty 
convoluted.
Please see this series (you have reviewed in past):
https://lore.kernel.org/linux-block/20231130215309.2923568-1-kbusch@meta.com/#r 

Nvme and io_uring (Patch 2, 3, 4) get nice wins because of keeping the 
user memory pinned even for bounce-buffer case.

> Sort of related to that is that this does driver the copy to user and
> unpin from bio_integrity_free, which is a low-level routine.  It really
> should be driven from the highlevel blk-map code that is the I/O
> submitter, just like the data side.  Shoe-horning uaccess into the
> low-level block layer plumbing is just going to get us into trouble.
> 

Not sure I follow, but citing this nvme patch again:
https://lore.kernel.org/linux-block/20231130215309.2923568-3-kbusch@meta.com/
Driver does not need to know whether meta was handled by pinning or by 
using bounce buffer. Everything is centrally handled in 
block/bio-integrity.c.
