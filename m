Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C62E36F9
	for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753877745; cv=none; b=RddDlwBhmgJCJXOR2fNyG8lH8zfWbGoksZAzjrtz2i/1RkkZzbinVaSJc+XmvoWzMUKVlSC0X4KeJAUYiuzCOhuMC5hBAc+r94+FEtMX6OxQgXTQDYXAoKd1RKLY8wSH7zlrMC+t7PAhT+NDBIvRcK/apT72BkUtibQ1lH7bo0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753877745; c=relaxed/simple;
	bh=nz4Aand+QjGz56SDFUW+Fb/Rrtuv9kwU64uC6F8Pcbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=nN06QjuG3qqwXlxW7SemBARzwwJEkOih/3gq8m+s8YMx4+qM3EsYm8TH4Y0HHwJJXpsdEvykDTMPaMv2HZomiac2+OApg00Z3YekbtIc744pmFp1Szf3DPVkmRWNYg5qEkJu/zuQLxQVa6F3Jl42Z80oUei23X+NGuuOqmxKl7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qP7REYz9; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qP7REYz9"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250730121534epoutp04f0c3c720ce492e54eefb58598f752983~XBoHrIOUD1161711617epoutp04B
	for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 12:15:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250730121534epoutp04f0c3c720ce492e54eefb58598f752983~XBoHrIOUD1161711617epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753877734;
	bh=+o/Oy6jtgxZb3IL0OaqxJLg6PLHtyWlpbSff0V6zpGM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=qP7REYz9dUcULt2Gdr/rPbcOO/HNMfn8jz22UMppStbahkTATTN16pyUJu0zAN89Y
	 TIlBEaYcEu+8bMQ/9ydpMKHiAW39hJXNIMqKls3rziyePD2opLodNVpCq646+prtl+
	 R2FjrrI7PKeNl2eJo20CpBGA9K0L+cCC24RyxFkE=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250730121530epcas5p3b584c5800e3f7937d191cc8a1114d7f1~XBoD7ItNs1519315193epcas5p3h;
	Wed, 30 Jul 2025 12:15:30 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.90]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bsWPs6brsz6B9mB; Wed, 30 Jul
	2025 12:15:29 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250730121529epcas5p18aee87528590191ece2ea8b16c52cec0~XBoCe1GV41597315973epcas5p1Y;
	Wed, 30 Jul 2025 12:15:29 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250730121528epsmtip2d4fd37c43f25c1d24c5019bea427bd9a~XBoBiEmX10734707347epsmtip2P;
	Wed, 30 Jul 2025 12:15:28 +0000 (GMT)
Message-ID: <8a4e7512-a997-4ff1-b465-2597bc6fa778@samsung.com>
Date: Wed, 30 Jul 2025 17:45:27 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/7] blk-mq-dma: provide the bio_vec list being
 iterated
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de
Cc: axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250729143442.2586575-3-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250730121529epcas5p18aee87528590191ece2ea8b16c52cec0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729143610epcas5p12a897510ef6da6563d32c7a41ed21659
References: <20250729143442.2586575-1-kbusch@meta.com>
	<CGME20250729143610epcas5p12a897510ef6da6563d32c7a41ed21659@epcas5p1.samsung.com>
	<20250729143442.2586575-3-kbusch@meta.com>

On 7/29/2025 8:04 PM, Keith Busch wrote:
> @@ -151,6 +146,11 @@ bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
>   	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
>   	iter->status = BLK_STS_OK;
>   
> +	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
> +		iter->iter.bvec = &req->special_vec;

I am not certain yet, but thinking whether this is enough to handle 
RQF_SPECIAL_PAYLOAD correctly.
Maybe "req->special_vec.bv_len" also need to be included here to 
initialize the iter.
