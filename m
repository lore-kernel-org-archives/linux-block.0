Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12F261698
	for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350134; cv=none; b=mbtfqqwP1vcgNYFMKPor7TXSiSrOAgEoeM701A9NEXZU2l9NUsaSfUXGF2vov5Zrxqb3uZLl9U/0QEIUp1dEfpt6aE4A73T2PjtHJtvrrs621ys6vLGpoN8nhMnZg2Q3u5jnIbUcAsdYQb/ZjO4AQBU2lQbAV4B9AIdLvUOO204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350134; c=relaxed/simple;
	bh=GnoDEdx3duwzKm80ef4ZGzZh9eFZFoFWxuuBWBE4yGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:From:In-Reply-To:
	 Content-Type:References; b=phEHBg9HTjFSTj0mEE6rftbZ7KPXWXxcCLPHXO+ql49jI6KkfRnB5Rjko7jUvqmKdOygCXPS2vyGJLPcjTXILubSymhC/1UXOv09aznBAc7R2wVzsGitKuh7WlcRMfShFYlh3x/aky6DjuKeobx1XzyBIAq6NFBWjQ9y19+sErs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WrfWlzMT; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WrfWlzMT"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240313171529euoutp010734899237df93a29718744700251440~8YmGRAWn40192001920euoutp01T
	for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 17:15:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240313171529euoutp010734899237df93a29718744700251440~8YmGRAWn40192001920euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710350129;
	bh=12O86wO0oziCQOquqgyW9NjX+5K6brlzpnUWyCjHv/g=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=WrfWlzMTdzNlQ2gB4kzvMtuHl+638C0SV8zHoKn+oTWsNvT7UaqUV/hnUN0iGzCs5
	 TmAVp/NnH88S3TU8FiBgD9VDPgle02YD87WzfjqW6VkjQGa76WbsQVZLj5dltJNJOT
	 I4Wpdx4JdWAJWGLpgfkKN86axSKf5FR0DIjqfsNY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240313171529eucas1p2f92ae84db3ce19d27bdfc6e957425fbc~8YmF9yvPd0210702107eucas1p2i;
	Wed, 13 Mar 2024 17:15:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 3E.BD.09552.13FD1F56; Wed, 13
	Mar 2024 17:15:29 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240313171529eucas1p11c4328a3466d3a4061c81bc21f3b3938~8YmFqMa2F0255502555eucas1p1-;
	Wed, 13 Mar 2024 17:15:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240313171529eusmtrp2a7426d5903f9f6ac42945e1b93c1baea~8YmFprEUe2161321613eusmtrp2T;
	Wed, 13 Mar 2024 17:15:29 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-28-65f1df31c9d4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id E2.94.10702.03FD1F56; Wed, 13
	Mar 2024 17:15:28 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240313171528eusmtip2583200517ce30a12b7e104737f3a2941~8YmFc0jUC2303523035eusmtip21;
	Wed, 13 Mar 2024 17:15:28 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.247) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 13 Mar 2024 17:15:27 +0000
Message-ID: <d470e16b-b7bf-451e-a6e2-eb68adcc2635@samsung.com>
Date: Wed, 13 Mar 2024 18:15:26 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brd in a memdesc world
To: Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>
CC: Christoph Hellwig <hch@lst.de>, <linux-block@vger.kernel.org>, Tetsuo
	Handa <penguin-kernel@i-love.sakura.ne.jp>, Hannes Reinecke <hare@suse.de>
