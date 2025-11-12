Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10327D782
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 21:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762982663; cv=none; b=U4DKNOnxtbPDTM6l30aFojKlmxYAB/hzzU0IkM2qU6w9aJ3UNdyXKXUOncbIqQHyqXMRS2L0/jGgme7KjrfuT4y3wZKYOzNonyxOOSK9C1F/YPhXwqy5hoqvJENPwCJJ61r4AjBQB83YJt+qQamTMB3g8qWHHpjACwfJ9f/MH/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762982663; c=relaxed/simple;
	bh=cd8tcXqNsLLTwr/jSfMxRkDOuidzzMstY6WxzH76bws=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GdWYuspg1mA2RZusWuZ9twuXtPKMl62aYxMgioc2mfUxRE59rkUWsdd6C8J+KZCnpoEsM21NIAmAEztHugAFWwl0jYlvilYvZ65Ti5GqCUxjRcbXaAqfxiBmsRwa+a8dEjsdFDOrsa15WR/WyJMvmfMcPmwrNyc3DeLbo+MR4HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hPhidwzH; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hPhidwzH"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-4337076ae3fso873295ab.1
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 13:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762982659; x=1763587459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dg+E/0ot7g/lCMU2amfXT2KrMeG647IQZnyTcupugdg=;
        b=hPhidwzHVCDNksL7mTr0vyxIP9YYZ2Y+mcW5PWtzri1DpxE1/UmXDylxSAATbAnFes
         9W7hOF9COvsx5shPJ5xdtS7Qbwu8jwMIr4H/aq5ERFBRhyA0je7vdt49pP2DXIwqPg7E
         iTJ99Z+XQYFDSAW/uji/XuAWGe5NY+3kKnvXqLulf+eTmYoAaXYsg5wy6dKu+rel0bwQ
         +GmS17M75CC62QlykDU2SpZIgoWNeVPbPjfadYGPjgEHjhWtSTQ04R9vUVB2fJiVURmJ
         chMjkW3gVgte3Q+HxWPTyQAhDy72rhlOENGPhaENi74kO0XhYstsACtbSwbAQOSwH2/Z
         AxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762982659; x=1763587459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dg+E/0ot7g/lCMU2amfXT2KrMeG647IQZnyTcupugdg=;
        b=jUGK7FdZOhL/k+7GJ+KTCkDQDVbcAZmWJ93yqMTEAij/Y30WEn6uKQfo1KIdmpwyde
         6Rvp/3w6ZiQH1eodpOtUukLq0vIQNBx7C7MyHZ3rHHwWEAlDldIe6jGgRUUpBlag+cGa
         +AZySLXCOHbFPTPqKJQ0yag+OkKAWEFRqFmISjnZcTNHdqdu3wkKxb7Qy7k4RjX2y5ED
         Xczrl/BPeCqVdvdgtZfZJ2j7YRp55mBqpF6u3U8SG1zpSSRSdYbtT5WpP0m2552PUSeg
         cgGZwr5QawNkxXkt6PvtNelICngdBpxznQIvGnjv0AvyPY25ypCNK5uO8rBrZgWMjxG8
         i56g==
X-Forwarded-Encrypted: i=1; AJvYcCVFzirBNH4eCfM0xYHZkWnsL9y3c812XZ8nhJKxwkVsPio4tHHmZsxqmBZQ6V4w5UdKXCoUePpiphRmag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrhjn1iMTTDUo5kjbdrZU5jCl2uyn9fwsr4+Dif+P7+wZtc0kb
	5Bi91C+TCiG4bBXf2Xylhm7a3aWZIIQhn5TD1tz9PbjiOFkZFRQuASn6c3vu/xSw5d0=
X-Gm-Gg: ASbGncuAx7ZOHKvU/skvve6xo53Uq3Ah9cIJATK6XiLXUMuvi3Y4nyS90Ldnrhn9bBc
	IM41M1T54n/B9YPPbeak1mjSFr0muTas/rHfbCfKagRPGgV9fA58VOhjsFYaeqguKXQZK4n2nD3
	KKnOqZfOw43Tyb4CDZR7xPsukBhgmTwZJrDG73Mz5jIadozJQ/fH+otbLUaPmQwcHh30e2thBM+
	gx+aF61B0KvxABjKydpEv1mPHXxAJBuAHPSBhc3C0Yw3UTxFyPhpBMWNtmhJWoaKT26bED0wYos
	WahkWBZ8npBmZq/iWoC56d+QKIzDg0iegZjvlkvKCkD6TbvImFRsp8UEheL49gdw6MLDp5mVjFA
	uuuemj1tvvj8rC9uYtLdafta0BR2yK6GyOTL87pDk9FeUdas7zlpFpKt8WaH+iORClBR9wjBF
X-Google-Smtp-Source: AGHT+IFPacCWkSNFWVI9h6kXwAoSV5zRJLXkXzAVXVTmD75c/Zi7+tq1cHJY8HB8QYjZGZ9YV68BgA==
X-Received: by 2002:a92:ca0d:0:b0:433:330a:a572 with SMTP id e9e14a558f8ab-43473d52e46mr65538595ab.13.1762982658957;
        Wed, 12 Nov 2025 13:24:18 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd3113cesm25641173.31.2025.11.12.13.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 13:24:18 -0800 (PST)
Message-ID: <9d79a898-e460-4ff0-8e58-5c0f34a10a70@kernel.dk>
Date: Wed, 12 Nov 2025 14:24:17 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: block-io/for-next build fails
To: Bart Van Assche <bvanassche@acm.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <cfc75c41-a230-44f4-8e07-fabb1838e02f@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cfc75c41-a230-44f4-8e07-fabb1838e02f@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/12/25 2:22 PM, Bart Van Assche wrote:
> Hi Jens,
> 
> Building the block-io/for-next branch fails on my setup (commit 0c9d2fd731b3 ("Merge branch 'for-6.19/block' into for-next")):
> 
> io_uring/net.c: In function ‘io_send_finish’:
> io_uring/net.c:533:26: error: ‘REQ_F_POLL_TRIGGERED’ undeclared (first use in this function)
>   533 |         if (req->flags & REQ_F_POLL_TRIGGERED)
>       |                          ^~~~~~~~~~~~~~~~~~~~
> io_uring/net.c:533:26: note: each undeclared identifier is reported only once for each function it appears in
> 
> 
> It seems like a definition is missing for REQ_F_POLL_TRIGGERED?
> 
> $ git grep -w REQ_F_POLL_TRIGGERED
> io_uring/net.c:if (req->flags & REQ_F_POLL_TRIGGERED)
> 
> io_uring/net.c:if (req->flags & REQ_F_POLL_TRIGGERED)

Gah sorry, had a test patch in there for a local build and forgot to prune
it before merging your last 3 patches and pushing it out. Fixed now.

-- 
Jens Axboe

