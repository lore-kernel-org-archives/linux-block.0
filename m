Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9092D058
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602526; cv=none; b=Uo2gaEgzJ1ETOoS0arQcdkqq5wcnBPgo/PrsyClmU6Mt08QHtmU/TuN6tYUH25v8z5OZFQrRF05jpRz35suRfhyD4RWOqpzSStwTHhPve6TuMrbMr6wF4cDVAi29XghCur5fj4zSXa6Oa68OPWd+XqiXUKTXJv5/4IpV+kFxNtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602526; c=relaxed/simple;
	bh=URE6bzkOrIYyT4mRMdMcwDEdJWsoNMc+c//v5KXuPY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVZOEh+Yw1BLrNIKOrZ61CmMvOPsftrjnOd0SC8x2B9b4KYqQgYSFQXtIcWHFlUioDAr0V8jPP5QiytEzLm2kN8jl23R7R4UlTIrlCYkfWoFDUrwsuDxYYz85EvnC9awBqrZDKk87d0jLAvTvvO26nuLnF13z6LVMfheQ7RQEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MDUf3Mfn; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MDUf3Mfn"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bed82030faso72603139f.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 10:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705602523; x=1706207323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YJ0p1f1la4dlGHNE2rAOZA2ExGxfk3PV546gMt9VX0=;
        b=MDUf3MfnryQrs/O4TrxEuNlBtTyrzFlTShxXCkIvjoZE+D/c5O7FE95vQ48zSeTyKX
         QJiiUW3aJn2dZ6T7EGzB9QOxBrDDu8qHgHgaiLwgsrykYxaqKqvhMoXzpmMobeTfRLN1
         ZU6r12PiWMri6SJUqYtBeEF3qyA7pqzXgzX6TUl3VUaYIRFQSlZCXqb8IYs+rAaarLoC
         r9qHN03hNLcCQZe24gYoYkPxAfmapSR56q5TSwf4BzMPG9SwLtxA2atbJMMc3gF8bMca
         TlothPHkrKezhh5Zn6Rgi5LXkS9P7ITb1XVO1WGLflSxFsXr/os/xOGb0z8qshVe5V4S
         D08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705602523; x=1706207323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YJ0p1f1la4dlGHNE2rAOZA2ExGxfk3PV546gMt9VX0=;
        b=nXH4o7YlqPDPuaIIyHFHChrME9OQ+YKjGx19PgkXOrD84GKmKVbTWGB9DPNdOOBKNZ
         fD2qix/m0XtE9mtpd6r9EGtJNmIcbpryJDSTzIULu/b41O5fNtYMgs1goiY87591rVxy
         We3WOoogt1SNzooAb7w0+qgD1dRA+XLP7Zx1CDQ4zVVNB4xuzaWLSm3a75BLiYaTRWJ5
         NmbSPPfoNIyErhbD4be+QOqlWGbdUxB9bjyFdq0hrrce1nnyWPFYQGF+iOgfyiyRynqy
         wzUfS+iIPEZU/3XofUgRlRxs0oMf/NXqTDCxgKpR0bTGweLMjvCFC0BP/ZPeywS0H6aF
         17dg==
X-Gm-Message-State: AOJu0YwgC89AyksiGXqRLWxmLuIqr8FVQHpaFxqwjCb6Ej0bc4mzMwHW
	B+2XlvwOfeUiOSW+2R8kvDo3GjfCHHFqmc/3w8vgGR9x779Nvvi4OUf/MpBT3As=
X-Google-Smtp-Source: AGHT+IFfltjjZuUuEYR0dytAzCeiZ/h1lfpiAfjNRdjFNit0LilgDGE5txQNjiriTAT2nPsW/RTduw==
X-Received: by 2002:a5e:8a45:0:b0:7bf:3651:4c6d with SMTP id o5-20020a5e8a45000000b007bf36514c6dmr234199iom.2.1705602522875;
        Thu, 18 Jan 2024 10:28:42 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l5-20020a023905000000b0046e0388eb45sm1144130jaa.94.2024.01.18.10.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 10:28:42 -0800 (PST)
Message-ID: <322cdaa5-5d6c-43f9-92f4-08f8505896ae@kernel.dk>
Date: Thu, 18 Jan 2024 11:28:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block/mq-deadline: fallback to per-cpu insertion
 buckets under contention
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, bvanassche@acm.org
References: <20240118180541.930783-1-axboe@kernel.dk>
 <20240118180541.930783-3-axboe@kernel.dk>
 <ZaltJ2H3pRVFqXIu@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZaltJ2H3pRVFqXIu@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/24 11:25 AM, Keith Busch wrote:
> On Thu, Jan 18, 2024 at 11:04:57AM -0700, Jens Axboe wrote:
>> +#define DD_CPU_BUCKETS		32
>> +#define DD_CPU_BUCKETS_MASK	(DD_CPU_BUCKETS - 1)
> 
> A bit of wasted space on machines with < 32 CPUs, no? Sure, it's not
> much and the fixed size makes the implementation simpler, but these add
> up.

True, could make it allocated instead, 32 was just pulled out of thin
air. Might make sense to make the magic 8 or something instead, that's
probably Good Enough in general. Or we can make it dependent on the
number of online CPUs when initialized. Honestly just didn't want to
overcomplicate this initial RFC.

-- 
Jens Axboe


