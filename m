Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23873FB1C
	for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354969; cv=none; b=A+tkqTd5sEWT+Hnnt7m0BvamggGj80ALVLqSHhpHuedlwD3dYdD0BC1TU1E5ckbF9301OTncs9wP2fMK8fruO5IeibZFktHeesR+IEpgI1Oz9FChr8UrznoJgqCXWTLLTTFrqtisohgpLuxEdKObln1jrcsfNr3LPISgIGYO3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354969; c=relaxed/simple;
	bh=Oxo1W9kG5RAbASm7DxJnevbhEVs13vlP7Lc5m7JZAgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:From:In-Reply-To:
	 Content-Type:References; b=QyXTn7J0smPOdh/rFPJu4no+HPgSlkGQLfUN0Q5jMR3EESrYUNiSohJRa3yRSWdG162l1vcg5/ZyqHJAmMHhoBDy6RQ7I8RL9MP5fgq78xagNkBHsH0Iy5UtbQqcd86kMeangsL114CP883x3+a8/O+mqsWjNXZ6T8yVF3JBxDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J5qFpRZS; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J5qFpRZS"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240313183604euoutp01f0ea351ef7d581986b9c6f0c377a3ccf~8ZsdRHAvW1265612656euoutp01W
	for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 18:36:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240313183604euoutp01f0ea351ef7d581986b9c6f0c377a3ccf~8ZsdRHAvW1265612656euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710354964;
	bh=/2K/PfDapXMcYwANgzoSU7yzxe6lrOxJb/DPgHQO6DM=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=J5qFpRZSCExIerPAIDvGqNVK1+dpk5r07bXMQqGqzyJxjJ+TKvtS8jPhiyvrp2ySS
	 9pVpbl3orfqmB8gd15OjQhHEMmpL9kx/4ZhM/Way9DIVd7jQl6oE/Ar9t9g01co0RF
	 UYj67UkltxzbH1eXMhQwP9nFdhLlg3jTwUPcxlT8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240313183604eucas1p1b5fd989c953e8377aa55adc4f926a497~8Zscv5yoD2778227782eucas1p11;
	Wed, 13 Mar 2024 18:36:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id CC.07.09814.412F1F56; Wed, 13
	Mar 2024 18:36:04 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240313183603eucas1p240cbaaabe7f9a1fcabb9ecb3b92abb48~8Zsb_sjgB2578925789eucas1p2C;
	Wed, 13 Mar 2024 18:36:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240313183603eusmtrp266d0e40807264b81d427bd1d8f3d738a~8Zsb_MEZm0572005720eusmtrp2W;
	Wed, 13 Mar 2024 18:36:03 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-78-65f1f214b21b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 25.A8.10702.312F1F56; Wed, 13
	Mar 2024 18:36:03 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240313183603eusmtip28228bf0829446b94c20a892901a286d7~8ZsbxxdH83064030640eusmtip2G;
	Wed, 13 Mar 2024 18:36:03 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.247) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 13 Mar 2024 18:36:02 +0000
