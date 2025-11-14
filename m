Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A430B51E
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122145; cv=none; b=ZQpPJIiwKqJUfq7hfRoLSYMKxwiCAzY3NYX0Qxe3z9RPRfChY9eV+Wq2ybUraNsJTc7PvZTi5hECX4ulS5s73NzGkZSre9H1k5/PBYRdtdrcWWseJg0ir6Q4MovsAVsUdcpPv7esGemCxju3UrVNS6z+iDcbWKKWlw1QpbqifXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122145; c=relaxed/simple;
	bh=I2m63Esd/4+JJsLC+Q3QHhMQJBeHukvCA7nbD7TRiDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pkAal+I4/jWaOcbI7sRt4ika8d9tx32d6I2h4TpTeuiJzyaLApZzF1X37O1VFptQmWWUM28p+S8zn/vN3MDtE6eF0+VrnRYbRI7VXrXr0b1U7vgqahX+P9PaN1azFxtcUEYUqI5Cm7+KDXgcSWLEuGcBzXQBbju6Dd6DppczPmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sEKuDETI; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sEKuDETI"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-43326c74911so10346735ab.2
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 04:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763122141; x=1763726941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kG1p+h6NmWkadBUCs9jMm1+jPfa7sXsq71LDbEX1jNQ=;
        b=sEKuDETIezmXh1hC0SJ4v0TKGUBwfN1/P0WPDtWPjaR0jJEpmGQmcQQwj233VdO79+
         QqQSSSYrBLpPnkY5byPHsIHcDjd4rKYI2etv8P4tq94RADF4/sk7CQi1jV5tUdtrqfV5
         WRV0EbQyhxFrusx7/W6hvnvjzrsdq5hBYawujaIJ+wRqjcOCmvSRNGCfkIwLcSb8OjnX
         pCYWuuD+FQR+D4NEzmbXk/Rm8/j+2bGMXFQesjvmpot9Rn1JGtfRWKobsc5qZlhGa0lU
         vIM+bj+w0FZ6zQWEp4v1YMmWDlCBWDJ5xAPvroaqhYv6/pARLpyD3WkwYdL//oEVrmVN
         gYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122141; x=1763726941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kG1p+h6NmWkadBUCs9jMm1+jPfa7sXsq71LDbEX1jNQ=;
        b=HaO8C+8EcVeMlEljrBWd1YhuReIUqUAkQh/VVeNbJH884v5tLu2zZtLSwbRPBp4cY3
         +zowXw8Z0c7gtBiHkcSg9UQUOxW+9D0PnsG8/iahg8UKh2C0UEc9KoVTG5Hjv/YBH9Uf
         C6IY2iaGma5XXMWfN6CLAMAO6OWvU5nAb17mRfab96AqzJTC3K0ztFVt5ZIVvdyOVhos
         qg5so7aTrgvo6b5qonBrZyyTC0LvQt7sguSzup/iyRd9+14ysXqAwG2RCjC7/zU2gRtu
         5wSSm1NwmhErck71ynVBypfUG9uQe3mSJdPggipz/QsXdCsyVy9VzmgOv7sbqdCjixfy
         Qd5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3i+DcgcMpBUN9v9a4u1QWTBQBMyuL8AUfltKi2nNZtBZbt1KdoarXVw3iH2tTte78jhIUFgEiET7irw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq5TDDGekTo5UntkUODjFgJkNqMSg5dKU7MAuLRX6j1iDB0r+1
	CmbgxbZs1JY7GtnFsiWu+1jMHF1hfxytlwK5ujMRiNh1CEBHg/Rt7SDk2l/m9CL1S4c=
X-Gm-Gg: ASbGnctFZLNqSiLWe+OiAO2IhbR3+QXg4QPet1XSoOkrvWit5gkVTiS6A6Kt0GSjRk5
	8q33V94YhWXExJpSlVdYG3rXO25Xk4yMsWExCxNejzIzJ/TwsQqnkebnPlN4SUPCU3jJGkn8Th/
	P7O4oOJGQh5+qWZsoTxe8w/EnAO3uVubK4Bg57unFvTeSBu1XJtp99+pevU0YKOgz2jER0By4aw
	NXacPJgmxjx36qgWEwO2qJmVu4bGWkKmRvhyoJYZABuUiudnDrf6kYcVQrXACrfT4P/DU9FdXCd
	bM3KRWX1AGKr8ALfpKOswvSTG5uSfj3YHa8of2ytWq0EVVdx3mcghdEEQaK0te2B5g7/zdsKvqS
	mAGS8+i4pgCcF8qi17qSvkEYOwNxofP3NBHBzL1wBl3PQ2NQ9YitwU4qS2xstgTgFnNTJAyBBgj
	FrPSdllOQ0yD0U8LUxSDs=
X-Google-Smtp-Source: AGHT+IEAqyNwPB3UvsxWeYSxCILw7sa+XHuGUVyOutIjmeWKLo9hHPdACjkztTSKX+8Y0R4tMIGQpQ==
X-Received: by 2002:a05:6e02:b49:b0:433:7c77:be58 with SMTP id e9e14a558f8ab-4348c94e27emr41757475ab.29.1763122141106;
        Fri, 14 Nov 2025 04:09:01 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43482bd586esm24371405ab.0.2025.11.14.04.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 04:09:00 -0800 (PST)
Message-ID: <4e24113d-b32e-40fd-baa2-0b878b9a7a15@kernel.dk>
Date: Fri, 14 Nov 2025 05:08:59 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
To: Leon Romanovsky <leon@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
 <aRY28IRvBFmTW6cz@kbusch-mbp>
 <d1641814-5ef8-4ccd-8a41-42bf99a61d0d@kernel.dk>
 <20251114081623.GB147495@unreal>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251114081623.GB147495@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/25 1:16 AM, Leon Romanovsky wrote:
> On Thu, Nov 13, 2025 at 01:40:50PM -0700, Jens Axboe wrote:
>> On 11/13/25 12:52 PM, Keith Busch wrote:
>>> On Thu, Nov 13, 2025 at 10:45:53AM -0700, Jens Axboe wrote:
>>>> I took a look, and what happens here is that iter.p2pdma.map is 0 as it
>>>> never got set to anything. That is the same as PCI_P2PDMA_MAP_UNKNOWN,
>>>> and hence we just end up in a BLK_STS_RESOURCE. First of all, returning
>>>> BLK_STS_RESOURCE for that seems... highly suspicious. That should surely
>>>> be a fatal error. And secondly, this just further backs up that there's
>>>> ZERO testing done on this patchset at all. WTF?
>>>>
>>>> FWIW, the below makes it boot just fine, as expected, as a default zero
>>>> filled iter then matches the UNKNOWN case.
>>>
>>> I think this must mean you don't have CONFIG_PCI_P2PDMA enabled. The
>>
>> Right, like most normal people :-)
> 
> It depends how you are declaring normal people :).
> In my Fedora OS, installed on my laptop, CONFIG_PCI_P2PDMA is enabled by default.
> https://src.fedoraproject.org/rpms/kernel/blob/rawhide/f/kernel-x86_64-fedora.config#_5567
> and in RHEL too
> https://src.fedoraproject.org/rpms/kernel/blob/rawhide/f/kernel-x86_64-rhel.config#_4964

Distros tend to enable everything under the sun, that's hardly news or
surprising to anyone. And also why the usual arguments of "oh but it
only bloats foo or slows down bar when enabled" are utterly bogus.

But I sure as hell don't run a distro config on my vm or my test boxes,
or anything else I use for that matter, if it's not running a distro
kernel.

-- 
Jens Axboe
