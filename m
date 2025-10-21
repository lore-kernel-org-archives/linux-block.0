Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0F0338903
	for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074216; cv=none; b=qeJmae/g5nsM7ZCYuXXrEJC96sXiG4R8eU25Ln5RH57zyzyzj4w/oxqQUzeS9lMg4HWxs8bb14Vxk2qjnveZqUqaCoCafgooCWgHD/r40sRYaJOdsmp4mORNU5EOWGbCrd8/UGEz1Hj0rk4hyXMEFeXSPF/ipJiuV1La/uopffM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074216; c=relaxed/simple;
	bh=WfFPtDMJOslnO8xd96RYBPFjxdDxPv7APLMtkSd5nII=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C0xXGNBJYKbqiYqt0cSsLHkartyIRaLu2UccjsU3dkAJNMUVPO0SLM3hQ1suJS6onbZZCfVkrRZZfCY6+J6jnchB0uz1ZUCITCEYxiUPCK2JkiYHdTwB5hEpDJgvQFoiBZjeT5hkEuCaUHv9sZAiffKFvrY4zZKSxLFBlJuRup0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZRa1ReN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZRa1ReN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761074213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Av2zs3MEbcbLC7aMwacLFVSODjPRb5hpuHHxAZIybWo=;
	b=HZRa1ReNbhDfZrPah/o+D4GJ0PRHjwngJYdUAGraqVRa/bHqxVPk5peX5pNffKDp6x8h4U
	aVqA8WLGpxKoHiTKR7xW2w7EQdN0uEnU+v8nR8Xm0rwA2gBQl7BGRerJ2bT4kfFGH3eDf/
	DqO/p49nwJMRHR5RbIR2hoXNvJPdXbU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-99fdJVGBOSaPzc76zjDaEQ-1; Tue, 21 Oct 2025 15:16:51 -0400
X-MC-Unique: 99fdJVGBOSaPzc76zjDaEQ-1
X-Mimecast-MFC-AGG-ID: 99fdJVGBOSaPzc76zjDaEQ_1761074211
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87c1cc5a75dso312149786d6.0
        for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 12:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761074211; x=1761679011;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Av2zs3MEbcbLC7aMwacLFVSODjPRb5hpuHHxAZIybWo=;
        b=DFDc/ky5kd9bt7bbdDsdSyJy+ex8hN0ltBz6t5uF5HRcEwO9LRi7dW3DNZFCvpwB3T
         S5bIdqzK0EJocSh2lqfeGzL5Gab3bYBL17/GWykuJhFrgxX+OtxUuF3rxNLZ86qUY4Li
         xziZppjQ+PK1KUUAbL2ALtxlAWyvl9hBlDDdfOt9RWypjeLHyyfvNUilCELUftCuzYA/
         Lf3h6x/BJTMZCqK5yZzJ5G5yuIDb7QuM8xENsXBkuwKkNRM9aFmf4mg30/yZHb2k1niC
         n/72dytXpSqYDVLgeZF1iJqm1VzSFmWt7VoVCc4u+DG+asjMHgWchNQAwV4oDRvlCdB2
         Mgng==
X-Forwarded-Encrypted: i=1; AJvYcCUqXsPSSm9qmJVX71dapR60ONTiFTyuuIPQ+sOjrgm3v+UiiROHF+UFaROB0+ydeeI4V0iKjYT2gSFtiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQrMtwmQ0P8j1j+mkVykgHJVmbWSirr4PKtTMBmvO9zLTZKQs9
	IHwLcp9CfksKBcC+IwSf48tNATvTWzWYzhYhn3uq1WsqIHjxDwNNGPkl10BrTmumXSiB1DIQps/
	pQChfRE9KLT0H9O8LaSAUN7+oxCNs+bSzZW+Y4k8DP8rugp6QZ2nOcNWXaropsQII
X-Gm-Gg: ASbGnctIWTL1vgVgANnKhvoxsZCHY9RBVNX+o6Npz93iByKM6gMzEWN5id9KYUVNXs/
	jYq3P8V/+c5q3kB8ST9KcZskvI0RBjzdilt3bR91IXQ5GAnj9sMGPD2p4hx6bznpVtzx1BO7z0I
	ZdM0WISv1fkLIZUG6rQx4qpL+26C40GwRFpbKRQPNEKY4+9MDCGxABvklySXNq40vozIiYEuaVT
	TgG35LtuIrc9iUwPydN4g1JVNB7RMeI/JMmB7gZjd/5J6J4eTwN1QUkjrKkZPeVHPTGECu1aWBm
	vF1yJ0ihs16aXrtAptLtvr5SO/K4ZluFl6fwS1wFah2EglIRDU7n4wtwtagtlvMXBajqxohKNV2
	BZQXEu23QYNncVBpr5pFqSz7LaRba2Q2UCvpy70/gaTBO9g==
