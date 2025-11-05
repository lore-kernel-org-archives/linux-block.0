Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3342833FE0A
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371246; cv=none; b=Sv9+oOoOlQvMTYV+H0BuQ+x3Fv/8HhV/w1COV/0vs/2TuGpQitafpLUr0r+bbM0+BMrkqSaQqZtaQcCFNnu3ANUwaFNDlAJWRg/nRzPZA43lu/tcYm2u2r061U7KBMuElSDbx9k7wjePQuUc5xR6jZJn62nPO2kOBJnVA2XAHoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371246; c=relaxed/simple;
	bh=FYwCdR07aiXgiDxog7Bu9bZNTiuLgby5vJUPf5QsKOo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VmMM3gHnX/adOSDvesTaXcKcBn3GPvRbpiZPaa5ALl2SKymztnjUwnHGvtGT+RpUjGGO2zNmluvGAoUvxkamBJBvL9hZoERi40Q781yz87d4n4tG1HiAds8MZINFutucOtblfw/a7TvP+hrqaomBFSk66vhlO9fnfOu2GIwE1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClfGrvCX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nplmuMeW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClfGrvCX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nplmuMeW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762371244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W2I3VQegSFx+o1eosI30+XZ8D9IOQq1JJdeZxqs+aI0=;
	b=ClfGrvCXhBGi8AlsHsu0RAgfHFop4kC/wd4n9IFV8JTo2PMI0R5W6RO4U8K8kNoePPDwuE
	botdVe1ROO6bPtoKjW8xm14Rh0knqkfTGK777nh0RwjUInISGQ6vvLO2pPWXsi9yPX8h2L
	PnrK1Z1784SEiuea/mjHThclw1hwvuM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-eA5DYOlfPISxUZ0kv8hWcA-1; Wed, 05 Nov 2025 14:34:01 -0500
X-MC-Unique: eA5DYOlfPISxUZ0kv8hWcA-1
X-Mimecast-MFC-AGG-ID: eA5DYOlfPISxUZ0kv8hWcA_1762371241
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-89eb8ee2a79so97247385a.2
        for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 11:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762371241; x=1762976041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W2I3VQegSFx+o1eosI30+XZ8D9IOQq1JJdeZxqs+aI0=;
        b=nplmuMeWo+EdLo776L7W6alL3gJJrKmAyK/tL+JNBm8huOMlI6JbB18+h8Hbc+57b/
         4R68StGzgDsm474ktvf2u5u3O6pXeW6CFyO+tAAd42vG/+R21dML1ISEg3pEprQPMGs8
         ngsn42yj2rncWPHahVsD5XxRAtpC+su12vUyEU4VaAQH/riQjGAl5iQAPpI7tSHWnn8Z
         UeSFPW59nUWlgt+03Z1Oq2rp297/V5Y3NSmIQc3xWZMdcDqYaylZop6kYfalmCkhssF0
         MRj832uFpmmtc/53caKVdA2zwBHTBMGzjRFI7xuYf301o7WJbNyGByiFQsvjeepR+MId
         CCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762371241; x=1762976041;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2I3VQegSFx+o1eosI30+XZ8D9IOQq1JJdeZxqs+aI0=;
        b=PaGspJCjiNaZ9Usb58cXUx34K3V0/USscOFjlC6Ix4NWEJbeHUBneVZJwtSj93R1WR
         MCKryZs5lrAr6X1QoE3DwnGq1hnO48s15T+P7Y5eX0XP3wEqvAcr4ruh5xjcT4SNQk42
         Q7zjfyP27J7OTUDT7IuYo5EbHFzGky8jSzfqpruQO98nL4GdoGVknlEp4KRF8CKMESYV
         7HQuxlLJByAEU3Z/2+RmUW3SUz8LlXANX5tGKqGRJ+vFBekjP8pbbwjLLcAtAXXzi86F
         FB6zXaLFTNao0LzDsgHFfGKAkB0E9Yg2/60yHzQyTkyjW8dUpaL7XVyzq5dQCbiFDY5d
         w9Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXMyVK1VxIjfA7EqKkdBuCDwa6EADLWkwRWZLwByYfGTa9x9YwsgBQ7ZAzTcSJvyuuY+gfxoO8tTyGt3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx14OKFg9Al+Qal4Zus8BLtorE78EnkwfwErzOU/LW1QqI1SesJ
	IdjcSj9dzqT3TkkMlGp8QzFcpcCPd2RQ7Cm/lejctLybXDNVG6oMCjTQjkCfeIzWl2Q8UlivNRd
	ZU2aoZi0kfEBkbFJxfi73jSfYgEWPIwLx+kG2JmzhGVc/obInoj+ygZyoql9Msjzk
