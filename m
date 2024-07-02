Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9B79DF
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 05:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719898326; cv=none; b=ry1mA7VRGxVv5jzaVevtPUHozwDTU0yEqKNSgkwmTbQshlzCuLYpZvTqRkstrhyupIJhIwK9YXXlN8qCs8I19Kc1EcMjRxxa9N+30rOEHIB6QPqMDb2nQzC3q7KBLr+fJgsFEV01kOVdE4ZPTKOC1uXLlA2nNybzPgytPmMyRIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719898326; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=F+G/Yy2RFb4kIM+cenpBTto+s4CJkeOsOnq+itUXkblBZRduIt4GUa0ZSO+b6yg+stxxpbHyjtwj3AjCFkxHgiMXOLotaY6FIWqIjCwmv9Tcw3lWL/vVCXLerfDLG3Px+VrMAVOM4oHuYI0BVUYvm8vjxDeOPi4tYOphnDs69pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FR0n/+v6; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FR0n/+v6"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240702053154epoutp04dec51e1e79dddd033bf09a8e14ee6c07~eTmeYaggC0684806848epoutp04c
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 05:31:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240702053154epoutp04dec51e1e79dddd033bf09a8e14ee6c07~eTmeYaggC0684806848epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719898314;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=FR0n/+v6TyburlUyVSpVQp7I4j7oatd0mqIEUCjtIh/d3wvtcOG0xKRfgAkgDK8SX
	 79i+kyIv/C5fkL9xmYGTNoukOwdBJVip1cMHUK0UKBxdLh9NOg7/9LTAMuOCmumxkL
	 hqiRlEmUnZ/LW0vcRmlfCiQ2FuW+kCWkkhay2RhE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240702053154epcas5p2420d53230f43af1821cf261fc4b616c5~eTmeFo4Iy1281212812epcas5p2G;
	Tue,  2 Jul 2024 05:31:54 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WCs3X57mCz4x9Py; Tue,  2 Jul
	2024 05:31:52 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BF.0E.19174.6C093866; Tue,  2 Jul 2024 14:31:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240702053150epcas5p19c26e4967cce4e353d2db8543c699f9c~eTmarGet_3147231472epcas5p1u;
	Tue,  2 Jul 2024 05:31:50 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240702053150epsmtrp110a1abdfdd6da96ab0a4c17a10d9c265~eTmapSDKg0898708987epsmtrp1N;
	Tue,  2 Jul 2024 05:31:50 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-40-668390c64954
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	15.AB.19057.6C093866; Tue,  2 Jul 2024 14:31:50 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240702053149epsmtip2edc12843d49dd9c952542f34d8f56059~eTmZ0x0qK2062320623epsmtip2U;
	Tue,  2 Jul 2024 05:31:49 +0000 (GMT)
