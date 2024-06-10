Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ED8A953
	for <linux-block@vger.kernel.org>; Mon, 10 Jun 2024 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718015977; cv=none; b=GEyLxFLjzy5didCEAVLlBfoCoEKEPlE2UcU56x1SMdoSHvCfILRj0+3jv0AOoB8AnX6ORSFk+6iu2yj08fJXPXDjBr7JxKPzuXGfc5uG3VXXO1RqYtc5lFsbMULWt4zxt9yV4r+/n1GMGCzDPc4KKHrsajnZ5DUfxFHx+XGEIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718015977; c=relaxed/simple;
	bh=dDt1VDbDwaEue1iNchgowCdjvmlyoAtWDDL9ZmI5cMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=cMs+0rJgc597MbfB3rMGiHFPkeYD3ltu0fhR9+8mOW95CO+MIrc0Q6ClUjO0OZDjIzUmI8srvdNULt6QaDyYtUNUNYuv9FstuwsylulGsMVtGtXTKuFXSkJo4YipeN1c18e22F9Fn3A0dvdknMXzb2mX/LdTbWf27fWcjQZy5M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tv3TLvoj; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tv3TLvoj"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240610103927epoutp033c9b6c85fa1245dae8d6b71a53a77c56~Xnmt2UPVd3081430814epoutp03H
	for <linux-block@vger.kernel.org>; Mon, 10 Jun 2024 10:39:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240610103927epoutp033c9b6c85fa1245dae8d6b71a53a77c56~Xnmt2UPVd3081430814epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718015967;
	bh=K7o2pR/79E9wG1wfel5kr9rOP7CXgqEUVCBlrlwT8sY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tv3TLvoj0Gni6K2JneUHCnBmwN6SRS1hN1ICqWzvgUi/X/CVpf+1gQWq/wSP45e+i
	 3xpAY58hXSxax5H1NaU2EplsRnfhgcIvyjqB+3tOIRJpGMoUcV9/n0wWkGhdMCLswQ
	 r7bK3h/jZUuAxM1ExvIzzd1HmE0xSjyOLUWil5/c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240610103926epcas5p3bd31d1491a0fb041c0fdfef3ab53a9c3~XnmtnHABk0579505795epcas5p3o;
	Mon, 10 Jun 2024 10:39:26 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VySwY0xrzz4x9Pw; Mon, 10 Jun
	2024 10:39:25 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	22.AA.19174.AD7D6666; Mon, 10 Jun 2024 19:39:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240610103922epcas5p1ef3a0db989666efdb9dcdeb6340d2ebd~XnmpXRXY90450704507epcas5p15;
	Mon, 10 Jun 2024 10:39:22 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240610103922epsmtrp25e6dba14eb79f32e433a92aafecbb27b~XnmpWu-CB2371023710epsmtrp2C;
	Mon, 10 Jun 2024 10:39:22 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-f7-6666d7da2ee2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	56.53.18846.AD7D6666; Mon, 10 Jun 2024 19:39:22 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240610103921epsmtip2c834cff092732191c726bdeb3a36e186~Xnmol7ou01318113181epsmtip2Y;
	Mon, 10 Jun 2024 10:39:21 +0000 (GMT)
