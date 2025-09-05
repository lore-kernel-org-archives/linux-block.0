Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943FB248176
	for <linux-block@vger.kernel.org>; Fri,  5 Sep 2025 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101965; cv=none; b=OIo8wrhrdxwYByyY+h6jnfPQ7vbi73BMOQrVMyCLZXC0RauwUkx87JXXAf7Dj1aoikHjSYVz0sDz+E6a+0zZ/l8qZclyEf3KLHmlozjep7cgVYZeRxww1RZYYzjUganhWHBB1PR9Dt0himf9I9OaTsHe95j87xoz68k3KX5AEyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101965; c=relaxed/simple;
	bh=2bnmXoFq8hT07977Bt8V37gyvrBp2WvBZT/P/9TkDN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nk5ImH827JuaqMVtgjuZZDrcKWeGw2vePGuFaI5fSu6dRvWGvmr1sxnApQJ4CIws3CINCtqsOyohYXVu0JGCiw4YgChcy0oALTNuX6M0FagsBemXPu1OrBVLjc1D5iWBd0jQkX1vEtYgADpgW/9mFE+IjoFEfIfM5AtFlEsm0zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wKsSzsBx; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wKsSzsBx"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d603b62adso25340337b3.1
        for <linux-block@vger.kernel.org>; Fri, 05 Sep 2025 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757101960; x=1757706760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HSKMhFHnXL4om4k6tLAqbvEJ0fBQx5JXzb5/1sEFd8=;
        b=wKsSzsBxAqegFKINgKpx1VtTvmOMhaasEQkbYKTZM6icWw5vFFL79beYX9IlWGzhlJ
         LGjiJvKFXtbq/BcRW45Etn8ewNuHda11BAvBdzT4BK4+9vXBvFRygMfq+VCSomBbqrDN
         /ph66V2UIFGmamobZMRqlNWQl+K4kJYZgthAsU1C50Eeo+AiK6acRpmIvPUY6XMkjk6c
         1o5j4jVeFwu1sA/lJ0qZrCaG327aVyj+09y45Qa6QtGRgiTEyCk0fFkIdPxMQd7NhK6J
         R+2kPvRWzZosQ964uJDV6VO1yVIv3kQLzENbP5ekkeP+Vr1YocicpbwIY1gBHrlSCu7K
         HLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757101960; x=1757706760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HSKMhFHnXL4om4k6tLAqbvEJ0fBQx5JXzb5/1sEFd8=;
        b=INpXeyBVYEwqTQTRVAFXPSaSKz5HatLeqT/BZPKg7S2oF670MfjDGUKAuVoQaor3Wt
         8qscW35SuDHKWB52VUyS9slRvH5oNIyGbzMIhAbcVnVb9Aoc6CdMEpF4zqWTdAOZwq+9
         oS5PMfOROY9PDECRffTiTdbmfxR1BII1p0D239Virux8wI1x6uHppLzSM9BPR9vkJBtM
         fV7GBfYE+ZNt0gYuhZ0sDiCH5W4jkh95Rq7J/yZM94Yixy0jHNnA3EHPCJ9ZRJ+l8CK3
         k1PR9HmLLpT887CeTxWa4KU/1hl9/2YQd+vJdWsIEK9gM4B5eVFtH6bHiLlOtqCegcS3
         GrOA==
X-Gm-Message-State: AOJu0YyPk4mlS+VsFnAsfKRpEnRYnfX0onszvftjzJEr0kPqAssY92QA
	wjp/IijyIQ+hBystOxZmwVOE8CMjm0PHekkbP1TPpnwFAqMTR+NzfouaCJlWlutsUaM0XG9twPT
	5GNdc
