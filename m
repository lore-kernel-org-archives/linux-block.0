Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F9C391
	for <linux-block@vger.kernel.org>; Thu, 16 May 2024 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715826616; cv=none; b=Y3pzfFPLmdr3bSwPm1D21UratFVxJ2lnSz3NEwB0V9aWuCmI0sliVeknuAIcCIgtXdRiVsZgYcDDXGc9A5gkg91yLTHi7NKg7yKjc0GoXpoHZk20CHKdmBmL2lmfQoReGiRHUw4AnvArOF1ZZ1/rxYa90kTzhxBE2Fco++l1gzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715826616; c=relaxed/simple;
	bh=IJfeXlGUHjly/M0zLN9mmkIcm0dd0HVgqLHDqtsmfqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lx4YtY9UHC7GANSBqI1+9XWdXDV5k3UAIqaPR165IqjomLeg0MpZSMg3Nxif15NkLQI45JPJEeWG/3lWsvqc8MjxICpEhpurktz2HSUNeWpQTO11BnU2WpU+A3CikaH8O1i0Yz1DIUa0Zbn2d4P3Bl+VUf1io8vL+bU1RqPOPp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=u3njCUiS; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="u3njCUiS"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b8efd5ee5dso1090361a91.3
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 19:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715826615; x=1716431415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+7daecJRB1K8ERvqxbImKF1sffU1MhW8D6cj40EMyY=;
        b=u3njCUiSwoOiwApBQBAoa95QedLLT8OGB+B5O5ICxiR8crMGvwI/aTLX5DECLag+GZ
         dpRPQ5tU/MDNaipZZXha93srPCaNg5emDUQCb/f5puUav2BA95bsCYtwN9keXHrFgyXQ
         driSL5Qq6Ljhc2jO5/4x2h0mCo9XLPBw7FH5MQGd/+b8jQPjvcFyNk1/xKpt0Sd3Q8iP
         CYQLqKxrsFsrdYYeCz3HkyVvKHgfTIcBuwrWzCY1IS+dx8qePQGzdy24my+vQYhvb0pp
         FONY4mIAvb43HHd6NK81Yx9mEdlwGT1OB6FKHI/U3CAsXxUhsjRJOripej6wqZgsvoqU
         FGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715826615; x=1716431415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+7daecJRB1K8ERvqxbImKF1sffU1MhW8D6cj40EMyY=;
        b=p3vP8O66yeLPKSyKJYKLRedCGDLCum8KQXePhxR5wwHPcuNyJgo7TOyTEEd/4Vk0vo
         tzQwJjV4AiRIcV0WXbNgmNjjrFjA5+JXbT/YRqfrBoCzA2vUcz2RPrIzI2iQtWl2ZaOa
         Fua2qiFe8oo+65W0l9FDeIghUHSyBYIRHwU3U70s/iF/UW1eXsgWj1j124T/oAEcvZeY
         9xeifR1TyWE3hkbeXpYB3JsOIsKUy+fbd9uOVd3le5QvJnKo9HM8ZeTnPS/1afylAbHb
         3gOnL6qebx5zbCJj2jkhaUuFkpwAvbMmOjbwL01qnWIXJeaTdpqYo0CnXEn2Zqi0W0sZ
         oiSQ==
X-Gm-Message-State: AOJu0YyeQO7MqZ9VJzxzeYrVgbZ3Sd9Vh+BYwZ9Pd9pf2jB3lUtuDYL+
	9UuiKyC+roZr3j8qc4+lpK2kHJTbQDV0dg/pnGNZ8XHlSrFizYBEO8zDfm11Ale8jacFYoIfACl
	m
X-Google-Smtp-Source: AGHT+IHisy9+lDOgAxqwY5N2n4AXPgS6IiVdn1NisspaguWsx50BdDg5mkfFVisgYhmrskBIhdn0sg==
X-Received: by 2002:a17:903:2444:b0:1e2:c544:9bb0 with SMTP id d9443c01a7336-1ef433d37a2mr200912295ad.0.1715826614709;
        Wed, 15 May 2024 19:30:14 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30fc7sm125494195ad.133.2024.05.15.19.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 19:30:14 -0700 (PDT)
Message-ID: <8522af2f-fb97-4d0b-9e38-868c572da18a@kernel.dk>
Date: Wed, 15 May 2024 20:30:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] block: change rq_integrity_vec to respect the
 iterator
To: Mikulas Patocka <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>
Cc: linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com>
 <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/24 7:28 AM, Mikulas Patocka wrote:
> @@ -177,9 +177,9 @@ static inline int blk_integrity_rq(struc
>  	return 0;
>  }
>  
> -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> +static inline struct bio_vec rq_integrity_vec(struct request *rq)
>  {
> -	return NULL;
> +	BUG();
>  }
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>  #endif /* _LINUX_BLK_INTEGRITY_H */

Let's please not do that. If it's not used outside of
CONFIG_BLK_DEV_INTEGRITY, it should just go away.

-- 
Jens Axboe

