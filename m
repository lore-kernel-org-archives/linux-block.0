Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11731134A0
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Bwg8wr5K"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240116095200epoutp03e2495706422434970615c75be752ec17~qyxneP4CL0264702647epoutp03H
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 09:52:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240116095200epoutp03e2495706422434970615c75be752ec17~qyxneP4CL0264702647epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705398720;
	bh=oC8sfo8bga8IOkBztQXGlU14pAfv3VHLV1iyow+ZlNM=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=Bwg8wr5K2+jxE9MHQItjjqbGQkKInXwJZw0W3OMXZLlwPZyQLeSBntYXnxACQvf1i
	 4JicEHLOGx2a8/Dzrc61O1FNv8IbMY4z1JA5d0py95x//bzFTfrrJlrGh60PJlaxRE
	 +QcP6SX7vF/D8yF1xcdUjQWh7Ibl6hg0U6pz0o6E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240116095200epcas5p238c5f263932e783042905671daf0ec1c~qyxnT20OP1589515895epcas5p2r;
	Tue, 16 Jan 2024 09:52:00 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TDknC0FtGz4x9Pw; Tue, 16 Jan
	2024 09:51:59 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BA.01.09672.CB156A56; Tue, 16 Jan 2024 18:51:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240116095156epcas5p2ebd6d454e36eee7d9f0683513342afca~qyxjHKOfB1589515895epcas5p2h;
	Tue, 16 Jan 2024 09:51:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240116095156epsmtrp2773057c3902bf91dc021b8cdbf8d9c15~qyxjGosOB3195731957epsmtrp2r;
	Tue, 16 Jan 2024 09:51:56 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-14-65a651bcf78c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FA.1D.08755.CB156A56; Tue, 16 Jan 2024 18:51:56 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240116095155epsmtip2a9f66195212b59a8331167c15c8b5b5c~qyxibvrWU0837608376epsmtip2a;
	Tue, 16 Jan 2024 09:51:55 +0000 (GMT)
Message-ID: <ff4a6649-9f09-23fc-ad33-06deb4845590@samsung.com>
Date: Tue, 16 Jan 2024 15:21:54 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] block: cache current nsec time in struct blk_plug
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240115215840.54432-3-axboe@kernel.dk>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmlu6ewGWpBt/uSVmsvtvPZrH3lrYD
	k8fls6UenzfJBTBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5
	+AToumXmAA1XUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+Wl
	llgZGhgYmQIVJmRnNK5ZxlwwnaeibeYD9gbGG5xdjJwcEgImElsbHjJ1MXJxCAnsZpRY8bmX
	DcL5xChxZ9VHqMw3RonFk9+ywLTsnP6dESKxl1Hiy/F3UFVvGSXObbjB2sXIwcErYCex7rcR
	iMkioCqx7KI7SC+vgKDEyZlPwOaICiRJ/Lo6hxHEFhbwkljQM5MVxGYWEJe49WQ+E0iriICt
	xPaVKSAmm4CmxIXJpSAVnAKmEhOXvGOEqJaX2P52DjPIARICh9glbrW/ZoQ400Xi35HtzBC2
	sMSr41vYIWwpic/v9rJB2MkSl2aeY4KwSyQe7zkIZdtLtJ7qZwbZywy0d/0ufYhdfBK9v5+A
	XSYhwCvR0SYEUa0ocW/SU1YIW1zi4YwlULaHRO/B56yQsNnMKLFu4XWWCYzys5ACYhaSh2ch
	eWcWwuYFjCyrGCVTC4pz01OLTQuM81LL4TGcnJ+7iRGc2LS8dzA+evBB7xAjEwfjIUYJDmYl
	EV5/g2WpQrwpiZVVqUX58UWlOanFhxhNgREykVlKNDkfmFrzSuINTSwNTMzMzEwsjc0MlcR5
	X7fOTRESSE8sSc1OTS1ILYLpY+LglGpgSr6501MgUe7aTyNHvxCt1z5CJ2xMnyjd1IkK6gje
	pOKxpKBvp/SrdEHGT9Z1Pxdv+5nD676Wn8X8IK/9vLSwU9Iz9RYYxxtHnClrUwt9EJVlma3V
	uYRreojixAPfL3qYiGbP6rRsKxbn/bbYYNHi2QuN3xpuWS66w6n2y1Hb2sKIk+fPystNnsa2
	rqUzpnSi3ZaJfAwSXId/8tx9alURNo93qmftyTStV1cCTl2a1qNprdL/JZ5vTvF2Xf/KEINV
	JxRc5v0s+HD/ge3Zz6bl2oyzezwvTgxP+qyYd7ni1Gn54Pdb9ly32+J+7HOamOj0XwzLe+V5
	Wk8Gej2fJsAmKfPDMeu736PaZ5whea5KLMUZiYZazEXFiQAJAacM9QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWy7bCSvO6ewGWpBs0b2C1W3+1ns9h7S9uB
	yePy2VKPz5vkApiiuGxSUnMyy1KL9O0SuDIa1yxjLpjOU9E28wF7A+MNzi5GTg4JAROJndO/
	M3YxcnEICexmlJj1+hkjREJcovnaD3YIW1hi5b/n7BBFrxklZv/5xdLFyMHBK2Anse63EYjJ
	IqAqseyiO0g5r4CgxMmZT1hAbFGBJIk99xuZQGxhAS+JBT0zWUFsZqDxt57MZwJpFRGwldi+
	MgVi+mZGiVUvtoJNZxPQlLgwuRSknFPAVGLikneMEK1mEl1bu6BseYntb+cwT2AUnIVk8ywk
	G2YhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgINbS3MG4fdUHvUOM
	TByMhxglOJiVRHj9DZalCvGmJFZWpRblxxeV5qQWH2KU5mBREucVf9GbIiSQnliSmp2aWpBa
	BJNl4uCUamAy23jmT+/zDF7/rdMNpf+Yl4dtr/V+dOdAqXAH9zoBBgaXjZ3GVy2KNpk7nl+4
	ZWHSh2qNhHfn58V/thRMy/82jb0qXS71dI92n/IyLqbqy+1adpEfymSVrAxW9yc5uDwKj9i5
	qaKxelNBetzcCy+K2Q2O7ohcPne7Su38nwfums5PfO+xwlma67vYm59b8/fIJ7drhDiIJTy/
	onzBS3Tqh80PTwWFHF3451lYgqLpAbcS9/+TCsW0+ZM1tm1h1fUpuS6vJTnhaInELJ2JF6Yv
	ZbnyQtYigpGx+omzkOyhKw/fSW5PK3vd8+jpvzNccRv2yii+Nem//prtnsDPVCWNK8d8rXvi
	7nbL9rhO/K3EUpyRaKjFXFScCABi1tVQ0QIAAA==
