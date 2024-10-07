Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F1F1DCB30
	for <linux-block@vger.kernel.org>; Mon,  7 Oct 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321661; cv=none; b=IeeSIgVUbmnH44lqBvannzWxsupCuYVf6RZoWmg9r2XpRAy+EXaSAfqrBHsOhuFeAGBFb6E6PSk1Cb1NKNXxuX2c5+0uGtgfPhcPS+QtiTmej+eF+K8QQS7b7mOyx8kQ+7Roq717hD+2x7EhswVgzBqnEcLEal6urc+AcdLtwiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321661; c=relaxed/simple;
	bh=uEMVFVjKMHg/BvG37muuBGKEOSFc3zl9DQSYYvtqAO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RW/EJDtotvRq26tdYUiaVeakaYjwPkpyWrgd51zdtmCZdzQQ9LZx1LYuVd0L2xX4IJVx3hl8o5r/5yM4+8OMGXEMiyzTmLQc+iR+ZmXH+fEcYYK8VMx5DhMtZBenDxxNTLnwaf9ot+p9y4TFRqszwwwfwZhtbhR5oLlXT9gc70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qsn0INb7; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qsn0INb7"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82cdada0f21so172616739f.3
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2024 10:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728321658; x=1728926458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HM/eNQVp9sS4pRv6Kkwi+3Ezf+Z5zDLYdRJi3sz9pR0=;
        b=qsn0INb70hvqxg0O9QnmFo9rRGsyvsoX/GMxLwKcgGXRCPtk6wnJzuYspu3Tqmk9+T
         /erXDSWjcjN19fhF7uDcutpbaMqwuk5GzO9keYQMYVjDLTKo+iQ6qAJArnPRIyf+dwmf
         YuAUFkoI1kJlAf9BX4IdtW8nJ6jBJvEp9q6/HJhmabnSIycnBjiQXeM0Cwx3ICO6w0fL
         It1tJsAvLYcfBHNnI9h6xZMCsfvYjuwzBiDhNgTn6by5SsOQZSitus7WCq+AlKoD3NxU
         KJQL5X9XLb89GlL2UQiyCTaYL6Auvsime6KcE4CE54pEk8W2naxKHMVfksywaFlHckil
         rT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728321658; x=1728926458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HM/eNQVp9sS4pRv6Kkwi+3Ezf+Z5zDLYdRJi3sz9pR0=;
        b=ZbGQXado6If9HKfbrovJocNrqKYU4om7ZGZ9HVS5NKJ8KWFD7AxnTisXMTLdSgcpwD
         ZF5tTFzw41Zw33IWowwZ70sR51wpniymvkUBG7jRp0MGwoy0z0aFbP1d1AYbcvtIZiaK
         vTMugPQf4FQr59ldwKXD5184EBJzov8wXNP5XIepLVt/KNBv2cQmeocSomLHrkSBzRVp
         1CroSpqkaBJ3hhRVP1VzqxnbyjiOrlsehLPXTHPOCintIqGcuVcMz4hSQFzqHsUVxINz
         LQ3czKCpJ07ywksgfSWTSvKKz56dOX2NDAjmVNERIB43dQn5oO7/j8VPIFeZfO9pJe+i
         CcrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP9PMcsDe1KRulsBZjtDaRBPb79Nq2PbEEq6t5ACpQVkN7xV79Z+Vo7GM0o3LroVPv3yxrFWG4HIqOww==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNQZ4Oq/3qyWDYk+x6W4aU5qkuV8M0ac0m++3FFl+oMdnlc9ds
	3iE0Yt+t5XKDfI22MibITbY0O99LS70zsYnI1+mry2qL/PHAlAFkB2jDJvGf5o5grtSu8sOFoEx
	oFrc=
X-Google-Smtp-Source: AGHT+IHQQ1eK2yoPU61vrGJpZjDagJrSQr7Q5nZeGf2sYzTNsyAIG0qjJxS5RFmMOdttEW/fnX7r6g==
X-Received: by 2002:a05:6602:1593:b0:82a:173a:3cd0 with SMTP id ca18e2360f4ac-834f7dc1cc8mr1178754139f.16.1728321658084;
        Mon, 07 Oct 2024 10:20:58 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83503aacb18sm133537339f.30.2024.10.07.10.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 10:20:57 -0700 (PDT)
Message-ID: <d6df2c28-467d-458e-9b53-4cb7abcf682f@kernel.dk>
Date: Mon, 7 Oct 2024 11:20:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/srpt: Make slab cache names unique
To: Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20241004173730.1932859-1-bvanassche@acm.org>
 <3108a1da-3eb3-4b9d-8063-eab25c7c2f29@linux.dev>
 <e9778971-9041-4383-8633-c3c8b137e92e@kernel.dk>
 <09ffcd22-8853-4bb3-8471-ef620303174b@acm.org>
 <09aa620c-b44b-41d2-a207-d2cc477fdad2@kernel.dk>
 <04daaf4c-9c62-404e-8c5e-1fffb3f2ecbd@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <04daaf4c-9c62-404e-8c5e-1fffb3f2ecbd@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 10:52 AM, Bart Van Assche wrote:
> On 10/7/24 9:28 AM, Jens Axboe wrote:
>> On 10/7/24 10:14 AM, Bart Van Assche wrote:
>>> On 10/7/24 7:06 AM, Jens Axboe wrote:
>>>> Still seems way over engineered, just use an atomic_long_t for a
>>>> continually increasing index number.
>>>
>>> Even an atomic_long_t can wrap around and hence can result in duplicate
>>> slab cache names. With my patch it is guaranteed that slab cache names
>>> are unique. I'm not claiming that this patch is the best possible
>>> solution but it's a working solution and a solution that doesn't require
>>> too many changes to the ib_srpt driver.
>>
>> Come on... The current patch doesn't even check if ida_alloc() got an ID.
>> Without that, using some mechanism to alloc+free an index is surely less
>> than useful.
> 
> Is it necessary in this case to check the ida_alloc() result? ida_free()
> ignores negative values. So if ida_alloc() fails, the worst that can
> happen is that a slab name with a negative number is passed to kmem_cache_create(). Additionally, if my interpretation of the ida code
> is correct, it allocates memory in 128 byte chunks. So if allocation of
> an ida fails, it means that less than 128 bytes of memory are left. More
> than 128 bytes are required by kmem_cache_create(). Hence, if ida
> allocation fails, the kmem cache creation will also fail and the slab
> name with the negative number will not become visible in procfs.
> 
> Do you agree that in this case it is safe not to check whether
> ida_alloc() succeeds?

I'm not worried about OOM, what if you run out of space? And yes the
free part deals with it fine, but you're right back to having duplicate
slab names in that case. I'm done arguing about this silly thing, I
stand by my comment that using ida for this is overengineering. And that
yes there are 3 slab caches, but having 3 per whatever instance is silly
and you should share those 3 across instances. And guess what, if that
was done, then you would not need to worry about creating silly indexes
to avoid conflicts in slab names. Not only would it be more efficient in
terms of overhead, it'd also fix this problem at the same time rather
than paper over it.

-- 
Jens Axboe
