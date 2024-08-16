Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC913A250
	for <linux-block@vger.kernel.org>; Fri, 16 Aug 2024 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799590; cv=none; b=LPK/aOPnsCaC4FrtGA9oBGLl4lCEpDngVSqXXiJKtvY8QRcLvizCPc/GTgkJwqU0x24ZiKcpsubzw1D1Zeha7E41x4k/FNeHoGXDzfXupeMTEyl1U2JmzKhTwEywrhAGXJSWLcThHs3HbTFahuMlsOXf/o6Yb0lpcWdNFqtq/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799590; c=relaxed/simple;
	bh=UgI+o6JuDwi6oXBQGJIuuc/7gFzSZjzswCP0ndmjxyk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=LfwdTi8NeQHelFzUFosZTWGLwVPkPxEmURkvkBxh60jnRcD8Ug86CywuoX+FPwYG6Kx+Aoh5BiiaSPqoYiYKFctcakA4I3O8Bgfv3USE9ELAEy3ojdVGfxXgS3TLyAq7GYcNFMy/4IY+tcgwRp2HsV5wPeAuROC6Ozh1E3jSStM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=V+d6qGNW; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V+d6qGNW"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240816091259epoutp02fd3fe885108f9fa3fc1148541f780fa6~sKpW5Ob2t2852928529epoutp02s
	for <linux-block@vger.kernel.org>; Fri, 16 Aug 2024 09:12:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240816091259epoutp02fd3fe885108f9fa3fc1148541f780fa6~sKpW5Ob2t2852928529epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723799579;
	bh=xzLghChNhTPe84RJP5JNjqjw7JP/94VMK437mG6+i2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V+d6qGNW6xxmYUSUoAogK/au9/pKXYy9ChOllotAq4nYBDG3xF4lEcZcsMRk6F2fc
	 dma1RQnlLWUYfBoYsUcDCaRUUoCoJqvf97z199vdalYqWfZe5/CYgca309sxKVmqia
	 yMbpCmsRc1D47xJ3OqOiZ3f8dcJTNsMimr94cifs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240816091259epcas5p4fc14d293a46b10598d505578ea4523ef~sKpWdMAlf3035830358epcas5p42;
	Fri, 16 Aug 2024 09:12:59 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Wlbqs4dw0z4x9Ps; Fri, 16 Aug
	2024 09:12:57 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3F.7F.09642.9181FB66; Fri, 16 Aug 2024 18:12:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240816085315epcas5p225b85ace7e76e07ea8738d77d5fdd763~sKYHv_Jd_1708617086epcas5p2O;
	Fri, 16 Aug 2024 08:53:15 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240816085315epsmtrp1b4cc8d9c4c573f2a9f811e424f080297~sKYHuQ5ZQ0323203232epsmtrp1U;
	Fri, 16 Aug 2024 08:53:15 +0000 (GMT)
X-AuditID: b6c32a4b-879fa700000025aa-07-66bf18199931
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1A.01.07567.B731FB66; Fri, 16 Aug 2024 17:53:15 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240816085313epsmtip229119ea4fbb7526565302a16b2487c99~sKYFwbztS2863028630epsmtip2U;
	Fri, 16 Aug 2024 08:53:13 +0000 (GMT)
Date: Fri, 16 Aug 2024 14:15:41 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, kernel@pankajraghav.com,
	axboe@kernel.dk, willy@infradead.org, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, anuj20.g@samsung.com,
	nj.shetty@samsung.com, c.gameti@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v8 0/5] block: add larger order folio instead of pages