Message-ID: <acafc796-fca8-2818-312c-9553fc248458@samsung.com>
Date: Mon, 10 Jun 2024 16:09:20 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] block: initialize integrity buffer to zero before
 writing it to media
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, "Martin K. Petersen"
	<martin.petersen@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240607054033.GA3631@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTXff29bQ0g2WxFqvv9rNZrFx9lMli
	7y1ti+XH/zE5sHhcPlvqsftmA5vHx6e3WDw+b5ILYInKtslITUxJLVJIzUvOT8nMS7dV8g6O
	d443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB2qekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8u
	sVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM5Y+bWoYAJTRef/h8wNjLcZuxg5OCQE
	TCQ2vuXtYuTiEBLYwyjR++k/UJwTyPnEKLHrlzNEAsi+duMZC0gCpOH97ensEImdjBJtJ3Yx
	QThvGSW+LbrGClLFK2AnsX7NC7AOFgFViX3Pm5gh4oISJ2c+AYuLCiRL/Ow6wAZiCwvESCw5
	9wLMZhYQl7j1ZD4TiC0iEC7xY8liFoi4gcTjB3+ZQM5mE9CUuDC5FCTMKaAt0bPyKCNEibzE
	9rdzmEHukRC4xy5x4MsUZoirXSReb78B9YGwxKvjW9ghbCmJz+/2skHYyRKXZp5jgrBLJB7v
	OQhl20u0nupnBtnLDLR3/S59iF18Er2/nzBBQpFXoqNNCKJaUeLepKesELa4xMMZS6BsD4kH
	KycxQQL3PaNEwxbhCYwKs5ACZRaS52ch+WYWwuIFjCyrGKVSC4pz01OTTQsMdfNSy+GxnZyf
	u4kRnBa1AnYwrt7wV+8QIxMH4yFGCQ5mJRFeoYzkNCHelMTKqtSi/Pii0pzU4kOMpsDomcgs
	JZqcD0zMeSXxhiaWBiZmZmYmlsZmhkrivK9b56YICaQnlqRmp6YWpBbB9DFxcEo1MC33+Tnl
	6MTle3oNppfqhE5KW6Vau9ZQ8GhqVPjLiKbkCHt7HflQ/dXeqkrWJ0X+KmuyPFj5/J7ILbd1
	u7bEHDi0NNL1tHDme64/tQUrV60STZ9bw3ii6HfOtBoeeYu63t3x+bOz0t0uB90xbC3eXesc
	Jt5lVCrRLzxLVnv2QnvL+uPLgi/l9fG+C14tfcFCcP2St8wd8VVCvc37utKXSE8+1rP15YHW
	1cuOSAn8vs9YdbMwJC35qNJDsws6BY9Em0NY4h+tWLX3QvHSkrhNtV0ihXPUl9uEtC7/+GLl
	yTd+YawLzgXamTZcuBTb/8TE4krh1KPdcSdNzk832Fl2+fALV1G10mUzjuUGO/KnKLEUZyQa
	ajEXFScCAF2AmlwUBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSvO6t62lpBk8fiFisvtvPZrFy9VEm
	i723tC2WH//H5MDicflsqcfumw1sHh+f3mLx+LxJLoAlissmJTUnsyy1SN8ugStj5deigglM
	FZ3/HzI3MN5m7GLk5JAQMJF4f3s6excjF4eQwHZGieZrL5ghEuJA9g92CFtYYuW/51BFrxkl
	5t68wgaS4BWwk1i/5gULiM0ioCqx73kTM0RcUOLkzCdgcVGBZImXfyaCDRIWiJFY8ugY2GZm
	oAW3nsxn6mLk4BARCJdYdlISImwg8fjBXyaIXe8ZJZ7NvcIOUsMmoClxYXIpSA2ngLZEz8qj
	UGPMJLq2dkHZ8hLb385hnsAoNAvJFbOQbJuFpGUWkpYFjCyrGEVTC4pz03OTCwz1ihNzi0vz
	0vWS83M3MYLDXytoB+Oy9X/1DjEycTAeYpTgYFYS4RXKSE4T4k1JrKxKLcqPLyrNSS0+xCjN
	waIkzquc05kiJJCeWJKanZpakFoEk2Xi4JRqYKrNTkq8ZiF5Z7N9xc872r2Lbv5Rith+Qlz9
	Vvlv9QPr7RwvZV2o/tk72+f04We+YYWWd+3+Te3K5P9bHu7xVvDGpuS2b5mbfQR2X5Xe+fvs
	5PWB7f/7Zn5LyLPUzp7yfrbjk0+9E/M+HQi76h27u2Ijq/Kk9idvzfrXZyStya0V16iWSTab
	kCf+fudnPaNZa5/19aaniNpdSDmuUqC0h+Nk5rTSE+emr63Zs+t5Z+KJZcv++a56+Wx6Otvd
	o1ZuhW90/XwPrN4kNrfsU+rrxVnTGxZ3dW+Jmf0puGV30+GbUUsr7D5khxQXGgS83PC3XfrK
	hUPNegoTVr6LefYx/WfmQbmPNfGP+tprDJPEd11TYinOSDTUYi4qTgQACtD2cu4CAAA=
X-CMS-MailID: 20240610103922epcas5p1ef3a0db989666efdb9dcdeb6340d2ebd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240607054046epcas5p470925fe8605311dc7bbc61f6c2a67a1a
References: <20240606052754.3462514-1-hch@lst.de>
	<yq1msny6ucc.fsf@ca-mkp.ca.oracle.com> <20240606141017.GA10730@lst.de>
	<CGME20240607054046epcas5p470925fe8605311dc7bbc61f6c2a67a1a@epcas5p4.samsung.com>
	<20240607054033.GA3631@lst.de>

On 6/7/2024 11:10 AM, Christoph Hellwig wrote:
>   So unless someone objets I'd like to go
> with this simple version, and with that series we can then easily
> relax the zeroing check to only cover the non-PI case.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
