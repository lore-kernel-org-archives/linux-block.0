Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F01182B7
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 02:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768185958; cv=none; b=A0zRRJGn86An7ZXRh7g2pBc3nwhhsP7ByEe0nWQWH2L2iibf3SqqO66EHYN3A0DQh44CAMa9CJPBVwzm5+uhaXNV334KdNSjsaK+Sk1rPYgMiJug5rz+3+N63q5UOsuZaLaDwN3jN6S2bhp9C9Bhh2Lo2UgHCffFLpXnDcpFkDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768185958; c=relaxed/simple;
	bh=t3fqYup1Q4i1hX+rY6sipxB1IioFo7OZLWHTUppIxwE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E1+neaHMQ1X6SG4EZ1kdhuNdm8bq9Oq0cAmFqj7aZyES+tY0pn/zWl/4ppwx60B9cr64NsshyesO+GzTP85HTlqwid1CLr4H1+M5znb0n7cl/K6RmhyVzLTWlRovJ40T/eQAZ60hnkOcO6KykPNT3rtqOQK8bI8zYg/Mzgm96v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RIHtvEL6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OQaguD4O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIHtvEL6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQaguD4O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768185954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcS5shRmDCmvz+IoTKqWTzUo+o6AAuc9PAErT+qJLAs=;
	b=RIHtvEL6WNI17SXaRSRMorIVqYMrxh0ySwzskBkEaln1u8krV+tG1S/A7Lr5TCnZ/xmPyZ
	KtKNrpQmrQ45jIQpgu6HJ7A1kYnPaFHjPmwVj/b5VXojhbjSh2ImKwg3YSG+yXekkmAAns
	oUF53XL9SgyNuCR2Z2VN4mMm5KjFmL8=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-_Fga1RB5PnKY_NR5_j_5sg-1; Sun, 11 Jan 2026 21:45:53 -0500
X-MC-Unique: _Fga1RB5PnKY_NR5_j_5sg-1
X-Mimecast-MFC-AGG-ID: _Fga1RB5PnKY_NR5_j_5sg_1768185953
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5634f73edc2so3721965e0c.2
        for <linux-block@vger.kernel.org>; Sun, 11 Jan 2026 18:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768185953; x=1768790753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xcS5shRmDCmvz+IoTKqWTzUo+o6AAuc9PAErT+qJLAs=;
        b=OQaguD4OW/a0PRcKXewnQoJz2HveUAELXWyoGoFSB4eakOiaN7tvkhvroIJENmrFeJ
         PuXhQwOuoS0ZPVBot7jNgIujYR/bmcdJMtq1VBx7U0wi1aj+iIuW4r/6YuomR+XN0y9v
         sSRuVS20/+rxYnHwdp+oQyGga1ktao5cj7wHS/C0jbSqfrBDZZVwi5JksbrL92hPebwY
         fLaRsznU4Ph/uhnaDGP5GyNfrYYkj71sNtZ7TZOgK0l/7FzeYA6/q8LhcJGUMV4nZinF
         gcNf58MM8flPh5y8Kkcdqu/uhs8VpBTqx5/327LJT+G9ApAPx2w6zzFUoq4SKNY3v0qk
         QpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768185953; x=1768790753;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcS5shRmDCmvz+IoTKqWTzUo+o6AAuc9PAErT+qJLAs=;
        b=m9aI4LljjuvubSv/wjW43g94TefPRi03oHxPffSoENGesqasnJm2rhCtH4FNE1/LvG
         Uh4DQLQ/nxyOP2SH2qzbTjef1J8uNhD8yOJZVv38QWzhC1AnuVjAxkscGN/++M97aWAX
         4KMRRtLr2aZJmopVQChnIhQXQjFn5vmQGgkpwrtv0dzUiSaBylGEzuKuC0OFalEhejyi
         Wa5vxfsSShiXwQMWPYrPLnrHS1RZ2zFOhu048kw1lllnzn9NYYka3JSrDb1Ifr7qSvsc
         3EtEvPCX8IecoSjhrPQNaT1XhdzdZ9dmmKg/cqKKUYGFVl6ifVPJwtjXxQQQIE1Y4ivN
         Nu5g==
X-Forwarded-Encrypted: i=1; AJvYcCUKCI77VPFuU1vy5Sb7I2zq4QTPbD07G33hU9NCSWaVhl7X7qAZ/q/vWGOok6gNJHSuWJQq+Kxf43p98Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpZNjRGw9Qs5aJfeN7by58emuSWQcl2DJb0g5VIfIA7WVuO8AW
	AeWzJTA50Ki14kYU0SG3ck5yKnow7k2E0bPbbQninalZ9naTuoj/LmGuxfj+AKg+BEWFQaDftlm
	GRln4Bc/ZEYGieMg7H3wVEBSX7o97BJZFUq4dKCIZ4CZG1hTKsCmyFvhzEDlQmu1o