X-Gm-Gg: ASbGncuUAItC+Q4LFUJMMts0U7Zic7wS8C286p+ZhyM9PNRLRejtljg76XCrbMl9UBc
	CVM6we5W9QNPseQDFELtsDDGnuMtWlnYWQzBthxZEGVUe2rXUJUFsqjAI9AjHYv1LaJiXJ5J//q
	IQkBwhc7use6F0FQpbBOYV4Pb01LMifr3j6VPp5JDDyLCfoLx+BwYLAZ1+fV1D+7HiZRqmYtoxW
	ZpqIrEkiox0G7rnAS5fLZFlSB3NKKjXPaBwi8mXe37WB6KvwamR+lD2EArfnGICsN2L6VVz7cW3
	AMnqqM6ShQAjo4WhNmDAxj9W8NKdW1RQpvm+/XHZ7xzI/2tro7SDn1r/4wrvNKPEJNv2V/5/oaW
	qb60kEuwy0K1xA+dlyYtgoW5D2tyUQbS6S60083pow1OxJQ==
X-Received: by 2002:a05:620a:4807:b0:8a2:e35f:90 with SMTP id af79cd13be357-8b220b1d46emr570522385a.30.1762371241129;
        Wed, 05 Nov 2025 11:34:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiRwB16QATLm26IUQJMPlOrIcZC/Pp82bOb2D9HMznRcFkSivER3LckBzG5MspPvf0gexFmQ==
X-Received: by 2002:a05:620a:4807:b0:8a2:e35f:90 with SMTP id af79cd13be357-8b220b1d46emr570517185a.30.1762371240407;
        Wed, 05 Nov 2025 11:34:00 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2357dbcc5sm28762885a.35.2025.11.05.11.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 11:33:59 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a5e3294b-4d37-4e98-9442-e35ca1949c17@redhat.com>
Date: Wed, 5 Nov 2025 14:33:57 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
To: Frederic Weisbecker <frederic@kernel.org>, Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Danilo Krummrich
 <dakr@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-14-frederic@kernel.org>
 <0e02915f-bde7-4b04-b760-89f34fb0a436@redhat.com>
 <aQtwbRrFBCUoQ2Yj@localhost.localdomain>
