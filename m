Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B85FDA7
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 05:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719898401; cv=none; b=IUrpXtm7LkB/YWwr6XvHl0EF8qH+ga3XciOxh05ZPlzvaUVis/CZL13ELmvsJ+NPrFVb/jdKMBxapYJziKisBuiRAOnCXQdO5TsaZTP3XS07ItQoX2bo4OLuV7PILOmy221SHxeFUzFUhUz7imNttUSYSqmNQcb6LTEwQTczhho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719898401; c=relaxed/simple;
	bh=5pYXyYgWkd2KolN6dYrDqx6MlBk1nYmUrUSnCmp+yAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=oR2qcdMQHVxL+yWM3PRT+w7s0AXoHK+hZwu03iYFl/r9p/ui/jDE35VxjJDBfdP6QSUoyiU9AcH9/EH4vr7dLO7S8axf/qBrntw4m3EWRNTE/fxNcJDYOvIrUs24aId4jS1QKZxkrrc9tSkxZ8jt1ixS+QT1Auq+ZsnH1OQ1Qvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RjkN0NK/; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RjkN0NK/"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240702053317epoutp01fb6a9063e636d122516ed04e7069ae3a~eTnr1bs4C1893718937epoutp01W
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 05:33:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240702053317epoutp01fb6a9063e636d122516ed04e7069ae3a~eTnr1bs4C1893718937epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719898397;
	bh=5pYXyYgWkd2KolN6dYrDqx6MlBk1nYmUrUSnCmp+yAs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=RjkN0NK/y+Yg40shtg/35GdUhGi7WOCvC72cUhTzfAYdYg3DN0IBdqEendpNev9ee
	 ErZcgddgTLXs3vj0jdcPIT2Y1bWvKYajl6TZ5QzPbrTvbk0sSoOP4FSd8aIZtTohOb
	 NoiJX2mJv6vd0AaC7qBEtbfWPkoJ2TP8R82/0/w8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240702053317epcas5p2b446fd21cbc4f8f9f6a04a619ed03b18~eTnrmuagy1612216122epcas5p2l;
	Tue,  2 Jul 2024 05:33:17 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WCs57565Gz4x9QN; Tue,  2 Jul
	2024 05:33:15 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E1.1E.11095.B1193866; Tue,  2 Jul 2024 14:33:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240702053315epcas5p28f3f6136a80a7380abe1733808e802fd~eTnpnEkDZ2114521145epcas5p2o;
	Tue,  2 Jul 2024 05:33:15 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240702053315epsmtrp1892df5bb5b16455150503df3f6a4cf90~eTnpmeA-H0952309523epsmtrp1d;
	Tue,  2 Jul 2024 05:33:15 +0000 (GMT)
X-AuditID: b6c32a49-3c3ff70000012b57-7f-6683911b046e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EF.E5.07412.B1193866; Tue,  2 Jul 2024 14:33:15 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240702053314epsmtip1d2bf3737bca78cd16d75e76b5d9bce97~eTnonzdec0388103881epsmtip1e;
	Tue,  2 Jul 2024 05:33:14 +0000 (GMT)