X-Gm-Gg: AY/fxX65dEmh/LZ3KrqkCwYire4Y0bKie1MlypEOkq2jlAYq4H1H8b/YjORXwV5gRLU
	1C2KSXC7dI3Ug5sIc7/eerYJe47V58hNrozRxIkphmo/F1aVcUj8hQb9aA68IVn1zqW9ihtLK2y
	F4v/yZQwdwv2/W04QHABa0VHA3lh4QBVRgYEx+5pHZfa392apC0k8e9V+nvKKjY/aSjA3q/MJsB
	ipVJ6XuqQ3FvIjinFd1NJAk5LbkMg1yiLnJl76AJc7CFaoKWjDwAKZHUre5Zaqgsqkw4BAOVX1q
	aP1iiK3dsj7mK0s6QjGz0FYwpBi+yk5oDFtmp1X60jA29eUefJuSHe8I0T4a0rv9rWj612fOICo
	Z6gNvgOk5DHuSW4SIHr+wqy2rkeNDDPBUKuJrYS8uIPO9SzNEpppkQSC8
X-Received: by 2002:a05:6122:1d4d:b0:55b:1a1b:3273 with SMTP id 71dfb90a1353d-56347d4a0bemr5054198e0c.6.1768185952708;
        Sun, 11 Jan 2026 18:45:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwOFp6cPvfkUcSbRWdkrghqM2mUWR9n3I0P3Nk8PJy6T841SLsur+1hpT47PiYyZ5sXMn8AA==
X-Received: by 2002:a05:6122:1d4d:b0:55b:1a1b:3273 with SMTP id 71dfb90a1353d-56347d4a0bemr5054194e0c.6.1768185952291;
        Sun, 11 Jan 2026 18:45:52 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563667cf148sm8166160e0c.2.2026.01.11.18.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 18:45:51 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <18ee9089-8a08-44ed-8761-7c9db765cd4e@redhat.com>
Date: Sun, 11 Jan 2026 21:45:36 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/33] sched/isolation: Convert housekeeping cpumasks to
 rcu pointers
To: Simon Horman <horms@kernel.org>, Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, netdev@vger.kernel.org
References: <20260101221359.22298-1-frederic@kernel.org>
 <20260101221359.22298-14-frederic@kernel.org>
 <20260107115653.GA196631@kernel.org>
Content-Language: en-US
In-Reply-To: <20260107115653.GA196631@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/7/26 6:56 AM, Simon Horman wrote:
> On Thu, Jan 01, 2026 at 11:13:38PM +0100, Frederic Weisbecker wrote:
>> HK_TYPE_DOMAIN's cpumask will soon be made modifiable by cpuset.
>> A synchronization mechanism is then needed to synchronize the updates
>> with the housekeeping cpumask readers.
>>
>> Turn the housekeeping cpumasks into RCU pointers. Once a housekeeping
>> cpumask will be modified, the update side will wait for an RCU grace
>> period and propagate the change to interested subsystem when deemed
>> necessary.
>>
>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>> ---
>>   kernel/sched/isolation.c | 58 +++++++++++++++++++++++++---------------
>>   kernel/sched/sched.h     |  1 +
>>   2 files changed, 37 insertions(+), 22 deletions(-)
>>
>> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
>> index 11a623fa6320..83be49ec2b06 100644
>> --- a/kernel/sched/isolation.c
>> +++ b/kernel/sched/isolation.c
>> @@ -21,7 +21,7 @@ DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
>>   EXPORT_SYMBOL_GPL(housekeeping_overridden);
>>   
>>   struct housekeeping {
>> -	cpumask_var_t cpumasks[HK_TYPE_MAX];
>> +	struct cpumask __rcu *cpumasks[HK_TYPE_MAX];
>>   	unsigned long flags;
>>   };
>>   
>> @@ -33,17 +33,28 @@ bool housekeeping_enabled(enum hk_type type)
>>   }
>>   EXPORT_SYMBOL_GPL(housekeeping_enabled);
>>   
>> +const struct cpumask *housekeeping_cpumask(enum hk_type type)
>> +{
>> +	if (static_branch_unlikely(&housekeeping_overridden)) {
>> +		if (housekeeping.flags & BIT(type)) {
>> +			return rcu_dereference_check(housekeeping.cpumasks[type], 1);
>> +		}
>> +	}
>> +	return cpu_possible_mask;
>> +}
>> +EXPORT_SYMBOL_GPL(housekeeping_cpumask);
>> +
> Hi Frederic,
>
> I think this patch should also update the access to housekeeping.cpumasks
> in housekeeping_setup(), on line 200, to use housekeeping_cpumask().
>
> As is, sparse flags __rcu a annotation miss match there.
>
>    kernel/sched/isolation.c:200:80: warning: incorrect type in argument 3 (different address spaces)
>    kernel/sched/isolation.c:200:80:    expected struct cpumask const *srcp3
>    kernel/sched/isolation.c:200:80:    got struct cpumask [noderef] __rcu *
>
> ...
>
The direct housekeeping.cpumasks[type] reference is in the newly merged 
check after Federic's initial patch series.

                 iter_flags = housekeeping.flags & (HK_FLAG_KERNEL_NOISE 
| HK_FLAG_DOMAIN);
                 type = find_first_bit(&iter_flags, HK_TYPE_MAX);
                 /*
                  * Pass the check if none of these flags were 
previously set or
                  * are not in the current selection.
                  */
                 iter_flags = flags & (HK_FLAG_KERNEL_NOISE | 
HK_FLAG_DOMAIN);
                 first_cpu = (type == HK_TYPE_MAX || !iter_flags) ? 0 :
cpumask_first_and_and(cpu_present_mask,
                                     housekeeping_staging, 
housekeeping.cpumasks[type]);

Maybe that is why it is missed.

Cheers,
Longman

