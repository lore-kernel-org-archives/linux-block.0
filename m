Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477AA44C6C
	for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 05:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734068596; cv=none; b=bzsfftJQbj/xopECRfRPBpTEX8pen4OImD+vsyc4reLVYTwEFu7+u3BZ7IgHimeBKiFEPfA+cr9QUQ4mO0q/P+bAtno88Jgzf+JB2kXxxEaZH+Podz8YJlK/BbzN9M0L9NbAseo9zTR4YpWRqRegYWVRjL2/VeoPb4ixyT7RI64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734068596; c=relaxed/simple;
	bh=s9s4sPL8e48KhzR4qpjiOEKZKMQtTt2lSQ5jiKI3/ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=oqeIqJSWz3MA7j6t00GwFLeM0lSYm6QzSOlvh6HIBQSjI1z1d51WhGUbDLfS3fSeaJLWErXZie4tb5KVPN2C9oU867Jq5cw/lq7wdoIZnyDUoSegsdmDymeiRHzcgSVz6z7nciM/Arn3H0yva3BiFQWrKECGBdyah+adFRS0RsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KCRuBG47; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KCRuBG47"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241213054310epoutp019597660a3cb3e49a59942f989dd3d4b2~QpjIdwwYn1812918129epoutp01E
	for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 05:43:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241213054310epoutp019597660a3cb3e49a59942f989dd3d4b2~QpjIdwwYn1812918129epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734068590;
	bh=s9s4sPL8e48KhzR4qpjiOEKZKMQtTt2lSQ5jiKI3/ZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KCRuBG47iwUKYqCud/criqtHD4WnjaBzHDjvyI2tx8v4feNEnbQe9QOZrJN7fZD0V
	 CV7bwNtN/4jonFFUrTK1iofpJoFCj7767TtO5VotfAn8j8boDbWL52Xifx21GpsvmF
	 cb2DseM4IKpxQW8uKAeHo/ojID89AoAhFr2OeH2w=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241213054310epcas5p29f1a4c4eb016e526c5eff568b945451e~QpjIFzh_k1290012900epcas5p2o;
	Fri, 13 Dec 2024 05:43:10 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Y8dXs0vMWz4x9Pv; Fri, 13 Dec
	2024 05:43:09 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	00.92.19710.C69CB576; Fri, 13 Dec 2024 14:43:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241213054245epcas5p4cac9beca94d7f11e792655b85e35b671~QpixD9QLr2621826218epcas5p4z;
	Fri, 13 Dec 2024 05:42:45 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241213054245epsmtrp19603693eee60148f02ab0169d7e51b45~QpixDMBHY3214432144epsmtrp1c;
	Fri, 13 Dec 2024 05:42:45 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-64-675bc96c6a94
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8C.2F.18949.559CB576; Fri, 13 Dec 2024 14:42:45 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241213054244epsmtip1f7937b00ae232ba403ae362226b506d6~QpiwIU6K63151531515epsmtip14;
	Fri, 13 Dec 2024 05:42:44 +0000 (GMT)
Date: Fri, 13 Dec 2024 11:04:51 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Christoph
	Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 2/3] blk-mq: Clean up blk_mq_requeue_work()