Content-Language: en-US
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZfCTfa9gfZwnCie0@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djP87qG9z+mGrzoErBYfbefzWLPoklM
	FitXH2Wy2HtL22J2yztWi98/5rA5sHnsXLuKyWPzCi2Py2dLPXbfbGDz2Hy62uPzJrkAtigu
	m5TUnMyy1CJ9uwSujC+L1zMWHOOuaFq4n7mB8RBnFyMnh4SAicSFM1dYuxi5OIQEVjBK3Pi6
	mwXC+cIoMfXoJXYI5zOjxJUXDawwLU3dh5ggEssZJfq3vGSFq7o39Q5Uy25GiR1317OAtPAK
	2El8Of2HGcRmEVCV+PVoGRNEXFDi5MwnYDWiAvIS92/NYAexhQWUJRqaFrN1MXJwiAi4SdxZ
	YgYSZhaYxijxuzEAwhaXuPVkPhNICZuAlkRjJ1gnJ9Bx207+ZIYo0ZRo3f6bHcKWl9j+dg4z
	xAPKEqePLmaEsGslTm25BfaMhEAzp8SiJ71QRS4SWz99gvpYWOLV8S3sELaMxP+d85kg7GqJ
	pzd+M0M0twBDYud6sJslBKwl+s7kQNQ4Ssy7dgQqzCdx460gxD18EpO2TWeewKg6CykgZiH5
	bBaSF2YheWEBI8sqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwPRz+t/xrzsYV7z6qHeI
	kYmD8RCjBAezkghvneLHVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qinyqUIC6YklqdmpqQWp
	RTBZJg5OqQYm9uNyl37bZZ6115D7vXlu7Gd5j0xpx+OznBiavRZw68ycEae3I0bg0SW77BiP
	70ZtH44+vZMVsCfvvvjzCJlJhSU3D2RFllZ9SSp9OeHtXc/cVW67Y9X9m86cFr5Xw9DGmbGp
	rnTavHDOPZunX3rl1nl0Ocsj7mn5BW8W1T0MnHxY6ElOSKhLVdRGkf17Liz6ymEfYznNZ8af
	a4XbmoRPmehrdvvZpr088Ix/5cTNV86VnrYS+HCiyKX88TK3TEP7vZ7GNm8ZU3eYchYUXV03
	5+i7B20XX9vO7ez+dODPdX3TxT+CTqr4fJ69xbaKpd77/Fmhnx9sxV/PF66auK7r2ANB6Uca
	fmzvtFiabhxzVWIpzkg01GIuKk4EAHus4VquAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xe7oG9z+mGmx8YG6x+m4/m8WeRZOY
	LFauPspksfeWtsXslnesFr9/zGFzYPPYuXYVk8fmFVoel8+Weuy+2cDmsfl0tcfnTXIBbFF6
	NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GV8Wr2cs
	OMZd0bRwP3MD4yHOLkZODgkBE4mm7kNMILaQwFJGiWd3fSDiMhIbv1xlhbCFJf5c62LrYuQC
	qvnIKPFwYQc7hLObUeLx9W+MIFW8AnYSX07/YQaxWQRUJX49WsYEEReUODnzCQuILSogL3H/
	1gx2EFtYQFmioWkx0FQODhEBN4k7S8xAZjILTGOU2NT1jgViQTujxIdvh8DOYBYQl7j1ZD4T
	SAObgJZEYyfYHE6gD7ad/MkMUaIp0br9NzuELS+x/e0cZogPlCVOH13MCGHXSnz++4xxAqPo
	LCTnzUKyYRaSUbOQjFrAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMGq3Hfu5ZQfjylcf
	9Q4xMnEwHmKU4GBWEuGtU/yYKsSbklhZlVqUH19UmpNafIjRFBhGE5mlRJPzgWkjryTe0MzA
	1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBaUN554wAv1siehY32nxV3xUG
	XMzdFB/59/774EqOrbunvs/xMVrQ5P+O54x7WqPq2ZauuuXXLS8eME18IrY9w6f9glxCkOaF
	v8HHTNZvO9y6qKJeTvidzzelU0WyxWf8vuw+PWkJ97W9bQz7FdZtKbqxhfF/ROWcU3en585l
	iQ825VOwWrvD4nP0HU2OaV5yGrXr1qmtXeV/Qy64b92BbVsvzr31JnBu4QRZj6l5EyIDf7UI
	Kp9Z43b/efqmsnlhq2ZlZC8s+MB9bKHkr1NH9ofadtv1cFVvK57We/ma5l0NTvVDncHt97ed
	FTl2XefF94dRSgYs997FbX4fxqi+sGzaycd9oQ86S380cly/KqHEUpyRaKjFXFScCAC+uTVN
	YwMAAA==
X-CMS-MailID: 20240313171529eucas1p11c4328a3466d3a4061c81bc21f3b3938
X-Msg-Generator: CA
X-RootMTR: 20240312174020eucas1p29cf41360c934c674fd1f36a808078e25
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240312174020eucas1p29cf41360c934c674fd1f36a808078e25
References: <CGME20240312174020eucas1p29cf41360c934c674fd1f36a808078e25@eucas1p2.samsung.com>
	<ZfCTfa9gfZwnCie0@casper.infradead.org>

On 12/03/2024 18:40, Matthew Wilcox wrote:
> Hi Jens,
> 
> I'm looking for an architecture-level decision on what the brd driver
> should look like once struct page has been shrunk to a minimal size
> (more detail at https://protect2.fireeye.com/v1/url?k=fdf5d9a0-9c7ecc9a-fdf452ef-74fe4860008a-d5306bf365c2b9b6&q=1&e=cbceae8b-61fb-4e3e-8f7c-6717d9b2431d&u=https%3A%2F%2Fkernelnewbies.org%2FMatthewWilcox%2FMemdescs )
> 
> Currently brd uses page->index as a debugging check.  In the memdesc
> future, struct page has no members (you could store a small amount of
> information in it, but I'm not willing to commit to more than a few bits).
> 

Shouldn't we change brd to use folios? Once we do that, this will not
be a problem any more right?

Hannes even had patches around it long time back [1]

> brd doesn't use anything else from struct page, as far as I can tell.
> It just calls kmap_atomic() / __free_page() / flush_dcache_page() (and
> it doesn't need to call flush_dcache_page() because you can't mmap the
> pages in the brd's array).
> 
> Now if you have plans to, eg, support page migration, you're going to need
> a bit more infrastructure than just allocating pages, but for what you
> have at the moment, just removing the debugging checks that page->index ==
> idx would make you entirely compatible with the memdesc future.
> 
> Any problem with that?

[1] https://lore.kernel.org/linux-block/20230306120127.21375-2-hare@suse.de/
