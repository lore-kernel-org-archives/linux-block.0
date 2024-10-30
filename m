Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04FA1E570D
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295521; cv=none; b=Kf9Uob/lgYKsedZ9AB6I7kX0hgGzX+XWIaNO6bueDb2a5z6r5yC+CVFck0jW1gQDtaostY1kcYhxYXFfXY8ASQa/MO6LcIujUxZMwiTHphJwUycsjqqdwE7GquZG2z9n01lfjV2+b/+lXFy7a2Acs3g60Eq6Q+1P3oKnYv7XY/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295521; c=relaxed/simple;
	bh=zTgYIo/ph95KYaS4AGg/KCiidRJKZvPlzVLAWb6L+dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=rnAKRHLNK9v1WbXy5cixm4ZZAYhcSCmddiOxMG4qXe1dCHUEXjVDudlhpLIdsyo9YeyEYLTwnH8GoyVLC7G6JcX32XweOG1kwvWb6tqKu/Uc9GaWyOi798payd2ziLoJYAiuQ00j4ZwDNItkOdkVrTRz/Cy9qKX0AxAIDlq+9YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dthvk/cY; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dthvk/cY"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241030133830epoutp02705176ca9cc57a1de766dd1c15c42b09~DPpl8bM_E2531125311epoutp02J
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 13:38:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241030133830epoutp02705176ca9cc57a1de766dd1c15c42b09~DPpl8bM_E2531125311epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730295510;
	bh=zTgYIo/ph95KYaS4AGg/KCiidRJKZvPlzVLAWb6L+dA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=dthvk/cYTQEkCGTtbBRpJrwGzPQ4y6Aq0ZtxjO8+ROBPa6F78JPDImWv7vgew/YUM
	 OoyO0iRBJKiYNUHhB3abGVYY+4u6O0Ghxmgp+Z+vwZNsBdeQG0xcNK0welgftggyEt
	 6jpl2MsX+WrVAFKk6XT+j1pmd/6/qOPSoyypvEXA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241030133830epcas5p1ddf2e7a7914c516d8e089455798b2ffc~DPplhwsqx2484524845epcas5p1t;
	Wed, 30 Oct 2024 13:38:30 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Xdp9d176kz4x9Pp; Wed, 30 Oct
	2024 13:38:29 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C6.A1.09420.5D632276; Wed, 30 Oct 2024 22:38:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241030133828epcas5p3309db76a679c8cdf5c9becf738d8132a~DPpj9I0GL1177411774epcas5p3F;
	Wed, 30 Oct 2024 13:38:28 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241030133828epsmtrp273d2749e8a99a5360c463a3f6a3db2c0~DPpj8guYt1231612316epsmtrp2U;
	Wed, 30 Oct 2024 13:38:28 +0000 (GMT)
X-AuditID: b6c32a49-0d5ff700000024cc-c3-672236d5d5af
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A5.00.07371.4D632276; Wed, 30 Oct 2024 22:38:28 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241030133827epsmtip148f9748681ac0d4487214a277e6a9802~DPpiwgHTl1312513125epsmtip1D;
	Wed, 30 Oct 2024 13:38:27 +0000 (GMT)
