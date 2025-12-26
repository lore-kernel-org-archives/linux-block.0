Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618F6313524
	for <linux-block@vger.kernel.org>; Fri, 26 Dec 2025 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766719280; cv=none; b=eNOz3Bg2357HKytXKJUo108djrW29EFrUdz6UDK7sl13ZHumLX/hxGQ2nPHJvBtu+mMHEct0BvQ1ooW6FHCjYoHeTD2Sdipz+5R0RkgVocGqPuMevzYDfOrLKwjz9TI1UbRnq6vOTVaxkcMgwJ3QlW1quynrlCy24A9jlMy55qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766719280; c=relaxed/simple;
	bh=y/+bcKUPZ2qPkgiB+TP48kY5Y7VCKR6l2NOE4CGOIto=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dNw0t6dr4QvKePYsM3IBYopNAc5XtgcQ08qKZpvBqClyMHg5kVDoPWZqyZIcy+Jm1YfnbVTbxVEvDnUo/ZaN9dn1xJbcfhrFW1aCXGZrtc0+w3NaiXe/nH1ZgGT6jY5TP6Ve4yXD1hwOpDHZNUKXHgc4KPJ4t0s3NYGCEeXgbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQKBLgM6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRXDXJvE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQKBLgM6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRXDXJvE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766719277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKHp6uC5zNb3gZSMB9BQPFV3o9H0iVs2RJyYgnJbrKc=;
	b=SQKBLgM6bKLYePxUlnJJS61R+Ob/e76i8C5+xTjJmXm43xJ1Ohx/HBC/iP7t9KBJTWTXhl
	U2ARbSZrwzh5kLIN6xxb+UO6Ezo8mGlWOvU1xCX5GhaEgDAVQVZOlye5xkHuGUITtJ2iNN
	2q3cjoDHQnzUv4I+XW4ougj1IICB3yE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-cEmEdrgGM8mCeAKEo8Q6bQ-1; Thu, 25 Dec 2025 22:21:15 -0500
X-MC-Unique: cEmEdrgGM8mCeAKEo8Q6bQ-1
X-Mimecast-MFC-AGG-ID: cEmEdrgGM8mCeAKEo8Q6bQ_1766719274
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-bc09a8454b9so16783519a12.1
        for <linux-block@vger.kernel.org>; Thu, 25 Dec 2025 19:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766719274; x=1767324074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dKHp6uC5zNb3gZSMB9BQPFV3o9H0iVs2RJyYgnJbrKc=;
        b=PRXDXJvEwPCO/NDTuBO+Sy8aPSc3/ThqX//r9y9c+0Sc5GuZ7Pch/T1vn6saYxhAgB
         baUWlEnY2ZwgybqcuP2u+GauFfXsW86cHdc3XekFVW2WbOvQ7gd2LQWLyjEDsTG9fkFf
         RRqcmoloU7VBqhkh4EkUU5imUs3Gld+N2hf8xMlXhcVtktoHgXgX4k56PDF1CGGNFfbh
         NV/YjcQwO0vHdvn3oFCGihDFuIf1h8cJB1gGrJ5EuzWD/Sc5kpD02mjjMHLx50NuOPj2
         pPZRd4qnktx0QVjRF1PDfP8uO1iXqceo3slvUPrE9Y3GT/XdBzQ7kZGsG35eG0qW4qCm
         HpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766719274; x=1767324074;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKHp6uC5zNb3gZSMB9BQPFV3o9H0iVs2RJyYgnJbrKc=;
        b=ALH4U4wdB9fWNScHigmlRwVR6o6iEVYoEbCR8n5oX0Aglft3lrP0jaAvDGKv3mAdAf
         rvJ6F56b4D6MCvD7RNKAotRihpoaV3q6faUabAb6jLbcAK8sI2Mn8/fnnq6p8FZG0fWF
         ml2sdyz0YhaG/BfR7D7//J1z9OysSDglWijumqEeH/IQxB4YWqIkdunLYAOvcB2AUd2G
         32A/5HRi3GKU8addh58xo8QILKE18qDtgq6ucnySj/ujUwhZ2khVOzjAjihZNpAFT7Fc
         zcS/0zCkmKpp1o2CUNTWvGz1SgdyzhfpXM9k3NwthlR2uPXERKjKIA9Y/rl1Clio9tYh
         /LLw==
