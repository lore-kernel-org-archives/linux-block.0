Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676E199B9
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296783; cv=none; b=TQpC/x0LBPlmWWKgRMLVdj1ZRRXC1dppczwqKpyKEeHO5pOYFdw52H08Pt7hv619aciA5GnfeZnq/hZdilDDKf0O9LnQALqiO5h4SMom33srhknbS6WuT8Wm5CWlX21qkUs1C2Hb+pvnKmPYO6oK2kawC//jIrGVbqBVkVXtMLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296783; c=relaxed/simple;
	bh=vgFe+mIp8kTKyb34kU2wZeoq2vGKRybw9PQjsSI2sFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Nl7Fe5BZk4MWvQ+8IU39Kiv4gRjvh8wUNBF7GuWNjeDut9E9gmX1hZTvfWBYH+im9OywrNGwY+x5YDOGpepjfA/ED52r2IrYVcBZ5kB4+Na9JXggDCpF1cWOZ8moRDl96tmU40Wla0Dq50pbtYnmNZ1Zb1m7fXQbHW6wNnAkge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Y16qfiXM; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y16qfiXM"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241030135938epoutp03b21cfbcd7d14adaa7d8501703c34b360~DP8CTC5232240022400epoutp03P
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 13:59:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241030135938epoutp03b21cfbcd7d14adaa7d8501703c34b360~DP8CTC5232240022400epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730296778;
	bh=vgFe+mIp8kTKyb34kU2wZeoq2vGKRybw9PQjsSI2sFY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Y16qfiXMOsl5J5ZWRvfNqZmpw2ftOxbsaoc56vUKTy8pJ4SJpnUEz2WxQNx4Kq/Fs
	 L423bH/yrAVG2iutFXrbIHlEX1wRyEfEeB4JvNoI350X7KquMI/Q9+HW843YTRbqEZ
	 CWjCiTq7RpPtsvJY7Z6aBhDNqcCUGLiwcUNGvsuI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241030135936epcas5p47a0a5aab8a01be2ca5785c81f577a700~DP8BHBadz0566905669epcas5p4e;
	Wed, 30 Oct 2024 13:59:36 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Xdpf01grhz4x9Pr; Wed, 30 Oct
	2024 13:59:36 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8B.29.09770.8CB32276; Wed, 30 Oct 2024 22:59:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241030135935epcas5p4b42e5355e469e99a9ebcb8f66a56bccb~DP7-7Pedv0566905669epcas5p4d;
	Wed, 30 Oct 2024 13:59:35 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241030135935epsmtrp2f92877ceabf3508ef8f735c0fcdab905~DP7-6oTgL2403824038epsmtrp2e;
	Wed, 30 Oct 2024 13:59:35 +0000 (GMT)
X-AuditID: b6c32a4a-e25fa7000000262a-2a-67223bc84a66
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	90.4E.08227.7CB32276; Wed, 30 Oct 2024 22:59:35 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241030135934epsmtip1d05ef58cdd199ae5647049a2ae95b51e~DP7_qDHr52369823698epsmtip1Q;
	Wed, 30 Oct 2024 13:59:34 +0000 (GMT)
