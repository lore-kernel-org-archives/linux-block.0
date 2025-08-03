Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A685C15B135
	for <linux-block@vger.kernel.org>; Sun,  3 Aug 2025 03:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754190881; cv=none; b=mIgnGsYy2gjrBGd3wJeUx9QtnMXfffjyTFcrgT2VsWYwQSH40y8VujiCFqP6H9r98Kli+2JaK3y4MvurDLbyGciW5bnOm9XJ5txO9zazdQo2K9zkbfR830p1h6O+VxiH8q86iH1UKdWmHvB3Iiu2TwEkReSL4RyricqlsP3YaWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754190881; c=relaxed/simple;
	bh=I06U9aST2GYkfvyDHP1AgJ2Sz+inFSqaGo3AvWZGZFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udVcPwvwP+hfO1jZ0AOvWJVGcuoe7djcv+S0BObK6CWZ+XZaeIRYI8lINKi1owszPyjyRMBMRbpk/3C4YIbyfjYKL8ZKscv0CeEn77MYyOB5G60TzXxqNpRIr7DUQfoheNLvgAtM6ZjEmaPP7hLJ7iOnJYvM8lYDXDW9/hqCEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZoZcC9ZK; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZoZcC9ZK"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3da73df6b6bso8937965ab.3
        for <linux-block@vger.kernel.org>; Sat, 02 Aug 2025 20:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754190877; x=1754795677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cW1yq1ITU9iSs5gFURnNqtAi2guQ2cAENBLEqAEaTOk=;
        b=ZoZcC9ZKs0JuSP8Hls54EV06+i6FEydHKP3qd7nUpb7KsT0brTEP2b2EJfIUOfSx8b
         kwiCMrBBYwZmHmvggM3XWczfxXObFrOoRAjwTYVp80UVgLqgedRG099akS36cVTxWN+Q
         yX5X69s8vVxthCtmGJUGdTwEBNWvYh9SYtEcVghzQh0b6NyscELHHqTw9pbPZCG8OwZq
         iPAlGpxehCFjwkimX3wYhmKjbVEBlI5qO7Il44jDidR+bU8i78LUfgomhWC7WrzBjtsV
         utogJuUPXJM8pr6CNpJZSzH+pdlTMQkRdoUER2L7OahIxKY4NqSsQghflrTwrAnfGSY4
         fM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754190877; x=1754795677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cW1yq1ITU9iSs5gFURnNqtAi2guQ2cAENBLEqAEaTOk=;
        b=V8IqewH0QHHF4yOZEaJQhgiwW7ncevafTIIIvY7Bnps9f57hFdhiTvN3jDoVPyiIsu
         BEgunsK5qSCG0KhsSHErj2TF4TMSrXkTh2QsRjWA5cFcpJQIkkCzFTnWDyI/RrD6tuRD
         82GLi4O5ZPo3GjkYQpCn2VBZSpbJ17OuPsEKUUKrgFpwEv8LRqNxw7CViYYJpCDVaITs
         hclXio4ohjfFP9OriA6vRzSMeAjT+azVyZQq4rsIGdre961EBpHsI/IECwSNIPH/OLrL
         Q+DLHoLaZAI4eslNyVZ92eK+be/u/v3zfj626ArxR4hNZnZ492b/E1MNwshAxfA2cCfh
         HpCg==
X-Forwarded-Encrypted: i=1; AJvYcCWvjRcOMthlRs1jsOpON6tDSvtrAoGU6kQ95z228s4VFSuprKRF6Mi2kxfaPc6McvVVP1D6PhU/HoKv9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/EBZZobBbq0+Uf6MAaQqO4QcGz+Uf2xjtghHfU1QXCWBcOj9h
	xgwxgqjo1+Fj7OdzU+720sxMLHIA4DwgrK/l9CZ4anvODf794ITKUCIAKFMRKROzgVZGoAoTu2b
	vdbd/
X-Gm-Gg: ASbGnctQadNH4cYonAD90nYF/bY8um8YGRqXyvsATpOnBNsHjSvO92xb64gr8O4Bx+n
	Sh9R1qiLZi6iLdy9DhHhSm5uNpKv/FxixOP3ogVAnOesJWA2yJnwTw9MPZvCpBOMiAjNlOL1kbl
	uRfiBrnGTeDwDZkSbi8/RuZQtwuqaUQDEwhTxX1wiVyi5M34diQMpf/JuaztcItgFSZg7ccUHul
	NvHbHKxrfGB3bpBSqgC7IncHj10h+rpMMgM2mZAqeX+T615oqwIsSRNhlSE3O8e1Dfbr+rfCmKW
	uFer5zG2dPZGkPfTT4RZqOq6fOjkjeGvT6/G1S/0vpYHTCAJkE8c2d8l3sBLY7JSRNtTSmGyPE9
	45fTka1uKgURQoekj89E=