Message-ID: <20241213053451.ltorxi4lywu7b6nn@ubuntu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241212212941.1268662-3-bvanassche@acm.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTXTfnZHS6wbd7Nhar7/azWUz78JPZ
	4sF+e4uVq48yWey9pe3A6nH5irfH5bOlHptWdbJ57L7ZwObxeZNcAGtUtk1GamJKapFCal5y
	fkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0GIlhbLEnFKgUEBicbGSvp1N
	UX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGiqZFbAVfWSsu/b/G
	3sA4nbWLkZNDQsBEYsedZ0A2F4eQwG5GiQ9bzjNCOJ8YJeb83M8G4XxjlNj8/xAzTMuur9fB
	bCGBvYwSr/5kQBQ9YZQ4+bGLBSTBIqAqcf/8LSCbg4NNQFvi9H8OkLCIgIbEtwfLWUDqmQVa
	GCWOz13IBpIQFrCXaD76AuwmXqAFdxb+ZoSwBSVOznwCNodTwEqi96ApSK+EwC12ifert7FB
	HOQi8eXjXyhbWOLV8S3sELaUxMv+Nii7XGLllBVsEM1Ai2ddn8UIkbCXaD3VD/YNs0CGxIoL
	56ABIysx9dQ6Jog4n0Tv7ydMEHFeiR3zYGxliTXrF0AtlpS49r2RDeRQCQEPia69ipBAAQbQ
	wfNXmScwys1C8s8sJOsgbCuJzg9NQDYHkC0tsfwfB4SpKbF+l/4CRtZVjJKpBcW56anJpgWG
	eanl8EhOzs/dxAhOi1ouOxhvzP+nd4iRiYPxEKMEB7OSCO8N+8h0Id6UxMqq1KL8+KLSnNTi
	Q4ymwPiZyCwlmpwPTMx5JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeWpGanphakFsH0MXFw
	SjUwZWo8jjz/Kd3YfLeYXPV6ibBfBg1pQAdqirD6uTKvS3zR/7u1qSlnBffjN5JZQg3sn54f
	5SpuNTO+/PTaxIjCm7tu1916p1FycMb3Yj7NX/ttjx0/UC58rEF7j2jQ39J9iazZtfuq5MRk
	454tE3FQ4pSLSY6ZKXSw7V5J227lL51rN1fIJmUEhDublEeVzf42O7dj6hafD/MZU8Lv/3UW
	Unfzl90WJnXxldjikztXn9kg+rzM3jjRyEbGn1E55uXj35zXy3ZlSSzxiZ6v1nzNS94hw+ui
	SlTMnPDKy2VHY8XFdgdJuc2/6dgu/WJWc06JYNSyVJ6/UVf43omZa0uutF04WbtrspfDbWMu
	JZbijERDLeai4kQAcm052BQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWy7bCSnG7oyeh0g+ePFCxW3+1ns5j24Sez
	xYP99hYrVx9lsth7S9uB1ePyFW+Py2dLPTat6mTz2H2zgc3j8ya5ANYoLpuU1JzMstQifbsE
	rozvn1+wFyxnrnj/rZWlgfExUxcjJ4eEgInErq/XmbsYuTiEBHYzSjx+8JQFIiEpsezvEWYI
	W1hi5b/n7BBFjxglZk0/BdbNIqAqcf/8LaAGDg42AW2J0/85QMIiAhoS3x4sZwGpZxZoYZRY
	tvka2FBhAXuJ5qMvWEFsXqDNdxb+ZgSxhQQyJa6uvs8MEReUODnzCVg9s4CZxLzND5lB5jML
	SEss/8cBYnIKWEn0HjSdwCgwC0nDLCQNsxAaFjAyr2KUTC0ozk3PLTYsMMpLLdcrTswtLs1L
	10vOz93ECA5mLa0djHtWfdA7xMjEwXiIUYKDWUmE94Z9ZLoQb0piZVVqUX58UWlOavEhRmkO
	FiVx3m+ve1OEBNITS1KzU1MLUotgskwcnFINTH3fmdsYPDQqPadvdmMPtcnKOlpw8QKb08+m
	C7+W/n6puU7g279tnJsOqEj8W9HGtddQVmGN1eTeq4dNT0ycmvniUE7A1YMrb8suXVjF8OWU
	w4PHC1JFDNjihM5VXJtxzlbZhbNEL+ewg9LShRs5zVYWqP3wedpvGKb/I2mHuP/EGdNOTGZm
	8eSzfae/wNvlirFNv+vcc/mZGRdeddluTvzgVlqxKvAwg0NtXNBlp5M2vz1uSUm/8eE0XnDD
	vYVRrNLcSWp5rcyV2l8T844UGfKVrLNSFy99bL2mlKnj/7+J4Vkd6tVf+RO6Ky+u35Eit+di
	5t+g+j+Wl9lK21f9+/MzNbHDZtXU88unxXueV2Ipzkg01GIuKk4EAE24+fjVAgAA
X-CMS-MailID: 20241213054245epcas5p4cac9beca94d7f11e792655b85e35b671
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----lzW.cJR_-6sCvQYD.lREqa.H-32Z9TKwpDxBjmCjs3VZTSBT=_808fc_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241213054245epcas5p4cac9beca94d7f11e792655b85e35b671
References: <20241212212941.1268662-1-bvanassche@acm.org>
	<20241212212941.1268662-3-bvanassche@acm.org>
	<CGME20241213054245epcas5p4cac9beca94d7f11e792655b85e35b671@epcas5p4.samsung.com>

------lzW.cJR_-6sCvQYD.lREqa.H-32Z9TKwpDxBjmCjs3VZTSBT=_808fc_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 12/12/24 01:29PM, Bart Van Assche wrote:
>Move a statement that occurs in both branches of an if-statement in front
>of the if-statement. Fix a typo in a source code comment. No functionality
>has been changed.
>
>Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>Cc: Christoph Hellwig <hch@lst.de>
>Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>---

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------lzW.cJR_-6sCvQYD.lREqa.H-32Z9TKwpDxBjmCjs3VZTSBT=_808fc_
Content-Type: text/plain; charset="utf-8"


------lzW.cJR_-6sCvQYD.lREqa.H-32Z9TKwpDxBjmCjs3VZTSBT=_808fc_--
