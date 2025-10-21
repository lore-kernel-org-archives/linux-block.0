Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29742EC57D
	for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761086590; cv=none; b=ZYB41ZIlyIdQnIY5Fg2h0TVkfcMNJ0K9OdqIOOLqps4bkok8V/mIuRtFLSyGCPkLrYpYdfQtZD7oIo+LZXWsiRTrgKStrUuOC29Vh7oLqDkRjTg0tzZi3U7KUooClgQi7cpd5Cojllkt15saS2bcXQkHV+DEMeAnPMHfd7kvoLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761086590; c=relaxed/simple;
	bh=jS5ISZwEtvLLzIR+81DH+JOC73WFTyMLIhKyND3d1RY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HKu6h2SJfWA+TxcY64sUHaCJur4AV/xQ/lCBTPvP546+n4HlBaxRmLHRBzpjzyMIC21RsOVoqARm0ikNTimn3YIiJH5Mqi/9W8Qsz5EIVTKrmGgwKyR0ruzkMOxDtieBLba5YNqLJKLgqD2RWfhmIYwXWdY8N0z9vZn5IYJJ1s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWWqnetq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWWqnetq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761086586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1ufi8hzAWdR5ZvtubHPkIBiveTzx8KWYjOx6TAX45A=;
	b=GWWqnetqwfnAMuYbv5aI8RZ4FMT+Uz8nv4rFYSBrkiFvT+6KGQELiVgAO2Z0IWiPgeLlrK
	Wrv7UNaJ3na6xCs4wNATZUUhqqhrUQe9w9qFR8yOgFI8h5FIbW+8lP6X32fd+qnY0JI0J8
	AbgPV+3vwou+ahbAl+qeZ1rZFU2JHCE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-Go0ZqzdJOjGINoAFdQ-JOA-1; Tue, 21 Oct 2025 18:43:05 -0400
X-MC-Unique: Go0ZqzdJOjGINoAFdQ-JOA-1
X-Mimecast-MFC-AGG-ID: Go0ZqzdJOjGINoAFdQ-JOA_1761086585
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-892637a3736so1790098885a.1
        for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 15:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761086585; x=1761691385;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1ufi8hzAWdR5ZvtubHPkIBiveTzx8KWYjOx6TAX45A=;
        b=mY2GCrS2jiZs00gyQawzDgd+GgtHuHVjqKrZC0kP6QqtNCL2cI3qnJGl0dGQ8FiJS1
         FTRid+6zbilRGhgObbrnx9jkuXLq20lv6NS3z0B38nXMYDmOdabdLqcE2xe7k0lJlkr/
         BdiXrUlCZOmWcTZx6zq+BgFpX/jVYDeV/3h1DqKvxG2K5Cxl7YVfJ/2uy4x+LKCz/iet
         fDblVhROPNl5Tl4AOI6zQNyrE1chO8A3QtUNOWIKgF8jo28G+jm9NLir4XR4pAa9OqFK
         J1HqpLx3+4eHOfLRievFtQKEiUPSG44WxCkOxuqDj6lcSEp4zA/AcApUPAp48kpYLiLN
         2v/g==
X-Forwarded-Encrypted: i=1; AJvYcCXbMSTcv//Z12QWs/1Xvp6RbAABGyAfzC1FDV5HSAoWEVu8ZjJ2fmH+7LlVyNtJYlSDfqSdkT7kmFuKRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAOY7qog/vNoAa6rPKOA6hD2MwQ4uXtbj2Ia5iB5kNV3FBtA/P
	hOXj8dDWHr1Baww12qJ5/Chxnweoev6AfMIdj26qUusM+hKTYRxcLWa4EqztGpH+Av/fxscGlqc
	wxknRr3O52UIPVWy0KUph/KwKmbvQmGIMG6acq0F6mWrOzj69KlrhA8HNXWdih6WP
X-Gm-Gg: ASbGncsLVTMd23jiRVCqOk8iSHKvTzKjInwECAjoALqMiauv1UJaIasO9ZUfosWiU5M
	gXmkWa9jvUTFlSFp1siH0fWZaIAAxBvDmmoSUoyVboxuwRmfN88isl19538EDcSH8aOKMTPhU59
	dqntZvqdT0wbgvgy6c//Obo5ZJIJ15TTC90R4pHk629R9tHy5xSU11cJa5r6ReaPsGv4cK/dyhY
	te1967YXFiGODRFTHOkOrSghYyuJByirnoV9LM/GNY4Ya1nkwBxYvUz9CRrGT/Rf3x1HlAcNHFy
	nWewa2Uh+hacI4Os8EEd6JZazbnzR4OujpuXRW9GWXst82m401Q4/G1RYJN5Y/tKAnnY+i7Zjlt
	bLKtrnupP7SF841JNFQ6G5BdnikGktvHSyFsn1DCtIbu4qg==
X-Received: by 2002:a05:620a:2892:b0:886:ea5d:9273 with SMTP id af79cd13be357-8906e6ba4b1mr2387617985a.28.1761086585029;
        Tue, 21 Oct 2025 15:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKKo/21Swm4z17XlE0/ydMbQxCAbbChu7Z8fNIxB6CZQJ6hcePBsIiw2WUviotKsZ3CeiiMA==
