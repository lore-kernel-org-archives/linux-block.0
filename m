Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707B912E71;
	Mon, 15 Jul 2024 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064370; cv=none; b=Q9eNXbOV/CSzXej1+EWOkbNCVB/A7kU6wKWIEKO/WryvjfeEGpNZHtDi9fmxQEAuttIwTMeMkt1XOC4ezXFaE/YTfvy3F5sLgBFot1i3SKw90j5ewpTqP28hwMcF1WUXVBezwIkLhRJabVNdHOFkmkRoUXpoMnoT7xIRIlVp20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064370; c=relaxed/simple;
	bh=uKuHsbv4jGYyMGBfTyyD2xkIBlkTwnThjcKpU2QB5kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eCE3p7cHqsK2zpYdwj+db/yPBAUnKgNdfe+0VUpmIP9aJew6RypLN0DtCqyKggvBkjS0JxNeo9vW2RvjjZ78kjrEfw6a/cvjENkZ9OVdqWBjAGMZTLqaj86LyjzypjPBYsVgvQj0grWCLEIA86p0vTFIW+Cbl0sg939HVT03f84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vG9InMy4; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vG9InMy4"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WN8Hg6MtRzlgMVQ;
	Mon, 15 Jul 2024 17:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1721064365; x=1723656366; bh=xzvgrre+HJgfaADmusVjaYvJ
	yf2ILqrGPTKg4Ps2YVc=; b=vG9InMy4gHp1nGXdLX85iEf7YJAXCqZkliNFIDuZ
	fBpKz3zS+BvRifkbNRrSitMB+v1iy4KnsPejzgCKi3NYHy7gP7DpaMHa+NgTjV3N
	nLD0rr53xlwLby1edMDQstTlJsVLW0DikWOmpSE8JY/0S3ph4EDVgGiaYHGv1QKW
	u6k9Nn6XCd3bwJL8Vrsdi0vPP19xYuKNliOKcLeIfX8hNa3QfXYNSH6PKQEArN55
	ZI9vi8Vde9CbPBIjqHg7pE2UvzzXN+hBi89uQAdBNyklVv+31DnYrssxLK7HyQQ5
	YvzymyjzZfUFXR/qundDj7EJ+qvrgN1VGWo9Lz56obBLSg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id V40ZX-cgwAAb; Mon, 15 Jul 2024 17:26:05 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2e14:8:30c:88a5:456e:8b88] (unknown [104.135.204.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WN8Hc1nQ5zlgMVL;
	Mon, 15 Jul 2024 17:26:04 +0000 (UTC)
Message-ID: <263282cd-dadc-43f7-be8f-892248bc3318@acm.org>
Date: Mon, 15 Jul 2024 10:26:03 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
To: Yang Yang <yang.yang@vivo.com>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20240715091125.36381-1-yang.yang@vivo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240715091125.36381-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/24 2:11 AM, Yang Yang wrote:
> +
> +	/**
> +	 * @swap_lock: serializes simultaneous updates of ->word and ->cleared
> +	 */
> +	spinlock_t swap_lock;
>   } ____cacheline_aligned_in_smp;

Thank you for having updated this comment.

> -static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
> +static inline bool sbitmap_deferred_clear(struct sbitmap_word *map,
> +		unsigned int depth, unsigned int alloc_hint, bool wrap)
>   {
> -	unsigned long mask;
> +	unsigned long mask, word_mask;
> +	bool ret = false;
>   
> -	if (!READ_ONCE(map->cleared))
> -		return false;
> +	guard(spinlock_irqsave)(&map->swap_lock);
> +
> +	if (!map->cleared) {
> +		if (depth > 0) {
> +			word_mask = (~0UL) >> (BITS_PER_LONG - depth);
> +			/*
> +			 * The current behavior is to always retry after moving
> +			 * ->cleared to word, and we change it to retry in case
> +			 * of any free bits. To avoid an infinite loop, we need
> +			 * to take wrap & alloc_hint into account, otherwise a
> +			 * soft lockup may occur.
> +			 */
> +			if (!wrap && alloc_hint)
> +				word_mask &= ~((1UL << alloc_hint) - 1);
> +
> +			if ((READ_ONCE(map->word) & word_mask) == word_mask)
> +				ret = false;
> +			else
> +				ret = true;
> +		}
> +
> +		return ret;
> +	}

Now that guard()() is being used, the local variable 'ret' can be 
eliminated. The if (READ_ONCE() ...) statement can be changed into the
following: return (READ_ONCE(map->word) & word_mask) != word_mask;
and "return ret;" can be changed into "return false;". Additionally,
the indentation depth can be reduced by changing "if (depth > 0) {" ...
into "if (depth == 0) return false;".

Otherwise this patch looks good to me.

Thanks,

Bart.
