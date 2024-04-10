Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD77181314
	for <linux-block@vger.kernel.org>; Wed, 10 Apr 2024 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778038; cv=none; b=byNl+dsMagWUeypHMlTU7Inh2F6XVryJwK02l5HA+hY631xWuuGWQx9uW6ZNFE4uInkMg4fGio0TaMgOzenOYxJkqTQj3aSAEyKFO7iQWEkKpp/TSlCvuImLp91GZ8zCxIjUV8NWM4z6ENyAClln3CGYsUlgV95QA5REgdZCGM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778038; c=relaxed/simple;
	bh=dVxNNyiSzc8E8XowZhEOkAqCqO9EkZxsLoTONMIIe+s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=ewxxDXnzbzvIKASZIe9e+rXlx/ttMkZ1TChYtf7JDmmr2JK8or81zE2kzqz2b4gfaA2jrPq9lPT/+++xSTh8vKuFwDI/Vq8p4/CKwkpmVYkorK5+VM01mINHt8/vassT+jTb6K1m7pgi8yICfXfirslSFbrYpL8j89Ez0/E+cIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NA/6CZZe; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NA/6CZZe"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240410194032epoutp01edd24e877b81bbce1fd74315067920db~FAovaef3K3003930039epoutp01M
	for <linux-block@vger.kernel.org>; Wed, 10 Apr 2024 19:40:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240410194032epoutp01edd24e877b81bbce1fd74315067920db~FAovaef3K3003930039epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712778033;
	bh=dVxNNyiSzc8E8XowZhEOkAqCqO9EkZxsLoTONMIIe+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NA/6CZZezOS/R3r3Oqp9YpjBUkbZo20Z1veVjl3NftUryEfuWlLr3pD8sUKJlcFSv
	 9uK2YVvXaDkmuGJo0uBn2SMAKd+wZTy6ffc3bYGRklUSz+SNjy9T6HeQcoKi4gxklb
	 z9jSJLCtFVrLOmtldYt0pNir55XurXcZdT6Y9EvM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240410194031epcas5p15759a46cf252a6fc74571f33bff37830~FAouV0biJ2649326493epcas5p1u;
	Wed, 10 Apr 2024 19:40:31 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VFCq21R0Pz4x9Pt; Wed, 10 Apr
	2024 19:40:30 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A7.E4.09666.E2BE6166; Thu, 11 Apr 2024 04:40:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240410192515epcas5p1360a731616fca3841c892be310afb109~FAbY8yBzE1911019110epcas5p1H;
	Wed, 10 Apr 2024 19:25:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240410192515epsmtrp26727929e6e890145f149426ceaf426de~FAbY8PYOW2877028770epsmtrp2y;
	Wed, 10 Apr 2024 19:25:15 +0000 (GMT)
X-AuditID: b6c32a49-cefff700000025c2-ea-6616eb2e74c0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.A6.08390.B97E6166; Thu, 11 Apr 2024 04:25:15 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240410192514epsmtip204f3b35f27f1024b677f3175e2963344~FAbYU9ksV2303223032epsmtip2w;
	Wed, 10 Apr 2024 19:25:14 +0000 (GMT)
Date: Thu, 11 Apr 2024 00:48:20 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: convert the debugfs interface to read/write
 iterators
