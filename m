Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68892857C1
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761125; cv=none; b=CdQOKwv03xOAhvkL6ItIz7311F6gTzTitGUyEOEGdDTcFf1ZV/8gWkeh6/2ZHtDUwn8I6+o+KbhoyHPw5Nwm4EqLmY6/wf78T/plIbzTyHdJM3JKaj/PE0x8TCXwaecAkuQlpqdgG6rsbBEczlg77U1woifIQpvJyrybOCep7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761125; c=relaxed/simple;
	bh=aab43vnKM1ss0I9X3ZkZ8BKt0Ft4cLo8wB19nB+wzAE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QtPLnkwTIM4TY6LFFBeydb19x0+o9+m+bj1yGZrV7K3KQBRVUFlDDuPpB4Te0B/ggZjDX/4aMbnJ3MXR/ro/xG7b6cNgL9l3MiEiw3nVp0BwNCH8kb/txgnrzu6xDdovv46rZ7J8E7UOVa/XH+eyh2NiHad8Kc8bHaRwsZWHqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzK6rvVX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzK6rvVX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761761122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNxXxUzXoqQQT9w5Yf9S20ddLNixsnFzdxWTN/CN8Uk=;
	b=CzK6rvVXkHLPs7sH+Hs7gaX+eOZgHfh505gYz7jLU19UnA6WTL5TNrE/vVDQwDy+Gg3b+w
	o+RaIoH53mI6VMFQfViqwYhri6xex71+J3fg2vyXMdasWSkM4QVvk0avDOzjcliKUeeadE
	OOLOTjlM3EoGxJBgSowNNFQtBRMBYOc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-oT4dz1ACPW6WKy3PdA8SEA-1; Wed, 29 Oct 2025 14:05:21 -0400
X-MC-Unique: oT4dz1ACPW6WKy3PdA8SEA-1
X-Mimecast-MFC-AGG-ID: oT4dz1ACPW6WKy3PdA8SEA_1761761121
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8a4ef35cc93so35122185a.3
        for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 11:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761121; x=1762365921;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNxXxUzXoqQQT9w5Yf9S20ddLNixsnFzdxWTN/CN8Uk=;
        b=Nz5+YbWMBqYovOuiiPq31lrWWR6bhxOjWSMAHn7YYlXbMqm1HDvL2h8xR7UPynftDC
         RN2Z5KSFw1HfxNMPwEM5ZTBF/13oXupPpPWDj9CkCmir8AoRftr2OQ3nww5uYAZVIc5+
         XgNSVQeThwyP5BqdT1cUV7PUjLVWvq0+KuwYtySVp8RNJo24RzWjTlaTKheD5d+z8Cg4
         XGwi8/xBX0XVPq9E1KqBnA5NNni1OgFTR4xJl+EUCYJXJMslSP9zVtwwf2BnJ09KlKOt
         eGetxhePQM+0FCRpTW0gPD4Xz2OAiu2W15hP3JrCrV+lWaBk5KXKyas8o9FQbdIdcJdh
         2nJw==
X-Forwarded-Encrypted: i=1; AJvYcCUBVjjpePVGPtSDoN2JiV+2Vp7+TiXBuiZXW4EbN0tppDbWCRyJFiAcm2RHWRjYp3PTLmdZk+f2SNWV6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh1rBVywFaUS9yuxbTegC0pOxO+tHmqpUF85+iF244/ozDsHmA
	jG+ZqtTOsKrKgbapdwVZ0QA27Khn3g6Ml9Ngcah/zSguteMvGc9i/lNjpmPpuWxpfGyOVFKVOXz
	F3219T/60m+QigOUqymYWp+Wk/AuMt0XnDRwQdEdmEjYOQyQ1hbJYqnI/uhuJ6Yaa
X-Gm-Gg: ASbGncvdS6IDUOR4Y63DVY3Y4u9JdjnFU7Gq5/5wR712aJJzc7N7/3VIngFCA3CwsDt
	8oPs/GcoNTcV8wnfYAl2f7KrjSWxtEBcBfy0euRPeOrScMW5QzkcoX89cALzNDcX5qWEnSe1KlC
	SX7zzDytp0xmWA4T47AfV7QhzpKcO2EO0rtOY6zGNXEd+TD0T/Qt38bIUWdiEuVeSspo83pHLSs
	96QuIZdHBneuZ5l+ilExTof3OQm9dxBBSrxwEInjcKxNifkz9umDdNtNbgGaKQAe628rw676GwS
	buTi9Ot/J+GcCru4muvi0as044JFcmlS5lswsYyHqc1WCTdorb2KtYZZsRFLZ/bk80IF8hKu6hf
	fyoV5Jnwp4286mQR1+mbISJOpbUMQozAnVQN1V1uqFlRPNg==
X-Received: by 2002:a05:620a:29cd:b0:8a6:92d1:2db5 with SMTP id af79cd13be357-8a8e473a6e6mr573644385a.24.1761761120477;
        Wed, 29 Oct 2025 11:05:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE6iTF4BqCkm725oJpB//2W/KjYfs5LBPrMdbtexGrXjP/dhJ17Z6sn/BKCKYXRH3K32fmkA==
X-Received: by 2002:a05:620a:29cd:b0:8a6:92d1:2db5 with SMTP id af79cd13be357-8a8e473a6e6mr573635985a.24.1761761119960;
        Wed, 29 Oct 2025 11:05:19 -0700 (PDT)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2421f6a5sm1111574885a.5.2025.10.29.11.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 11:05:19 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <7821fb40-5082-4d11-b539-4c5abc2e572c@redhat.com>
Date: Wed, 29 Oct 2025 14:05:17 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/33] cpuset: Remove cpuset_cpu_is_isolated()
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
 <20251013203146.10162-19-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251013203146.10162-19-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> The set of cpuset isolated CPUs is now included in HK_TYPE_DOMAIN
> housekeeping cpumask. There is no usecase left interested in just
> checking what is isolated by cpuset and not by the isolcpus= kernel
> boot parameter.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/cpuset.h          |  6 ------
>   include/linux/sched/isolation.h |  3 +--
>   kernel/cgroup/cpuset.c          | 12 ------------
>   3 files changed, 1 insertion(+), 20 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 051d36fec578..a10775a4f702 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -78,7 +78,6 @@ extern void cpuset_lock(void);
>   extern void cpuset_unlock(void);
>   extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
>   extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
> -extern bool cpuset_cpu_is_isolated(int cpu);
>   extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
>   #define cpuset_current_mems_allowed (current->mems_allowed)
>   void cpuset_init_current_mems_allowed(void);
> @@ -208,11 +207,6 @@ static inline bool cpuset_cpus_allowed_fallback(struct task_struct *p)
>   	return false;
>   }
>   
> -static inline bool cpuset_cpu_is_isolated(int cpu)
> -{
> -	return false;
> -}
> -
>   static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
>   {
>   	return node_possible_map;
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 94d5c835121b..0f50c152cf68 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -76,8 +76,7 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
>   static inline bool cpu_is_isolated(int cpu)
>   {
>   	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
> -	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK) ||
> -	       cpuset_cpu_is_isolated(cpu);
> +	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
>   }
>   

You can also remove the "<linux/cpuset.h>" include from isolation.h 
which was added by commit 3232e7aad11e5 ("cgroup/cpuset: Include 
isolated cpuset CPUs in cpu_is_isolated() check") which introduces 
cpuset_cpu_is_isolated().

Cheers,
Longman


