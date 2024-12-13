Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415FC6F30F
	for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 05:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734069026; cv=none; b=XPwmR4sfmKDK761s3Rd998iczLHy0Cmgsq0jBYlEVRZJU6ImlpLiiNaIi5EAgwtGWLznrzcFM5QVkXUKtmYtk19UTBvAM4kufxAN+ho+/0eO/Lxh2VYQnpjWtTfNd34YRtFSk5m2Ai+q8hXSvSH5MZ567awR3JN6O95ztY6O4L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734069026; c=relaxed/simple;
	bh=OiCWtWAsblRtGKa1NgfSJeQtycXi2VuYXbKqO+w9294=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=u1ptCOWivR82gGRLMCjDNsk+ENBgOQIG/iyxPB//2/oD0XwFtC5mGnukN0wl7fXCz4/e8vNDO313vjKIYX5oCWio3p4ZiHAAQHIp2TpFhOXP5t6eQI1QHCsIAM1OhTRG1WZE2hO+Kc5/dCxDkh7JjwoQ42FidnUqAWklmM+hBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tjqZeCfE; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tjqZeCfE"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241213055021epoutp022198aff29721aad1ec252ac3528b6d91~QppZRQB1J2964029640epoutp025
	for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 05:50:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241213055021epoutp022198aff29721aad1ec252ac3528b6d91~QppZRQB1J2964029640epoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734069021;
	bh=OiCWtWAsblRtGKa1NgfSJeQtycXi2VuYXbKqO+w9294=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tjqZeCfEJ0VDIz7F1n+inkyBIZXdH0/jeKTwLZZKIb1/0GGjqSe5Uaqr+ZQuJB+YP
	 RUfY6ySUS0NHDY7JQz0i7cYYk6430PsQYVchpxh+fN5+6ZTBY+oRbdxOm0mznCdmZT
	 S1/uk69nIBuIEBIv1OVPZFZZaEo+IP1NWN5wo13w=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241213055020epcas5p1390cc2f58b64dbc39798e0f21e8619c5~QppZDVukU0899908999epcas5p1h;
	Fri, 13 Dec 2024 05:50:20 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Y8dj66w0Pz4x9Q9; Fri, 13 Dec
	2024 05:50:18 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	44.14.19710.91BCB576; Fri, 13 Dec 2024 14:50:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241213054434epcas5p1da1ee096aa234818543785c164d3988d~QpkWGKLBs1195511955epcas5p13;
	Fri, 13 Dec 2024 05:44:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241213054433epsmtrp1394cd1725af8408d1a4846a8c2b5ebda~QpkWByQzP0076100761epsmtrp1D;
	Fri, 13 Dec 2024 05:44:33 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-fb-675bcb199816
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B3.DE.18729.1C9CB576; Fri, 13 Dec 2024 14:44:33 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241213054433epsmtip2e1987647a89b33491afe48ee9c963a36~QpkVHF7p21860118601epsmtip2I;
	Fri, 13 Dec 2024 05:44:32 +0000 (GMT)
Date: Fri, 13 Dec 2024 11:06:39 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Christoph
	Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 1/3] mq-deadline: Remove a local variable
