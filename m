Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A841990C8
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502935; cv=none; b=t8mataN2Ii40cS2FzntLZtnUbgkkNP+UwhP/MG1ObbghveJw6p8YNuVZLbamQTygkxbZJgaQonpDgyICBpzsvxylAKHelnb4l/p5PRa3YiRMHSjuw8O3BSaoKGyv5KlUV1oVshC+u03o682HrUZMDVikm9G4mB0T2YS/6RS+2A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502935; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=i0lyORkai7Y14mOq83eH6atutyEHY56ocvSEM3aRHoeXVHrJbb/oDR4KzCrnnac2kEuIhZ7ZKk0D+UJn2Qrvp7eK1sk+qsXc2f3oHxmmXpkFvNGlzrvT8AroCNEr4G0XjbBfNyw80y3CrSN0CxeaERQJ9/uCqIooqcK1LA/sIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SlePNs/m; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SlePNs/m"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240627154210epoutp03609995e935b4cd3fb51d7ac57b5f3d26~c5s3_ouNH3126231262epoutp035
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 15:42:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240627154210epoutp03609995e935b4cd3fb51d7ac57b5f3d26~c5s3_ouNH3126231262epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719502930;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=SlePNs/mQHE0cmgw8E4ZlI1n4+0MMiLK/3tV7gsXAhjVERU4Y8Eem43jnR/pKCiu5
	 jyrx7/Aeg/1ALgx+db8oKwFXs0rxChz6WVASYX4kz4Yp48YvnQcZh9g59hoAg5FkbK
	 RUQ99vOQ07tVWvc00bKnhCf7tNJm3CU0kWiuKxeQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240627154208epcas5p3d41ef5a1ad92f2ebe9a79f8c57c46683~c5s2vV3X10692606926epcas5p3A;
	Thu, 27 Jun 2024 15:42:08 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4W92qz4NxKz4x9Pw; Thu, 27 Jun
	2024 15:42:07 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.A3.09989.F488D766; Fri, 28 Jun 2024 00:42:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240627154206epcas5p2f10ddb0f449aaaaa9abfc12c1426c6cb~c5s0_887L1004710047epcas5p29;
	Thu, 27 Jun 2024 15:42:06 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240627154206epsmtrp2184a65fb12ffecdfd128c176ba1566b1~c5s0_Vo3j1300813008epsmtrp2L;
	Thu, 27 Jun 2024 15:42:06 +0000 (GMT)
X-AuditID: b6c32a4a-e57f970000002705-a3-667d884f098a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	8B.1E.18846.E488D766; Fri, 28 Jun 2024 00:42:06 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240627154205epsmtip181b5f6392e5d87b935b4434881ce5e4a~c5szz7IQI1272512725epsmtip1O;
	Thu, 27 Jun 2024 15:42:05 +0000 (GMT)