X-Forwarded-Encrypted: i=1; AJvYcCV69WW+0/5snKUfaVtv+O+mT9/CRYW9FRauIsqXTin4Op2KpE6iEV2crfu3RwIiQ+n7fPzMrVXH/X7nCw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34H01jI4JShg9Jw8zZhLtN0eNKJb21M+dVZ6TixDJj4V5P9ck
	kNCmgDnFOoIcr5PpCU+w8wEEK/UAUDVpcGCapaDRmSFcHsNC8HCaL414aPyybeqK/jIyjCQysaN
	Bsv1wv4KexYwHJQNafrbX5XtwvaPFLq/6N77zHD67/InKKd7aaO0Opshji4vBcZXX
X-Gm-Gg: AY/fxX67N/7nmwvsCpsrADG8i6loGyfCef3/eOOgeQ7cxiJCPSh3+wKGEvikYSUgtFn
	aJMdLlnVKKDppHCAAMUAjrKqFJL69NCHsKTv4Or6RBPbFiyhkYHJ8ozBpooQ0piOjHinGCGWyA0
	qGIsMUrFIC0vFafZALW/ok/LmVe23A71mCLVmfQYKMSVwGtfPmEBhmFgyvlQ7fMTB0Ldq0Ho13P
	MhIXdBvV2zbtxnzRLZZca2BImKUNF2dbfoS7tJIuogzChkk2SUM8p/r7Uld9iS/E2dbEL9LHAWJ
	tAsgnSY0emytODBpxcJI9kz8fuy+1xL9mPAeTA3+93uGa6Wk6tFM3yz3d/F0E1x5nPb/BDtnoMB
	UWaa4SpyywZFWqMx1PeIGG4qLRsM8AWw0VkHHNEimjYnj32TNeqN9N2t1
X-Received: by 2002:a05:7022:f902:20b0:11c:b3ad:1fe1 with SMTP id a92af1059eb24-121722b1a7bmr20900980c88.11.1766719274171;
        Thu, 25 Dec 2025 19:21:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrRbO/uTv2AgLdwLaHgNpsWrHMXpzUWqpTKYvMicj4UtKVHtP6aAiwD9wbO4xGgVHronC7tQ==
X-Received: by 2002:a05:7022:f902:20b0:11c:b3ad:1fe1 with SMTP id a92af1059eb24-121722b1a7bmr20900963c88.11.1766719273695;
        Thu, 25 Dec 2025 19:21:13 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm80252105c88.1.2025.12.25.19.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 19:21:13 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5b019a5c-1db4-41d9-aca9-2e3eaf1cece9@redhat.com>
Date: Thu, 25 Dec 2025 22:20:59 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-15-frederic@kernel.org>
 <17aadc7e-7dd6-4335-a748-e66f0239df85@redhat.com>
