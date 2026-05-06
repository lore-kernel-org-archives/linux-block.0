Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEB73E274E
	for <linux-block@vger.kernel.org>; Wed,  6 May 2026 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778064202; cv=none; b=KLTDcz3/PcQBfLXHt7M6gXGmd3h5ZpJyjgifH4NosuyHgoIbeJxNHzrL3UV/bqX1Z5mBhsUA2Mzv5MLBnLlr/EViKefIstpRADjVS3msfFyZNQeAc1CLJGh0aJC7GOSnlFGUjJPvCC9QBNW6mzFvuHixGAxC1X1o1+JxsROmUnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778064202; c=relaxed/simple;
	bh=hOmu4Us7ulxPNOky/M6H+xw8sGA21hVukVAm9GB4TKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFCv+2tEnUzIUu/u0XqvITkEqfRRmC9PlO4igHhut7mrm9w7P1C/PyaIcJMmse8XHTk6GUXhiVQLD5FHYS8b03POwWFnsUFTyvtoRn93WUiHQX5QhshbJ9IGo/yc+9KUryClpkNGMM6eBA2N4uLgo/ng8Xa/EnwL2D0KjTIAsnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=vF/akcv1; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="vF/akcv1"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d7e23defbso3560078f8f.0
        for <linux-block@vger.kernel.org>; Wed, 06 May 2026 03:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778064199; x=1778668999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kNKW8exgBK0FS2c2WGoBUqZnBzWtTWrHpZ5cK2HpsJk=;
        b=vF/akcv1ketwUgFKjTNCFpPLz+pHVzSOI4J1MXUmKIUOeDDs3xWi+5BCDHNBY36xA7
         9pH4D5dydSpDjxVZ7GJHzEFsRlis7esrsK/MtsPtocdNSNyllZpepPToGtFj0Om6Fp3E
         Gb8+WmdMHIjPI1uLfVhLm3cbxqWOa3dXQetxACnDxHhl83lq6ITpmOWblGWX+WhY+O1O
         HFeYrxQFS6YKa7nzAr9HOH0jU0CvdpCK+M8EeiToGA5DwpJXLyrVtKew0wFeb1vOJ8jz
         sjAbb/o6leU5bnAn2N1JE8E+txAu/4CkzqWlBDXYrXBvl3XNykuhqzOGy0NvBpbsxgj1
         Kgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778064199; x=1778668999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNKW8exgBK0FS2c2WGoBUqZnBzWtTWrHpZ5cK2HpsJk=;
        b=gN1wop4KHPeSaDl/QGyX3N3qZH/qFamugTO0/eySCLM7GqstQsS7UXMz2lqkaKxsNO
         nq21Q+OpHFdOnQgPGk/edLaK0psEOdfNZXaHwJ4w+in9DkFYGAaPHXZrPEAoGUUrQZcy
         KP6BFa/DBoDcbPYgjwm5x/7435nmqAQq6SYpwIwsvwvRHj1TTJCGXR393sKuJ7va7s3t
         ALb5cperwa+tgystsgD1tUowmpcWdeNWiEsRAKEt+0VqXU5u9y5yYiMyZo1Hrk9hkOqi
         r1kCi+eH6tfbd25QH+nzzHb4TiuknQXDQR5cFiJ3gZDSkHsEUHkazYF682Pa8NxnmioT
         HYcQ==
X-Gm-Message-State: AOJu0YxmyDt5UOaSWFex7jiB4aiXIpDI6dzurnF5cbyVC9zbgmUL+MLi
	b9ZZfzYu1u7nlQs5sL2V9q+BOhatGG9KgI79FHtgKBtJ/JOkNyCIwvg+qMyUoXXTae2Rtddcz7V
	XMpZxfrs=
X-Gm-Gg: AeBDievEI7ya/qAlAtpHHQrvqxRAhikr0lPUrGsUz9vtOb113/llPRnenM3e3XGXojy
	gnpKyYtnT6YNkJSYKCZ79AgOiq7e0Dq10vNLrQZyjnJkcATLRCZKOcDgY8Or1waBZ0alWXf/9JT
	7H1c1sSwM58WhIAE4VfHufQGATdOAi0jtSGf/3yhS/uP5UXxcwF+qAq8R5fv6zMEmaM89w3I+Lo
	uOlkrZC/19N3xOj6HrNT1O5Wm/MGs+4mkFYkuqES+iJ9wjpid2wJRanUcEQF23ZNz7MSDTKW6UP
	ygFnZ13lVeLKgSF53VT2LVwRo2sNN7YiGUyuaSdJCayZ3dLwS35DbhbZghrDSN5KV0xb1/e2u7N
	LrO6tZYbAuz6+FjQ5rNWyXAEGReWvZQUWEP50XgkK0duyIHJTTVeLQzVj78/lkGx1iv9E4n5+Qz
	aZJJU6cvUv+Ya7nNSW5vQEWz0TW2eXpNiVXLsgaeqjQBcgUywT0c7FA64cplLz0Bv5qXQccuuAU
	QJZR8Z4HUJr4wR1qf6EtLXFuhAP374=
X-Received: by 2002:a05:6000:26ca:b0:43d:68ad:3b7f with SMTP id ffacd0b85a97d-4515ce1ca0emr4794680f8f.21.1778064198973;
        Wed, 06 May 2026 03:43:18 -0700 (PDT)
Received: from [10.211.9.173] ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-450524834eesm11178915f8f.4.2026.05.06.03.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 03:43:18 -0700 (PDT)
Message-ID: <be3d5412-ec7c-4abf-b890-22c0b7295cc3@kernel.dk>
Date: Wed, 6 May 2026 04:43:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: only read from sqe on initial invocation of
 blkdev_uring_cmd()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <64e053e4-24aa-434d-9b35-794d3b292628@kernel.dk>
 <CADUfDZq11PnyH5Vh8VjUzsV9Mxq6=0poGw--umMxccfwXiz54g@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZq11PnyH5Vh8VjUzsV9Mxq6=0poGw--umMxccfwXiz54g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/26 9:32 AM, Caleb Sander Mateos wrote:
> On Tue, May 5, 2026 at 12:38?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> This passthrough helper currently only supports discards. Part of that
>> command is the start and length, which is read from the SQE. It does
>> so on every invocation, where it really should just make it stable
>> on the first invocation. This avoids needing to copy the SQE upfront,
>> as we only really need those two 8b values stored in our per-req
>> payload.
> 
> Maybe I'm missing something, but how does this avoid the SQE copy?
> Won't io_uring_cmd_sqe_copy() still copy the SQE if the command issue
> is delayed by links/drain/forced async or if the initial issue returns
> EAGAIN? The code change looks fine to me, but I'm not sure I
> understand the motivation.

Because the alternative would be to copy it upfront and then using ->sqe
would always be fine. But we can just ensure start/len are stable. The
patch is about the latter, not adding any further copy avoidance. Yes if
you use async or it's a link or drained, prep will always copy it.
That's fine.

-- 
Jens Axboe