X-CMS-MailID: 20240116095156epcas5p2ebd6d454e36eee7d9f0683513342afca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240115215903epcas5p1518ca37cf0c83499dadba07bd3e51c77
References: <20240115215840.54432-1-axboe@kernel.dk>
	<CGME20240115215903epcas5p1518ca37cf0c83499dadba07bd3e51c77@epcas5p1.samsung.com>
	<20240115215840.54432-3-axboe@kernel.dk>

On 1/16/2024 3:23 AM, Jens Axboe wrote:

> diff --git a/block/blk-core.c b/block/blk-core.c
> index 11342af420d0..cc4db4d92c75 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1073,6 +1073,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
>   	if (tsk->plug)
>   		return;
>   
> +	plug->cur_ktime = 0;
>   	plug->mq_list = NULL;
>   	plug->cached_rq = NULL;
>   	plug->nr_ios = min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 2f9ceea0e23b..23c237b22071 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -942,6 +942,7 @@ struct blk_plug {
>   
>   	/* if ios_left is > 1, we can batch tag/rq allocations */
>   	struct request *cached_rq;
> +	u64 cur_ktime;
>   	unsigned short nr_ios;
>   
>   	unsigned short rq_count;
> @@ -977,7 +978,15 @@ long nr_blockdev_pages(void);
>   
>   static inline u64 blk_time_get_ns(void)
>   {
> -	return ktime_get_ns();
> +	struct blk_plug *plug = current->plug;
> +
> +	if (!plug)
> +		return ktime_get_ns();
> +	if (!(plug->cur_ktime & 1ULL)) {
> +		plug->cur_ktime = ktime_get_ns();
> +		plug->cur_ktime |= 1ULL;
> +	}
> +	return plug->cur_ktime;

I did not understand the relevance of 1ULL here.
If ktime_get_ns() returns even value, it will turn that into an odd 
value before caching. And that value will be returned for the subsequent 
calls.
But how is that better compared to just caching whatever ktime_get_ns() 
returned.
