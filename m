Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445E71E520A
	for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753858371; cv=none; b=Ep4MIS7qkV7rwz9kwXXFNgB5g2r5DTV95hhzRLg6Jt7Ptn+qfQ61Iq3TiYqWpHlYX36T+J1Pxl4uhE64nmj/XfqqNdPBCrGM6IUZkIumBkYgGQdkLOc7Yz1//vJjY0nZolGTbXD45f1i9MsdHir3qQAmLJKcGAk0l6YBtePbZgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753858371; c=relaxed/simple;
	bh=j/z2j30d8C5e2ZnMvAlC/HdA2ADeZLA/zCIn4f13q6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=QopHGEnvxhcE4eESf2GJNA01mLgE6GHOY6mUcLmExl3Y4zp/gsanzVHGKGO6QRcvudATfavD55htpEkGesUui23qcEo0PSNn/9SUM7d3Pn1iuyF4u3OqzkKuFxu+Wbt3dWck3KpLr/Xh7B6ft36/7j6sbEvpkxJfTkp19btkogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=m03oskIS; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m03oskIS"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250730065244epoutp02e7faac4504368c135c23b5086983c13d~W9OP-SJlP0274002740epoutp02k
	for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 06:52:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250730065244epoutp02e7faac4504368c135c23b5086983c13d~W9OP-SJlP0274002740epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753858365;
	bh=wCAvDXDelKt6cfEkBOtN1pGCZsc+ckqH5BOvF+vS/88=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=m03oskISCQSfZyTDk5FUTra8Oa1Ojx0QBCqv7roEI0m7if/CxY2mg4nxZ0jPd7Gh4
	 lCl6LMblt6/kRt+OCPnG3Et4F/qXMs5aSFEUiBurPFWnocOJCXAvOgemm9Qn4VZ+XT
	 0AB7JB38uHxE76RorrVA+oCbV0Akqdm7QGJM2mgo=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250730065244epcas5p16535b56a459c7e04df9452aa5051e495~W9OPmQ7ME0097500975epcas5p1t;
	Wed, 30 Jul 2025 06:52:44 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.86]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bsNFS0yn7z2SSKn; Wed, 30 Jul
	2025 06:52:44 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250730065243epcas5p3750a9faae68daf85b1259ed2cbf0926f~W9OOdDWyt2796927969epcas5p3z;
	Wed, 30 Jul 2025 06:52:43 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250730065242epsmtip2fa26c948125d1721c0ff4b363b1da96e~W9ONe8Zme0229502295epsmtip2Y;
	Wed, 30 Jul 2025 06:52:42 +0000 (GMT)
Message-ID: <8b32b82b-095f-4f2c-9a21-b4cbbbca52c7@samsung.com>
Date: Wed, 30 Jul 2025 12:22:41 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/7] blk-mq: introduce blk_map_iter
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de
Cc: axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250729143442.2586575-2-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250730065243epcas5p3750a9faae68daf85b1259ed2cbf0926f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729143518epcas5p2938dfecb7c1596adfa1802d46c75a75a
References: <20250729143442.2586575-1-kbusch@meta.com>
	<CGME20250729143518epcas5p2938dfecb7c1596adfa1802d46c75a75a@epcas5p2.samsung.com>
	<20250729143442.2586575-2-kbusch@meta.com>

On 7/29/2025 8:04 PM, Keith Busch wrote:
> -	iter->addr = dma_map_page(dma_dev, phys_to_page(vec->paddr),
> -			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
> -	if (dma_mapping_error(dma_dev, iter->addr)) {
> +	iter->addr = dma_map_page(dma_dev, phys_to_page(iter->iter.paddr),
> +			offset_in_page(iter->iter.paddr), iter->iter.len,
> +			rq_dma_dir(req));
> +	if (dma_mapping_error(dma_dev, iter->iter.paddr)) {

This should be
dma_mapping_error(dma_dev, iter->addr).
