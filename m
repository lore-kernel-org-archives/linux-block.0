Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0367322E
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 05:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716788010; cv=none; b=QDFKDm3KM/fBjBb3ZzhtEsSFx9rys3dzks64lDlrrMMQQIE0DTTqCQliJuIDvrgLyaXMDDICGlVJVeNBN7HBA1kQo1YvrVaICBgxEyZwbL//tr+c7S+pLD3baLtvZO9nvVUSVPKhYiaFwQD6igTOM3ENQ78EVHvJ/TBHvhjaj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716788010; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Ib2kjicxCD0Xv0N6LcsHoWhxrSZr6wbQsf/lBkKNH+nlFxYxwI9k94U7eGPuHX/+Q42DXD2TmOdHR3+hnEY6Vocy+tIOQH+IXNtlr7G5pKCmh8QN8CC1rpz1sIMw/x816ci1MFJ8gPevU4PF8vXfvbQssaiWqIc3RlsskBG0qW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CHRNSv/U; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CHRNSv/U"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240527053326epoutp01a38e04bf298f48cb77e1d10fdb9a9849~TQZh_1AXn1426314263epoutp01s
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 05:33:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240527053326epoutp01a38e04bf298f48cb77e1d10fdb9a9849~TQZh_1AXn1426314263epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716788006;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=CHRNSv/UI9D0bHTeFgF1IT/cvxG2CR/mO0uQK/YugHEHREd3Lr91EHlffDdbFV0l9
	 4UlLjuSFhIf8H8DGqMy/FTxuLWYCAjikBI8RxMwWExj0jvcNsBez0MpWJhX8H8qmde
	 NyLPsWCmUGNFDLX6NOkma4HOmVgISoctiQXGTItg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240527053326epcas5p219b06194b28f1e27ff6a989f398a9562~TQZh0x6Ab3163331633epcas5p2F;
	Mon, 27 May 2024 05:33:26 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Vnknv1H5nz4x9Px; Mon, 27 May
	2024 05:33:23 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E0.9B.09989.32B14566; Mon, 27 May 2024 14:33:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240527053322epcas5p399db2db8f0304d180d1128377ab6b490~TQZe5n0Af1253512535epcas5p3T;
	Mon, 27 May 2024 05:33:22 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240527053322epsmtrp2fda2e7d1f5c6b4b5d582487b9c208001~TQZe4-kKk0699706997epsmtrp2V;
	Mon, 27 May 2024 05:33:22 +0000 (GMT)
X-AuditID: b6c32a4a-e57f970000002705-ad-66541b23007f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	CF.5E.18846.22B14566; Mon, 27 May 2024 14:33:22 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240527053322epsmtip131a7fe0fa90dbce08ed3069e9519eb3f~TQZeJj5t10606106061epsmtip1Z;
	Mon, 27 May 2024 05:33:21 +0000 (GMT)
