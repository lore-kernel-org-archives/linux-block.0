Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFB285279
	for <linux-block@vger.kernel.org>; Fri, 24 May 2024 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543752; cv=none; b=W4RKs2eycXeAS9NXP8Y5s7MbRbhQ4dAccfq+hlwFJLkyKk0TCGIr78M6kaIrEuNXsBlixwPEaYK3J9OxQmnYzTygrTCKGYu0D7mU4pSNYOOzeNOAYmMsHM2YDZKyuaPxOUgYLSSDd/JCCQKRxxWd4ng+i7wn1v41DBOkfo5mDLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543752; c=relaxed/simple;
	bh=mVBQXpdV8yGNewbSi9tK8GXww0UBcukDE4Awfoq4GFc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=GkmkfNrdr+n7yrwFQOrCBcR8iFeG1Kh4YQHwvHqrMOxMBK3li+Zf+eAjEv4r0pJCzn/tqrokmZikH+uV7gc7EZ4jeQeBB7Zi5Z77rb8jLsg4K/tArRlNQs9629FGZSpmIP1Eo+Fr/i4zH8gRjzzasCKA4HM4uCAY5VE/etn8gfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ilz0l49g; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ilz0l49g"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240524094221epoutp0357cb02ade2f20125258f5d7055582c56~SY3BErOXn2002320023epoutp03D
	for <linux-block@vger.kernel.org>; Fri, 24 May 2024 09:42:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240524094221epoutp0357cb02ade2f20125258f5d7055582c56~SY3BErOXn2002320023epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716543741;
	bh=aGzCioQf/GOfZLOrQic0rs7Du6VGIcHmifP7WMB/dcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ilz0l49gvZE/lfGddVGPDnZU5zbhQID48Ieeiyp4k3foHIZ4ljU7YvjNIS8Fs/ckY
	 MHqIEDYG7IH/ib5QN3xaIUC9ECUIh7SohGHTRrKlY8OPx5yWYG2XLdQmcwGKtwud/R
	 K5RKYSA0m4M+0iDL7W8ES2w3WfaZKIMJocij7bfM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240524094221epcas5p43519d4472c4d6332c8c12579091099a6~SY3Aypo630749407494epcas5p4K;
	Fri, 24 May 2024 09:42:21 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Vm0SW52X6z4x9Q1; Fri, 24 May
	2024 09:42:19 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1A.68.09665.BF060566; Fri, 24 May 2024 18:42:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240524092940epcas5p4c70b243305eab167e4eead276a016be1~SYr8RiCXB2275422754epcas5p45;
	Fri, 24 May 2024 09:29:40 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240524092940epsmtrp2ab552c7969c6b45e0d3259681641a904~SYr8Qb0JQ0589505895epsmtrp2l;
	Fri, 24 May 2024 09:29:40 +0000 (GMT)
X-AuditID: b6c32a4b-829fa700000025c1-1a-665060fb18ec
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D6.18.09238.40E50566; Fri, 24 May 2024 18:29:40 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240524092939epsmtip2d0c03260f792d42b21cc42b0be4f7b30~SYr6qymwq3207932079epsmtip2N;
	Fri, 24 May 2024 09:29:38 +0000 (GMT)
Date: Fri, 24 May 2024 14:52:31 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	joshi.k@samsung.com, mcgrof@kernel.org, anuj20.g@samsung.com,
	nj.shetty@samsung.com, c.gameti@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v3 2/3] block: add folio awareness instead of looping
 through pages