Message-ID: <25477f15-e6d7-6405-c386-06f16c4db879@samsung.com>
Date: Tue, 2 Jul 2024 11:03:13 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 3/5] block: call bio_integrity_unmap_free_user from
 blk_rq_unmap_user
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240701050918.1244264-4-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdlhTU1d6YnOawfTv6hZNE/4yW6y+289m
	sXL1USaLvbe0LZYf/8fkwOpx+Wypx+6bDWweH5/eYvHo27KK0ePzJrkA1qhsm4zUxJTUIoXU
	vOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg1UoKZYk5pUChgMTiYiV9
	O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Iyt6x+xF9xjrJh+
	6DZLA+Muxi5GTg4JAROJ661TWEBsIYHdjBJHWmIg7E+MEj9mhXQxcgHZ3xglJn9rZYVp2Haj
	lwkisZdR4tqMp6wQzltGiSfTJ7ODVPEK2Emse9TKBmKzCKhI/N9+iRkiLihxcuYTsHWiAskS
	P7sOgNUIC0RLNP1ZBxZnFhCXuPVkPhOILSLgIDF7w1I2iHiFxNR7z4BsDg42AU2JC5NLQcKc
	AkYSC+4/ZYcokZfY/nYOM8g9EgI/2SV+Hr3ADFIvIeAi8flFFsQDwhKvjm9hh7ClJF72t0HZ
	2RIPHj1ggbBrJHZs7oN62F6i4c8NVpAxzEBr1+/Sh1jFJ9H7+wkTxHReiY42IYhqRYl7k55C
	dYpLPJyxBMr2kHh45BIjJGzXMkocOqM3gVFhFlKYzELy+ywkz8xCWLyAkWUVo2RqQXFuemqx
	aYFhXmo5PLKT83M3MYJTpZbnDsa7Dz7oHWJk4mA8xCjBwawkwhv4qz5NiDclsbIqtSg/vqg0
	J7X4EKMpMHImMkuJJucDk3VeSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9
	TBycUg1Myyb7RnrqSi8JZ5qmErb+ttH5tyt36ry7mB3HsPO22Pa9d4S9yrYuDKl/vY751Obf
	Pw7/kHPSEW/oWmY655Lu4i3BO43vnVwyPePQRzYzE357mXMnDk9r47h4Y9rlvRr9T5eJhWfw
	d+47nvz3NkPKrD7HvWUN9UtPWb+T+hTZcW5D/ZEQ9XuHEk302jvfV665/b7Wyy3m6pW/Z82m
	rEhTcrK3+xXBP2N2n57vshSnqFcHnQQi2pekOM5cJfORZ/m7HSa3+FwOMlrOlBfQFNyyI1Vm
	Pwt7smFa8rTKtOTrPGrLjnuufDa//ZLuStbVL7Q/qdzi+h276lTfowQp5l0LuAN3lchqn/6d
	dkH95GnzfCWW4oxEQy3mouJEAKjbchAeBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSnK70xOY0g109fBZNE/4yW6y+289m
	sXL1USaLvbe0LZYf/8fkwOpx+Wypx+6bDWweH5/eYvHo27KK0ePzJrkA1igum5TUnMyy1CJ9
	uwSujK3rH7EX3GOsmH7oNksD4y7GLkZODgkBE4ltN3qZuhi5OIQEdjNKLJw2BSohLtF87Qc7
	hC0ssfLfc3aIoteMEv/afrKAJHgF7CTWPWplA7FZBFQk/m+/xAwRF5Q4OfMJWI2oQLLEyz8T
	wQYJC0RLNP1ZBxZnBlpw68l8JhBbRMBBYvaGpUBzOIDiFRJ3VhZC7FrLKLHn2gVGkDibgKbE
	hcmlIOWcAkYSC+4/ZYcYYybRtbWLEcKWl9j+dg7zBEahWUiumIVk2ywkLbOQtCxgZFnFKJla
	UJybnptsWGCYl1quV5yYW1yal66XnJ+7iREcHVoaOxjvzf+nd4iRiYPxEKMEB7OSCG/gr/o0
	Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryGM2anCAmkJ5akZqemFqQWwWSZODilGpiclSfX2cnu
	X9YTu67bRGaZE9dLF0/2QMWT1cL/N5/2/3pM6/iK5xIiivZnTJ4IrA8ysyrl2FuZL/jwwayv
	aepnvrDMTJbrOj6H/VDflX7mm5NeHmlukegvmezg7rtx5buw/TJPbk93WXItJPYMg7BCNvMf
	FaHzhcUfKvd9cNLvfFXAIHZCMem3yNuewKOhr3OrDb4YrIxpVw5Rm8bhmSfiyV4za331A+WD
	dudZW8pknl3x3XlH+/qORt/2U4VB35dydrcfbtKfcUPpK5dJxf/896fvnNjM4bvzxTPlq7J7
	dsdHCJcGWEbP/x/G3PW72meWt0O+6CNty+PaD8VlLhvVLr5/ea7Wl8sGH/JOcyixFGckGmox
	FxUnAgBpy53I/QIAAA==
X-CMS-MailID: 20240702053315epcas5p28f3f6136a80a7380abe1733808e802fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240701050939epcas5p13918d364bf5b18edb4beb5cba6d74656
References: <20240701050918.1244264-1-hch@lst.de>
	<CGME20240701050939epcas5p13918d364bf5b18edb4beb5cba6d74656@epcas5p1.samsung.com>
	<20240701050918.1244264-4-hch@lst.de>

On 7/1/2024 10:38 AM, Christoph Hellwig wrote:
> blk_rq_unmap_user always maps user space pass-through request

always maps -> always unmaps?

Otherwise, looks good.
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