Message-ID: <20240816084541.t7bn7qlklhynsglq@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zro5xJgcVlSaM4zP@bombadil.infradead.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmuq6kxP40gylrVSyaJvxltlh9t5/N
	4vv2PhaL95e3MVncPLCTyWLl6qNMFkf/v2WzmHToGqPFmZefWSz23tK2uDHhKaPFtt/zmS0+
	L21ht/j9Yw6bA5/H5hVaHpfPlnpsWtXJ5rH7ZgObx9mVjh59W1YxenzeJBfAHpVtk5GamJJa
	pJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0r5JCWWJOKVAoILG4
	WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+PS+mfsBY38
	Fb/vz2JtYJzL08XIySEhYCJx/V03excjF4eQwG5GievfVzNCOJ8YJVbd6maCcL4xSkyefI8J
	puXzj9esEIm9jBJX915iAUkICTxjlDh/TreLkYODRUBV4mVLLojJJqAr8aMpFKRCREBDYt+E
	XrCZzAKXmCTety5kBEkIC3hJtG9qARvDK2AmceNSGyOELShxcuYTsDgnULxx4152EFtUQEZi
	xtKvzCCDJAR2cEjsafzCBLJMQsBFYs85SYg7hSVeHd/CDmFLSbzsb4OysyUONW6A+qVEYueR
	Bqi4vUTrqX5mEJtZIEPiw4t+qLisxNRT65gg4nwSvb+fQPXySuyYB2OrScx5N5UFwpaRWHhp
	BlTcQ2Llvv/QEO1kkjj6ag/LBEb5WUh+m4VkH4RtJdH5oYl1FtA7zALSEsv/cUCYmhLrd+kv
	YGRdxSiZWlCcm55abFpgnJdaDo/v5PzcTYzg1KzlvYPx0YMPeocYmTgYDzFKcDArifA+/bI3
	TYg3JbGyKrUoP76oNCe1+BCjKTCqJjJLiSbnA7NDXkm8oYmlgYmZmZmJpbGZoZI47+vWuSlC
	AumJJanZqakFqUUwfUwcnFINTFHP6xN36Pol/lMNUz7nWbjAr9Usrpa9Vmhu8U5rNVmFj7vS
	9S8zd82/ePP0U9HvD7nYL/zwEv5lsnvTn9uF9jeOXlrwrj2mU+lb8jTF/UqGmvt51y1fpF12
	Pu3xrJ4IbyeVY2uVjoozfJVnZ8lObDe6Zb77mvG7SXu5xO5++DTvdkh/zvFTK5p3Hn+w8k3e
	gx1XE+2upU94VjJBhFd01U0pXe55nz2KVX4lL5v3XHzjeYHyRRLS73YavpNfOv1b3bS52rzn
	HJfoBEn41P1RVXjpvL3nrNLy6g2rlN0+FHQfr9rx8+jM7s1nDJYtiOWbsqRws0HH4b71tw/+
	1nGL1/Txfy174NfPSVmOB45ck3+vxFKckWioxVxUnAgAMQ5c3FYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXrdaeH+aweFJfBZNE/4yW6y+289m
	8X17H4vF+8vbmCxuHtjJZLFy9VEmi6P/37JZTDp0jdHizMvPLBZ7b2lb3JjwlNFi2+/5zBaf
	l7awW/z+MYfNgc9j8wotj8tnSz02repk89h9s4HN4+xKR4++LasYPT5vkgtgj+KySUnNySxL
	LdK3S+DKmPwhvWAzT8X2vysYGxhfcnYxcnJICJhIfP7xmrWLkYtDSGA3o0THtvnsEAkZid13
	d7JC2MISK/89Z4coesIo8WgSSAcHB4uAqsTLllwQk01AV+JHUyhIuYiAhsS+Cb1MIOXMAleY
	JG6se8gGkhAW8JJo39TCAmLzCphJ3LjUxggxs5tJYue5+UwQCUGJkzOfgBUxAxXN2/yQGWQB
	s4C0xPJ/HCBhTqBw48a9YHeKAt05Y+lX5gmMgrOQdM9C0j0LoXsBI/MqRsnUguLc9NxkwwLD
	vNRyveLE3OLSvHS95PzcTYzgmNLS2MF4b/4/vUOMTByMhxglOJiVRHifftmbJsSbklhZlVqU
	H19UmpNafIhRmoNFSZzXcMbsFCGB9MSS1OzU1ILUIpgsEwenVAOTgveUXbsd3Vfzv+aazu55
	+PFj28iz6RNvBz3717SCf+KrnN5H7zdrpgnl6M6Mncob+M1EJMx82rp3FRvSb/7ccezPNoW1
	HQt5fn1MZVbhO3Fy/TfviP0qdW8ZpP7zcz0MFK9kn+a7SFshmu3G5GmXezQTjVf9Fz54ehvz
	s69cdcoNhg4iTTc6/psntGVYWF69vnP+tdil1xemNB5fmOx/RET2kPAd26KZp93f7dC8dO3s
	vyq2mVEzM394v1DWZ3t56MWNE1FdGp3zu2L5VEUDSqdG9md+vb5ISuOQa9+2NffPFDj+Snx5
	8Oq0sGv3fmUv1tcQ8Gg9sjOprN87IZ5tUdk54WsZ8U1tNyesP12spsRSnJFoqMVcVJwIALil
	G6EYAwAA