Message-ID: <4605ebb7-2fcf-4570-b849-7aaa80a21954@samsung.com>
Date: Wed, 13 Mar 2024 19:36:01 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brd in a memdesc world
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	<linux-block@vger.kernel.org>, Tetsuo Handa
	<penguin-kernel@i-love.sakura.ne.jp>, Hannes Reinecke <hare@suse.de>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZfHwXLr54bWl1fns@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djP87oinz6mGtz5zGqx+m4/m8WeRZOY
	LFauPspksfeWtsXslnesFr9/zGFzYPPYuXYVk8fmFVoel8+Weuy+2cDmsfl0tcfnTXIBbFFc
	NimpOZllqUX6dglcGScPnGQqeMBZsWndFcYGxqvsXYycHBICJhIrtpwHsrk4hARWMEo8//+Y
	FcL5wihxoWURG4TzmVHi+P4pLDAt6y8sYoRILGeUmLfhIiNc1bn2xawgVUICuxklpt9L6WLk
	4OAVsJM40qwJEmYRUJVYPu0sE4jNKyAocXLmE7ChogLyEvdvzQC7SVhAWaKhaTEbiM0sIC5x
	68l8JpAxIgIaEm+2GIGsYhbYxiixY8NPFpA4m4CWRGMnWCsn0G29T7ZBtWpKtG7/zQ5hy0ts
	fzuHGeJ+ZYnTRxczQti1Eqe23GICmSkh0Mwp8e3+CyaIhIvE8k3voWEkLPHq+BYoW0bi/875
	UDXVEk9v/GaGaG5hlOjfuZ4N5CAJAWuJvjM5EDWOEvOuHYEK80nceCsIcQ+fxKRt05knMKrO
	QgqJWUg+noXkhVlIXljAyLKKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMPmc/nf8yw7G
	5a8+6h1iZOJgPMQowcGsJMJbp/gxVYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBAemJJ
	anZqakFqEUyWiYNTqoEpZv6GGo6WKY57zFYs6e2ySrim1OTceKyDt+3w90LJuOafSy0C7xmf
	TzoY9O9EVP/lB/cf3DtrZO5VqZDxwbpI6uDU5s0WsfvuJ8tZJ5t/8ZsTxKUh5OzBFs9qaJ2d
	eJ0nuTbNk+9V6+YV3I5LrsZ/b2NbFhQUbHpIgH2FL59m6QOuDLk9wgU6Z1SulF9Zy6SeUTWt
	6H9Hd9FB/xCDMw6ajA9e6LHvePtnuuLUm5WrYncZJGodnOP+JDbJ9q667b8sUamZustvMmt/
	i7vfcHTiiXWWmfI7f+1da6xufuK5q2Og5LPsY+b2Ww0frU5cc0Sdt+bKO+13HxcrO0SoXNzJ
	MH3N5a36J1ZJXzlpFq3EUpyRaKjFXFScCACW2HMlrQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xe7rCnz6mGky+yW+x+m4/m8WeRZOY
	LFauPspksfeWtsXslnesFr9/zGFzYPPYuXYVk8fmFVoel8+Weuy+2cDmsfl0tcfnTXIBbFF6
	NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GScPnGQq
	eMBZsWndFcYGxqvsXYycHBICJhLrLyxi7GLk4hASWMooMfX0d1aIhIzExi9XoWxhiT/Xutgg
	ij4ySkyc2M0CkhAS2M0ocXO1eBcjBwevgJ3EkWZNkDCLgKrE8mlnmUBsXgFBiZMzn4CViwrI
	S9y/NQNssbCAskRD02I2EJtZQFzi1pP5TCBjRAQ0JN5sMQJZxSywjVFix4afLBB7nzFK3Dvf
	zQxSxCagJdHYCTaHE+iB3ifboOZoSrRu/80OYctLbH87hxnifmWJ00cXM0LYtRKf/z5jnMAo
	OgvJebOQnDELyahZSEYtYGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERiz24793LKDceWr
	j3qHGJk4GA8xSnAwK4nw1il+TBXiTUmsrEotyo8vKs1JLT7EaAoMo4nMUqLJ+cCkkVcSb2hm
	YGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwFRw4IdG6qkjDWLrWGeeORy3
	Uv/PvB9fpZXdqoRq7025v2BBX2qugvfSe9EOeYv2huk4nmx0Uf65xvBqbJaN+pmvrxI3qFfE
	bZy85dashTu+ZvC7H1NbufT6o8V2yUsMAnyje4+4KKw0+Jt/fcsc30m8Nq+nP+Fc+r+59+VR
	lnNWLjdcPh/ZMiVoYqJjSNz2IwEb9Nd8kI785O2lH6jJJXKjIXN5nhXrjjWVIp/m5uRn7fmk
	6XzsMP/SJfLn+TQ3GPHxVDSpJ4ne8dy/Q4lnrYy6WdLNd11t74T82z5O72AL6I3J81dab/z2
	imtrrlPwLffc1ecu5nBY/L+bGqcUvPLi56Xxv/bmVGaVWXWwf1RiKc5INNRiLipOBAAQAqkT
	YgMAAA==
X-CMS-MailID: 20240313183603eucas1p240cbaaabe7f9a1fcabb9ecb3b92abb48
X-Msg-Generator: CA
X-RootMTR: 20240312174020eucas1p29cf41360c934c674fd1f36a808078e25
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240312174020eucas1p29cf41360c934c674fd1f36a808078e25
References: <CGME20240312174020eucas1p29cf41360c934c674fd1f36a808078e25@eucas1p2.samsung.com>
	<ZfCTfa9gfZwnCie0@casper.infradead.org>
	<d470e16b-b7bf-451e-a6e2-eb68adcc2635@samsung.com>
	<ZfHwXLr54bWl1fns@casper.infradead.org>


>>> Currently brd uses page->index as a debugging check.  In the memdesc
>>> future, struct page has no members (you could store a small amount of
>>> information in it, but I'm not willing to commit to more than a few bits).
>>>
>>
>> Shouldn't we change brd to use folios? Once we do that, this will not
>> be a problem any more right?
> 
> We certainly could change brd to use folios.  But why would we want to?
> Hannes' work always allocates memory of a fixed size (a fixed multiple
> of PAGE_SIZE).  Folios are a medium-weight data structure (probably
> about 80 bytes once we get to memdescs).  They support a lot of things,
> eg belonging to an inode, having an index, being mappable to userspace,
> being lockable, accountable to memcgs, allowing extra private data,
> knowing their own size, ...
> 

Got it! Probably moving to folios just for the sake of retaining the
debugging checks is not enough.

> None of those things are needed for brd's uses.  All brd needs is to
> be able to allocate, kmap and free chunks of memory.  Unless there are
> plans to do more than this.
> 

I remember he mentioned he wanted to support bigger logical block sizes
in brd, in which case moving to folios might be justified.
