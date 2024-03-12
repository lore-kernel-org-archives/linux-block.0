Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C9B653
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 01:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710205305; cv=none; b=IVuTHj6ybqKXS1BQ3Ae3M86q8dqh8rLcDTTr+/keoCpm7EbI3jj98hrHd0nsNWwd99X6T+LMkazyVJFLPzjqd/IWGX/qf9ICNmWm8O3ysnZ65cVjlj0D5OvXEefwnyspKOBAyiVRSObZxi4VITMtGn6CDP49ncBdOw1ico8xdQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710205305; c=relaxed/simple;
	bh=m1rGjQy77yw95mSf7US39oq2/B0oOuxoHVpSpHD8f/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBYV3OdaSviKRaoaGMqzkZ411je9MTszN37QtKJUgO++GXO2Yz1RXVYQbfHQpmz6RugM/0jlZ6UYCFg54Vg11WAJ3TD8wWfOdOp01bmRu780khxm8etmmJv4Izxzmqg+MxG5gw/R08i5jfrXUQKBlAOmVMMN4Zw1FTvQTOsJE4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BcbuBfA4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BcbuBfA4"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d862e8b163so1731044a12.1
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 18:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710205301; x=1710810101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLmUbX7IyugukF5hApWgrsaqSNJ28iAYVTfA3RfKKmc=;
        b=BcbuBfA4XfleDuUJ2sH46sKUQhG9dDYYaQiLcc5facrXKdslJEq+tyIdlfBD5eYC8e
         SMQRn3VszDA3ADhQhWBFQWMLV5h11bBhJVsxFPeLo0fVVh0/nUWuH7vOT4jBvlz804IN
         Vpx7sLoOJRYRCAjxCZOXlk/bhXhJBmKQ8zNmnl5VG/LjuQbsrdYs/lqWS/VGwPkhG9pS
         aHgt2Vncvb4X69h1m0n6yoX6ZO6PkyZ4kPO7sU/Em8Kq/TRtJDVpteOUhd/VgPE2xOhg
         MmYyAY5W4Pmkzz3Og3xarIg36a0lqNcPypMaXsY24seO47iKxCLddYTj7Hsm8mkdanFV
         COrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710205301; x=1710810101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLmUbX7IyugukF5hApWgrsaqSNJ28iAYVTfA3RfKKmc=;
        b=RFJXEAfu/t5GCGIBNhKrejTOmjVD+JFILkfnEKZJGsbzotIpD4DgFEF6sLf5upI0YH
         4A6NR6TyDPc03N2tE0UUYO1Y+h3iR8QgPdB6aEF2eFH2KLqv8bHjek2O683TSXA02PWC
         qkRtY+sXgjbq/8tTBQ6XAO4jnVHKoGb7AHfiOHAcUPagACHUq+T9uRUnSTMSUkZCcpx8
         2PqYUCQ3IfWUS89YjKPuIcYSS9jHWEZrfSMlGUr6KUhX6ZqMfah+58BkvjIMSSNWAORV
         3Uzb4fjYesPRq2j/BiChrljRTwKp29I+SjBSHOtlH9PXCiIyvKn7ZQQMH7DRAJ3JFU2b
         90VA==
X-Forwarded-Encrypted: i=1; AJvYcCURqMbHoFwS+OqDbjrpl6GMnJpdHyiJH7XscxxyZ4uOZF6D1sh7ImNWZYI4CV99mRnExJ7rosTcuGWRDtqvKRHI4NvdSlA2XquE7ew=
X-Gm-Message-State: AOJu0YyS+32u9PVn6HjzHy1asbTXjYEbb6f1WHVhzyExcEIrzuufECzQ
	qDKcvuPpmE26QCNQY3Adp9XA0+QXuIDLYkgNQ9kh/9dYEvtEW8w1aDDF855bOnOvf0Rfzkolx/Y
	y
X-Google-Smtp-Source: AGHT+IFx4FgcKj2HztVcBXzWXiWr+Cafd2KIKKVpefTWtqHDm189BFjppwVxa2ql7VFQBS1b7RMk0Q==
X-Received: by 2002:a17:902:ed53:b0:1db:3ee6:e432 with SMTP id y19-20020a170902ed5300b001db3ee6e432mr8722557plb.3.1710205300935;
        Mon, 11 Mar 2024 18:01:40 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 18-20020a170902c21200b001dd6290283fsm5323939pll.248.2024.03.11.18.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 18:01:40 -0700 (PDT)
Message-ID: <9f07c344-d91f-46e0-b8b9-aa9db1d04b0a@kernel.dk>
Date: Mon, 11 Mar 2024 19:01:39 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@kernel.org>
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
 <20240311235023.GA1205@cmpxchg.org>
 <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
 <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk>
 <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/24 6:21 PM, Linus Torvalds wrote:
> On Mon, 11 Mar 2024 at 17:02, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Just revert that commit it for now.
> 
> Done.

Thanks!

> I have to say, this is *not* some odd config here. It's literally a
> default Fedora setup with encrypted volumes.

Oh I realize that, which is why I'm so puzzled why it was broken. It's
probably THE most common laptop setup.

> So the fact that this got reported after I merged this shows a
> complete lack of testing.

Mike reviewed AND tested the whole thing, so you are wrong. I see he's
also responded with that. Why we had this fallout is as-of yet not
known, but we'll certainly figure it out.

> It also makes me suspect that you do all your performance-testing on
> something that may show great performance, but isn't perhaps the best
> thing to actually use.

I do that on things that I use, and what's being used in production.
This includes obvious the block core and bits that use it, and on the
storage front mostly nvme these days. I tested dm scalability and
performance with Mike some months ago, and md is a regular thing too. In
fact some of the little tweaks in this current series benefit the distro
configurations quite a bit, which is obviously what customers/users tend
to run. It's all being worked up through the stack.

crypt is fine and all for laptop usage, but I haven't otherwise seen it
used.

> May I suggest you start looking at encrypted volumes, and do your
> performance work on those for a while?
> 
> Yes, it will suck to see the crypto overhead, but hey, it's also real
> life for real loads, so...

Honestly, my knee jerk reaction was "pfft I don't think so" as it's not
an interesting use case to me. I'd be very surprised if it wasn't all
lower hanging DM related fruits here, and maybe it's things like a
single decrypt/encrypt pipeline. Maybe that's out of necessity, maybe
it's an implementation detail that could get fixed.

That said, it certainly would be interesting to look at. But also
probably something that require rewriting it from scratch, probably as a
dm-crypt-v2 or something. Maybe? Pure handwaving.

What would make me do that is if I had to use it myself. Without that
motivation, there's not a lot of time leftover to throw at an area where
I suspect performance is perhaps Good Enough that people don't complain
about it, particularly because the use case is what it is.

-- 
Jens Axboe

