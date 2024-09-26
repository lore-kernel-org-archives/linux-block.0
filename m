Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630715AADB
	for <linux-block@vger.kernel.org>; Thu, 26 Sep 2024 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368704; cv=none; b=TXNhxgVm82Rb0Gf3t6OpEMNA7IJr0yF0eLnQZdiFcUA5JePDdKu+wJxbsMLRCzA6mNXizu1dHEYGdwwNrL719XuWprCBAjp1UfJSoGAgYFJ7dCykhTWg3tzJpnH99DRcISFc4pk4QhphGcLyaT9DeAzUtg+G+FjAlczbiGGA0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368704; c=relaxed/simple;
	bh=behsTdNcU/+ChSifKSfaguVC8VZWzPuZfNyRi/+mkyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=blDx/4zWaC4qIrSxJBbkBc4LTb3JRo/rfla8t1ImzEdH1+jby7xkQkRryQ82Vx5AlDnQkAnFEoJTi/KRbowjtHf9mXIOyMLlQdPMnCOu50H329fTn1OmYokgQrEgi6+oabP7FkaTVpP0/zKJKgcAqmFGqI1u9WnvnVIPcDC82HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eSkF4E1l; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eSkF4E1l"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240926163819epoutp048f7b694a42baf2d4614a8bf69db56b99~42K4f_ryS1914319143epoutp04o
	for <linux-block@vger.kernel.org>; Thu, 26 Sep 2024 16:38:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240926163819epoutp048f7b694a42baf2d4614a8bf69db56b99~42K4f_ryS1914319143epoutp04o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727368699;
	bh=I9PrBq4VRyNqM7vB2acMB7QhPsc7ZilPrm5o5cDnQWc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=eSkF4E1lN3lKwrkajJWAWP+wZcu9B95okcBoZKX745CpNs6iy+CU+6VJR44/a1O2d
	 3CLKUgSzX+MYl8Q/w1yeky25j6MBwCig9U/uSQlxip9wBGJRpkZIUzaTK3r6v5owdj
	 X/tfO5vMbwNR1YAGhagCsaO+NjWPVyM7KIkDW0jQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240926163818epcas5p426491427b731dcfe8b15fac4a82390e9~42K338Pyd2198221982epcas5p4c;
	Thu, 26 Sep 2024 16:38:18 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4XDzmm70Thz4x9Pq; Thu, 26 Sep
	2024 16:38:16 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	16.59.09640.8FD85F66; Fri, 27 Sep 2024 01:38:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240926163816epcas5p3c74179bddf80da97477a0c947f5556ac~42K1uJmql3076030760epcas5p3G;
	Thu, 26 Sep 2024 16:38:16 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240926163816epsmtrp253a903162ce547e66beee8aed8f2f7b4~42K1s755Z1104611046epsmtrp2M;
	Thu, 26 Sep 2024 16:38:16 +0000 (GMT)
X-AuditID: b6c32a49-a57ff700000025a8-95-66f58df85f0f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3C.6F.07567.8FD85F66; Fri, 27 Sep 2024 01:38:16 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240926163814epsmtip2315fe41bd61248b05873c22703a47e32~42K0Q_bwj2954329543epsmtip2B;
	Thu, 26 Sep 2024 16:38:14 +0000 (GMT)
