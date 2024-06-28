Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8015886A
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719591405; cv=none; b=SCMQxnZhCk8C3lwEcV2Htm7amTXw/aFwSpuZJile/JZwjf2NV9wI8sn/XnuY0vY2jNeouMWqzhEkO+iuCF8iydMjk3f+VUtfBe2quol+EwpuhC1ej3ed3jfNxtDMNpS6PqRnJ8jVBGnh9PcfPDvm4jf8QSivR66lLMT5hXA4NGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719591405; c=relaxed/simple;
	bh=On+m+CsmAtranPrQo+v+RKVmTSNdwS86WEoaDnCivQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=qeQ2cETHRM0OwBd0zi8AVaC0Nw0wNIbvuhHatgpLuP7L5SlSkc55SJtZPgEdhXWBnrEImzw5zVS4q3Po+LqQxEf3F3GDXK+shx6kyea2arieem2xdw3QgFPx1b/Ul5wSW+uxVk7RA2QY1i15UXdHgZGtx7mK7t9YDW0eDIpG188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kdC1V3WK; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kdC1V3WK"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240628161634epoutp04c819a6d8a907917a911b4686d8acfb14~dN0MmGJn20768107681epoutp04j
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 16:16:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240628161634epoutp04c819a6d8a907917a911b4686d8acfb14~dN0MmGJn20768107681epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719591394;
	bh=SPgpRhbRHIjF+rY0g5KUuJV7ty5RcJwO6Mma/cQ2gkY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=kdC1V3WKe+gBX9fgQUy4BKJGZo+gtV86Kw26ptexzaFfa03O1IU/FYGDmoBuAveYN
	 5DofxubsCkduslPIv5zXMiqjYWeqlIIAC66hSl87auZ4i3Zc1S+xQtkelXvicXLIma
	 KQ6LBZWgv+GGmx+wLUDkoXfbCfIJ4Z8wZ+c7c0ss=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240628161633epcas5p302f92211478272baaea265790b0cee4e~dN0MRsVrW3274932749epcas5p3k;
	Fri, 28 Jun 2024 16:16:33 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4W9gYD1gs3z4x9Pt; Fri, 28 Jun
	2024 16:16:32 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.73.07307.0E1EE766; Sat, 29 Jun 2024 01:16:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240628161631epcas5p15a924d417d6f244a882bb1b241c7b66d~dN0Kbh_uB0040200402epcas5p1Y;
	Fri, 28 Jun 2024 16:16:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240628161631epsmtrp2d89a01febf55bac5f43e8965f81ffa4a~dN0Ka4c4u0684906849epsmtrp2s;
	Fri, 28 Jun 2024 16:16:31 +0000 (GMT)
X-AuditID: b6c32a44-3f1fa70000011c8b-5a-667ee1e0da46
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	95.0C.29940.FD1EE766; Sat, 29 Jun 2024 01:16:31 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240628161630epsmtip2c8afc2138ff59af886216439f89c5832~dN0JczmvW2361323613epsmtip2T;
	Fri, 28 Jun 2024 16:16:30 +0000 (GMT)