X-Gm-Gg: ASbGncsSnfYkvxDzg9fALsxIcs3/Kj1tcIFlXKB9DUuQud+ehAZmGHQNBcq/BY1JuiD
	xZZoaddGbbvHjVNVzhUs5/BPs43Otgi+YnchxgsslzMEGvOGebagjV6gFvgN/Hh7djmGiNOEsX5
	sNLTaAW22gj0Y6wBF9Nz7yTsECO/lZ4O8o5rNxH/VtHdrbvCKXAC61/35VZPQFyALBTBd8uCstF
	p71LdlKWyhNZmE/66dKwBjajAYxZQ/Xe3no1UD14lIZq5JxBAdy8TU3nmk8wHvETlRiNK9ePEJb
	tUzyWGnJ4HhhHipu5B777ftSBKRd0wiw2gNb6iPgBYxnce+z+wDO+gYLFRRx6tC8Sj79M0B6nEc
	95snAHFR0NVUXtWN3gKw=
X-Google-Smtp-Source: AGHT+IFdsFDBwdpPG1DdzDrJ6wvtu1VxG7NloPK+qUtgvUQ5KzDXlITM6YW8RLXwJZuYT9usxfwmIg==
X-Received: by 2002:a05:690c:6411:b0:721:5880:6b2 with SMTP id 00721157ae682-727f5e3b124mr925857b3.51.1757101960514;
        Fri, 05 Sep 2025 12:52:40 -0700 (PDT)
Received: from [172.17.0.109] ([50.168.186.2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-609d205c24dsm1361503d50.0.2025.09.05.12.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:52:40 -0700 (PDT)
Message-ID: <e15833f9-c18b-4783-af01-42f44a9cecb3@kernel.dk>
Date: Fri, 5 Sep 2025 13:52:39 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] blk-mq: fix update nr_requests regressions
To: Yu Kuai <yukuai1@huaweicloud.com>, bvanassche@acm.org,
 ming.lei@redhat.com, nilay@linux.ibm.com, hare@suse.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
 <95389918-b809-f81b-5fd0-2e350154ca01@huaweicloud.com>
 <f4231a7f-cc73-c506-e30b-b2bfa9d98dba@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f4231a7f-cc73-c506-e30b-b2bfa9d98dba@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 1:20 AM, Yu Kuai wrote:
> Hi, Jens
> 
> ? 2025/08/26 14:27, Yu Kuai ??:
>> Hi, Jens
>>
>> ? 2025/08/21 14:06, Yu Kuai ??:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Changes in v3:
>>>   - call depth_updated() directly in init_sched() method in patch 1;
>>>   - fix typos in patch 2;
>>>   - add review for patch 2;
>>> Changes in v2:
>>>   - instead of refactor and cleanups and fix updating nr_requests
>>>   thoroughly, fix the regression in patch 2 the easy way, and dealy
>>>   refactor and cleanups to next merge window.
>>>
>>> patch 1 fix regression that elevator async_depth is not updated correctly
>>> if nr_requests changes, first from error path and then for mq-deadline,
>>> and recently for bfq and kyber.
>>>
>>> patch 2 fix regression that if nr_requests grow, kernel will panic due
>>> to tags double free.
>>>
>>> Yu Kuai (2):
>>>    blk-mq: fix elevator depth_updated method
>>>    blk-mq: fix blk_mq_tags double free while nr_requests grown
>>>
>>>   block/bfq-iosched.c   | 22 +++++-----------------
>>>   block/blk-mq-sched.h  | 11 +++++++++++
>>>   block/blk-mq-tag.c    |  1 +
>>>   block/blk-mq.c        | 23 ++++++++++++-----------
>>>   block/elevator.h      |  2 +-
>>>   block/kyber-iosched.c | 19 +++++++++----------
>>>   block/mq-deadline.c   | 16 +++-------------
>>>   7 files changed, 42 insertions(+), 52 deletions(-)
>>>
>>
>> Friendly ping, please consider this set in this merge window.
>>
>> BTW, I see that for-6.18/block branch was created, however, I have
>> a pending set[1] for the next merge window that will have conflicts with
>> this set, not sure if you want to rebase for-6.18/block with block-6.17
>> or handle conflicts later for 6.18-rc1.

I think we're just a bit late on this one, given that they'd go into
-rc6 at this point. Going to queue this up for 6.18 and then we just get
it into stable instead, that gives us a lot more time to shake out any
potential issues.

-- 
Jens Axboe
