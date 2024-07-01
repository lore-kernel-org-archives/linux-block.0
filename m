Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F62154BE7
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838856; cv=none; b=oGbWrgp3I+Vcf+gd0Mv1nmWdrVb9fzWLsLlh+vSyD2VF6Z/qReK0kKCeAJfva7sdQS9JDBSFFTJSDYigDalh4FWym+016R3tKo8KQl+k5cBGvfXLJy+xxOKFoeOZK9WlnVQhD8kQ3eN3CFY29LPXheFN8qdIuZgXIv3MMhd8wJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838856; c=relaxed/simple;
	bh=W9bltCBYFM+C2WucMMKme+Rkf/CG0xwlsXfIgc1ettM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=I1zrM7vT8n7oOTAAucB5wFjeljJs2G1GgyhQ/cRqXtgpxMu2CCmYxVfV5PyDGZBR+djoz7g6m9GQcnFlTcBD/jfNcTgoJOH0fMK96dWrQNY49ZXi79pMjAjQ5GMchvzoPagiad3yp0qhCT0Br+OUH3v1iiQc/rYjy+HKqj9SQv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BrTij7pc; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BrTij7pc"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240701130046epoutp03208cadfc6d32dde563484162ae43add4~eGFGdOiLw3081530815epoutp03b
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 13:00:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240701130046epoutp03208cadfc6d32dde563484162ae43add4~eGFGdOiLw3081530815epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719838846;
	bh=DE/RiLhiBXHk6GIVAh1+ja3dSByWB2NgP310dqUrp/8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=BrTij7pc6xUsCrvzI5i9pZ2wGpFMIWiDkLDvVHZ3u9d+VgUKu6mGzFciWuprpANGs
	 seWlzevyYdvwVy6gC5jt9rxm83bSCHnsP7Dsk1sDAS+qfBGKrMDmVr/7CzDxENdv/u
	 2H2HYrvTAKcWuHDui0PobLSMc2mPiiH7A9M9ckUk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240701130046epcas5p2cd75d9c70d4ed9b0ab2a3f5eaed66d9b~eGFGCxSbk0231402314epcas5p2I;
	Mon,  1 Jul 2024 13:00:46 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WCR3w3LV8z4x9Pr; Mon,  1 Jul
	2024 13:00:44 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8F.58.09989.A78A2866; Mon,  1 Jul 2024 22:00:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240701130041epcas5p3dc11ba75cf5a207d40ceb702eeb68c1d~eGFB1ioU60520505205epcas5p3f;
	Mon,  1 Jul 2024 13:00:41 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240701130041epsmtrp2f89d9dc8c2a291c8398606ebf4e97767~eGFB0tuwk3210132101epsmtrp2Y;
	Mon,  1 Jul 2024 13:00:41 +0000 (GMT)
X-AuditID: b6c32a4a-bffff70000002705-7a-6682a87ac434
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	68.FB.18846.978A2866; Mon,  1 Jul 2024 22:00:41 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240701130040epsmtip2c18da06f70c800542161d2b743626204~eGFA9_rj61280212802epsmtip2e;
	Mon,  1 Jul 2024 13:00:40 +0000 (GMT)