X-CMS-MailID: 20240816085315epcas5p225b85ace7e76e07ea8738d77d5fdd763
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----K_xth5sKcUEfCV0X9aU-k.Br-XWllh-4huxyB_iNSY1rR3o.=_7e0ad_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240711051521epcas5p348f2cd84a1a80577754929143255352b
References: <CGME20240711051521epcas5p348f2cd84a1a80577754929143255352b@epcas5p3.samsung.com>
	<20240711050750.17792-1-kundan.kumar@samsung.com>
	<ZrVO45fvpn4uVmFH@bombadil.infradead.org> <20240812133843.GA24570@lst.de>
	<Zro5xJgcVlSaM4zP@bombadil.infradead.org>

------K_xth5sKcUEfCV0X9aU-k.Br-XWllh-4huxyB_iNSY1rR3o.=_7e0ad_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 12/08/24 09:35AM, Luis Chamberlain wrote:
>On Mon, Aug 12, 2024 at 03:38:43PM +0200, Christoph Hellwig wrote:
>> On Thu, Aug 08, 2024 at 04:04:03PM -0700, Luis Chamberlain wrote:
>> > This is not just about mTHP uses though, this can also affect buffered IO and
>> > direct IO patterns as well and this needs to be considered and tested as well.
>>
>> Not sure what the above is supposed to mean.  Besides small tweaks
>> to very low-level helpers the changes are entirely in the direct I/O
>> path, and they optimize that path for folios larger than PAGE_SIZE.
>
>Which was my expectation as well.
>
>> > I've given this a spin on top of of the LBS patches [0] and used the LBS
>> > patches as a baseline. The good news is I see a considerable amount of
>> > larger IOs for buffered IO and direct IO, however for buffered IO there
>> > is an increase on unalignenment to the target filesystem block size and
>> > that can affect performance.
>>
>> Compared to what?  There is nothing in the series here changing buffered
>> I/O patterns.  What do you compare?  If this series changes buffered
>> I/O patterns that is very well hidden and accidental, so we need to
>> bisect which patch does it and figure out why, but it would surprise me
>> a lot.
>
>The comparison was the without the patches Vs with the patches on the
>same fio run with buffered IO. I'll re-test more times and bisect.
>

Did tests with LBS + block folio patches and couldn't observe alignment
issue. Also, the changes in this series are not executed when we issue
buffered I/O.


------K_xth5sKcUEfCV0X9aU-k.Br-XWllh-4huxyB_iNSY1rR3o.=_7e0ad_
Content-Type: text/plain; charset="utf-8"


------K_xth5sKcUEfCV0X9aU-k.Br-XWllh-4huxyB_iNSY1rR3o.=_7e0ad_--