Message-ID: <5220b70f-13e9-4f73-b611-97235db87ed5@samsung.com>
Date: Wed, 30 Oct 2024 19:08:26 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
To: Keith Busch <kbusch@meta.com>, hch@lst.de, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: anuj20.g@samsung.com, martin.petersen@oracle.com, Keith Busch
	<kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20241016201309.1090320-1-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmhu5VM6V0g+09LBZNE/4yW6y+289m
	sXL1USaLSYeuMVqcubqQxWLvLW2L+cueslssP/6PyYHD4/LZUo9NqzrZPDYvqffYfbOBzePc
	xQqPj09vsXj0bVnF6PF5k1wAR1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmS
	Ql5ibqqtkotPgK5bZg7QWUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE
	3OLSvHS9vNQSK0MDAyNToMKE7IxNCzcyFcxirFjZztnAWN/FyMkhIWAi8fLCB+YuRi4OIYHd
	jBL/9n5lgXA+MUqc6ZjABuF8Y5To+XuaDabl6KRtUFV7GSX+X7zLDuG8ZZRYsLcFrIpXwE7i
	ddMaMJtFQFXi2saXjBBxQYmTM5+wgNiiAvIS92/NYAexhQXcJZ6u7QCrFxGolfjb9IgJxGYW
	CJc42LMNyhaXuPVkPpDNwcEmoClxYXIpSJhTwFxi/srd7BAl8hLb385hhjh0LodE/7ZECNtF
	4t/3W1APCEu8Or6FHcKWkvj8bi9UPFviwaMHLBB2jcSOzX2sELa9RMOfG6wga5mB1q7fpQ+x
	ik+i9/cTsGskBHglOtqEIKoVJe5NegrVKS7xcMYSKNtDouXhH2iwdTFKfJr/k30Co8IspECZ
	heTJWUi+mYWweQEjyypGydSC4tz01GLTAsO81HJ4bCfn525iBCdZLc8djHcffNA7xMjEwXiI
	UYKDWUmE1zJIMV2INyWxsiq1KD++qDQntfgQoykwdiYyS4km5wPTfF5JvKGJpYGJmZmZiaWx
	maGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxSDUx80cdLt9Z/OxzaP8EjfZOcpKpLvtOBc5Os
	9HMzdZ8FXzZv4dHJfH9JcOeqm+llc9dfNeJTW+p2WUpvo6ZD8bWoU3fMz+XcS1M7mG6nePb8
	D/MnbTu3qbS9sRA2ePxh/zVX9lAOucmma861WZRcV1thonwg5q7ndYZpz+Z319jfXX9ZRU9q
	SthPYYt7N38Z+NouyerX4DnJnPA/2OTbUwO+X9ytj86vVbvB80475OP6yEZP6+XvpURt8rYF
	cx/f3bD9RrRe587rMw53SWaIBAht9z3j/8ZBL5TXjXvXrred/O/t5hxZnfGfTXe5ZfGv4i2K
	q/uXWixefjDcbiWv4eusRx5z7k0J7dSxfZU+85ESS3FGoqEWc1FxIgDzo0YXOwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJTveKmVK6wbSdShZNE/4yW6y+289m
	sXL1USaLSYeuMVqcubqQxWLvLW2L+cueslssP/6PyYHD4/LZUo9NqzrZPDYvqffYfbOBzePc
	xQqPj09vsXj0bVnF6PF5k1wARxSXTUpqTmZZapG+XQJXxqaFG5kKZjFWrGznbGCs72Lk5JAQ
	MJE4OmkbSxcjF4eQwG5GiTtH+9ggEuISzdd+sEPYwhIr/z1nhyh6zSix8nEfC0iCV8BO4nXT
	GrAGFgFViWsbXzJCxAUlTs58AlYjKiAvcf/WDLBBwgLuEk/XdoDViwjUSkz5OocJxGYWCJf4
	8LsFLC4k0MUocflqKURcXOLWk/lANRwcbAKaEhcmg4U5Bcwl5q/czQ5RYibRtbWLEcKWl9j+
	dg7zBEahWUiumIVk0iwkLbOQtCxgZFnFKJlaUJybnptsWGCYl1quV5yYW1yal66XnJ+7iREc
	UVoaOxjvzf+nd4iRiYPxEKMEB7OSCK9lkGK6EG9KYmVValF+fFFpTmrxIUZpDhYlcV7DGbNT
	hATSE0tSs1NTC1KLYLJMHJxSDUwmJxe4Lj239PE35suJScEhe77EnsqU9NUSmdc8xUPwqpid
	6He+mi0hk9eenpucVXX0UNIXsb3FUXsF7S8sWvvAuPwV99Ss5o19Xw4Xty980BRR8J0vMDvZ
	kS/irEmJiMbsm9d3pzwVfmX9uX6lnJ6Sl/T0T7Nkv2ec+3qbZ92+AyXXIw7l1d06MbmdV7Lk
	jMmJ84sTvFbq9R/d/XCK8AXNBSdebgqeuUH+z9ZV2zi43724v/vNqbDwl+FHesS0TzSmGTHs
	bV1q/Z8z5dfJjzwzjn1O5JyUcWBz5PNfz2dn2+Zb90iJ/HVid/ETmRF98tX3VTo3H9qcunKA
	ReVe6E7uhewxh93092f9r+nkCH27WomlOCPRUIu5qDgRAEW4CiwXAwAA
X-CMS-MailID: 20241030133828epcas5p3309db76a679c8cdf5c9becf738d8132a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241016201337epcas5p33625af2c67f92092078b0b43874d67bd
References: <CGME20241016201337epcas5p33625af2c67f92092078b0b43874d67bd@epcas5p3.samsung.com>
	<20241016201309.1090320-1-kbusch@meta.com>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

Jens,
Please see if this can be picked.
Helps to reduce a dependency for io_uring metadata series.