Message-ID: <a4c7b88a-7dca-c443-15c0-a0699976f057@samsung.com>
Date: Mon, 1 Jul 2024 18:30:34 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 4/5] block: don't free submitter owned integrity payload
 on I/O completion
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240701050918.1244264-5-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTQ7dqRVOawbYudoumCX+ZLVbf7Wez
	WLn6KJPF3lvaFsuP/2NyYPW4fLbUY/fNBjaPj09vsXj0bVnF6PF5k1wAa1S2TUZqYkpqkUJq
	XnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QaiWFssScUqBQQGJxsZK+
	nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbzq7EF1zgrZpyf
	w9jA+IK9i5GTQ0LAROLp8XUsXYxcHEICuxklnrzoYAFJCAl8YpT4fVYfIgFkt+//wAzT0Tbh
	LStE0U5GiRdftCCK3jJKTO68DdTNwcErYCdx6YgPSA2LgIpE+7E2sHpeAUGJkzOfgC0QFUiW
	+Nl1gA3EFhZIkHg6Zy+YzSwgLnHryXwmEFtEwEFi9oalUPEKian3nrGBjGcT0JS4MLkUxOQU
	MJK4fDYVokJeYvvbOcwg10gI/GSXWHj3AyvEyS4SLYsnMELYwhKvjm+Bel5K4vM7iLUSAtkS
	Dx49YIGwayR2bO6D6rWXaPhzgxVkFzPQ2vW79CF28Un0/n7CBBKWEOCV6GgTgqhWlLg36SlU
	p7jEwxlLoGwPiXN7WpghAbWWUaL71m7mCYwKs5ACZRaS52cheWcWwuYFjCyrGCVTC4pz01OL
	TQuM8lLL4XGdnJ+7iRGcKLW8djA+fPBB7xAjEwfjIUYJDmYlEd7AX/VpQrwpiZVVqUX58UWl
	OanFhxhNgbEzkVlKNDkfmKrzSuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8sSc1OTS1ILYLp
	Y+LglGpg2mzyo2K2e4rbwvwnPNPnmdX6HKzNtS3+JLHtRb641MtW778NcwVEdX5VNU59dJDj
	meYs0Yv2U6f0vg9N4Incv9T49rqdnsk6V+eHvJ+/rjFfNGuRoe3is4KWxXJT2s/bJCikzJO9
	qnfj+5LZnLsnXlyd07uz779yzda1+3dfCeIK41z1991kL43tgqy3r9Sfj+18krP1/F83Te7J
	XLJK4Qn/XFx93umVKJVKJ9556nLAfV6NZ/z76eKHdbi9d5at/SfGzyJWd6sgY85dKVs1y9nT
	87jtTtQEbtu2VpH74DXjx1seH5dkZeF9OU++cM02v7qXx2Pkfv1h7fNv5nzY2b0j8Gx79yf9
	y6bbg+dHK7EUZyQaajEXFScCADTJTgIdBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvG7liqY0g6cPpC2aJvxltlh9t5/N
	YuXqo0wWe29pWyw//o/JgdXj8tlSj903G9g8Pj69xeLRt2UVo8fnTXIBrFFcNimpOZllqUX6
	dglcGc+vxhZc46yYcX4OYwPjC/YuRk4OCQETibYJb1m7GLk4hAS2M0rMurqVGSIhLtF87QdU
	kbDEyn/P2SGKXjNKzNz5h6mLkYODV8BO4tIRH5AaFgEVifZjbawgNq+AoMTJmU9YQGxRgWSJ
	l38mgs0RFkiQeDpnLxuIzQw0/9aT+UwgtoiAg8TsDUvZQEYyC1RI3FlZCLFqLaPE+wd7mEHi
	bAKaEhcml4KYnAJGEpfPpkJMMZPo2trFCGHLS2x/O4d5AqPQLCRHzEKybBaSlllIWhYwsqxi
	FE0tKM5Nz00uMNQrTswtLs1L10vOz93ECI4HraAdjMvW/9U7xMjEwXiIUYKDWUmEN/BXfZoQ
	b0piZVVqUX58UWlOavEhRmkOFiVxXuWczhQhgfTEktTs1NSC1CKYLBMHp1QDk+XXy71r/u2/
	vqvJcLfgzNUr7L1uBq4/yOLz6er1jcdFpZ9ue54U0vnlTn7Jt4vanReOxskIb1fTOLNIMMf2
	kpWpnnP2xrkr1Lbyumxv32J+MXflh4L9859qv9qTYDp3+eSCE2l72Ofuu/xpAn/dFjuT0q8T
	V5o1abKU6zYl5kvxvbjVcfpd+Bv2q8ddrbZbndWvW23SyuA5p+Qr+7IWz6lh39ecf7Bkrh/j
	+xeRYZlK+zyP3H0so/9nY2Hj+vmFyz+31QQ6a8tm8AR4FLnbWH2uYHn0d3dsLdPJVnFN/4ig
	29rM03kDL1fG8S3QFkl7+6XlwTyVt7Pa1JWrl4a/5tm4romhK4FlO8udX9HPdyixFGckGmox
	FxUnAgArCBZ29gIAAA==
X-CMS-MailID: 20240701130041epcas5p3dc11ba75cf5a207d40ceb702eeb68c1d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240701050934epcas5p4b2a829697ea9e0f90bf510f511abf19d
References: <20240701050918.1244264-1-hch@lst.de>
	<CGME20240701050934epcas5p4b2a829697ea9e0f90bf510f511abf19d@epcas5p4.samsung.com>
	<20240701050918.1244264-5-hch@lst.de>

On 7/1/2024 10:39 AM, Christoph Hellwig wrote:
> +/*
> + * Integrity payloads can either be owned by the submitter, in which case
> + * bio_uninit will free them, or owned and generated by the block layer,
> + * in which case we'll verify them here (for reads) and free them before
> + * the bio is handed back to the submitted.
> + */
> +bool __bio_integrity_endio(struct bio *bio);
>   static inline bool bio_integrity_endio(struct bio *bio)
>   {
> -	if (bio_integrity(bio))
> +	struct bio_integrity_payload *bip = bio_integrity(bio);
> +
> +	if (bip && (bip->bip_flags & BIP_BLOCK_INTEGRITY))
>   		return __bio_integrity_endio(bio);

The patch will cause regression for nvme-passthrough. For that 
completion order is:
(a) bio_endio()
(b) req->end_io
(c) blk_rq_unmap_user.

And current code ensures that integrity is freed explicitly only after 
(a) and (b).
With the patch, integrity will get freed during (a) itself.

There are two places in bio_endio() that can free the integrity.
It first calls bio_integrity_endio() - which is handled fine above.
But it also calls bio_uninit() - which will free the integrity. We don't 
want that to happen before passthrough gets the chance to unpin/copy-back.
