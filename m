Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A4E1DD54C;
	Tue, 17 Dec 2024 21:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472047; cv=none; b=heBUdPreVPux+2hYER60Z73Q3eQm5UoEmGKBwZyT0C79iJoFgKrGt+GTT7IZ+ai+b0Gel3qwDwOqh8ZcG44/f5BpjG5S1hwL4IctSyhl/BlEgItue/IgZLvgCbXmjRGF2QRsm9pMovwpR3oW+vAmaqApslr7U2XwFbk5MOl3GOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472047; c=relaxed/simple;
	bh=pYyX1T/5vK2+5pV8VU/rJ/K/+cNIGuO1HaL7v0uBAfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBqkqZUdWFSqUqsLFeM9QznUMZcKXf5Hom5z6NQ0VZrvNQ6DZPD8O7Y9/kQHquCwtYhKBtrcvSQ0wcpvrbFbPZncsxWamf8YdkyGa1POQVZmSedwLcRKlOTB9vVlG68lX1QIa2IjcNjznq/I9lRLJ0RzGVm/e3AogiUhO3a1nmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YWoIsZoe; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YWoIsZoe"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YCVld3CRCz6ClY9C;
	Tue, 17 Dec 2024 21:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734472036; x=1737064037; bh=oKc3I7/BFaJjoh8h/Omv70y7
	8k6J2IuKTo+Wlw0Dg8E=; b=YWoIsZoeUpFXDc6cTr2oX4nSRWQYxxJ8eNk3ZPZX
	GTKEUOqfY9bLa2s06i9EiFmhKdc8tzD4AFXdsHmUOMj/zZxo7haxGXVSwuHHmmq+
	XzuFNXqjuftS92EddbPzTeB3YeDcI3uf0H8RaPu25IE/DZZ1hlFZK/LyV+ETtl0f
	BGGFMOEuk2bOw55GKXrfiJ2TozD39lMmncYptbLI0GOcrnezzQ0oTDtRnjhXRSy4
	lLetMaff7cqcoRrYCpouCoDe+RW2PJD+oYrM8AqIFcHFoayixhWtK/GHr+J6lYDh
	hZL+JyVoo+nQ37hGOhoHi9G9qVAcp6xXu4cpaoAn7Lcyhg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XX7dlaQA97iz; Tue, 17 Dec 2024 21:47:16 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YCVlP1X5qz6ClY94;
	Tue, 17 Dec 2024 21:47:12 +0000 (UTC)
Message-ID: <698a01e6-cb03-43a2-a0f1-5c8555dea8c1@acm.org>
Date: Tue, 17 Dec 2024 13:47:11 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RFC 2/4] lib/sbitmap: fix shallow_depth tag allocation
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 akpm@linux-foundation.org, ming.lei@redhat.com, yang.yang@vivo.com,
 osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20241217024047.1091893-1-yukuai1@huaweicloud.com>
 <20241217024047.1091893-3-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241217024047.1091893-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 6:40 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, shallow_depth is used by bfq, kyber and mq-deadline, they both

both -> all

> pass in the value for the whole sbitmap, while sbitmap treats the value

treats for -> applies to

> for just one word. Which means, shallow_depth never work as expected,

work -> works

> and there really is no such functional tests to covert it.

is ... tests -> is ... test or are ... tests

covert -> cover

> Consider that callers doesn't know which word will be used, and it's

Consider -> Considering
doesn't -> don't

> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index 189140bf11fc..92e77bc13cf6 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -213,12 +213,12 @@ int sbitmap_get(struct sbitmap *sb);
>    * sbitmap_get_shallow() - Try to allocate a free bit from a &struct sbitmap,
>    * limiting the depth used from each word.
>    * @sb: Bitmap to allocate from.
> - * @shallow_depth: The maximum number of bits to allocate from a single word.
> + * @shallow_depth: The maximum number of bits to allocate from the bitmap.
>    *
>    * This rather specific operation allows for having multiple users with
>    * different allocation limits. E.g., there can be a high-priority class that
>    * uses sbitmap_get() and a low-priority class that uses sbitmap_get_shallow()
> - * with a @shallow_depth of (1 << (@sb->shift - 1)). Then, the low-priority
> + * with a @shallow_depth of (sb->depth << 1). Then, the low-priority

(sb->depth << 1) -> (sb->depth >> 1)

> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index d3412984170c..6b8b909614a5 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -208,8 +208,27 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
>   	return nr;
>   }
>   
> +static unsigned int __map_depth_with_shallow(const struct sbitmap *sb,
> +					     int index,
> +					     unsigned int shallow_depth)
> +{
> +	unsigned int pre_word_bits = 0;
> +
> +	if (shallow_depth >= sb->depth)
> +		return __map_depth(sb, index);
> +
> +	if (index > 0)
> +		pre_word_bits += (index - 1) << sb->shift;

Why "index - 1" instead of "index"?

> +
> +	if (shallow_depth <= pre_word_bits)
> +		return 0;
> +
> +	return min_t(unsigned int, __map_depth(sb, index),
> +				   shallow_depth - pre_word_bits);
> +}

How about renaming pre_word_bits into lower_bound?

Otherwise this patch looks good to me.

Thanks,

Bart.