Message-ID: <bc9aa762-3ef8-7a63-4c27-4cb8ca0e43ac@samsung.com>
Date: Thu, 27 Jun 2024 21:12:04 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 3/5] block: remove allocation failure warnings in
 bio_integrity_prep
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240626045950.189758-4-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTQ9e/ozbN4NpaeYvVd/vZLFauPspk
	sfeWtsXy4/+YHFg8Lp8t9dh9s4HN4+PTWywenzfJBbBEZdtkpCampBYppOYl56dk5qXbKnkH
	xzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAC1UUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQX
	l9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnnNqxlKnAqOLa3D6mBkbdLkZODgkB
	E4mHGz4zdzFycQgJ7GaU+HlkJhuE84lRYuGSNSxwzrtrJ1hgWm7snAWV2Mkoce7oOlYI5y2j
	RNuSL4xdjBwcvAJ2Ettvy4A0sAioSiz+1MsMYvMKCEqcnPkEbJCoQLLEz64DbCC2sECURGfj
	AlYQm1lAXOLWk/lMILaIgIPE7A1L2SDioRIf5sxkARnPJqApcWFyKUiYU8BQYu/sOSwQJfIS
	29/OAXtHQuARu8TFTd/AzpEQcJH4e6wc4n5hiVfHt7BD2FISn9/tZYOwsyUePHoA9WONxI7N
	fawQtr1Ew58brCBjmIHWrt+lD7GKT6L39xMmiOm8Eh1tQhDVihL3Jj2F6hSXeDhjCZTtIbH5
	znMmSECtZpRYsPscywRGhVlIgTILyfOzkHwzC2HzAkaWVYySqQXFuempxaYFRnmp5fDITs7P
	3cQITotaXjsYHz74oHeIkYmD8RCjBAezkghvaElVmhBvSmJlVWpRfnxRaU5q8SFGU2DsTGSW
	Ek3OBybmvJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamISc76SY
	3Ha3TuTKDXRfxbVyVqxsW6pjfK30F93S7sLsXXEdTwyVUzK0dM5zqrzj3fX/u0t24roHXzOu
	r+iSy7Z8VHH5xIdtWmzhF5PzdLofMD1ouMq4SeXcA+EH12Qe3Au69moxv7Da9GpJrp8H669E
	afy/6Jqg/pLPOJLZ++QTrw8vCzaqfdvMnMPbIvt7gh+H9Y3cA531wi7BNrfe6dz9mvP/t7lr
	eGT4vLCJCr7s2acVtx6TPPlgSv/ntFXvEmfEPOo6kKI5pW+F2vLl3s18U1f9n6t76a5BRhqD
	Y3THr80zPewZ1h3J6Fuvl3NP78WaupNHJpd+XHl11swv18Ij2K+/ORZsHGe6b6GItRJLcUai
	oRZzUXEiAHR1RX4UBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSnK5fR22awfszRhar7/azWaxcfZTJ
	Yu8tbYvlx/8xObB4XD5b6rH7ZgObx8ent1g8Pm+SC2CJ4rJJSc3JLEst0rdL4Mo4tWMpU4FR
	xbW5fUwNjLpdjJwcEgImEjd2zmLpYuTiEBLYzihx+uMcJoiEuETztR/sELawxMp/z9khil4z
	Skz+NAPI4eDgFbCT2H5bBqSGRUBVYvGnXmYQm1dAUOLkzCcsILaoQLLEyz8TweYIC0RJdDYu
	YAWxmYHm33oyH2yXiICDxOwNS9kg4qESJ4/9YIXYtZpR4tzhPywgu9gENCUuTC4FqeEUMJTY
	O3sOC0S9mUTX1i5GCFteYvvbOcwTGIVmITljFpJ1s5C0zELSsoCRZRWjaGpBcW56bnKBoV5x
	Ym5xaV66XnJ+7iZGcPBrBe1gXLb+r94hRiYOxkOMEhzMSiK8oSVVaUK8KYmVValF+fFFpTmp
	xYcYpTlYlMR5lXM6U4QE0hNLUrNTUwtSi2CyTBycUg1M6VpN6yOP/l5ra1G4qvbxZOPF7Kf+
	3xFfdC/78T/JjcVitzNLvi2ax/1J6J1f5c680+X6z5rmPxQpY6zKdLrCoPD38bG9+rGbVttF
	zZmdsuHTFduiGRkOOubzZWTkyt0cXhxOsXVjL5zcN6dZe8b+bVP3nTpz5HvIre/1Ii7vORim
	bjp5o3Oa8PFDaVM4tX6qy2+f/ThoGsOFLNFdWwxOfFnzyE1A6/hdhYdTXJ7sO3D0cuXxkiiu
	5ZVL1+mc6V9vfFlB7XWbeO41/p9dpasOewlxNS1m3V8a/Ko9oFBtRVHWkl0G7p/DCoK3n/I4
	8vzur88P+nil1Y8lzOA4uszpUf7uVzKdvRK6+vH+fjEKQkosxRmJhlrMRcWJABT6G23tAgAA
X-CMS-MailID: 20240627154206epcas5p2f10ddb0f449aaaaa9abfc12c1426c6cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240626050018epcas5p45f83e418b7036935d2d48c1404fcf4a5
References: <20240626045950.189758-1-hch@lst.de>
	<CGME20240626050018epcas5p45f83e418b7036935d2d48c1404fcf4a5@epcas5p4.samsung.com>
	<20240626045950.189758-4-hch@lst.de>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
