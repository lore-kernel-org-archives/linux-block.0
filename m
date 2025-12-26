Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08521A945
	for <linux-block@vger.kernel.org>; Fri, 26 Dec 2025 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766787096; cv=none; b=P+R0X9hPZAIOkpSY2RLgNJHuxFPP1jcpb2vHbn37wajvjX0fGKd/twDRaXn2Ft1gBSAOZi7umMOnSxBVdWQLY9TUXveGkh6cNUxbjS/k038516NLY2uBjCg1Rcm8jbvO+rP6zOm98FVPv7RP3oF5PM66FN05iWKA9XbfKMy+1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766787096; c=relaxed/simple;
	bh=R9tnImEFZzIwnpkj2WDVfVzgbrkCYG/lZwE4VsztwgI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ugq46q3aSdvWB89j4iBr3XoyZWZ0uE25MpICYB/bdzVt44lnhn2Bu327uX4a03kACQE6nOIL+YilQLOag+QPavXUiPlefH1K2guWXBOStS84+vrnxHqHZauUQ6nBswjqA8qu8c1HjRcXy86EaAfPK+5d6fAWrYudtct9AJgrOZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmuGXbKl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EidF7Ydq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmuGXbKl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EidF7Ydq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766787094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkFBnQY3LS/CUDnrkcxR3YOk4jUDJ9IE93cEOOeBXqU=;
	b=NmuGXbKl1ddvCuhKhxYwRYtD+C4NAzkzwuBr/1DcPLAc4jjeTMZppqy2rfz5esB7I1riKM
	4m6yKfs54E9JSGnMou1Qhod0XJ2kO/y4t4L9UJImTE8DtXprSQDXMRDRykFlcHbuMiia3n
	QgFVX8jLgXZekhhbVAMjOIsqb9EbEjg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-Q-aguA_ZMUSvmUFVsQT0eQ-1; Fri, 26 Dec 2025 17:11:32 -0500
X-MC-Unique: Q-aguA_ZMUSvmUFVsQT0eQ-1
X-Mimecast-MFC-AGG-ID: Q-aguA_ZMUSvmUFVsQT0eQ_1766787092
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f4ab58098eso177252971cf.1
        for <linux-block@vger.kernel.org>; Fri, 26 Dec 2025 14:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766787092; x=1767391892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TkFBnQY3LS/CUDnrkcxR3YOk4jUDJ9IE93cEOOeBXqU=;
        b=EidF7YdqfyHw2+42PNOPVaxHWa35FwPtFgE1WAbC5CTRD9tIR+8icI6UGXyvHiVPUT
         nD6mR1IcfsqKp/VfccdhNo+iY5YH3QMrnUer4n2pAEBsDrORuGEc271YQjF74sWeDfsb
         wsaAF+EjM/qf4iECJJf5YKZlH+lhhyJapXrCWE/DiKIHmyw0tw0v16nVIfXK77PJ5bMb
         l8FnU9wa8EuKRU4QMlaUkCX/ivgPGpKG3LlOr2Rh1Fl2ASVJy5bOwk7jWQrOQZgO+tdH
         mTae93qCT+F3wgXvhN4A8YD1m+ZThxKo31bEHrsMVbxOwXuwMD19eFAtcQAkqPDmrU/b
         nN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766787092; x=1767391892;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkFBnQY3LS/CUDnrkcxR3YOk4jUDJ9IE93cEOOeBXqU=;
        b=PvUL4n4GWtEAtOogvL2xuCUatnp0KLh1k3fKBa/dWvjLPm936/MtWvdteSCE93CcwW
         B+TBJ2r9ijwBa4+zAW2oaP/7OMNa/vjAkEKVe+n16yFqLSfruugCBV9YCID8EexzhVqi
         fX2Rc1Jp2z+PS70ed9xJvzcc46UwgrpNLmzP9aj5b5x3gWJXggP0Ut7HCW4sBF/rYam+
         I/PMgz0/3PBS6WD2tptr/TQ0EYsprT81OFhKcnmT+QwSWgglV6gSP0IVs+vjqkGs/va6
         PuN8fEr91xNaVkOGK75y23Aq9C9WZ9JkhTK/m/0HUy37oijyRBbGSO53mp8uXE5Hg8HY
         js8g==