Message-ID: <20240524092231.pijr74qryxo5fazk@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZkUhPoWnvxPYONIA@casper.infradead.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmlu7vhIA0g84XahZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i723tC1uTHjKaLHt93xmi98/5rA5cHlsXqHlcflsqcem
	VZ1sHrtvNrB59G1ZxejxeZNcAFtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5
	kkJeYm6qrZKLT4CuW2YO0F1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3i
	xNzi0rx0vbzUEitDAwMjU6DChOyMlT2bWQq6BSvmLVjC2MD4jreLkZNDQsBEYtO/ZpYuRi4O
	IYHdjBI72m9COZ8YJfY8PADlfGOU2P/iFxtMS9/Oo8wQib2MEg9PLmeHcJ4xSvRdmcrUxcjB
	wSKgKvHtTzaIySagK/GjKRTEFBHQkHizxQhkDLPAQUaJFRckQGxhgUiJjSe2go3nFTCTOHro
	DhOELShxcuYTFhCbE2jtqyv9YHFRARmJGUu/gp0gITCRQ2Jz9ylWiNtcJJa9ecYOYQtLvDq+
	BcqWkvj8bi/U/dkShxo3MEHYJRI7jzRA1dhLtJ7qZ4Y4LkPi8L7vLBBxWYmpp9YxQcT5JHp/
	P4Hq5ZXYMQ/GVpOY824qVL2MxMJLM6DiHhKrPtyFBs97RonzWzaxT2CUn4XkuVlI9kHYVhKd
	H5pYZwHDi1lAWmL5Pw4IU1Ni/S79BYysqxglUwuKc9NTi00LjPNSy+HxnZyfu4kRnGq1vHcw
	PnrwQe8QIxMH4yFGCQ5mJRHe6JW+aUK8KYmVValF+fFFpTmpxYcYTYExNZFZSjQ5H5js80ri
	DU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRqYOr4vmu7YeGs7VIrdFdv
	mj3n3PYpBd82P5nYqMsbNylJtUXxrYXT/dbL54/c/tPlnVxaXrBKSttAr3d+TyvP1NJ9nTdv
	yx6rXpYp5SZ+19Nkn5Tvf77t7Xm/Aj5Min04W/PuWl2tLSKiHYx3TO9u1ZN65Xj17nEtGb9n
	ey9evlvlrLghOoNvxa2NonMsJvP0P714giNl3eKaXXFpnd/t3++ybL2ZELFyt0iR9OrPXXwa
	O3d9NRQr3GZxed+SZxllpnKvKpxr37fzhsZq/pkvdnHjeYHdK1dvO3rv2jN+gzmTOTpK5QWv
	LXcp9qq0izi2vNyJS49rxfycFYssPm1xvt7+wTxrFtvH13z6eur27GuVWIozEg21mIuKEwHO
	aI0bPgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvC5LXECawZxWVYumCX+ZLVbf7Wez
	+L69j8Xi5oGdTBYrVx9lsjj6/y2bxd5b2hY3JjxltNj2ez6zxe8fc9gcuDw2r9DyuHy21GPT
	qk42j903G9g8+rasYvT4vEkugC2KyyYlNSezLLVI3y6BK2PhnePsBXv5KvqWLGBuYNzF3cXI
	ySEhYCLRt/MocxcjF4eQwG5GiZtLTrJBJGQkdt/dyQphC0us/PecHaLoCaPEr1n7WboYOThY
	BFQlvv3JBjHZBHQlfjSFgpgiAhoSb7YYgXQyCxxklFhxQQLEFhaIlNh4YivYdF4BM4mjh+4w
	QUx8zyhxrPMKO0RCUOLkzCcsEM1mEvM2P2QGmcksIC2x/B8HSJgT6ORXV/qZQGxRoCtnLP3K
	PIFRcBaS7llIumchdC9gZF7FKJlaUJybnptsWGCYl1quV5yYW1yal66XnJ+7iREcIVoaOxjv
	zf+nd4iRiYPxEKMEB7OSCG/0St80Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryGM2anCAmkJ5ak
	ZqemFqQWwWSZODilGpjK2fPvZ1a7no2aExYzld/mqm5HsIudCzeTtfnrmuNLjt7ZX1Z10e+9
	326jXLNpmumfDCR+e8Szec/q5pW7ZVic2PRVmPODoV6YcuyLh94rGW6de9d62vnkJLdbz+dO
	+Z/t9lxKTixBxEuoi9PjTZb5x+nb69V5VqoH1P+z/SDiOf9jfHkFN3/MkglbBTp83f/pxb5x
	36yr89VA6I1sVPlDo5eavRPlrqlcqb6n3cH+f8EDEc/lf3euWj4vSmvZo5yTmRYfrhzrt0y5
	ynyDleeP6G9rq+P/t1n8Paw1obbuwdbuwO1/hc7MZ+RpKeYJrv6wlPtdqLRu5p1Uve7ttlt/
	zCvn2XvKpKrvz5zS30osxRmJhlrMRcWJAILTZgn/AgAA
X-CMS-MailID: 20240524092940epcas5p4c70b243305eab167e4eead276a016be1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_25e95_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240507145323epcas5p3834a1c67986bf104dbf25a5bd844a063
References: <20240507144509.37477-1-kundan.kumar@samsung.com>
	<CGME20240507145323epcas5p3834a1c67986bf104dbf25a5bd844a063@epcas5p3.samsung.com>
	<20240507144509.37477-3-kundan.kumar@samsung.com>
	<ZkUhPoWnvxPYONIA@casper.infradead.org>

------0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_25e95_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 15/05/24 09:55PM, Matthew Wilcox wrote:
>On Tue, May 07, 2024 at 08:15:08PM +0530, Kundan Kumar wrote:
>> Add a bigger size from folio to bio and skip processing for pages.
>>
>> Fetch the offset of page within a folio. Depending on the size of folio
>> and folio_offset, fetch a larger length. This length may consist of
>> multiple contiguous pages if folio is multiorder.
>
>The problem is that it may not.  Here's the scenario:
>
>int fd, fd2;
>fd = open(src, O_RDONLY);
>char *addr = mmap(NULL, 1024 * 1024, PROT_READ | PROT_WRITE,
>	MAP_PRIVATE | MAP_HUGETLB, fd, 0);

I also added MAP_ANONYMOUS flag here, otherwise mmap fails.

>int i, j;
>
>for (i = 0; i < 1024 * 1024; i++)
>	j |= addr[i];
>
>addr[30000] = 17;
>fd2 = open(dest, O_RDWR | O_DIRECT);
>write(fd2, &addr[16384], 32768);
>
>Assuming that the source file supports being cached in large folios,
>the page array we get from GUP might contain:h
>
>f0p4 f0p5 f0p6 f1p0 f0p8 f0p9 ...
>
>because we allocated 'f1' when we did COW due to the store to addr[30000].
>
>We can certainly reduce the cost of merge if we know two pages are part
>of the same folio, but we still need to check that we actually got
>pages which are part of the same folio.
>

Thanks, now I understand that COW may happen and will modify the ptes in
between contiguous folio mapping in page table. I will include the check
if each page belongs to same folio.

I tried executing the sample code. When this does a GUP due to a O_DIRECT
write, I see that entire HUGE folio gets reused.
"addr[30000] = 17;" generates a COW but hugetlb_wp() reuses the
same huge page, using the old_folio again.

Am I missing something here? Do you have any further suggestions to
generate a scenario similar to "f0p4 f0p5 f0p6 f1p0 f0p8 f0p9 ..."
using a sample program.
--
Kundan

------0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_25e95_
Content-Type: text/plain; charset="utf-8"


------0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_25e95_--
