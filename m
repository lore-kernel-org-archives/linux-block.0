Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94D6C2F2
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733749; cv=none; b=iciYCapoiuaUXIOjqpdKbqVCVLLVsGNHtncmUYDJ/rEX7HxILNGbhO3kacZBl7VnBNVBmbYj6Y9hbPfzD4L/h+zbYzKzfPQTWwmR0sAhntZYDh5i7LfgFjTdGDd9BDsqYvWAuOlLa33KIQ/AImCbNZkPqYkI75WlCpbzMRB8UAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733749; c=relaxed/simple;
	bh=x0q2kSE5hKQj88R4LtBm72cXCEpEpkoA9WYFRDVUlOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i5grQ87+roapadX1qH0WyzZrO8u2wJ/XOUXc/X7S3sWchzbzzlxEhVK8pbZf9l/PjDo16rpsgNBHjTczsvdaW7w40emGA3zp0QXA2GXp4atiKynj3QuuhP0unzFZIXE4XRWAkblTaRbohR8MZskfGG3iEijAC21l5uyee5QS6Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IrHYcNKr; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IrHYcNKr"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d4496a34cdso20410975ab.1
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 09:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744733745; x=1745338545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AEZIKS/xchUL+VUG3UTu4pSMzNAu0W+IbyPPSBukn8U=;
        b=IrHYcNKrU4Nchwsu/ovWXIRfn4MitFUxFjSQPT45qa9PpUVyxxF5kjSn+yK6sPEu4R
         xslipJ/sbpO0Cmd/60qO06ni8LWFGL2ZN6WRPXC+B1bWmXYG0C8Gw6UdAuo+A2+ovQGu
         gvqAWhzbpx5Ep6rgtiMKNMcPHIPegTXcQhkL7sgUQXxtNVz6F6qS83UkJIj1CssI9G/P
         nW3HUqgoSlTbuoYrPolWDSBvpoRgKssdiO0NnXiNpz20Tc4H2PwtTKQhzxn68li1ufvO
         QN0sQZmAEJRQLF7uliRg3qU6ZGCVx86VDWHKN0pD4rABvFNheizBPJogfQuul0pNSf9i
         IJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744733745; x=1745338545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEZIKS/xchUL+VUG3UTu4pSMzNAu0W+IbyPPSBukn8U=;
        b=wgV8IxywuiJYl/orvZgajWVQw7+6iQSDkRcdi9yV+gfnk2uIVT7MFNm6ny1XUmbn0E
         m1pE6tPYLYMyL9YNs7qdFRuVEggz1kzCcydYvcoDgXori5B1gKPGC74EBuIZoBqFm0XS
         zmWbW0/XqTtDXhuyKO8wxjUKLbpP705v5WxJBmqrSEPX2GdKbaPIkwTby3Vibzyiikmo
         SCJhoEHKxP20OcofwpnC+4YUivtVKy7Mt/FNxqZZH0A+Rb3nTjXh+i6IK/0fK76FPhh7
         xiHdRT4c4KTgC+tGfvd/J5EEgvnotIJOY8tV+8TBjgdBK3/TVvYTDjwjbTQyKvLj3oTR
         rw/g==
X-Forwarded-Encrypted: i=1; AJvYcCX5ocUYMI4gA5hmqGwYzhuvhyyhFtsIhigMpkp25QPfn/Z55qiRP768jaus2HifC3FLlkWu1DQMX5YxAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWfyFzZluPgFx3R4qcEm/AwbWl0y4I2agkeVkMdaLcu4Q7GXuh
	1gGXckvEB2/a8GLQS2aBMoMcsYlfGCsOwkNHCGAOJ0A4N67FRCLufsbnuSncUC8yrT5azACJ8ye
	d
X-Gm-Gg: ASbGnctiblRY8ZNurLcNph0mdLNeARN3pONo0SygHNhv8JogieXysAtNt3j+liw3pNT
	Pz6/9moJRjH5cBfS7D7nfppkj9H5AykG29vAu40rtXsuH+WKLtlJ/XxhDmywiWd3+295IcRmjjK
	yWmPm8pXfROz+Q87kc+b93lWuz9uUBtYyjCWp5nUm4iS2HgoSKKYgnhEz3guxMOqN1cqpFVaHvZ
	TmBlPJ2gtm0Qb4oqSZEkTOFFiX/30D+6bxfRpZNcOjX3vu2U/3ZwJfR3mLjRdvSECRByRqifSx3
	xNXInxZxGmgQ/AnHC8HzCosxETeaFu53f1ua+A==
X-Google-Smtp-Source: AGHT+IFx5p8HLJM5xmeh9OftbpA0VptbMSR18A/yPKoJohiJFxbgtFvdnlSz2JtoroW/T9hCgpEItQ==
X-Received: by 2002:a05:6e02:3f05:b0:3d2:aa73:7b7a with SMTP id e9e14a558f8ab-3d7ec22785dmr189759495ab.12.1744733744755;
        Tue, 15 Apr 2025 09:15:44 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505d15989sm3262781173.31.2025.04.15.09.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 09:15:44 -0700 (PDT)
Message-ID: <6323c463-0d42-4c5f-a7d1-8739dcd34487@kernel.dk>
Date: Tue, 15 Apr 2025 10:15:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: ensure that struct blk_mq_alloc_data is fully
 initialized
To: Bart Van Assche <bvanassche@acm.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1720cf81-6170-4cac-abf3-e19a4493653b@kernel.dk>
 <a8074c72-e258-4b34-a629-c253997dfab9@acm.org>
 <4b0eee16-a37b-4770-95f0-c5f02160e0da@kernel.dk>
 <77aa1c61-dc33-47d0-854d-22e4f1cae60e@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <77aa1c61-dc33-47d0-854d-22e4f1cae60e@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 10:13 AM, Bart Van Assche wrote:
> On 4/15/25 8:59 AM, Jens Axboe wrote:
>> On 4/15/25 9:50 AM, Bart Van Assche wrote:
>>> On 4/15/25 7:51 AM, Jens Axboe wrote:
>>>> On x86, rep stos will be emitted to clear the the blk_mq_alloc_data
>>>> struct, as not all members are being initialied.
>>>
>>> "Partial initialization" never happens in the C language when
>>> initializing a data structure. If a data structure is initialized,
>>> members that have not been specified are initialized to zero (the
>>> compiler is not required to initialize padding bytes). In other words,
>>> the description of this patch needs to be improved.
>>
>> How is the description inaccurate? As not all members are being
>> explicitly initialized, rep stos is emitted to do so.
> 
> Hi Jens,
> 
> I think we agree if the word "explicit" would be added to the patch
> description.

Sure

-- 
Jens Axboe