X-Forwarded-Encrypted: i=1; AJvYcCUIhyRC3LvgVTijmj4o8ddTLjcBd5nvFoRTp/LwyUMJLBLlwqu5HCR13aL+0VBumGOzeIrwVoguuASIWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdRZ8IlyDD4g8U0w3xh6kUHF6cG6RejIZ2nPhMsBeP/Nbpf1Ny
	nXFEn8bd0ZQygeZT4/n6xKt1x0gmUcK+oPDUApB8h/wjPyue9+eq07lR64oN9Hzf3YWMot/me3y
	kyP6pDTiASBWlvwjURmYc2qbijkEBxn2GYWK7758jXu87o9MCnj5z8120qlsLCheB
X-Gm-Gg: AY/fxX5CLXzeF6EQPXvvVMUBQ5lh1MbImAgh2E4asFkF9hhr7cipLI+8ZekOwS/aK1J
	jbIPKgeGfA74+7MsCp6cK3hJuJ08FLQ1YFqYhkcJzJa4DQJ1M0W018VXdq4OcThkAFy3bciCPrE
	dwpEDZ9OArQZYHfWfkTeKUSwUQL9xZ/+7ngXT67f2wQoudEUwTrvgcfX/nJ/RfjCTO1irsLhV6S
	yLLo4BEFFOT74TVT7pbqFlsTazTef8BdFH9spctX4t2uV7shpNDTvXg9NQAHTunFx8sHxIW+uDR
	hHWtU66A3d39dqzVdyBjbnVDV1DWByeJ6M5UJqXmUBUj/7h2/43dEzTNA9eNPRJZl4rqlxAnNo3
	jgLTYBAdACxzPxKIe6bP33at4smG19Wm7gCZ2e2b3n0sCpuNsZ6TTYy0r
X-Received: by 2002:a05:622a:4a09:b0:4ee:2510:198a with SMTP id d75a77b69052e-4f4abd75629mr345582071cf.39.1766787091843;
        Fri, 26 Dec 2025 14:11:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfAC0mMAvBMTtIg0HnYR5V/3qz64S5XCvmCWe5yr1a0y1ZiMQUT11GI7YF+lRu7HFhzwx/CQ==
X-Received: by 2002:a05:622a:4a09:b0:4ee:2510:198a with SMTP id d75a77b69052e-4f4abd75629mr345581701cf.39.1766787091473;
        Fri, 26 Dec 2025 14:11:31 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623fd37sm176347436d6.3.2025.12.26.14.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 14:11:30 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1e530c72-75d7-4c7e-96e7-329056d6baf5@redhat.com>
Date: Fri, 26 Dec 2025 17:11:26 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/33] kthread: Include unbound kthreads in the managed
 affinity list
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
 <20251224134520.33231-26-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-26-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
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
>   kernel/kthread.c | 70 ++++++++++++++++++++++++++++--------------------
>   1 file changed, 41 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index f1e4f1f35cae..51c0908d3d02 100644
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
> @@ -919,8 +917,22 @@ static int kthreads_online_cpu(unsigned int cpu)
>   			ret = -EINVAL;
>   			continue;
>   		}
> -		kthread_fetch_affinity(k, affinity);
> -		set_cpus_allowed_ptr(k->task, affinity);
> +
> +		/*
> +		 * Unbound kthreads without preferred affinity are already affine
> +		 * to housekeeping, whether those CPUs are online or not. So no need
> +		 * to handle newly online CPUs for them.
> +		 *
> +		 * But kthreads with a preferred affinity or node are different:
> +		 * if none of their preferred CPUs are online and part of
> +		 * housekeeping at the same time, they must be affine to housekeeping.
> +		 * But as soon as one of their preferred CPU becomes online, they must
> +		 * be affine to them.
> +		 */
> +		if (k->preferred_affinity || k->node != NUMA_NO_NODE) {
> +			kthread_fetch_affinity(k, affinity);
> +			set_cpus_allowed_ptr(k->task, affinity);
> +		}
>   	}
>   
>   	free_cpumask_var(affinity);
Reviewed-by: Waiman Long <longman@redhat.com>