X-Received: by 2002:a05:6214:4012:b0:87d:8fa7:d29e with SMTP id 6a1803df08f44-87d8fa7d3a7mr172807956d6.35.1761074211093;
        Tue, 21 Oct 2025 12:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMN3DCL5z77zrF4an/kPQngsHh4Dl7HI0jLtCtPSfq0EP/4XoCKRGCEKlYnjWxZgcz1y0y9w==
X-Received: by 2002:a05:6214:4012:b0:87d:8fa7:d29e with SMTP id 6a1803df08f44-87d8fa7d3a7mr172807136d6.35.1761074210482;
        Tue, 21 Oct 2025 12:16:50 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf521c2c7sm74369666d6.19.2025.10.21.12.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 12:16:49 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <364e084a-ef37-42ab-a2ae-5f103f1eb212@redhat.com>
Date: Tue, 21 Oct 2025 15:16:45 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] sched/isolation: Flush memcg workqueues on cpuset
 isolated partition change
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 <20251013203146.10162-15-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251013203146.10162-15-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> The HK_TYPE_DOMAIN housekeeping cpumask is now modifyable at runtime. In
> order to synchronize against memcg workqueue to make sure that no
> asynchronous draining is still pending or executing on a newly made
> isolated CPU, the housekeeping susbsystem must flush the memcg
> workqueues.
>
> However the memcg workqueues can't be flushed easily since they are
> queued to the main per-CPU workqueue pool.
>
> Solve this with creating a memcg specific pool and provide and use the
> appropriate flushing API.
>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/memcontrol.h |  4 ++++
>   kernel/sched/isolation.c   |  2 ++
>   kernel/sched/sched.h       |  1 +
>   mm/memcontrol.c            | 12 +++++++++++-
>   4 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 873e510d6f8d..001200df63cf 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1074,6 +1074,8 @@ static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
>   	return id;
>   }
>   
> +void mem_cgroup_flush_workqueue(void);
> +
>   extern int mem_cgroup_init(void);
>   #else /* CONFIG_MEMCG */
>   
> @@ -1481,6 +1483,8 @@ static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
>   	return 0;
>   }
>   
> +static inline void mem_cgroup_flush_workqueue(void) { }
> +
>   static inline int mem_cgroup_init(void) { return 0; }
>   #endif /* CONFIG_MEMCG */
>   
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 95d69c2102f6..9ec365dea921 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -144,6 +144,8 @@ int housekeeping_update(struct cpumask *mask, enum hk_type type)
>   
>   	synchronize_rcu();
>   
> +	mem_cgroup_flush_workqueue();
> +
>   	kfree(old);
>   
>   	return 0;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 8fac8aa451c6..8bfc0b4b133f 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -44,6 +44,7 @@
>   #include <linux/lockdep_api.h>
>   #include <linux/lockdep.h>
>   #include <linux/memblock.h>
> +#include <linux/memcontrol.h>
>   #include <linux/minmax.h>
>   #include <linux/mm.h>
>   #include <linux/module.h>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1033e52ab6cf..1aa14e543f35 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -95,6 +95,8 @@ static bool cgroup_memory_nokmem __ro_after_init;
>   /* BPF memory accounting disabled? */
>   static bool cgroup_memory_nobpf __ro_after_init;
>   
> +static struct workqueue_struct *memcg_wq __ro_after_init;
> +
>   static struct kmem_cache *memcg_cachep;
>   static struct kmem_cache *memcg_pn_cachep;
>   
> @@ -1975,7 +1977,7 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
>   {
>   	guard(rcu)();
>   	if (!cpu_is_isolated(cpu))
> -		schedule_work_on(cpu, work);
> +		queue_work_on(cpu, memcg_wq, work);
>   }
>   
>   /*
> @@ -5092,6 +5094,11 @@ void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages)
>   	refill_stock(memcg, nr_pages);
>   }
>   
> +void mem_cgroup_flush_workqueue(void)
> +{
> +	flush_workqueue(memcg_wq);
> +}
> +
>   static int __init cgroup_memory(char *s)
>   {
>   	char *token;
> @@ -5134,6 +5141,9 @@ int __init mem_cgroup_init(void)
>   	cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
>   				  memcg_hotplug_cpu_dead);
>   
> +	memcg_wq = alloc_workqueue("memcg", 0, 0);

Should we explicitly mark the memcg_wq as WQ_PERCPU even though I think 
percpu is the default. The schedule_work_on() schedules work on the 
system_percpu_wq.

Cheers,
Longman

> +	WARN_ON(!memcg_wq);
> +
>   	for_each_possible_cpu(cpu) {
>   		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
>   			  drain_local_memcg_stock);

