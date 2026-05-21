Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1030B508
	for <linux-block@vger.kernel.org>; Thu, 21 May 2026 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376330; cv=none; b=T0Xa/vSOygZh+KJYOOYg45eG9mvRhQIDuwL/M3GvY2h1Z3fwMjlBXpseAW7tu2r9XCDjR7H9Tdc5YSFm32opfxRX3YLqk51x//LShrPOyyjdN3e8daEEMCC1FCKXuhGLTXCoAv927am3fR5dFfPIYM5BnusR8n/wEuGfmuWHzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376330; c=relaxed/simple;
	bh=5b6dDd/apBw83ZNkyNbAf6r0CcFd7s92qdQXrIM9H5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qe12us4RLg2Y1JlHkevgVF4MLnyn/0KZuRtkiICQMcvlePOPWMzkJ8RUGYB/2saRY9IuIV7RmPuM2l1SLtSywrQFkUB9VJ1a9+E4N5fKr1ZCwIjD7qTQlvk5/rnXYJt/Hnoc8nTVpedlTEgrdGdSfHfbH3dY+VkW+tVvOs6RWIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=rbty/kQI; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="rbty/kQI"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dcdd1b492eso6272808a34.1
        for <linux-block@vger.kernel.org>; Thu, 21 May 2026 08:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779376327; x=1779981127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORM6eIAyeQum/nN9TYnGomW73Bgxy7Sx7S8mEjZOcd0=;
        b=rbty/kQIbdJbFXr0DMjZWFDqWajK1tH/ycS4KDcciNDte4aeBqF4yQCZkSV1CRr0C3
         jOecBjp3+4NZrkdOkEoZ6FzNydIQ2p0R1ogprLTdKBXW/PrmVceP5/e5sttuRKIDJnVX
         jcbcseHB9AIlHV90St7nZOeg1gdIDMXmRbWiiytFgJgS3IULrNmzeGtzP4+jOX2EBQTC
         3QnhX5JoMj3S1FirpmwfqAhWdDoJ2Ic4NKTw7PNpxfZJTJACG2tj/X88cHPx/7aDTlCl
         UO0gPtO5I57U5COlsD9XyeaRPDDXa+2fUfazgC4i0xfOLSwF5wXQt71IoFfeGlWXYpn2
         EHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779376327; x=1779981127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORM6eIAyeQum/nN9TYnGomW73Bgxy7Sx7S8mEjZOcd0=;
        b=eTqjRl+pc1EyOin47sfRXNgY5qp+MTfNhGiaBKnWtOff95cnEm2gtrNIv2dXg5o8Pp
         JQ8V5S5zXSfR8SzbXvtI5p4WzYqwzS1ZEWEOAQ7tYpOMkiZUsRu3eXAJ4yF8J6ERpdqF
         GsPtfZLmS+A6A3iszTbAh/6TXGC4nnscbo7xC8EzJkfJCeMolw+gJij+UXEn+nvZexUK
         f+N3BWkxV2UyWuqT64vsRgt6H855MZTxl5JJhh+gYz3pGungt2i//uNVB9/jH0QBeKp7
         CvxXnJKHRjTAGRQd9brToX6AGh6shDMNADY4IR4+m++spWJVCF+iVktDCUzz9VoPtFW6
         Zn8w==
X-Forwarded-Encrypted: i=1; AFNElJ+lFj9sh+d8zs3uBAU5ZiLB6oNjwYQvh9IUQc+HgFImeoh4TO4rV/IZkNs98F+G6sQE5Qcxm+7bEISTqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp1OJHAPM/w383IfyoVr8wFQaxiwB0QI5HtfjJCqFhYhMTYV42
	9CsxSU9Rns5GC3G2TZ14NOcPfpFBG6Fg/R5Lht64TrEYrPRvMD5gR3PLVOmB9tUF4ZkjXdabiX8
	5M8k4
X-Gm-Gg: Acq92OEXfssuF1H4nVYAMyfHygsH0iXZ8sjaojHRw0j8hf1L3L2SANJSz8e5gC8fE8k
	iHFqjFdeuz1DSnlcRBAqwGUhkL4ylWHF+Aq91xI7Lw/ydlSMnwzTVIlv2lo02H3ZyWLNXtyUy3v
	3y3FtzXcWCxrpuD0c7R7l8F2F3gMHf8n7Eq+qCq9NesbdCZ8un+WbEW8nba//lmc2pWyhTK4TVm
	w5CBlVo6afenQcZ8iEo902rwXO0f0ot5JJF7RHpBxqbhgXsfwUL6Ei7eRb8YyNHzjkN8gBcajBx
	4yJhIYRzDxAiFfbRpmB+w+7p7oRkbJ2TkZiQFf2NzgSfhn3G7Wc0bTSJtIzY9jV/y0L9J+Czu8O
	0RDB+c93ESjTCzydUC836Fe6wMptrOGeC3Uyi62uPrA0BTG1lScooKfuGHlTniMdCWe7ubiGMfj
	PLAcpi3WNqaI7PZKvuz4lJZtdBBZ2VbBhndwf7OuvYVpRTq1Cca7mENybquhyXPISmlxqlGJLfs
	UvUbr4jQhOJ/LqRXMo=
X-Received: by 2002:a9d:6a50:0:b0:7de:cf3f:1b3d with SMTP id 46e09a7af769-7e5ea37d7c9mr1366920a34.7.1779376327187;
        Thu, 21 May 2026 08:12:07 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e5f6eb30e7sm624016a34.23.2026.05.21.08.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 08:12:06 -0700 (PDT)
Message-ID: <89c94510-abb6-485c-87c4-73364c8f6914@kernel.dk>
Date: Thu, 21 May 2026 09:12:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: always take a queue reference in
 blk_mq_submit_bio
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, linux-block@vger.kernel.org
References: <20260520084905.1092158-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260520084905.1092158-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/26 2:49 AM, Christoph Hellwig wrote:
> When submitting a bio to blk-mq, if the task should sleep after peeking
> a cached request, but before it pops it, the plug flushes and calls
> blk_mq_free_plug_rqs, freeing the cached_rqs. This creates a
> use-after-free bug.
> 
> Fix this by alway grabbing a queue usage reference in blk_mq_submit_bio.
> While past commit claims that this is slow, we're better safe than
> fast as a first priority.
> 
> The code had already warned of this possibility, and specifically popped
> the request before other known blocking calls, but it didn't handle a
> blocking GFP_NOIO alloc. Under memory pressure, allocating the split bio
> or the integrity payload are two such cases that can block. The blk-mq
> submit_bio function continues using the peeked request that was already
> freed and re-initialized, so the driver receives that request with a
> NULL'ed mq_hctx, and inevitably panics.
> 
> Large parts of the commit message are stolen from an earlier attempt
> to fix this issue by Keith Busch <kbusch@kernel.org>.

This is about a 5% regression in peak performance, fwiw. I'm all for
eliminating this issue, but this kind of big hammer approach is pretty
crap in terms of adding overhead to the IO path. Maybe we just cover
blocking split bio case, and look into doing a proper fix for 7.2 that
isn't such a massive regression?

-- 
Jens Axboe
