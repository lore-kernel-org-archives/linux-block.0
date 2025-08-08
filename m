Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03464191F89
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658086; cv=none; b=Ta3PKWWMl6Q3d5oqs2XZAinU2xo4QCbac3yyoCbFxZUotDer4PnGvgOaQUoWhvP9Q2pBkd1Q0gVmF4zfyHtL29BYnhCsODVqvskOUsmpenPjN3WUFdsnXghNX32YXMHynJqo6RLfFWsRuCuNEURaqRoyuHy7LsMKOuYpCXDkAl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658086; c=relaxed/simple;
	bh=SUH8Tye8GBJ15oIsoIQnFWbAKSe/T59xk0zdcbiXgXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=iJrarx9Y8bjwGnCxYg4oFWvYBvDge4bA6atwOw7ujEIDkgvefiko2CP+Uf9F0c7oOgYwH5gC3cCOSKuYM0/QCxViYQ5LF6+TtOqY/gl4dYH/R4uHoOaRs2zBDPNBKxtrRdTQSIvyUi/YSxyNkDTr6GUReLxuq7IQ3xeBbTQsMcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=l5C0E9Pt; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l5C0E9Pt"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250808130120epoutp0185081163ce77d1ff8f31533e516999e1~ZzDphPWAl3214532145epoutp01g
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 13:01:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250808130120epoutp0185081163ce77d1ff8f31533e516999e1~ZzDphPWAl3214532145epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754658080;
	bh=V7H/HNtK+WIhQZTcATGbOZGAlBvU9iv0q0dlKuaen/w=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=l5C0E9PtjXe1LQUXEXQa1MtmvvcMbA5XCfXpfvLroNuu06gTzt8IlFOqJvjSaPFN7
	 HooffEdjm2kj7AHtnNBHQOE+PbZ0PJcnEGUIm3Gjj3khYRTJBuXc+7PoOk3wH3rK2r
	 9uRcndPKNbqrQtqwCZ/epcCnU1wDPzBLSI3/sIY0=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250808130120epcas5p1177d920a8f2a241a76345c9ce5278b2f~ZzDpIX2Sf2491424914epcas5p17;
	Fri,  8 Aug 2025 13:01:20 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.88]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bz40b62XSz6B9m5; Fri,  8 Aug
	2025 13:01:19 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250808130119epcas5p18dc676ac009d3032576412d4953c01bd~ZzDoGp0pF0628606286epcas5p1c;
	Fri,  8 Aug 2025 13:01:19 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250808130118epsmtip2fd0788518b2f1fa0c99f0395f71c36a8~ZzDnROCGJ1102111021epsmtip2F;
	Fri,  8 Aug 2025 13:01:18 +0000 (GMT)
Message-ID: <94414f36-ea73-4f36-ada7-684b4fe36506@samsung.com>
Date: Fri, 8 Aug 2025 18:31:17 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 8/8] nvme-pci: convert metadata mapping to dma iter
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250731150513.220395-9-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250808130119epcas5p18dc676ac009d3032576412d4953c01bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250731150532epcas5p19499d1438d1910bcac513cc085456f2c
References: <20250731150513.220395-1-kbusch@meta.com>
	<CGME20250731150532epcas5p19499d1438d1910bcac513cc085456f2c@epcas5p1.samsung.com>
	<20250731150513.220395-9-kbusch@meta.com>

On 7/31/2025 8:35 PM, Keith Busch wrote:
> @@ -1120,7 +1157,6 @@ static blk_status_t nvme_prep_rq(struct request *req)
>   	iod->flags = 0;
>   	iod->nr_descriptors = 0;
>   	iod->total_len = 0;
> -	iod->meta_sgt.nents = 0;

This is missing "iod->meta_total_len = 0;" here.