X-Google-Smtp-Source: AGHT+IHLtNbe3wkVigxIkgvTdap020cV0mPxVNB6VX1mwJIrQoS7lKEdHpQvbjHgL3xZ8VW+jA/N5w==
X-Received: by 2002:a05:6602:6d0f:b0:881:7a5d:e615 with SMTP id ca18e2360f4ac-8817a5de6f1mr113881739f.14.1754190876635;
        Sat, 02 Aug 2025 20:14:36 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55def302sm2227492173.101.2025.08.02.20.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Aug 2025 20:14:35 -0700 (PDT)
Message-ID: <ebd84f0e-21bf-4259-8c05-5797a4e0bbfe@kernel.dk>
Date: Sat, 2 Aug 2025 21:14:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-6.17-20250803
To: yukuai@kernel.org, linux-block@vger.kernel.org,
 inux-raid@vger.kernel.org, song@kernel.org
Cc: yukuai3@huawei.com, yangerkun@huawei.com, yi.zhang@huawei.com,
 johnny.chenyi@huawei.com, xni@redhat.com, heming.zhao@suse.com,
 linan122@huawei.com, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>
References: <20250802172507.7561-1-yukuai@kernel.org>
 <0c680f7d-f656-4e79-8e1e-b6f2e5155a80@kernel.dk>
 <f02514c1-6f29-4029-a80f-f68202a863d0@kernel.dk>
 <5884b30a-8ffc-48a1-b944-675441626fc7@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5884b30a-8ffc-48a1-b944-675441626fc7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/25 5:50 PM, Yu Kuai wrote:
> Hi, Jens
> 
> ? 2025/8/3 5:42, Jens Axboe ??:
>> On 8/2/25 12:29 PM, Jens Axboe wrote:
>>> On 8/2/25 11:25 AM, Yu Kuai wrote:
>>>> Hi, Jens
>>>>
>>>> Please consider pulling following changes on your block-6.17 branch,
>>>> this pull request contains:
>>>>
>>>> - mddev null-ptr-dereference fix, by Erkun
>>>> - md-cluster fail to remove the faulty disk regression fix, by Heming
>>>> - minor cleanup, by Li Nan
>>>> - mdadm lifetime regression fix reported by syzkaller, by Yu Kuai
>>>> - experimental feature: introduce new lockless bitmap, by Yu Kuai
>>> Why was this sent in so late? You're at least a week later sending in
>>> big changes for the merge window, as we're already half way through it.
>>> Generally anything big should land in my tree a week before the merge
>>> window OPENS, not a week into it.
>> I took a closer look, because perhaps you just sent in the pull request
>> pretty late. And it's a bit hard to tell because it looks like you
>> rebased this code (why?), but at least the lockless bitmap code looks
>> like it was finished up inside the merge window. That looks late. The
>> rest looks more reasonably timed, just rebased for some reason.
>>
>> If I'm going to get yelled at by a traveling Linus, there better be a
>> good reason for it. In other words, is there a justification for the
>> lockless bitmap code being in there?
> 
> Apologies for the late submission - this was unintentional. The core
> changes were ready before 6.15, but the final llbitmap patch got
> delayed due to review backlog.

> 
> About the last patch:
>  - all feedback are addressed 2 weeks ago
>  - still waiting formal Reviewed-by tag, not sure why, possibly due to
>  this patch is huge.
> 
> About the rebase, this is because llbitmap set has conflicts with
> other patches during the period, and I sent a new version and just
> pick it last night.
> 
> I do take a bet sending this pr last night, and hoping llbitmap won't
> delayed to next merge window again.  However, I fully understand if
> this misses 6.17, I'm prepared to defer to 6.18.

Let's defer it to 6.18 then, if you're fine with that, as this really
should've been sent out ~2 weeks ago. FWIW, it's not an issue to have
conflicts with my tree or master, I can resolve those. What is generally
nice is if you have a merged branch somewhere you can point at, then I
can double check if it's all good in case it's a complicated merge. But
that is greatly preferable to deferring pull requests or rebasing them
to avoid the merges.

If you have fixes in your current tree that should go into 6.17-rc1,
then please do send those separately.

-- 
Jens Axboe
