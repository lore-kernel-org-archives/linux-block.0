Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AAE3ED124
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946864; cv=none; b=BSG2PUldcfqrt1XMHAIibZSjwSVdbOYAb3lP5EVKej9xiVVDZFg/CBmwks5lGnsYvdMPq8WMjSY00IX0qttBn8W329jBAxvvcd+8Y3Z1l2pyGOt2gqkfBxOjGhmg2XFHxxs3jDHn6kXfaLs3F6i/lVXU3WRhq41QNNlSMBXQ0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946864; c=relaxed/simple;
	bh=nMa6lgdt+RFQjrnlQOt0uonW8xi6IIy1XP1EMTMpGXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=dzSgpEYt6doA1GSU2W75mS4yqXFPjYv769SgI4yhtcvWwgET4fvX+weUgxUhLeuXR3SqOAeNVbHTPP0ogibJITsrPvzoPHKzpNZXF9t/du4a1wOTugzk12CcHUURcMbDhul2bzfvDpbEv8ymN6xXqe2q5tAIgpT8ymHbSaHgTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=F2WIMq07; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F2WIMq07"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260331084728epoutp017b07e330c1de95d89038c47f2cfd2ff4~h4MET__4j0893608936epoutp01p
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 08:47:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260331084728epoutp017b07e330c1de95d89038c47f2cfd2ff4~h4MET__4j0893608936epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774946848;
	bh=qLB5MRC6sh6mDjrX9LIvM7q6klFfOWi0+tZ3drPtkZw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=F2WIMq07mvyomyYx3T7q9DIvS8vrf0ulTBiQSk/oB03lXwvs6hdu5v/nuw+9Y++Od
	 YtxBqGPneOp4/UAdSdtETJ0kO5an3TfdmcbbV7zcWpLCW2tcWq5redK6DFhqVYpWwV
	 gKs1nadsAwFFtAxktQk12Tdn7GjOt3na5qTz5UFM=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260331084727epcas5p4a3fe946de254ee65e1aec1c76d1cbacd~h4MD888h71596215962epcas5p4B;
	Tue, 31 Mar 2026 08:47:27 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.91]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4flMFB4WNRz6B9mH; Tue, 31 Mar
	2026 08:47:26 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260331084726epcas5p4cee1981e996fb9c68ce4734e790bd36c~h4MCpQMrl0907109071epcas5p40;
	Tue, 31 Mar 2026 08:47:26 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260331084725epsmtip262e2230a4bb43c83f2b4351e9ade5e2f~h4MBgzYso0275002750epsmtip2c;
	Tue, 31 Mar 2026 08:47:24 +0000 (GMT)
Message-ID: <c7c7d273-9012-47df-841c-156fedd8edb6@samsung.com>
Date: Tue, 31 Mar 2026 14:17:23 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Fix general protection fault in
 bio_integrity_map_user()
To: Sungwoo Kim <iam@sung-woo.kim>, Jens Axboe <axboe@kernel.dk>, Keith
	Busch <kbusch@kernel.org>
Cc: Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>, Dave Tian
	<daveti@purdue.edu>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260330230256.4160820-2-iam@sung-woo.kim>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260331084726epcas5p4cee1981e996fb9c68ce4734e790bd36c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260330230512epcas5p3edfcbd6e163aab8b238c317418abb7a2
References: <CGME20260330230512epcas5p3edfcbd6e163aab8b238c317418abb7a2@epcas5p3.samsung.com>
	<20260330230256.4160820-2-iam@sung-woo.kim>

On 3/31/2026 4:32 AM, Sungwoo Kim wrote:
> pin_user_pages_fast() can partially succeed and return the number of
> pages that were actually pinned. However, the bio_integrity_map_user()
> does not handle this partial pinning. This leads to a general protection
> fault since bvec_from_pages() dereferences an unpinned page address,
> which is 0.
> 
> To fix this, add a check to verify that all requested memory is pinned.
> 
> KASAN splat:
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> RIP: 0010:_compound_head home/wukong/fuzznvme/linux/./include/linux/page-flags.h:240 [inline]
> RIP: 0010:bvec_from_pages home/wukong/fuzznvme/linux/block/bio-integrity.c:290 [inline]
> 
> Fixes: 492c5d455969 ("block: bio-integrity: directly map user buffers")
> Acked-by: Chao Shi<cshi008@fiu.edu>
> Acked-by: Weidong Zhu<weizhu@fiu.edu>
> Acked-by: Dave Tian<daveti@purdue.edu>
> Signed-off-by: Sungwoo Kim<iam@sung-woo.kim>
> ---
> V1:https://lore.kernel.org/linux-block/20260308001358.1675543-2-iam@sung- 
> woo.kim/T/#u
> V1->V2:
> - v1 incorrectly assumed pin_user_pages_fast() returns bytes. Fixed.

But this function does not call pin_user_pages_fast(). It calls 
iov_iter_extract_pages() which returns in bytes. So v1 maybe better than 
this patch?

> 
>   block/bio-integrity.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index 20f5d301d32d..992ce39e8ab9 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -338,6 +338,15 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
>   					extraction_flags, &offset);
>   	if (unlikely(ret < 0))
>   		goto free_bvec;
> +	if (unlikely(ret != nr_vecs)) {

ret is in bytes and nr_vecs is in pages. Almost always we will go inside 
and throw failures for perfectly valid case. No?

> +		for (int i = 0; i < ret; i++)
> +			unpin_user_page(pages[i]);

And out-of-bounds access here.

> +
> +		if (pages != stack_pages)
> +			kvfree(pages);
> +		ret = -EFAULT;

