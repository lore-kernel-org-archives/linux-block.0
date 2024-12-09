Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D731F5F6;
	Mon,  9 Dec 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767549; cv=none; b=PNM9JlydLKDVv6CibI+80MIypeZelVsgopnPX3VQRtU+N6Yix2XZC6pNZlk873EOyRcBXMP137L6S1mgb+SBVjS0QImHOL0WPItpflWyTO5fC4+ZCJAYl3+Xf2sRjJqt+Q8kWcBJDJCvMH34vbQDupt2FZsdJ95siY6RvLCj/jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767549; c=relaxed/simple;
	bh=Pp7lI+ou7urfQHOD0BarCGanmUgLWiyXQK9Br+QYCmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=feeT7yVxmKACIgzfjBr8NSOg5mS2J+eeZmbfPGhSjG8VJ5xaLRl+sV1Gitq3XbpX12aSbG/FFicHhs4rEiAk+j2+VlYrN8Oyhkaa3QuPXUV+ONJ/OA2tXxwTOQvvZ4VesiQ+zA9cxq77vPnJrtiVJ7ww6SlkGyIjvDJ73h1uE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Ocaz0G9P; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Ocaz0G9P"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Y6VCZ61Slz6CmM6N;
	Mon,  9 Dec 2024 18:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1733767540; x=1736359541; bh=Pp7lI+ou7urfQHOD0BarCGan
	mUgLWiyXQK9Br+QYCmQ=; b=Ocaz0G9PWgVoOgOGOS9WO/rk97F53OoT9jxcxnQC
	EizS+6kYhImjjNKpN9EfRpFJuei/7RMg7WSdZbR+1qwyFmEZYuIbhAzMAe0crBAI
	OMlqN1/LO4VvTITqe0dlc9plDkQ8eIlKw3Gguj/xXbBWm0aCziL0Fc79FLU/LKBD
	scBVSt7bKWDiJEUcfr3GgW7uwscXiXKZS5iS+hFw8eqx//nBnpm3K07xe+NbWLce
	K8JvaLadXyPftPpKmN3SS2giSIVF1GMvM2xlA3MFuZQ76YZinM9ViOs2s1X00OOb
	YOSdwadoELo6CuUnoiSehrHWvNHCZbbZPRzcA90pYHG0og==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xrtsgesCzJ9p; Mon,  9 Dec 2024 18:05:40 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Y6VCM0HNSz6CmQtQ;
	Mon,  9 Dec 2024 18:05:34 +0000 (UTC)
Message-ID: <87f569d6-fb17-4d3b-8075-1a74d11148a9@acm.org>
Date: Mon, 9 Dec 2024 10:05:32 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] lib/sbitmap: don't export sbitmap_get_shallow()
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 akpm@linux-foundation.org, yang.yang@vivo.com, ming.lei@redhat.com,
 yukuai3@huawei.com, osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com
References: <20241209115522.3741093-1-yukuai1@huaweicloud.com>
 <20241209115522.3741093-3-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241209115522.3741093-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/24 7:55 PM, Yu Kuai wrote:
> -/**
> - * sbitmap_get_shallow() - Try to allocate a free bit from a &struct sbitmap,
> - * limiting the depth used from each word.
> - * @sb: Bitmap to allocate from.
> - * @shallow_depth: The maximum number of bits to allocate from a single word.
> - *
> - * This rather specific operation allows for having multiple users with
> - * different allocation limits. E.g., there can be a high-priority class that
> - * uses sbitmap_get() and a low-priority class that uses sbitmap_get_shallow()
> - * with a @shallow_depth of (1 << (@sb->shift - 1)). Then, the low-priority
> - * class can only allocate half of the total bits in the bitmap, preventing it
> - * from starving out the high-priority class.
> - *
> - * Return: Non-negative allocated bit number if successful, -1 otherwise.
> - */
> -int sbitmap_get_shallow(struct sbitmap *sb, unsigned long shallow_depth);

Please retain the above comment block by moving it into lib/sbitmap.c.

Thanks,

Bart.
