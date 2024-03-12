Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573253BE
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 01:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710205411; cv=none; b=A2RSGcxyMK4yvWShVAvGB1Plyc68kgIrpfUj8/Po7fRqW+pshtWaxPCDUbcZUp+2vWuUYjcRbHirNYdgzOv2gx1WAhDSZkcZDn4UHCpLhExsYnYoJV+9ecuua9rtPSQZTGhTw8HzpsKfRtA0vPxi9tD4SbwcxYXmykm6WLBK2Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710205411; c=relaxed/simple;
	bh=j2Kt51r14iVttrLC7USXJ/TgmeOXmBaWyQBxJj7Tj1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+n77uwvsoe2IBnolgPLuPgamRyz+e6i8/qg2RySuGvvbEXzqiJQFJ15wPBBnO5X/mkq9QnUeWYpES6V+HY7HJS+4beCjWJGCXP83C4Rs6sq88MNCr+zPo/ZFDcXzU15bjcOUvauo3wV2eQ3vYFlh9jBW+lCiETS3fP993LA8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LJLQxNiT; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LJLQxNiT"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d862e8b163so1731521a12.1
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 18:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710205408; x=1710810208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HemQv53Ky0oSc9HJQfdqnG7iulcdAhtsN41ej43lwTw=;
        b=LJLQxNiTRXO291ZdQw4b1NvRDFVmb6Ot5HbQCKuJZurBIC4jpJsQ0f0lP+KpLUkFrR
         ZHzbbe+S3ltDiwxsLrdaRffVt4PYubBpKgdNxcUJ2QCqQXRqBpdLoKsO3KJQl9JbxEw3
         EFv+67Thjj273IifN55M7cockAaQA5t+gZ8c7IMDDrs+tUzbPZu8G8+DKbECsAm9Cdtr
         OTO1PnmUCdSKxCEipdumZJNXULOnNkHrq0/QLa657i62VV1sErw6V4kY33YtkYmAqhlC
         KQJHB0sSm/EIYK73fJH5eIiM4JFOsb1tw3b4lYKL6eB9SBzUKw7tdqPXQFKcWGHUf89i
         3qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710205408; x=1710810208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HemQv53Ky0oSc9HJQfdqnG7iulcdAhtsN41ej43lwTw=;
        b=FNO7jXEV1mXVFgf7DIAKjIbPqzRvqnsSiQi8zLLhYw+WIn2mgHgmDWiKsOOzXSlv9D
         UbKRY3CQJOBuX8vIUyGuTmovBo4EIo09UQDA+UprdveZgiXWfZoDB/gFd0cJfC1TRvYz
         EcNPBkzhmYQ4QUbciJePj/pnkB72qa+uvdJNbkC6qhyUIwQ/f8MgP8cTJJ1dwXJHSUjJ
         rLbM47wcuahvA7aTBcQH7DNl09YKhcDcTiSR23vxC/awt3qn5LqPNYROUPaZsP8yl3nR
         /+OwIMddZsgsZmzGNmhRc0jBIG93njL8lVGKDM7Tx6UTCQu3xhPTIMYZ49yrR3dSIZBs
         kuXw==
X-Forwarded-Encrypted: i=1; AJvYcCXOb8Brq0rx5VIZPCGVvXjro9DwyPQP4DLVxBWiVSdq7hs0wi+ASGXXrfH/OxYGzLH9TsXFlQaIey1wzMceGanmv3pQv7giAqdqolI=
X-Gm-Message-State: AOJu0Ywc/d7of7QTfo7dxCIl4ZGxWD81XLcRMH3+gAASDy3si5W1FWuN
	853hDRIwsdf2pV+ZF3HyQvmuHfs8GOkPBrjrXxE4DUUxc1r3BodrNUZWuWf1Naw=
X-Google-Smtp-Source: AGHT+IHpJli9abkDIUAfhGw+wEpLj72Cc0kvtRWrBD7AQ9ah4nYnrlYCWT/96a0J4RCKNM7PnvZJFg==
X-Received: by 2002:a05:6a20:9f04:b0:1a1:42db:9c5a with SMTP id mk4-20020a056a209f0400b001a142db9c5amr12543379pzb.6.1710205408415;
        Mon, 11 Mar 2024 18:03:28 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902cecc00b001dd9e2dc807sm2662485plg.63.2024.03.11.18.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 18:03:27 -0700 (PDT)
Message-ID: <3a8cca38-8555-4d28-a1eb-731fd3e6db28@kernel.dk>
Date: Mon, 11 Mar 2024 19:03:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
Content-Language: en-US
To: Mike Snitzer <snitzer@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
 <20240311235023.GA1205@cmpxchg.org>
 <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
 <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk>
 <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>
 <Ze-hwnd3ocfJc9xU@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Ze-hwnd3ocfJc9xU@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/24 6:28 PM, Mike Snitzer wrote:
> On Mon, Mar 11 2024 at  8:21P -0400,
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> On Mon, 11 Mar 2024 at 17:02, Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> Just revert that commit it for now.
>>
>> Done.
>>
>> I have to say, this is *not* some odd config here. It's literally a
>> default Fedora setup with encrypted volumes.
>>
>> So the fact that this got reported after I merged this shows a
>> complete lack of testing.
> 
> Please see my other reply just now.  This breakage is new.  Obviously
> cryptsetup's testsuite is lacking too because there wasn't any issue
> for weeks now.

Yep, agree on that, if it breaks maybe the first few booting it with
dm-crypt, then the testing certainly should've caught it.

>> It also makes me suspect that you do all your performance-testing on
>> something that may show great performance, but isn't perhaps the best
>> thing to actually use.
>>
>> May I suggest you start looking at encrypted volumes, and do your
>> performance work on those for a while?
>>
>> Yes, it will suck to see the crypto overhead, but hey, it's also real
>> life for real loads, so...
> 
> All for Jens being made to suffer with dm-crypt but I think we need a
> proper root cause of what is happening for you and Johannes ;)

Hah, yes. Does current -git without that revert boot for you? I'm
assuming you have a dm-crypt setup on your laptop :-)

-- 
Jens Axboe