Message-ID: <90e4c830-784a-e6ce-bcf1-89c4da5cca20@samsung.com>
Date: Tue, 2 Jul 2024 11:01:48 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 2/5] block: also return bio_integrity_payload * from
 stubs
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240701050918.1244264-3-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTU/fYhOY0g1fPjCyaJvxltlh9t5/N
	YuXqo0wWe29pWyw//o/JgdXj8tlSj903G9g8Pj69xeLRt2UVo8fnTXIBrFHZNhmpiSmpRQqp
	ecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAq5UUyhJzSoFCAYnFxUr6
	djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eaklVoYGBkamQIUJ2Rl/zp5mLTCpuDa3
	j6mBUbeLkYNDQsBEYtPKhC5GLg4hgT2MErPu7WGCcD4xSqyY84UdwvnGKDFtwjHmLkZOsI61
	N/cyQiT2Mkq0Xm5kgXDeMkqc2tbOBlLFK2An8WPBaiYQm0VARaLl21FWiLigxMmZT1hAbFGB
	ZImfXQfA6oUFAiTeztoItoFZQFzi1pP5YL0iAg4SszcsZYOIV0hMvfeMDeRuNgFNiQuTS0HC
	nAJGEjt3v2KCKJGX2P52DjPIPRICP9klpl/thLraRaJ79WUoW1ji1fEt7BC2lMTL/jYoO1vi
	waMHLBB2jcSOzX2sELa9RMOfG6wge5mB9q7fpQ+xi0+i9/cTJkgw8kp0tAlBVCtK3Jv0FKpT
	XOLhjCVQtofE8rlfWSFBtZZR4uW378wTGBVmIYXKLCTfz0LyziyEzQsYWVYxSqUWFOempyab
	Fhjq5qWWw6M7OT93EyM4XWoF7GBcveGv3iFGJg7GQ4wSHMxKIryBv+rThHhTEiurUovy44tK
	c1KLDzGaAuNnIrOUaHI+MGHnlcQbmlgamJiZmZlYGpsZKonzvm6dmyIkkJ5YkpqdmlqQWgTT
	x8TBKdXAlJ0T7F5VZ60o+OSzxM95b7+vEKp2nFiy7v2RO7sDDziHHb/n9IpTsJ8pUOzArenJ
	3w53+XU469l+EzQ6839J3vqXbZP3LbrM7GD6fP6at7+zD1YrfjSV65yza0dzqOvNBy95f78R
	vVLy7ZrWw9sLPMUDlifw+quJrp3RXfA/ZZ9AWuzkSbNYRMtenzv798vZTIVgc/Hpf+d0PE3/
	3/J1xwuF850xkzpN0r4bTxHfVnb5+q5mjTvKs/vUpKZu/OQzfbUga0ei72kho+k2IdveuNt5
	FZ7ZvuK2Vty7s3q3D3+zbJBV/Jp3YrvvkT03pOynF6qtr/wq8+v+zZo3/1c5LNfs0V+/Tasn
	VWzb45m9KgpKLMUZiYZazEXFiQBdMckRIAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvO6xCc1pBvMPy1k0TfjLbLH6bj+b
	xcrVR5ks9t7Stlh+/B+TA6vH5bOlHrtvNrB5fHx6i8Wjb8sqRo/Pm+QCWKO4bFJSczLLUov0
	7RK4Mv6cPc1aYFJxbW4fUwOjbhcjJ4eEgInE2pt7GbsYuTiEBHYzSqxff44NIiEu0XztBzuE
	LSyx8t9zMFtI4DWjxJbz2SA2r4CdxI8Fq5lAbBYBFYmWb0dZIeKCEidnPmEBsUUFkiVe/pkI
	1MvBISzgJ9HXxg8SZgYaf+vJfLBWEQEHidkblrKBlDALVEjcWVkIcc5aRonnx7eDxdkENCUu
	TC4FKecUMJLYufsVE8QYM4murV2MELa8xPa3c5gnMArNQnLELCTbZiFpmYWkZQEjyypGydSC
	4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOCo0NLawbhn1Qe9Q4xMHIyHGCU4mJVEeAN/1acJ
	8aYkVlalFuXHF5XmpBYfYpTmYFES5/32ujdFSCA9sSQ1OzW1ILUIJsvEwSnVwDQlUv6Y+fOa
	EtcssRO5uq4C8u/3/5BjnLnt2IrKP3ezpHkeCD+1rXpoldv/X9Cv+5ffqT0LjzIuqz54X0q0
	9p+GZ47/LQn9Dav8Zj3PuLNp4YazigwJn17nvikTCFubV5/PpRI/d2sgE+t9XoYY67J/vneu
	REWce5+98sCJTREFZ6sU/jC96fPL19/TyiF+ZLu33X/Gqs+LvJNiip5r/tV7o6han7ByLXPN
	SsOyWyv2ubp/6d5h0nXos/aM7HL+3ASh0ycDHojlHMt0Tk6aJBWfmjD39OWbr6KzhK+u+LnR
	82DmhvfPG5f3LHr8jL8/Tbbg2nFpNZ7FO51nTzowN9TpRMi85JCX76dNvf7d0UeJpTgj0VCL
	uag4EQBY4esc+QIAAA==
X-CMS-MailID: 20240702053150epcas5p19c26e4967cce4e353d2db8543c699f9c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240701050937epcas5p3d64acbc7826a61a628e0a881caf514f1
References: <20240701050918.1244264-1-hch@lst.de>
	<CGME20240701050937epcas5p3d64acbc7826a61a628e0a881caf514f1@epcas5p3.samsung.com>
	<20240701050918.1244264-3-hch@lst.de>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