Message-ID: <20241213053639.bkfafvaogspgsflc@ubuntu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241212212941.1268662-2-bvanassche@acm.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdlhTXVfydHS6wdef3Bar7/azWUz78JPZ
	4sF+e4uVq48yWey9pe3A6nH5irfH5bOlHptWdbJ57L7ZwObxeZNcAGtUtk1GamJKapFCal5y
	fkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0GIlhbLEnFKgUEBicbGSvp1N
	UX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGlbPb2Qr62Sqmdho2
	MG5m7WLk5JAQMJGY/v4HexcjF4eQwG5Gib3r/oIlhAQ+MUo8/KYNkfjGKLFj6W3GLkYOsI6m
	p54Q8b2MEpN2/IPqfsIosfhWAzNIN4uAqkRr30c2kAY2AW2J0/85QMIiAhoS3x4sZwGpZxZo
	YZQ4PnchG0hCWMBWYtG8NSwgNi/Qgr+/zjJD2IISJ2c+YQGZwylgJfFnhzJIr4TAPXaJpa37
	mCFecJE4NOsj1DvCEq+Ob2GHsKUkXva3QdnlEiunrGCDaAZaPOv6LEaIhL1E66l+sEHMAhkS
	Z5c/gRoqKzH11DomiDifRO/vJ0wQcV6JHfNgbGWJNesXsEHYkhLXvjdC2R4S+9q/sMOD6Mzd
	9SwTGOVmIXloFpJ9ELaVROeHJtZZQI8yC0hLLP/HAWFqSqzfpb+AkXUVo2RqQXFuemqyaYFh
	Xmo5PI6T83M3MYKTopbLDsYb8//pHWJk4mA8xCjBwawkwnvDPjJdiDclsbIqtSg/vqg0J7X4
	EKMpMIImMkuJJucD03JeSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9TByc
	Ug1MMYJXhblWpv+aZmjKnd4R9zVpT8fn0/0beiSuvXRee8N7r1522I9jUxbuijI+Okv1v7t+
	xMvVmR1fLm48LsarsDjxbfvym8sP2NXK3ujMvfXjIUN2xpsp9mkxK3S7Muv9M4NjYlo8NY32
	cf3eGv3iSeIGnoziWw+NHJReldy8WHmo3/Oa2JPzFcaO5T1Jbb2WpxfdOz5hrsCKgltL38a9
	jm/blPpcfDHzw2kZ/LobrnAv/PydX+j1Jz6tlwqiKcxa099eUPrvLc7wfmmhoIlYMfN+73oJ
	Rfub/Sve7tv256Pze8XCLHlBzV7dzomxV9dHHw25aVCzUq3QgGnX4SjTdz2Fa79Ojlz2qXhG
	480oJZbijERDLeai4kQAZHXcehMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWy7bCSvO7Bk9HpBl8nWlmsvtvPZjHtw09m
	iwf77S1Wrj7KZLH3lrYDq8flK94el8+Wemxa1cnmsftmA5vH501yAaxRXDYpqTmZZalF+nYJ
	XBmrju9jKzjIXPFt1TO2Bsb/TF2MHBwSAiYSTU89uxi5OIQEdjNK/PzSyNjFyAkUl5RY9vcI
	M4QtLLHy33N2iKJHjBL9Ty8xgSRYBFQlWvs+soEMYhPQljj9nwMkLCKgIfHtwXIWkHpmgRZG
	iWWbr7GAJIQFbCUWzVsDZvMCLf776yzYAiGBTIkXB+cyQ8QFJU7OfAJWwyxgJjFv80NmkPnM
	AtISy/9xgJicAlYSf3YoT2AUmIWkYRaShlkIDQsYmVcxSqYWFOem5xYbFhjmpZbrFSfmFpfm
	pesl5+duYgSHspbmDsbtqz7oHWJk4mA8xCjBwawkwnvDPjJdiDclsbIqtSg/vqg0J7X4EKM0
	B4uSOK/4i94UIYH0xJLU7NTUgtQimCwTB6dUA9OB93leKiKH/96RaspbGbTtxaLFhxbzz55y
	X79otrsZry6T+Sexazums679YvGO7af+Gf8n+9OT1zJUKLz7FWcjtXXfTR6ltj/yR28u2q76
	WuXVduMD2SIyfScmv5q4+Ohi13mLNCfneKSunf+pTunrwwVrt5/m9fNO0VQs2y7mPnGebV7O
	iZPL1h7h68t9M7ta7P2WqIMvOR4kR3VP2JoSyma2T3LdPZHUnFfupdlfNieZOyYcVbTMvfxq
	ossWe9vdvcVCp3zSG3yUBLuZu3u6GaI/T5/1uvavqGCxyMnjUzx7H65wdFnAzLwmvv2r6k/h
	id13DjtemsX95X7q54tmreEGpQ6HfzqnLbln9bhHiaU4I9FQi7moOBEA4tmF+dQCAAA=
X-CMS-MailID: 20241213054434epcas5p1da1ee096aa234818543785c164d3988d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----OTMyRIxA-vjvkyMBIEVTa8B.hsA2RhXFaIa_oKBleWSyrD67=_804f2_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241213054434epcas5p1da1ee096aa234818543785c164d3988d
References: <20241212212941.1268662-1-bvanassche@acm.org>
	<20241212212941.1268662-2-bvanassche@acm.org>
	<CGME20241213054434epcas5p1da1ee096aa234818543785c164d3988d@epcas5p1.samsung.com>

------OTMyRIxA-vjvkyMBIEVTa8B.hsA2RhXFaIa_oKBleWSyrD67=_804f2_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 12/12/24 01:29PM, Bart Van Assche wrote:
>Since commit fde02699c242 ("block: mq-deadline: Remove support for zone
>write locking"), the local variable 'insert_before' is assigned once and
>is used once. Hence remove this local variable.
>
>Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>Cc: Christoph Hellwig <hch@lst.de>
>Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>---

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------OTMyRIxA-vjvkyMBIEVTa8B.hsA2RhXFaIa_oKBleWSyrD67=_804f2_
Content-Type: text/plain; charset="utf-8"


------OTMyRIxA-vjvkyMBIEVTa8B.hsA2RhXFaIa_oKBleWSyrD67=_804f2_--