Message-ID: <8ed2637b-559e-3f27-3d1f-84a4718475fb@samsung.com>
Date: Thu, 26 Sep 2024 22:08:09 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/3] block: support PI at non-zero offset within
 metadata
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Chinmay Gameti
	<c.gameti@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <ZvV4uCUXp9_4x5ct@kbusch-mbp>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmpu6P3q9pBsdOm1qsvtvPZvF9ex+L
	xc0DO5ksVq4+ymQx6dA1Rou9t7Qt5i97ym6x/Pg/Jot1r9+zOHB6nL+3kcXj8tlSj02rOtk8
	Ni+p99h9s4HN4+PTWywefVtWMXp83iQXwBGVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZg
	qGtoaWGupJCXmJtqq+TiE6DrlpkDdJySQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAl
	p8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvjwcMbjAVvuSpev25lbWA8zdHFyMkhIWAi0XJr
	OlsXIxeHkMBuRolt068xQTifGCUmTJ/IDuF8Y5TYefsvE0zLkoVfoVr2MkrMPdsF1fKWUeL9
	7jWsIFW8AnYSa2b8BrI5OFgEVCXObzaHCAtKnJz5hAXEFhVIkvh1dQ4jiC0sECSx5XEP2AJm
	AXGJW0/mg9kiAsoSd+fPZAWZzyxwllHi46xtjCAz2QQ0JS5MLgWp4RTQknh7+zkbRK+8xPa3
	c5hB6iUE1nJIXN/zE+wGCQEXiZc9ChAPCEu8Or6FHcKWkvj8bi8bhJ0t8eDRAxYIu0Zix+Y+
	VgjbXqLhzw2wMcxAa9fv0odYxSfR+/sJE8R0XomONiGIakWJe5OeQnWKSzycsQTK9pB4+LEd
	Gmy3GSVWfG1lnsCoMAspVGYh+X4Wkm9mIWxewMiyilEytaA4Nz212LTAMC+1HB7fyfm5mxjB
	SVfLcwfj3Qcf9A4xMnEwHmKU4GBWEuGddPNjmhBvSmJlVWpRfnxRaU5q8SFGU2DsTGSWEk3O
	B6b9vJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamNa2zxFYl9S0
	SvVPRphHybOeH7l7OKJ8FxlE1R13fFXPXna3typRta838GfLTNV1f3Z/M02sYXaYoDifJfPL
	9bKysoLfJ9YKPf2kMckg5sDvrdvt93kJKxy6Vfjm71WX7dzx+ew+j9jWKz+bMiFIf1Uoj1vn
	vx8bY7S2d26LmX+U73DNBRGrnbcMd/9wemgXXPhbNZtZ+cGnSt7l36IrdG5ovS0/mpAU/CVd
	KIXvzJ7au8K89tNWR7zO6/W/++Sze33P3NOJLhM/3JzhwPPfSfJKQwiX4FSvDWdl9ntGX4iu
	Wvr63t3Cl4YGP/vfC2fU53ifFOx5Op3P55lk4WfW2vczfO7M+VvNJP+05lbEPiWW4oxEQy3m
	ouJEAGzMBrVDBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXvdH79c0g/vTRSxW3+1ns/i+vY/F
	4uaBnUwWK1cfZbKYdOgao8XeW9oW85c9ZbdYfvwfk8W61+9ZHDg9zt/byOJx+Wypx6ZVnWwe
	m5fUe+y+2cDm8fHpLRaPvi2rGD0+b5IL4IjisklJzcksSy3St0vgynjw8AZjwVuuitevW1kb
	GE9zdDFyckgImEgsWfiVDcQWEtjNKNEyJx4iLi7RfO0HO4QtLLHy33Mgmwuo5jWjxItlH8AS
	vAJ2Emtm/GbtYuTgYBFQlTi/2RwiLChxcuYTFhBbVCBJYs/9RiYQW1ggSGLL4x4wmxlo/q0n
	88FsEQFlibvzZ7KCzGcWOMsoMalzBhPEstuMEvO2TmUGWcAmoClxYXIpSAOngJbE29vP2SAG
	mUl0be1ihLDlJba/ncM8gVFoFpI7ZiHZNwtJyywkLQsYWVYxSqYWFOem5yYbFhjmpZbrFSfm
	Fpfmpesl5+duYgRHmJbGDsZ78//pHWJk4mA8xCjBwawkwjvp5sc0Id6UxMqq1KL8+KLSnNTi
	Q4zSHCxK4ryGM2anCAmkJ5akZqemFqQWwWSZODilGpieCs9erT7RqEJpeWDxR6lN28y4ZyxQ
	6nUxNJpx6duRYnnjL2/72dSlz7t49nPWvasUvrH82YqIVYtXuQrzm7Kq3j2T9GjC4wOHzKZ9
	fNl4ceW6rh9Rv+27N634k7C1aWPzt8TcpKU8zyynnHjLvfR2COv51uZLPEx9T9j5jbjsD5Xd
	/VMmpWA6PW3Jo9s2ToUHN3gyqj459tTm5c8WnfdBy+bs6fXx52M9XS11+obenz1v54Wcn/xo
	76R5+1bdfnFewvO7+9bVD8MLc/PktrXdcXis/6/H/U6Du3iHs3QJx5ve1rj8b4u3npWz2x97
	5/UBZpPPzHl8n060XtU/pPeAUeNAQHlL4yb1aOsdDcuylFiKMxINtZiLihMBWEPXch8DAAA=
X-CMS-MailID: 20240926163816epcas5p3c74179bddf80da97477a0c947f5556ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d
References: <20240201130126.211402-1-joshi.k@samsung.com>
	<CGME20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d@epcas5p1.samsung.com>
	<20240201130126.211402-3-joshi.k@samsung.com> <ZvV4uCUXp9_4x5ct@kbusch-mbp>

On 9/26/2024 8:37 PM, Keith Busch wrote:
> On Thu, Feb 01, 2024 at 06:31:25PM +0530, Kanchan Joshi wrote:
>> Block layer integrity processing assumes that protection information
>> (PI) is placed in the first bytes of each metadata block.
>>
>> Remove this limitation and include the metadata before the PI in the
>> calculation of the guard tag.
> 
> Very late reply, but I am just now discovering the consequences of this
> patch.
> 
> We have drives with this format, 64b metadata with PI at the end. With
> previous kernels, we had written data to these drives. Those kernel
> versions disabled the GUARD generation, so the metadata was written
> without it, and everything was fine.
> 
> Now we upgrade to 6.9+, and this kernel enables the GUARD check. All the
> data previously written to this drive is unreadable because the GUARD is
> invalid.
> 
> Not sure exactly what to do about this, but it is a broken kernel
> upgrade path, so wanted to throw that information out there.
> 

Ah, writing to the disk without any guard, but after that reading with 
the guard!

I wish if there was a way to format the NVMe only to reset its pi type 
(from non-zero to 0).
But there are kernel knobs too. Hope you are able to get to the same 
state (as nop profile) by clearing write_generate and read_verify:
echo 0 > /sys/block/nvme0n1/integrity/read_verify