Message-ID: <1d041113-54bb-d301-4f17-675cc60749bd@samsung.com>
Date: Mon, 27 May 2024 11:03:21 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] null_blk: Fix return value of
 nullb_device_power_store()
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240527043445.235267-1-dlemoal@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmpq6ydEiawZclbBar7/azWTzYb2+x
	95a2xZyFbA4sHi1H3rJ6XD5b6rFpVSebx+dNcgEsUdk2GamJKalFCql5yfkpmXnptkrewfHO
	8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDrlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2
	SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGX/OnmYtMKm4NrePqYFRt4uRk0NCwERi
	4tZGZhBbSGA3o8TiVpYuRi4g+xOjxPpdM5kgEkDOmcWFMA1HVs+AKtrJKPF5bR8rhPOWUeL7
	0jUsIFW8AnYSF5b0gXWzCKhKHL/TxAoRF5Q4OfMJWI2oQLLEz64DbCC2sIC/xPPWp2D1zALi
	EreezAezRQRSJA59fsMOEVeQuNDcBNTLwcEmoClxYXIpSJhTwFLiyOZTUCXyEtvfzmGGOPQa
	u8TESXEQtgvQaY/YIGxhiVfHt7BD2FISn9/thYonS1yaeY4Jwi6ReLznIJRtL9F6qp8ZZC0z
	0Nr1u/QhVvFJ9P5+wgQSlhDglehoE4KoVpS4N+kpK4QtLvFwxhIo20Ni+6kZ7JCQ6mGU2Ptp
	EfsERoVZSIEyC8nzs5B8Mwth8wJGllWMkqkFxbnpqcWmBUZ5qeXwuE7Oz93ECE6IWl47GB8+
	+KB3iJGJg/EQowQHs5IIr8i8wDQh3pTEyqrUovz4otKc1OJDjKbA2JnILCWanA9MyXkl8YYm
	lgYmZmZmJpbGZoZK4ryvW+emCAmkJ5akZqemFqQWwfQxcXBKNTCVNmcZV1atkOMXvB6s+sTl
	lG5fYZybwm9j55ovtd67rh/Ok+9ee+taD3f73XKuJv4VSfJ7Fhl8ktU588zC1tOnJ+P+u2vt
	56LKgsIUz7DpKfNmzj7XPemEstOD1frf1soYzdgv6eMa23jmDafzt0jJ9EC1p3f4OHbWev3u
	+v0s9uRzs4hpM3c5Rq/4XeedH7jiX9r/TepFmQksPgrR2n9crPjs1s/tdN2hoG2Ssfi6/+Hy
	F/MenWx+fOBY8wbuKbPc0rLvcEeK36lf+CFXxKz0emS6DPOttzk7b2c/mfLs5pVP7H0LVHf3
	/2JnFJonKXRKxq1US6iMT2551RHbi3Zhri9uL8+98P9S99vSK0osxRmJhlrMRcWJAJghb04R
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSnK6SdEiaQc8tPYvVd/vZLB7st7fY
	e0vbYs5CNgcWj5Yjb1k9Lp8t9di0qpPN4/MmuQCWKC6blNSczLLUIn27BK6MP2dPsxaYVFyb
	28fUwKjbxcjJISFgInFk9QyWLkYuDiGB7YwSs7fvYYZIiEs0X/vBDmELS6z895wdoug1o8Tx
	b4eYQBK8AnYSF5b0gdksAqoSx+80sULEBSVOznzCAmKLCiRLvPwzEWyQsICvxK3VzWA2M9CC
	W0/mA/Wyc4gIpEi844OIKkhcaG6CuqeHUeL9grdA93BwsAloSlyYXApSwylgKXFk8ymoKWYS
	XVu7GCFseYntb+cwT2AUmoXkiFlIls1C0jILScsCRpZVjKKpBcW56bnJBYZ6xYm5xaV56XrJ
	+bmbGMFhrxW0g3HZ+r96hxiZOBgPMUpwMCuJ8IrMC0wT4k1JrKxKLcqPLyrNSS0+xCjNwaIk
	zquc05kiJJCeWJKanZpakFoEk2Xi4JRqYHIVl2IyqI/9e4qdb9/GddWta769yr6zVPr92Zqt
	N0OlLT6eWG3rt+bF61/p/ae2ieh7hnG6BmyV8yh/PjsgqlND/tr+FZ1HburXaK5zYj9cz7Cx
	dtl2KV6rX3PK1IwiFqc7HLgf1reTi9vt9adlz/T2rQu36rfVPeLoOWHTrXWScZ1npv7d0uLI
	VMNQobv4ZVFIhVVv9n4Xm1vF9byzD0/V5HjW5h4muK/S3XPmQba6qI2zFp01/lhfNzPnhyZX
	ava5gk+/nBNqJbLevt384/0u30u/Vc8ufyNl1e1bPd0kXVZiW71tg5J3W/StLXfjmvxW5XlM
	EPtlHqZVuVrOI3O3dsDUY4YzbH4KrVKbqsRSnJFoqMVcVJwIAIPAXcbqAgAA
X-CMS-MailID: 20240527053322epcas5p399db2db8f0304d180d1128377ab6b490
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240527043455epcas5p18a6d514da1e203726501570b07fc8d19
References: <CGME20240527043455epcas5p18a6d514da1e203726501570b07fc8d19@epcas5p1.samsung.com>
	<20240527043445.235267-1-dlemoal@kernel.org>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