Message-ID: <554281ce-9f83-48db-9e24-7a7cfd4ed240@samsung.com>
Date: Wed, 30 Oct 2024 19:29:33 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@meta.com>, hch@lst.de,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: anuj20.g@samsung.com, martin.petersen@oracle.com, Keith Busch
	<kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <75331d62-fb0b-41ef-9a47-2bbe78e09f9f@kernel.dk>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmuu4Ja6V0g6OtnBZNE/4yW6y+289m
	sXL1USaLSYeuMVqcubqQxWLvLW2L+cueslssP/6PyYHD4/LZUo9NqzrZPDYvqffYfbOBzePc
	xQqPj09vsXj0bVnF6PF5k1wAR1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmS
	Ql5ibqqtkotPgK5bZg7QWUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE
	3OLSvHS9vNQSK0MDAyNToMKE7IwXn26xFcRXdF67x9rA6NnFyMkhIWAi8eXxOvYuRi4OIYHd
	jBI/JqxlBUkICXxilGicJQthf2OUuL8iG6bh4p4TLBDxvYwSU8+xQDS/ZZRo6djECJLgFbCT
	2Pu0jQnEZhFQlZj78wQrRFxQ4uTMJ2DNogLyEvdvzWAHsYUF3CWeru1gAxkkItDFKPF4ygtm
	kASzQLjEwZ5tTBC2uMStJ/OBbA4ONgFNiQuTS0HCnAK2EtPXPIcql5fY/nYOM8gcCYGFHBJt
	616zQFztIrG38zsjhC0s8er4FnYIW0ri87u9bBB2tsSDRw+g6mskdmzuY4Ww7SUa/txgBdnL
	DLR3/S59iF18Er2/n4CdIyHAK9HRJgRRrShxb9JTqE5xiYczlkDZHhItD/9Aw2opk8ScJ9tY
	JjAqzEIKlllIvpyF5J1ZCJsXMLKsYpRMLSjOTU8tNi0wyksth0d2cn7uJkZwitXy2sH48MEH
	vUOMTByMhxglOJiVRHgtgxTThXhTEiurUovy44tKc1KLDzGaAuNnIrOUaHI+MMnnlcQbmlga
	mJiZmZlYGpsZKonzvm6dmyIkkJ5YkpqdmlqQWgTTx8TBKdXApP9f3ko4YVqGksbsDSs9HVjF
	JTXKd1+Q7q5ct/7QEvkvJ/QZWf+8vlgheztMN8lwSsPl9rctRgpFlxMup6rNnGDm2qR8JnP3
	oj0nX7TfXBC5YDnDhGfMD3wnHXiT3qLtph96+KqCvs4GtTm3pyZNErwxvzTvl/UrR6eT09Rq
	FN2jRHI1v+wvstr4Vu3ix5CAhFittFXuLVaFScuMDx7Q3nTDaKF83bHSm9+09/X7LffTFupJ
	Fc3ytWvvkH3muHhx9YWmmi65xBy7O//t793vWc6UGM+cIxjawLVhGcODXLmwNTNWPjs6q+Pm
	m6XWSdr3mjgKdx5cyNb5O0Ryp17S1vWy6ZVT72Zah82WMd+vxFKckWioxVxUnAgAHBGboToE
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJTve4tVK6wYIlihZNE/4yW6y+289m
	sXL1USaLSYeuMVqcubqQxWLvLW2L+cueslssP/6PyYHD4/LZUo9NqzrZPDYvqffYfbOBzePc
	xQqPj09vsXj0bVnF6PF5k1wARxSXTUpqTmZZapG+XQJXxotPt9gK4is6r91jbWD07GLk5JAQ
	MJG4uOcESxcjF4eQwG5GiVNfVzFBJMQlmq/9YIewhSVW/nvODlH0mlGidelXsASvgJ3E3qdt
	YA0sAqoSc3+eYIWIC0qcnPmEBcQWFZCXuH9rBli9sIC7xNO1HWwgg0QEuhglVm+aCdbALBAu
	8eF3CxuILSSwlEniwB4LiLi4xK0n84EWcHCwCWhKXJhcChLmFLCVmL7mOTNEiZlE19YuRghb
	XmL72znMExiFZiE5YxaSSbOQtMxC0rKAkWUVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7u
	JkZwTGlp7WDcs+qD3iFGJg7GQ4wSHMxKIryWQYrpQrwpiZVVqUX58UWlOanFhxilOViUxHm/
	ve5NERJITyxJzU5NLUgtgskycXBKNTClHNda1lx8oCDfLSr32885W489OtW70dOz/8Zmobjc
	Rx8kv5gnCh+4Y7FW34PnQlmqm9Oe1Q8++XF9yV/GUHPg+u7t1p1blNTmbj/H4vZi+dE2pnUp
	75VlGtRsHodpiT160j3redRT7f4bk70OqPJsPNPx98xuvoXG/x8+4mtW5ZUWMj+87sfkWpkn
	ywyeXJgZrbzjXLXiAs4LiQL8tRE7VNIirPl/NsyTbREXD9K+aWdZLy3hc///smPaMs9utfoe
	1Hnw7ecUdfd8887cG1Obn30Ur1T6dF9wQZDT8o/ar8I6epkYGSUkZ7DY9vyvnOtvHb4xLpVv
	WePKE2sm6sz3irQ2zF1VmXH1SWvR5n4lluKMREMt5qLiRADAFqbzGAMAAA==
X-CMS-MailID: 20241030135935epcas5p4b42e5355e469e99a9ebcb8f66a56bccb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241016201337epcas5p33625af2c67f92092078b0b43874d67bd
References: <CGME20241016201337epcas5p33625af2c67f92092078b0b43874d67bd@epcas5p3.samsung.com>
	<20241016201309.1090320-1-kbusch@meta.com>
	<5220b70f-13e9-4f73-b611-97235db87ed5@samsung.com>
	<c156bc1f-da5c-4522-8e5d-b138a94cb7d2@kernel.dk>
	<75331d62-fb0b-41ef-9a47-2bbe78e09f9f@kernel.dk>

On 10/30/2024 7:20 PM, Jens Axboe wrote:
> Doesn't look like it is, picked it up.

Thanks.