Message-ID: <20240410191820.krjqmam76jde2j5i@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <dc58cf1e-cfbc-4771-80b8-4dfdf5d7f0d1@kernel.dk>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmhq7ea7E0g3+7WSxW3+1ns9h7S9uB
	yePy2VKPz5vkApiism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVc
	fAJ03TJzgIYrKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJS
	S6wMDQyMTIEKE7IzljV/Yy5oZa2YOPMtcwPjbpYuRk4OCQETif/HjzJ1MXJxCAnsZpTY/HoL
	I4TziVFi26sJLBDON0aJ8zfXscO0TO95D9Wyl1Fifd99ZgjnGaPE6nl/2UCqWARUJS78mQk0
	i4ODTUBb4vR/DpCwiICCRM/vlWAlzAL2Eme2T2UFKREWCJY4sbkcJMwrYCYx8+hhFghbUOLk
	zCdgNqeArcS+j8/AbhAVkJGYsfQr2FoJgX3sEreWHGCGOM5F4uHWHihbWOLV8S1QR0tJfH63
	lw3CLpdYOWUFG0RzC6PErOuzGCES9hKtp/qZQQ5iFsiQ+HwrHyIsKzH11DomiJv5JHp/P2GC
	iPNK7JgHYytLrFm/AGq+pMS1741QtofE82sTWCHhM4FRonfeDqYJjPKzkDw3C2HdLLAVVhKd
	H5pYIcLSEsv/cUCYmhLrd+kvYGRdxSiZWlCcm55abFpgmJdaDo/v5PzcTYzgpKfluYPx7oMP
	eocYmTgYDzFKcDArifBKa4mmCfGmJFZWpRblxxeV5qQWH2I0BcbURGYp0eR8YNrNK4k3NLE0
	MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qBiftddNKGuplfpHmrtn1I3/Zu
	4Z5/E3+9OO7Ve/+c65/0+W5XL7syhpk9maf41snixWyPZeW3ljXcenls+wmhpj2V1UILpt3P
	/VrUcO+mQNIDbwP5lVbblmvMWP1x2h8BDv9FYXqXdjzPvv3+VqOpCPMSrX0G/f8S/k68si9s
	sliVhvL3O0vP3rU/cKvadVbKqdL/WakFNr4dZiVRja3pqf8Zv9wSqNf59vidX55PUcOfG+4i
	qlv/cGrevDtR/bHcgpX+xhH6nPElAlFrj12arGxV69i9zHFjwsd1Z3Li35oanLxzhn/lzRXM
	h/esX395qfy6U9Y6Pr8FJYWFP6bdLvBUrElt5n60RjTLQlEhjkeJpTgj0VCLuag4EQDT0fYZ
	AwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSvO7s52JpBpN/S1qsvtvPZrH3lrYD
	k8fls6UenzfJBTBFcdmkpOZklqUW6dslcGX8WjSBvWA7U8WaaT9YGhjbmboYOTkkBEwkpve8
	B7K5OIQEdjNKTLzczAqRkJRY9vcIM4QtLLHy33N2iKInjBJ/T18F62YRUJW48GcmYxcjBweb
	gLbE6f8cIGERAQWJnt8r2UBsZgF7iTPbp7KClAgLBEuc2FwOEuYVMJOYefQwC4gtJGAjcfPv
	ZlaIuKDEyZlPWCBazSTmbX7IDNLKLCAtsfwf2HROAVuJfR+fsYPYogIyEjOWfmWewCg4C0n3
	LCTdsxC6FzAyr2KUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA5VLa0djHtWfdA7xMjE
	wXiIUYKDWUmEV1pLNE2INyWxsiq1KD++qDQntfgQozQHi5I477fXvSlCAumJJanZqakFqUUw
	WSYOTqkGpiJJu1V50hc+sb3iqWU6dfJu3PldYcdcLUNkriZ7fmj59r/wwtK2eS4Ptu3T3qcz
	eU+dzCnPA3skLnUW6Z9+eyrz8esztxvEPH3+vjVdsLFRXWD9M8um19LFX419H6dPWxOV6B8f
	yKbn3nVazk3u61vrd8s0rWYU19T+4T9enRykc7cmvKrD/vCkEj/Zjd/1Q9b4TKma6BAillMf
	7RjwysO1XW/Fq7LXPjvlurb1Mr7fM8ks/EjT8jWeZxuX+qyZUbjs+sd8HU//7NITP13Dt/+4
	7mXvoO9cOSs2Qsc/8MZsl9Ck98/WvK6c0NS+eYl88eSkCl7rExum/pu36UhjwosV6RpSgpZ/
	nzypMBZ4osRSnJFoqMVcVJwIAFde7gjEAgAA
X-CMS-MailID: 20240410192515epcas5p1360a731616fca3841c892be310afb109
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_7248a_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240410192515epcas5p1360a731616fca3841c892be310afb109
References: <dc58cf1e-cfbc-4771-80b8-4dfdf5d7f0d1@kernel.dk>
	<CGME20240410192515epcas5p1360a731616fca3841c892be310afb109@epcas5p1.samsung.com>

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_7248a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 09/04/24 09:00AM, Jens Axboe wrote:
>Convert the block debugfs interface to use read/write iterators rather
>than the older style ->read()/->write().
>
>No intended functional changes in this patch.
>
>Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_7248a_
Content-Type: text/plain; charset="utf-8"


------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_7248a_--
