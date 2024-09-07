Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0834158A18
	for <linux-block@vger.kernel.org>; Sat,  7 Sep 2024 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725717037; cv=none; b=Xxhqb5AaK3TrzojPzP4Hd851pGb1P0JnMroBwQt4/3Xc7fEZUfUldup+9tkHva4xUnKyzIHtNUl5FUovPVtd4WswHa1DN9mlL15iy/t9aLiKmBlesqK7V1rIO9flT0ZfkD7//MGEHsg3/Hzb1bG5BW3umEqGz6pBdwA3NoYk3Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725717037; c=relaxed/simple;
	bh=WHoIxnBb4SBEJ15qVm05JJw11BoEE4YUZsFD/5duCZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYWQdtTVFKHTHn8Bwjl6iUcY/YuqvBXIbC7sK+JS5PIcz6v1Q2K6AKGmkp0+wXB+z6/YcITQ7WrXxEmMcpVtAyAyRD0oh9mRnZyjMdp7pRo4DyhXVuXef5uYBOgUgp0itjMsGIpyq5O2lTYpZ3eYM2nWOhhVKrLafN5b1m68uQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Hvr+1TdW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Hvr+1TdW"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2059204f448so25276505ad.0
        for <linux-block@vger.kernel.org>; Sat, 07 Sep 2024 06:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725717035; x=1726321835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMA2SqrIHZ2snoiPna0SLwPinr3MBCQFZCvHCM++WCw=;
        b=Hvr+1TdW5zeHjK2VXO57jlNr32vxdt3BTSL/6Pjulu4rj6XmrL7Bkar39m14Dh4A2K
         QzrjzONRaXjVXCFnoVxlesbJ5mzGOd7BpJT/qrfmr6sNv9Q/3yyUE7GATMv7tos67QPo
         qEJa6U6MBtt98/C8gHE4jr0XlAO8WyhY69rwjl5rWcSpvLfnse/Ztqwt5VELDqabiA0B
         LGz7RghihnkdtwcVhQbfsw78vre6saTbgAEcVpIsZEHs9Czid6WL9zr7i10g4PeY7waD
         3D/++EECVBcx43b10BnbHhl5AGIB72fBy6oPHnwrwrpNN/gUNoDZCm4amaD469ZFrpoH
         ilHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725717035; x=1726321835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMA2SqrIHZ2snoiPna0SLwPinr3MBCQFZCvHCM++WCw=;
        b=HFBgo998d7Lq3E8OBlh5Qn5CXWwG94Eyr4VUG+kxEAMyD3pIX4s3HLW87ElLDj1uZp
         IxwCJYIlXcMiWLsJ/y36UEqmAi3feeyLAjjjhcgPFNg0hABZx3BY7KsX8Z0HPmMe23v6
         7b5NP9lqGUg7pKsfykhn3ZkqoETr/KXz9HkfSp6VCZEgxSsrKbtCTIJpzab5W84SD35Y
         I2RIByTlfzRTl/UVLNwg6dv9wJnYIzFa4WgQwHpprnFn0dT/n8jPNJJ6iVeHSUELT5Wv
         QMeuL2fInzDHF2HNPoLkJITdaRMwgwN1yfOEphsh7hNqKAT/RL0sNhF/QxHjbCBh0rwA
         gWBg==
X-Gm-Message-State: AOJu0Yz+nSXv82yUgYwKjM7j0CWxhNgS5VOWEtX6guW4i3Mnr1KNgVqo
	EUm50529yNybiKZkKLdSdGQs4nnh51VV2GdMWztT0ttVfNBC10Qq32J9yasTPnw=
X-Google-Smtp-Source: AGHT+IHFYlLyR5rwPw3XBx1ucXx5PO/WGEED6w2l5W/Mw17FJutwafFJqBJ/voGr9YFjiN94o8cTMw==
X-Received: by 2002:a17:903:22c3:b0:206:8acd:ef7d with SMTP id d9443c01a7336-206f0655fa9mr81093115ad.52.1725717034840;
        Sat, 07 Sep 2024 06:50:34 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710eea9d1sm8818615ad.157.2024.09.07.06.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2024 06:50:34 -0700 (PDT)
