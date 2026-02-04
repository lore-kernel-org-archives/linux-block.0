Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95462BD012
	for <linux-block@vger.kernel.org>; Wed,  4 Feb 2026 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219055; cv=none; b=cnCpTPS/ae6NiI5RpmvaElYrNxV1cGOtR6DbcV1h1RS7XJ/3yN97tzb2E+kTXTeP39ILk/F7F4cGsmOgkzUBA9SBS5R3uwsVM3Yxwpw6NWxFpXfNFNdXkMQDp1JpdlrSGrzB8VSDfU1NkeIX0WIrMQNMTKIo5vZT+InnFCFTvfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219055; c=relaxed/simple;
	bh=a7OAGpPMyyu4loh7iMCRQAaawYutoxtkzlPkls7sOMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=FinvwtWvCgEU5YA426WaiSmm1018/1LkJ83oB1xZEnQxlom2bZk8o40a51ylaDh8H+BH1O9NnC3PoX5+iryLNs+1JuFOKNjG/0ccIKjYa0AwxRH7drK+WLR+DPt+5g4OJnsz5fF0VoN94YSHZ50HKmCN6+PCBXmb2r/g9mWP/Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=i0cYTe7l; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i0cYTe7l"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260204153052epoutp022c47249d9ba587fb8bb5da4006637f8c~RFNmC85hP2649026490epoutp02z
	for <linux-block@vger.kernel.org>; Wed,  4 Feb 2026 15:30:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260204153052epoutp022c47249d9ba587fb8bb5da4006637f8c~RFNmC85hP2649026490epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770219053;
	bh=GMZkkwt+ygUc95YJRehpOJ9rDzYC29QaYgbwGeEI8Ug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i0cYTe7lQkN7aGv58NQgjHPtUvuHT+JX3mAt19E3Y83yRgGckZc9FfmXCOTcv38ND
	 Me2yK0JIjdDdfHzWZdiDgTZssJudS2tncWvp/JQtVj8RGnJ3e80Hgm1e9eGk5fT6Hj
	 W8vHYvibHO7mYSbxNp8l7/podEfvyPtyuEjRM1Bs=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260204153052epcas5p2a5dd889761fbbe0da0188d4f55423645~RFNlpYRUi0658106581epcas5p23;
	Wed,  4 Feb 2026 15:30:52 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4f5kp34KGfz2SSKX; Wed,  4 Feb
	2026 15:30:51 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260204153051epcas5p1c2efd01ef32883680fed2541f9fca6c2~RFNkOnJ8g2260322603epcas5p16;
	Wed,  4 Feb 2026 15:30:51 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260204153049epsmtip22ed4d2525789b012deef6b6b5c76c314~RFNii_-zk3140331403epsmtip2K;
	Wed,  4 Feb 2026 15:30:48 +0000 (GMT)
Date: Wed, 4 Feb 2026 20:56:34 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christian
	=?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Christoph Hellwig
	<hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
Message-ID: <20260204152634.gyybb2axszwpewrk@green245.gost>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
X-CMS-MailID: 20260204153051epcas5p1c2efd01ef32883680fed2541f9fca6c2
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_150a72_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260204153051epcas5p1c2efd01ef32883680fed2541f9fca6c2
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
	<CGME20260204153051epcas5p1c2efd01ef32883680fed2541f9fca6c2@epcas5p1.samsung.com>

------dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_150a72_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 03/02/26 02:29PM, Pavel Begunkov wrote:
>Good day everyone,
>
>dma-buf is a powerful abstraction for managing buffers and DMA mappings,
>and there is growing interest in extending it to the read/write path to
>enable device-to-device transfers without bouncing data through system
>memory. I was encouraged to submit it to LSF/MM/BPF as that might be
>useful to mull over details and what capabilities and features people
>may need.
>
>The proposal consists of two parts. The first is a small in-kernel
>framework that allows a dma-buf to be registered against a given file
>and returns an object representing a DMA mapping. The actual mapping
>creation is delegated to the target subsystem (e.g. NVMe). This
>abstraction centralises request accounting, mapping management, dynamic
>recreation, etc. The resulting mapping object is passed through the I/O
>stack via a new iov_iter type.
>
>As for the user API, a dma-buf is installed as an io_uring registered
>buffer for a specific file. Once registered, the buffer can be used by
>read / write io_uring requests as normal. io_uring will enforce that the
>buffer is only used with "compatible files", which is for now restricted
>to the target registration file, but will be expanded in the future.
>Notably, io_uring is a consumer of the framework rather than a
>dependency, and the infrastructure can be reused.
>
We have been following the series, its interesting from couple of angles,
- IOPS wise we see a major improvement especially for IOMMU
- Series provides a way to do p2pdma to accelerator memory

Here are few topics which I am looking into specifically,
- Right now the series uses a PRP list. We need a good way to keep the
   sg_table info around and decide on‑the‑fly whether to expose the buffer
   as a PRP list or an SG list, depending on the I/O size.
- Possibility of futher optimization for new type of iov iter to reduce
   per IO cost

Thanks,
Nitesh

------dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_150a72_
Content-Type: text/plain; charset="utf-8"


------dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_150a72_--
