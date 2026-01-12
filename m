Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9182926F2AD
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228364; cv=none; b=RwKN6dgVKN1vU3TtraUQigFdRVLMMeQmLMSxpa1eeLV+9Y7LEgH4LmSHtn6voJJVxYNiN5pjLlbcYBzE/qKtQHyQonJPkEa/ZJKJe8DsNKBTQAJKOvD1AC2RwHq8888VBS9niDJm/W0uMJiWmbwabwDrWwhX7jw0Hs5Gd10j8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228364; c=relaxed/simple;
	bh=80JCxSWd4tGHwgMhbnqw9IUCD6SydYhXdbhu97ynvfc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=ktz2ucTHdwPdxVrVJ8scZ1rvuBjkkn8JbZzgob0NRmsz2yupi1hvYrg5rZr81aZ3sOkjKhNUoVX/tyoKg3A+5JcUPUsNZvzlMF2HaXS6GDBNQy8NjTuFdhMV/wHrByW5KqsWTiPifYd8Kig2Yy17kzSxAMW2E3/vbasGwg7K1fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TE+/aWU0; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TE+/aWU0"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260112143240epoutp033ecd1c3deb05f3239a23d6be4b013d68~KAlM9CBNa1471814718epoutp03N
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 14:32:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260112143240epoutp033ecd1c3deb05f3239a23d6be4b013d68~KAlM9CBNa1471814718epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768228360;
	bh=4+CiaHJqMjjQE9Phb31KzcMHXN//1jSymEg2oeDr9k8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TE+/aWU0C+Qy9VRS4U+q6pL6iSFzIiY7KLv2/MErs/fO7OkAitpvRS7Ebut/pvikT
	 YUe/NqFhojX8M9jRnFvVJDwCNfjm4lmREj6T+Rf1Co3irHycj1kY7Q6IQ6LoXKfa8q
	 jRJiHUvtpvkahi6JLiEBTvxrdWV0jVY91wzUmMGo=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260112143239epcas5p3d89bf9b66b9b9627170c58a4666a70b9~KAlMDhBBA2096120961epcas5p3d;
	Mon, 12 Jan 2026 14:32:39 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.92]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4dqZbV44dGz6B9m4; Mon, 12 Jan
	2026 14:32:38 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260112143237epcas5p3e58114246f9601703c0a45f6a31fccf7~KAlKMs1sE2096120961epcas5p3c;
	Mon, 12 Jan 2026 14:32:37 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260112143229epsmtip221775e9f44a307dd420588ee9a0c43d6~KAlC4youa1619516195epsmtip2V;
	Mon, 12 Jan 2026 14:32:28 +0000 (GMT)
Date: Mon, 12 Jan 2026 19:58:22 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
	Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	nitheshshetty@gmail.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: blk_rq_dma_map_iter_next is no longer using
 iova state
Message-ID: <20260112142822.tk34ei4evgypw3qv@green245.gost>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5b07dbce-2644-4079-a768-9167cbe3e25a@kernel.org>
X-CMS-MailID: 20260112143237epcas5p3e58114246f9601703c0a45f6a31fccf7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----IrfruICR4kMULzJWPGPqiSt5VhS9eUGYkVmPB-DHhmy0YhYM=_eeb6b_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260112140208epcas5p4c3ef0209b01be379c836f705a10efa7d
References: <20260112135736.1982406-1-nj.shetty@samsung.com>
	<CGME20260112140208epcas5p4c3ef0209b01be379c836f705a10efa7d@epcas5p4.samsung.com>
	<20260112135736.1982406-2-nj.shetty@samsung.com>
	<5b07dbce-2644-4079-a768-9167cbe3e25a@kernel.org>

------IrfruICR4kMULzJWPGPqiSt5VhS9eUGYkVmPB-DHhmy0YhYM=_eeb6b_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 12/01/26 03:08PM, Damien Le Moal wrote:
>On 1/12/26 14:57, Nitesh Shetty wrote:
>> DMA IOVA state is not used inside blk_rq_dma_map_iter_next
>>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> ---
>>  drivers/nvme/host/pci.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 3b528369f5454..065555576d2f9 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -823,7 +823,7 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>>
>>  	if (iter->len)
>>  		return true;
>> -	if (!blk_rq_dma_map_iter_next(req, dma_dev, &iod->dma_state, iter))
>> +	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
>
>Hu... Why is this not squashed with the previous patch ? If only patch 1 is
>applied, this will not compile, right ?
>
I couldn’t decide whether to use the layering convention or a unified patch,
so I chose one patch per layer.
Agreed, independently this doesn't compile, merging make sense.
I will resend.

Thanks,
Nitesh

------IrfruICR4kMULzJWPGPqiSt5VhS9eUGYkVmPB-DHhmy0YhYM=_eeb6b_
Content-Type: text/plain; charset="utf-8"


------IrfruICR4kMULzJWPGPqiSt5VhS9eUGYkVmPB-DHhmy0YhYM=_eeb6b_--