Message-ID: <c8fd6c9b-67a7-4cc5-b4e5-c615c37f6b4e@kernel.dk>
Date: Sat, 7 Sep 2024 07:50:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: elevator: avoid to load iosched module from this
 disk
To: Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>
Cc: linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
 Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20240907014331.176152-1-ming.lei@redhat.com>
 <20240907073522.GW1450@redhat.com> <ZtwHwTh6FYn+WnGD@fedora>
 <4d7280eb-7f26-4652-a1d4-4f82c4d99a4c@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4d7280eb-7f26-4652-a1d4-4f82c4d99a4c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/7/24 3:04 AM, Damien Le Moal wrote:
> On 9/7/24 16:58, Ming Lei wrote:
>> On Sat, Sep 07, 2024 at 08:35:22AM +0100, Richard W.M. Jones wrote:
>>> On Sat, Sep 07, 2024 at 09:43:31AM +0800, Ming Lei wrote:
>>>> When switching io scheduler via sysfs, 'request_module' may be called
>>>> if the specified scheduler doesn't exist.
>>>>
>>>> This was has deadlock risk because the module may be stored on FS behind
>>>> our disk since request queue is frozen before switching its elevator.
>>>>
>>>> Fix it by returning -EDEADLK in case that the disk is claimed, which
>>>> can be thought as one signal that the disk is mounted.
>>>>
>>>> Some distributions(Fedora) simulates the original kernel command line of
>>>> 'elevator=foo' via 'echo foo > /sys/block/$DISK/queue/scheduler', and boot
>>>> hang is triggered.
>>>>
>>>> Cc: Richard Jones <rjones@redhat.com>
>>>> Cc: Jeff Moyer <jmoyer@redhat.com>
>>>> Cc: Jiri Jaburek <jjaburek@redhat.com>
>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>
>>> I'd suggest also:
>>>
>>> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=219166
>>> Reported-by: Richard W.M. Jones <rjones@redhat.com>
>>> Reported-by: Jiri Jaburek <jjaburek@redhat.com>
>>> Tested-by: Richard W.M. Jones <rjones@redhat.com>
>>>
>>> So I have tested this patch and it does fix the issue, at the possible
>>> cost that now setting the scheduler can fail:
>>>
>>>   + for f in /sys/block/{h,s,ub,v}d*/queue/scheduler
>>>   + echo noop
>>>   /init: line 109: echo: write error: Resource deadlock avoided
>>>
>>> (I know I'm setting it to an impossible value here, but this could
>>> also happen when setting it to a valid one.)
>>
>> Actually in most of dist, io-schedulers are built-in, so request_module
>> is just a nop, but meta IO must be started.
>>
>>>
>>> Since almost no one checks the result of 'echo foo > /sys/...'  that
>>> would probably mean that sometimes a desired setting is silently not
>>> set.
>>
>> As I mentioned, io-schedulers are built-in for most of dist, so
>> request_module isn't called in case of one valid io-sched.
>>
>>>
>>> Also I bisected this bug yesterday and found it was caused by (or,
>>> more likely, exposed by):
>>>
>>>   commit af2814149883e2c1851866ea2afcd8eadc040f79
>>>   Author: Christoph Hellwig <hch@lst.de>
>>>   Date:   Mon Jun 17 08:04:38 2024 +0200
>>>
>>>     block: freeze the queue in queue_attr_store
>>>     
>>>     queue_attr_store updates attributes used to control generating I/O, and
>>>     can cause malformed bios if changed with I/O in flight.  Freeze the queue
>>>     in common code instead of adding it to almost every attribute.
>>>
>>> Reverting this commit on top of git head also fixes the problem.
>>>
>>> Why did this commit expose the problem?
>>
>> That is really the 1st bad commit which moves queue freezing before
>> calling request_module(), originally we won't freeze queue until
>> we have to do it.
>>
>> Another candidate fix is to revert it, or at least not do it
>> for storing elevator attribute.
> 
> I do not think that reverting is acceptable. Rather, a proper fix would simply
> be to do the request_module() before freezing the queue.
> Something like below should work (totally untested and that may be overkill).

I like this approach, but let's please call it something descriptive
like "load_module" or something like that.

-- 
Jens Axboe

