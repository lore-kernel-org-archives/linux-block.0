Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2743F3093CF
	for <linux-block@vger.kernel.org>; Mon,  9 Feb 2026 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630870; cv=none; b=AKqf4mCrYuOcAGYo6UtQ5Jr6skgf/QhkeKxXT3IuAbGArXdQUps7jOWYQV61Co4GwxNElDC8OhdVyCgIPVTRoawuymDwZhneYYGRLwqiZCMHFZUY1GS6rKdxQi5zqLxxB5U4YiCGX2kw/qnToXWncHe1LVf8E6de+Qz/a33/P5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630870; c=relaxed/simple;
	bh=bM4Q0T/lQqNhx8/mZLpF6GTin6XpABbPyp4hevey6IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=qgVgSgihnL3wr5VkYICqvHJr7PPUa8+BZB11C6kTpyKkmvehmOuO2/Sk51kUV9rWpUcESEK5svV0H+E11tWSBWZ5AMc+J+SuBC9lKas7xO81jDobhQSE82KoO2AtQqs/XSWcYHgSWyo1wXkK8y/HiQW8ltgkilD9gl1TmLhGZC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Gsm8wXDd; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Gsm8wXDd"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260209095420epoutp0266d2bbd81e1e37ab29d115a33b1fb70c~Si2L_dxCN3091930919epoutp02P
	for <linux-block@vger.kernel.org>; Mon,  9 Feb 2026 09:54:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260209095420epoutp0266d2bbd81e1e37ab29d115a33b1fb70c~Si2L_dxCN3091930919epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770630860;
	bh=eXWcvTSLW12Fg5ug1AJXh6M1M2KJGmAD1nYmXUDNb8g=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Gsm8wXDdEO3GtT6H1CjwZrk0xzM6uURpZzflkgCUlGNdkMeDkqr2Olijcq+E8ZDGg
	 Q74E2V0G26F/7Dmxs0t5OQC5NMYXcaTvHYcW8MKdLr7IFcJrVD2OYn16lrsDo0AtsC
	 HAipOAblj/HGxUglwtG06S9U0JmztQPP9pxo5FD0=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260209095420epcas5p4ffe39a127437ec7dc55b654af6aa3c75~Si2LeUyQB1174511745epcas5p4R;
	Mon,  9 Feb 2026 09:54:20 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.88]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4f8g5N4bw9z2SSKb; Mon,  9 Feb
	2026 09:54:16 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260209095416epcas5p2503e4351e65e74189470ece4806f1066~Si2Hs-yj92877528775epcas5p2Q;
	Mon,  9 Feb 2026 09:54:16 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260209095414epsmtip27494fb2762a11dc60e7df19d1674a2a9~Si2GVTHcC2191421914epsmtip2i;
	Mon,  9 Feb 2026 09:54:14 +0000 (GMT)
Message-ID: <4068f00e-e84e-49b2-b1ac-72180ba19558@samsung.com>
Date: Mon, 9 Feb 2026 15:24:13 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: Jason Gunthorpe <jgg@nvidia.com>, Pavel Begunkov
	<asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Christoph
	Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>, Nitesh Shetty
	<nj.shetty@samsung.com>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260206152041.GA1874040@nvidia.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260209095416epcas5p2503e4351e65e74189470ece4806f1066
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260206152216epcas5p293f71122593a41954f8a92bff170202e
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
	<20260205174135.GA444713@nvidia.com>
	<dbcc2912-e1df-491d-b1e0-7812279297de@gmail.com>
	<20260205235647.GA4177530@nvidia.com>
	<3281a845-a1b8-468c-a528-b9f6003cddea@gmail.com>
	<CGME20260206152216epcas5p293f71122593a41954f8a92bff170202e@epcas5p2.samsung.com>
	<20260206152041.GA1874040@nvidia.com>

On 2/6/2026 8:50 PM, Jason Gunthorpe wrote:
>> I'm actually curious, is there a way to somehow create a
>> MEMORY_DEVICE_PCI_P2PDMA mapping out of a random dma-buf?
> No. The driver owning the P2P MMIO has to do this during its probe and
> then it has to provide a VMA with normal pages so GUP works. This is
> usally not hard on the exporting driver side.
> 
> It costs some memory but then everything works naturally in the IO
> stack.
> 
> Your project is interesting and would be a nice improvement, but I
> also don't entirely understand why you are bothering when the P2PDMA
> solution is already fully there ready to go... Is something preventing
> you from creating the P2PDMA pages for your exporting driver?

The exporter driver may have opted out of the P2PDMA struct page path
(MEMORY_DEVICE_PCI_P2PDMA route). This maybe a design choice to avoid
the system RAM overhead.
As an example, for a H100 GPU with 80 GB of VRAM and a 4 KB system page
size: we would need ~20 million entries, and with each 'struct page' as
64 bytes in size, this would amount to extra ~1.2 GB of RAM tax.

At this point, the series does not introduce any change on the
exporter side and that is a good thing. No?