Content-Language: en-US
In-Reply-To: <aQtwbRrFBCUoQ2Yj@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/5/25 10:42 AM, Frederic Weisbecker wrote:
> Le Tue, Oct 21, 2025 at 12:10:16AM -0400, Waiman Long a écrit :
>> On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
>>> Until now, HK_TYPE_DOMAIN used to only include boot defined isolated
>>> CPUs passed through isolcpus= boot option. Users interested in also
>>> knowing the runtime defined isolated CPUs through cpuset must use
>>> different APIs: cpuset_cpu_is_isolated(), cpu_is_isolated(), etc...
>>>
>>> There are many drawbacks to that approach:
>>>
>>> 1) Most interested subsystems want to know about all isolated CPUs, not
>>>     just those defined on boot time.
>>>
>>> 2) cpuset_cpu_is_isolated() / cpu_is_isolated() are not synchronized with
>>>     concurrent cpuset changes.
>>>
>>> 3) Further cpuset modifications are not propagated to subsystems
>>>
>>> Solve 1) and 2) and centralize all isolated CPUs within the
>>> HK_TYPE_DOMAIN housekeeping cpumask.
>>>
>>> Subsystems can rely on RCU to synchronize against concurrent changes.
>>>
>>> The propagation mentioned in 3) will be handled in further patches.
>>>
>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>> ---
>>>    include/linux/sched/isolation.h |  2 +
>>>    kernel/cgroup/cpuset.c          |  2 +
>>>    kernel/sched/isolation.c        | 75 ++++++++++++++++++++++++++++++---
>>>    kernel/sched/sched.h            |  1 +
>>>    4 files changed, 74 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
>>> index da22b038942a..94d5c835121b 100644
>>> --- a/include/linux/sched/isolation.h
>>> +++ b/include/linux/sched/isolation.h
>>> @@ -32,6 +32,7 @@ extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
>>>    extern bool housekeeping_enabled(enum hk_type type);
>>>    extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
>>>    extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
>>> +extern int housekeeping_update(struct cpumask *mask, enum hk_type type);
>>>    extern void __init housekeeping_init(void);
>>>    #else
>>> @@ -59,6 +60,7 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
>>>    	return true;
>>>    }
>>> +static inline int housekeeping_update(struct cpumask *mask, enum hk_type type) { return 0; }
>>>    static inline void housekeeping_init(void) { }
>>>    #endif /* CONFIG_CPU_ISOLATION */
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index aa1ac7bcf2ea..b04a4242f2fa 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -1403,6 +1403,8 @@ static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
>>>    	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
>>>    	WARN_ON_ONCE(ret < 0);
>>> +	ret = housekeeping_update(isolated_cpus, HK_TYPE_DOMAIN);
>>> +	WARN_ON_ONCE(ret < 0);
>>>    }
>>>    /**
>>> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
>>> index b46c20b5437f..95d69c2102f6 100644
>>> --- a/kernel/sched/isolation.c
>>> +++ b/kernel/sched/isolation.c
>>> @@ -29,18 +29,48 @@ static struct housekeeping housekeeping;
>>>    bool housekeeping_enabled(enum hk_type type)
>>>    {
>>> -	return !!(housekeeping.flags & BIT(type));
>>> +	return !!(READ_ONCE(housekeeping.flags) & BIT(type));
>>>    }
>>>    EXPORT_SYMBOL_GPL(housekeeping_enabled);
>>> +static bool housekeeping_dereference_check(enum hk_type type)
>>> +{
>>> +	if (IS_ENABLED(CONFIG_LOCKDEP) && type == HK_TYPE_DOMAIN) {
>>> +		/* Cpuset isn't even writable yet? */
>>> +		if (system_state <= SYSTEM_SCHEDULING)
>>> +			return true;
>>> +
>>> +		/* CPU hotplug write locked, so cpuset partition can't be overwritten */
>>> +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_write_held())
>>> +			return true;
>>> +
>>> +		/* Cpuset lock held, partitions not writable */
>>> +		if (IS_ENABLED(CONFIG_CPUSETS) && lockdep_is_cpuset_held())
>>> +			return true;
>> I have some doubt about this condition as the cpuset_mutex may be held in
>> the process of making changes to an isolated partition that will impact
>> HK_TYPE_DOMAIN cpumask.
> Indeed and therefore if the current process is holding the cpuset mutex,
> it is guaranteed that no other process will update the housekeeping cpumask
> concurrently.
>
> So the housekeeping mask is guaranteed to be stable, right? Of course
> the current task may be changing it but while it is changing it, it is
> not reading it.

Right. The lockdep check is for the current task, not other tasks that 
holding the lock.

Thanks,
Longman