Content-Language: en-US
In-Reply-To: <17aadc7e-7dd6-4335-a748-e66f0239df85@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/25/25 9:24 PM, Waiman Long wrote:
> On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
>> Until now, HK_TYPE_DOMAIN used to only include boot defined isolated
>> CPUs passed through isolcpus= boot option. Users interested in also
>> knowing the runtime defined isolated CPUs through cpuset must use
>> different APIs: cpuset_cpu_is_isolated(), cpu_is_isolated(), etc...
>>
>> There are many drawbacks to that approach:
>>
>> 1) Most interested subsystems want to know about all isolated CPUs, not
>>    just those defined on boot time.
>>
>> 2) cpuset_cpu_is_isolated() / cpu_is_isolated() are not synchronized 
>> with
>>    concurrent cpuset changes.
>>
>> 3) Further cpuset modifications are not propagated to subsystems
>>
>> Solve 1) and 2) and centralize all isolated CPUs within the
>> HK_TYPE_DOMAIN housekeeping cpumask.
>>
>> Subsystems can rely on RCU to synchronize against concurrent changes.
>>
>> The propagation mentioned in 3) will be handled in further patches.
>>
>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>> ---
>>   include/linux/sched/isolation.h |  7 +++
>>   kernel/cgroup/cpuset.c          |  3 ++
>>   kernel/sched/isolation.c        | 76 ++++++++++++++++++++++++++++++---
>>   kernel/sched/sched.h            |  1 +
>>   4 files changed, 81 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/sched/isolation.h 
>> b/include/linux/sched/isolation.h
>> index 109a2149e21a..6842a1ba4d13 100644
>> --- a/include/linux/sched/isolation.h
>> +++ b/include/linux/sched/isolation.h
>> @@ -9,6 +9,11 @@
>>   enum hk_type {
>>       /* Revert of boot-time isolcpus= argument */
>>       HK_TYPE_DOMAIN_BOOT,
>> +    /*
>> +     * Same as HK_TYPE_DOMAIN_BOOT but also includes the
>> +     * revert of cpuset isolated partitions. As such it
>> +     * is always a subset of HK_TYPE_DOMAIN_BOOT.
>> +     */
>>       HK_TYPE_DOMAIN,
>>       /* Revert of boot-time isolcpus=managed_irq argument */
>>       HK_TYPE_MANAGED_IRQ,
>> @@ -35,6 +40,7 @@ extern const struct cpumask 
>> *housekeeping_cpumask(enum hk_type type);
>>   extern bool housekeeping_enabled(enum hk_type type);
>>   extern void housekeeping_affine(struct task_struct *t, enum hk_type 
>> type);
>>   extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
>> +extern int housekeeping_update(struct cpumask *isol_mask, enum 
>> hk_type type);
>>   extern void __init housekeeping_init(void);
>>     #else
>> @@ -62,6 +68,7 @@ static inline bool housekeeping_test_cpu(int cpu, 
>> enum hk_type type)
>>       return true;
>>   }
>>   +static inline int housekeeping_update(struct cpumask *isol_mask, 
>> enum hk_type type) { return 0; }
>>   static inline void housekeeping_init(void) { }
>>   #endif /* CONFIG_CPU_ISOLATION */
>>   diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 5e2e3514c22e..e13e32491ebf 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1490,6 +1490,9 @@ static void update_isolation_cpumasks(void)
>>       ret = tmigr_isolated_exclude_cpumask(isolated_cpus);
>>       WARN_ON_ONCE(ret < 0);
>>   +    ret = housekeeping_update(isolated_cpus, HK_TYPE_DOMAIN);
>> +    WARN_ON_ONCE(ret < 0);
>> +
>>       isolated_cpus_updating = false;
>>   }
>>   diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
>> index 83be49ec2b06..a124f1119f2e 100644
>> --- a/kernel/sched/isolation.c
>> +++ b/kernel/sched/isolation.c
>> @@ -29,18 +29,48 @@ static struct housekeeping housekeeping;
>>     bool housekeeping_enabled(enum hk_type type)
>>   {
>> -    return !!(housekeeping.flags & BIT(type));
>> +    return !!(READ_ONCE(housekeeping.flags) & BIT(type));
>>   }
>>   EXPORT_SYMBOL_GPL(housekeeping_enabled);
>>   +static bool housekeeping_dereference_check(enum hk_type type)
>> +{
>> +    if (IS_ENABLED(CONFIG_LOCKDEP) && type == HK_TYPE_DOMAIN) {
>
> To be more correct, we should use IS_ENABLED(CONFIG_PROVE_LOCKING) as 
> this is the real kconfig that enables most of the lockdep checking. 
> PROVE_LOCKING selects LOCKDEP but not vice versa. So for some weird 
> configs that set LOCKDEP but not PROVE_LOCKING, it can cause 
> compilation problem. 

I think I get confused too. The various lockdep* helpers should be 
defined when CONFIG_LOCKDEP is enabled even if they may not do anything 
useful. So using IS_ENABLED(CONFIG_LOCKDEP) should be fine. Sorry for 
the noise.

Reviewed-by: Waiman Long <longman@redhat.com>