Message-ID: <43ba3da2-8645-a255-0db8-c0352eb9d3d7@samsung.com>
Date: Fri, 28 Jun 2024 21:46:21 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 3/3] block: don't free submitter owned integrity payload
 on I/O completion
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240628132736.668184-4-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTS/fBw7o0g7lXuS2aJvxltlh9t5/N
	YuXqo0wWe29pWyw//o/JgdXj8tlSj903G9g8Pj69xeLRt2UVo8fnTXIBrFHZNhmpiSmpRQqp
	ecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAq5UUyhJzSoFCAYnFxUr6
	djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eaklVoYGBkamQIUJ2RkL9r1nL7gmVPGt
	o4GtgfEAXxcjB4eEgInElBMJXYxcHEICuxklLt1tZoNwPjFKvJzRywjhfGOUOLZsA2sXIydY
	x61P86ASexklbk78ygrhvGWU+HWxmwWkilfATmLH+qusIDtYBFQlNi0PgAgLSpyc+QSsRFQg
	WeJn1wE2EFtYIEFi9bmjYAuYBcQlbj2ZzwRiiwg4SMzesJQNIl4hMfXeMzaQkWwCmhIXJpeC
	hDkFDCV2t7YzQpTIS2x/O4cZ4s6f7BK7PvFD2C4SK571sUDYwhKvjm9hh7ClJD6/28sGYWdL
	PHj0AKqmRmLH5j6of+0lGv7cAPuEGWjt+l36EKv4JHp/P2GCBCKvREebEES1osS9SU+hOsUl
	Hs5YAmV7SCw5sw4atqsZJZ49W8g4gVFhFlKgzELy/Cwk38xC2LyAkWUVo2RqQXFuemqyaYFh
	Xmo5PLaT83M3MYKTpZbLDsYb8//pHWJk4mA8xCjBwawkwsufWZcmxJuSWFmVWpQfX1Sak1p8
	iNEUGDkTmaVEk/OB6TqvJN7QxNLAxMzMzMTS2MxQSZz3devcFCGB9MSS1OzU1ILUIpg+Jg5O
	qQamnREfNWt366jKS1yfkGewyeW0jWdg6Y7GubeXnkzpfOz/nanCad/R1KdWmu9eGK5MbdZ/
	8nSqy71vv2/0+NptOPue48vk0tnvfy/zWeHw7YfmgQVLBI7Pm3iv5bZE21p7uxzPi/K2Pf4P
	hDqb9u3uD1VtOR799tPRiMcXvmsnmRT5hajd80koWxhy7u3Rtb/3O3LynWCSU1ksIyz4ed5c
	w4opsu8/fFfLXXd187wzp502pL86yLGuOGLK4/jnB06l7HbcdnLvlKyXWXOqzyeoCz3m/m7F
	XJvy/+j5Syb9py0P/M/6JCOV8dI8tS6/51DjolDeoGXzjrwpFFkoLb3yR9SLpp2sF9w7WKbK
	Nt4S2abEUpyRaKjFXFScCABys6EGHwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvO79h3VpBjNO6Vs0TfjLbLH6bj+b
	xcrVR5ks9t7Stlh+/B+TA6vH5bOlHrtvNrB5fHx6i8Wjb8sqRo/Pm+QCWKO4bFJSczLLUov0
	7RK4Mhbse89ecE2o4ltHA1sD4wG+LkZODgkBE4lbn+YxdjFycQgJ7GaUOLvzIRtEQlyi+doP
	dghbWGLlv+fsEEWvGSV+b7jLBJLgFbCT2LH+KmsXIwcHi4CqxKblARBhQYmTM5+wgNiiAskS
	L/9MBJsjLJAgsfrcUVYQmxlo/q0n88HGiAg4SMzesJQNZAyzQIXEnZWFEKtWM0r8+dLPCBJn
	E9CUuDC5FKScU8BQYndrOyPEGDOJrq1dULa8xPa3c5gnMArNQnLFLCTbZiFpmYWkZQEjyypG
	ydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjODY0NLcwbh91Qe9Q4xMHIyHGCU4mJVEePkz
	69KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ84q/6E0REkhPLEnNTk0tSC2CyTJxcEo1MB3Tm7wq
	+/imxwerldkX31Pyqcu75DiL5/Yf5XXRD/tcrh1+b/HcPLxWcuLZPdkSzqzFc+tseH7ExN65
	evfCp/uOv+/vY3S33nhvs9yEw//V1b69ddtQtM/bsTat58YCCdFzO78mK6tdXOp4ZIrMef7w
	4O2typyTWz3/rNVNPMTAIxjh+SvOzbFd+nlIYIhssO3Sz09mZ08VOWiyLHblLi1hzcbktjdZ
	Lh3SdpLsc3fsufUt+LOWftjvaL+U0Mnmlw5b/VL0Nop2um53JvDGy26dmPuLphVYOMZsje1b
	XqHZrDdN0E6duf0ns1iL7QvdT0ck3ylMbbi3cfWxW4+3mz/nb3CZVxB0tzzzYPEWQyWW4oxE
	Qy3mouJEAILQ70j8AgAA
X-CMS-MailID: 20240628161631epcas5p15a924d417d6f244a882bb1b241c7b66d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240628132757epcas5p1760f53ce802e725626a37f9f1e4d8f2c
References: <20240628132736.668184-1-hch@lst.de>
	<CGME20240628132757epcas5p1760f53ce802e725626a37f9f1e4d8f2c@epcas5p1.samsung.com>
	<20240628132736.668184-4-hch@lst.de>

On 6/28/2024 6:57 PM, Christoph Hellwig wrote:

Thanks for streamlining this. Few comments below.

>   static inline bool bio_integrity_endio(struct bio *bio)
>   {
> -	if (bio_integrity(bio))
> +	struct bio_integrity_payload *bip = bio_integrity(bio);
> +
> +	if (bip && (bip->bip_flags & BIP_BLOCK_INTEGRITY))
>   		return __bio_integrity_endio(bio);

Seems we will need similar BIP_BLOCK_INTEGRITY check inside bio_uninit 
too. At line 221 in below snippet [1].
As that also frees integrity by calling bio_integrity_free. Earlier that 
free was skipped due to BIP_INTEGRITY_USER flag. Now that flag has gone, 
integrity will get freed and after that control may go back to 
nvme-passthrough where it will try to unmap (and potentially copy back) 
integrity.

>   	return true;
>   }
> diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
> index 7b6e687d436de2..a5a8b44e9b118f 100644
> --- a/include/linux/bio-integrity.h
> +++ b/include/linux/bio-integrity.h
> @@ -10,8 +10,7 @@ enum bip_flags {
>   	BIP_CTRL_NOCHECK	= 1 << 2, /* disable HBA integrity checking */
>   	BIP_DISK_NOCHECK	= 1 << 3, /* disable disk integrity checking */
>   	BIP_IP_CHECKSUM		= 1 << 4, /* IP checksum */
> -	BIP_INTEGRITY_USER	= 1 << 5, /* Integrity payload is user address */

Seems this patch is with "for-6.11/block".
But with "for-next" you will see more places where this flag has been 
used. And there will be conflicts because we have this patch there [1]. 
Parts of this patch need changes to work with it. I can look more and 
test next week.

[1]
commit e038ee6189842e9662d2fc59d09dbcf48350cf99
Author: Anuj Gupta <anuj20.g@samsung.com>
Date:   Mon Jun 10 16:41:44 2024 +0530

     block: unmap and free user mapped integrity via submitter

     The user mapped intergity is copied back and unpinned by
     bio_integrity_free which is a low-level routine. Do it via the 
submitter
     rather than doing it in the low-level block layer code, to split the
     submitter side from the consumer side of the bio.

[2]
213 void bio_uninit(struct bio *bio)
214 {
215 #ifdef CONFIG_BLK_CGROUP
216         if (bio->bi_blkg) {
217                 blkg_put(bio->bi_blkg);
218                 bio->bi_blkg = NULL;
219         }
220 #endif
221         if (bio_integrity(bio))
222                 bio_integrity_free(bio);
