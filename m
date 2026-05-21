Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A959F3C3BF4
	for <linux-block@vger.kernel.org>; Thu, 21 May 2026 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390348; cv=none; b=l1xW2QEREVqJaTs9LJJBs3a9qQ4XIE/Tc0Om3Y9KMDrHU848sUWmKcPlmg2mE446ny3WTHnSVaeVUMkfbys7EsfrB/I4T8Chx8Rk6bwJwlLSSoVKmDSX0pim+cGim7iQh4Jy5OzSsfNykPufUf4odVuKkqiQR4aNFl4vjxJX7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390348; c=relaxed/simple;
	bh=EsDQ+bjGGGBE7U1va5RDEvpoMq2T3HTdiZvqDkpAs6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqGn6jxNPj/n7Ea8DoShuCFceW8S7L9I6N2N8rbduTiDgL2d8OHHvJb+UPedcmLVwDGcJT6RJmMQFHpnI+4gvS3iAs9GindNI4haOGcPsUCPJmTl3CFkm++0X6n+yokNCVTK/I29GTPguTtajpBGbrrkGSGTcjRzjrkAwmfO5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=DsT2tf64; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="DsT2tf64"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-484cf882ce5so4488595b6e.1
        for <linux-block@vger.kernel.org>; Thu, 21 May 2026 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779390341; x=1779995141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GKZWfxUS+4Tb1YFOg6z2FhYi+KBYNtAoDv3dZXK4Wf8=;
        b=DsT2tf64FL9Lz4Fu4KHIagfEeEmca2BKUrbT04t7Gw33V87CF7V/iw5YGN2ZAFu2c2
         ddERfZauIkT7t39rbtdxZHoPUMbEpT38OKtWgljTeyZ6YNrVL0k+l7AX94j2Hyne+6vd
         0wwdHrzBeZozUObtXsWAIM6Hu5e8bFxnH46VGz++flqeVahWNeUBMYGk6XYLNeq+JZMg
         LpefKS0xw5rLXtpFj0zQ9rTaGnyB0OmczMVBsW9DunMeYg1KDBM7KLjfO1V1qdSj6tF8
         3a4ttHd22C9ZXv2X1XZrKCGvhM7aOZFrEYEZwzAx4dvv58/V3beELixD8gBx7WXkVhJq
         wzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779390341; x=1779995141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKZWfxUS+4Tb1YFOg6z2FhYi+KBYNtAoDv3dZXK4Wf8=;
        b=IfpvEQpWq/y2FAH/K2PMbBwpetJ7aNj6eHYzYVYcl9kPuP6wpvfjrIaCEOHHNxyQMI
         +hrz8d5sKr3dPw/5cdaYNzE+lZlklwyDZoYhJ2F7XL6+P/Vtw94KYnfK5fLT3ZY2BSb1
         2Gl2TzYHD3FgLfJfIT2Nb+9532P/KuNeDYLMce3Gbau6cVEAfHlk3zdpbHOyxR9qBXOp
         C5AG7L+Am4UVsYaKsCEs6YC9A4MIGpSaByguti0Plx8+S3zo7n6RYZCNF7+QO2jh5gR7
         bfj671cUhVVuvY8JhtxLg332IUZgPv5B2RkCQaqHi7ulT+O9+gpd7NS0OGfQLjFgHk/o
         b3Sg==
X-Forwarded-Encrypted: i=1; AFNElJ8/i988T9GRzykv81dzbuowKKaz1JvYxzqa2LPFKCLD3LufpfWswIxMG4d0wdFGE2fBOhe3VQ2mc8g/8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyG0T9yj7EyOJw6R90JdqDiXaoSK4Rs0fJbaM8eIf8NZIY5z1cK
	iuIhFF4AvG205R5w77mFxVAivNxFd4pCZT6fBbW/JLpa4SlC4elclD1AGmjq6pyyhIs=
X-Gm-Gg: Acq92OFwwpI4ryNSpuggHqdI59Sz5KuL2+Y2EtnI1H7vQNeeC58ulJZ5zGN5STEPuLc
	KInGrUhTpwCn/fsaXLyJzb3REe8jRmrTQ5bq5cj6PzV1VHoyI0Tp/dW/+TiuJgCGOsbiI4i7fvH
	GTTCGLKIU8phYtg4SV4S1bPS6b72wfz3uMfDN5VYc17vXnIvB90wwAWtmmYIQJwbg5VmThB4haw
	yMFDLeQVouAW8vhIUVp+8HWiyKTLXKyl7HjaJvjTc/V4YbxnISrzuD3I++yO7gCXLm51Bu+de4r
	5wJa5t/A4KObLtBNu+3jp69UgBN3E2K63FFm8jhXCq7bopvUlVs4A6XNGh/9O3uNkcqsRjxGtBN
	5Y89ikQl/ivmgmdCjTAq6jd6/FlSNGMDjPGtoVv0jqln6A1aWYgkZJUcKKXk9KOYmgwPRYslQ0U
	1i15WBLpCfYTFqyC1egY5jT2CGz2SMMnCzrhOU4EWXJQB8GekbOSUKy+ZpkV9tcC6tZGDfayae6
	+zHYdeI
X-Received: by 2002:a05:6808:191a:b0:47b:d914:48c3 with SMTP id 5614622812f47-48549cfca30mr189968b6e.10.1779390341515;
        Thu, 21 May 2026 12:05:41 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-485431be4bdsm725820b6e.18.2026.05.21.12.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 12:05:40 -0700 (PDT)
Message-ID: <2bc4ae80-a010-489c-b85d-3f75b2319100@kernel.dk>
Date: Thu, 21 May 2026 13:05:39 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] blk-mq: pop cached request if it is usable
To: Keith Busch <kbusch@meta.com>, hch@lst.de, linux-block@vger.kernel.org
Cc: tom.leiming@gmail.com, Keith Busch <kbusch@kernel.org>
References: <20260521190253.242065-1-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260521190253.242065-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/26 1:02 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> When submitting a bio to blk-mq, if the task should sleep after peeking
> a cached request, but before it pops it, the plug flushes and calls
> blk_mq_free_plug_rqs, freeing the cached_rqs. This creates a
> use-after-free bug. Fix this by popping the cached request before any
> possible blocking calls if it is suitable for use.
> 
> Popping this request first holds a queue reference, so avoid any
> serialization races with queue freezes and can safely proceed with
> dispatching that request to the driver. This potentially increases a
> timing window from when a driver wants to freeze its queue to when
> requests stop being dispatched. That scenario is off the fast path
> though, and drivers need to appropriately handle requests during a
> freeze request anyway.
> 
> The downside is the popped element needs to be individually freed when
> we performed a bio plug merge. The cached request would have had to be
> freed later anyway, but this patch does it inline with building the plug
> list instead of after flushing it.

Keith and I had a side-bar about this earlier today, and yes this is so
much better imho than both v2 or Christoph's sledge hammer.

I've already tested this one too, and as expected, it's not regressing
performance. It's also saner in that there's no gap between peek and pop
anymore, so no risk of further blocking screwing with the list on
unplug.

-- 
Jens Axboe
