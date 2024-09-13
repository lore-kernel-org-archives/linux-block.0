Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9784A8C11
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726187972; cv=none; b=OhPITM8eVVtgVui9fe5U6cNS69z/3rRgR0NOg6bmT9tchM6kYGa2FmKB36dEFFeIAPVwr5bihpfSPPJtyx9FkWSh7PDcFZcZu0BHkH36ghWrJP2i15XWSKEpazo6rVf/7gpL3NqeunGyjDwk/Pla3wcRfkpGhZF5t0mHupXrAJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726187972; c=relaxed/simple;
	bh=F9V/bj7AS8dlM/SOPCylqy0nrsB4Kg7XhZzS5qqkiRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eF9W5ZBOJfE0YYYFbf4hJycnZLERxdYPlceJQw89NAp/+JPWvEpBxyqkmERieJ8yYWVNhqgLqUbBOi3ItJ3GZuUYDvvBydIjNirk4vy5EbKSolzlGqWVYLtjIUTUIKD62l1mv3X/fwh/5HsCvRVS/gpJJahWhe/DZjRok1ChhZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nnyPdzXn; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nnyPdzXn"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2da4e84c198so1165233a91.0
        for <linux-block@vger.kernel.org>; Thu, 12 Sep 2024 17:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726187969; x=1726792769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bEqpE1/53j05/MmgDJ0YGDgTKmQeMPpD+gGmbqev45I=;
        b=nnyPdzXnV3As6HVfUTXm9lfb/S7aXlWppSAsquYL+KYnTWlFDjwKZsHk7J5Y11jpCT
         d0z71CHrOQtq1EY5FqhbOisUe1g51PlSTIpGQBCB97tMgkkmTL746M7aixoHeKFNhthd
         tkRuObcs9+L7ndzrDtVO8IvwPc2XTXjZb58i9qtogqch3jkN7SSZPnjSj7NgSmZtPjS9
         9GW5PH27pxN0chcvhJTrPI62eTWvWr79aQ9PujKd72mOg+L4yAhl3zSRJhYEDJS+c6/5
         BALVwqdGI79uh0MgHtR7okU16F3B7K3Jr1OZK9sCwAEKTkgJ07Aqi4sCVkScHzrylR6X
         lmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726187969; x=1726792769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEqpE1/53j05/MmgDJ0YGDgTKmQeMPpD+gGmbqev45I=;
        b=a5fIkCA/zQ3yUAk85/d35EwY2LBf5drbgOQQx02vcNtqrYTRtu0fDy3xbqCmVucKeE
         86iqu9a+h6UESruRAxufTkGIxL0TfTNLj8+M2hpnn7ZRfHN7AWeNTmTzNnVckg3fq3BF
         SIihoxpZEey92Hjj2DUfKhyGW23c7XIJMlpppqr+AM/CkzThhvSp4Skx+x7C/V07wJf9
         C+Y7Mfp6sN5FLoFlx0faV4mK87mx3JQwg3Lz5QDEdGL7BlUO2fRScbYRqsg24atXNgWM
         t15TjCKpp67AZ+9kWnZfcCLkTzdPi/lxzj0+npnLkkJ/JzezRrvi8KstMMBMS73KOHnS
         pJOg==
X-Gm-Message-State: AOJu0YxUXqGyQDr2p7B14XVboo3+HJgZ6c4+LzbJ9h2KPJpWz4lbaXtV
	ZySn+hl09bcU/dK/0iGVP0Q0sc8XK23qRB0T9FgB2IEiidRJXgYNOucE4YQ05zaRyUJFRCiWpdC
	1
X-Google-Smtp-Source: AGHT+IED/YsTi/lASY7F4gtOaRLC6Z2uec5LuLt65v4EVCyRifw2L1q3HPhH6bPpJYmJA7TKiHnfpQ==
X-Received: by 2002:a17:90a:8988:b0:2d8:e524:797b with SMTP id 98e67ed59e1d1-2db9ffb3f12mr4764646a91.18.1726187968778;
        Thu, 12 Sep 2024 17:39:28 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9ccfa31sm348729a91.29.2024.09.12.17.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 17:39:28 -0700 (PDT)
Message-ID: <6cefd313-a7a9-4b21-ac70-09eecdc78043@kernel.dk>
Date: Thu, 12 Sep 2024 18:39:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Block fix for 6.11-final
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <c8f3fba4-9cc1-4e7c-baf3-afb10ab7605d@kernel.dk>
 <CAHk-=wgdjRgB0WRULyWU3S2LG+z7fQULAq5_44Kx7TrakAasYQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wgdjRgB0WRULyWU3S2LG+z7fQULAq5_44Kx7TrakAasYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/24 5:21 PM, Linus Torvalds wrote:
> On Thu, 12 Sept 2024 at 15:44, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Just a single fix for a deadlock issue that can happen if someone
>> attempts to change the root disk IO scheduler with a module that
>> requires loading from disk. Changing the scheduler freezes the queue
>> while that operation is happening, hence causing a deadlock.
> 
> Side note: I do think that doing the blk_mq_freeze_queue() outside the
> sysfs_lock mutex is also a mistake, and will deadlock if anybody then
> needs to do any IO (like a user space access) inside the sysfs_lock
> mutex somewhere else.
> 
> It wasn't what caused Jesper's problems, and maybe nothing actually
> does that, but it still looks rather questionable in
> queue_attr_store().
> 
> I mean, imagine holding q->sysfs_lock, and doing something as simple
> as just a memory allocation that wants to do swapping, but somebody
> else did that queue_attr_store(), which freezed the queues and is now
> waiting for the lock and won't unfreeze them until it gets it...
> 
> Yeah, yeah, very very unlikely to hit in real life, but still. Seems
> very wrong.

Yep I agree, it does feel like the wrong thing and could deadlock under
reclaim. I didn't get around to replying to the other one, but I didn't
want to risk changing the ordering right before release. Will do a
separate patch for testing.

-- 
Jens Axboe
