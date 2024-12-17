Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE071F9ED1
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469650; cv=none; b=h+sNO4BsY5OGUaxM4uSC5UJjT5uxv+yR090vymn/abSoKHigpYJV+y16hAJC8x1jJQ5NoNEy0x7/JQLU+VZk0A7/Nq97lJPdGOXhSjJYgIC8eJZsz0mESFR0f6S3ZxhsEP0ar7dfDqMBh28gYJBb7pSCE/RD2SvVvbalUiF9QZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469650; c=relaxed/simple;
	bh=DYXCpIfYdRHNRG32/Ni0pl1LzbN+rMCEr35BN5GBtqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1cGR8RgKqKbMBIodyFWCU2R4/U+BxFVtFbss5t42wWgYEBYNn6Ab3Fnf+zoEATlOV6yzlw+MlxBsQWq46J7rq4Ep/tEOlNRzY+LEh8olxSWiUR0KuwmhZYPPRXfjhw1bUDufpaY18CR0bgED4jkWaGhkOWk63W2SSZmFJWx1CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wVQml5bX; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wVQml5bX"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-844e55a981dso168679639f.3
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 13:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734469648; x=1735074448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxTHFAi0ufizCl7I67BVly4Us0FktZFreE3PeudaUmw=;
        b=wVQml5bXEZ7p4mwj9+z84iqJaLYCrkNwAC4j9BPatt6NgC/YRtMtp+loscpqRiGnK4
         MGw8fHj3rNiLo/Q/NwXKM16bS3y60E0uuzaBHLAVH0a/w619Vou0oPFvSOmnrLZ6wo9m
         U8KtXAkgNNDOxLbd/sih+/xrqp7X1NLhpV6Cr0AovzHr4wfo8a9V148lxnHVLVrDq5k5
         vk86a5ijzLZRyEds3k+sBYovbErKL72NEo1UddS/cjryOZ6fz4NQ7BJQwe6Pr/r3Q5qC
         qX7HaXKn32Ts2L/Xg5/eWv0olVxhPos52JMp5526DGx6tlqV2PUeG4U9Br8l6nArXX1+
         LP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734469648; x=1735074448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxTHFAi0ufizCl7I67BVly4Us0FktZFreE3PeudaUmw=;
        b=SikhkVt7CKbqzZDJrv0WncDZRAUvRniIneDtpOhGObX/hnq6u9W4Tz1XpxCHP12UZN
         ilHXPHpLJc0snOU/jKvWI7jFuNPnkNstOcNmjehEqejQkstdUr6zj3CfrRyWEAbylnEl
         pBJkgFTbKrqnaVtxX/TI8Jie6T3tA1i3Hy3s1rueJDvMThEzE0f5ZoW5G391iKsS96tn
         bqV3J9ERplGS/Xgr6P4buLT/hlNZ5n/v9Wn2dUCjHYU8Vc8+Tn9hEJE5PnvLCWHAH5y9
         JZImaplBDiJe4ZzrBTrjYB5v3uj+etQ1offZLjAUOSLTZpDT0Ambxnt16kSn+2PZ5GbW
         Yhrg==
X-Forwarded-Encrypted: i=1; AJvYcCWeI5RqI+ODSJOR67oCKBUxKa8RTgdkLhcBayrdg0Wsqq5FIQby9QmBfi/y1ldUUPfmMjbSP7RPAwb2Tg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0EgYjX5MIL9+4x8QjeD/nEVV3RNI+3v+c5DTCrSB9Gor630Kz
	yry6x6NXiZl5fsJteXmdu3avScNDxWksZxCZc3dZOP7dcBn5+ZV4fpy5cn1EtGE=
X-Gm-Gg: ASbGncsluAh5jK8NmHYWXZGZqHB7MPwbK2FA94D6zsIPdx/ePlgwfjPrWGGVLYA8tDx
	bH8b1V0CpJj/6W/p1d43CL2XwoJmIbuZuqpMhHWZWw9fbKaubiCqagtWsZXlIw0WGo9xxTyHwkF
	XkDaD83It+/R/3bPHHR/TCPgj7bhdTLy6HXcMlllP4tWBBtDsmAQ2fpQu1knpNmOtYeog7E76sb
	BeAI6KsgWJZTvMCfzp6OyJ0BxJ7MDl1DrV6XSO7P1hIpcKmDw0e
X-Google-Smtp-Source: AGHT+IEZuOks5bPSEmDavYC9qmsQ8z1l/snRQxoEwkEepPxAkIeF35dwOhWBSaIIdJE+B3U31qo95A==
X-Received: by 2002:a05:6602:2c88:b0:803:5e55:ecb2 with SMTP id ca18e2360f4ac-8475831e21emr49355439f.0.1734469647813;
        Tue, 17 Dec 2024 13:07:27 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844f62583ebsm194676439f.11.2024.12.17.13.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 13:07:27 -0800 (PST)
Message-ID: <92eafd0f-943a-4595-8df3-45128cac5ee9@kernel.dk>
Date: Tue, 17 Dec 2024 14:07:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3][RFC] virtio-blk: add io_uring passthrough support for
 virtio-blk
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>,
 Christoph Hellwig <hch@infradead.org>,
 Ferry Meng <mengferry@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-block@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20241203121424.19887-1-mengferry@linux.alibaba.com>
 <Z2BNHWFWgLjEMiAn@infradead.org>
 <CAJSP0QXU_uNqL-9LmLRkDdPPSdUAGdesQ2DFuCMHnjyEuREvXQ@mail.gmail.com>
 <0535520b-a6a6-4578-9aca-c698e148004e@linux.alibaba.com>
 <acaf46f3-3f6c-44c9-86b5-98aa7845f1b6@kernel.dk>
 <CAJSP0QWfSzD8Z+22SEjUMkG07nrBa+6WU_APYkrvwzNbScRRCw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAJSP0QWfSzD8Z+22SEjUMkG07nrBa+6WU_APYkrvwzNbScRRCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/24 2:00 PM, Stefan Hajnoczi wrote:
> On Tue, 17 Dec 2024 at 12:54, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 12/16/24 11:08 PM, Jingbo Xu wrote:
>>>> That's why I asked Jens to weigh in on whether there is a generic
>>>> block layer solution here. If uring_cmd is faster then maybe a generic
>>>> uring_cmd I/O interface can be defined without tying applications to
>>>> device-specific commands. Or maybe the traditional io_uring code path
>>>> can be optimized so that bypass is no longer attractive.
>>
>> It's not that the traditional io_uring code path is slower, it's in fact
>> basically the same thing. It's that all the other jazz that happens
>> below io_uring slows things down, which is why passthrough ends up being
>> faster.
> 
> Are you happy with virtio_blk passthrough or do you want a different approach?

I think it looks fine.

-- 
Jens Axboe