X-Received: by 2002:a05:620a:2892:b0:886:ea5d:9273 with SMTP id af79cd13be357-8906e6ba4b1mr2387614585a.28.1761086584536;
        Tue, 21 Oct 2025 15:43:04 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba728sm848019085a.38.2025.10.21.15.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 15:43:03 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ba437129-062a-4a2f-a753-64945e9a13ff@redhat.com>
Date: Tue, 21 Oct 2025 18:42:59 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/33] kthread: Include unbound kthreads in the managed
 affinity list
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
 <20251013203146.10162-23-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251013203146.10162-23-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> The managed affinity list currently contains only unbound kthreads that
> have affinity preferences. Unbound kthreads globally affine by default
> are outside of the list because their affinity is automatically managed
> by the scheduler (through the fallback housekeeping mask) and by cpuset.
>
> However in order to preserve the preferred affinity of kthreads, cpuset
> will delegate the isolated partition update propagation to the
> housekeeping and kthread code.
>
> Prepare for that with including all unbound kthreads in the managed
> affinity list.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/kthread.c | 59 ++++++++++++++++++++++++------------------------
>   1 file changed, 30 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index c4dd967e9e9c..cba3d297f267 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -365,9 +365,10 @@ static void kthread_fetch_affinity(struct kthread *kthread, struct cpumask *cpum
>   	if (kthread->preferred_affinity) {
>   		pref = kthread->preferred_affinity;
>   	} else {
> -		if (WARN_ON_ONCE(kthread->node == NUMA_NO_NODE))
> -			return;
> -		pref = cpumask_of_node(kthread->node);
> +		if (kthread->node == NUMA_NO_NODE)
> +			pref = housekeeping_cpumask(HK_TYPE_KTHREAD);
> +		else
> +			pref = cpumask_of_node(kthread->node);
>   	}
>   
>   	cpumask_and(cpumask, pref, housekeeping_cpumask(HK_TYPE_KTHREAD));
> @@ -380,32 +381,29 @@ static void kthread_affine_node(void)
>   	struct kthread *kthread = to_kthread(current);
>   	cpumask_var_t affinity;
>   
> -	WARN_ON_ONCE(kthread_is_per_cpu(current));
> +	if (WARN_ON_ONCE(kthread_is_per_cpu(current)))
> +		return;
>   
> -	if (kthread->node == NUMA_NO_NODE) {
> -		housekeeping_affine(current, HK_TYPE_KTHREAD);
> -	} else {
> -		if (!zalloc_cpumask_var(&affinity, GFP_KERNEL)) {
> -			WARN_ON_ONCE(1);
> -			return;
> -		}
> -
> -		mutex_lock(&kthread_affinity_lock);
> -		WARN_ON_ONCE(!list_empty(&kthread->affinity_node));
> -		list_add_tail(&kthread->affinity_node, &kthread_affinity_list);
> -		/*
> -		 * The node cpumask is racy when read from kthread() but:
> -		 * - a racing CPU going down will either fail on the subsequent
> -		 *   call to set_cpus_allowed_ptr() or be migrated to housekeepers
> -		 *   afterwards by the scheduler.
> -		 * - a racing CPU going up will be handled by kthreads_online_cpu()
> -		 */
> -		kthread_fetch_affinity(kthread, affinity);
> -		set_cpus_allowed_ptr(current, affinity);
> -		mutex_unlock(&kthread_affinity_lock);
> -
> -		free_cpumask_var(affinity);
> +	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL)) {
> +		WARN_ON_ONCE(1);
> +		return;
>   	}
> +
> +	mutex_lock(&kthread_affinity_lock);
> +	WARN_ON_ONCE(!list_empty(&kthread->affinity_node));
> +	list_add_tail(&kthread->affinity_node, &kthread_affinity_list);
> +	/*
> +	 * The node cpumask is racy when read from kthread() but:
> +	 * - a racing CPU going down will either fail on the subsequent
> +	 *   call to set_cpus_allowed_ptr() or be migrated to housekeepers
> +	 *   afterwards by the scheduler.
> +	 * - a racing CPU going up will be handled by kthreads_online_cpu()
> +	 */
> +	kthread_fetch_affinity(kthread, affinity);
> +	set_cpus_allowed_ptr(current, affinity);
> +	mutex_unlock(&kthread_affinity_lock);
> +
> +	free_cpumask_var(affinity);
>   }
>   
>   static int kthread(void *_create)
> @@ -924,8 +922,11 @@ static int kthreads_online_cpu(unsigned int cpu)
>   			ret = -EINVAL;
>   			continue;
>   		}
> -		kthread_fetch_affinity(k, affinity);
> -		set_cpus_allowed_ptr(k->task, affinity);
> +
> +		if (k->preferred_affinity || k->node != NUMA_NO_NODE) {
> +			kthread_fetch_affinity(k, affinity);
> +			set_cpus_allowed_ptr(k->task, affinity);
> +		}
>   	}

My understanding of kthreads_online_cpu() is that hotplug won't affect 
the affinity returned from kthread_fetch_affinity(). However, 
set_cpus_allowed_ptr() will mask out all the offline CPUs. So if the 
given "cpu" to be brought online is in the returned affinity, we should 
call set_cpus_allowed_ptr() to add this cpu into its affinity mask 
though the current code will call it even it is not strictly necessary. 
This change will not do this update to NUMA_NO_NODE kthread with no 
preferred_affinity, is this a problem?

Cheers,
Longman

