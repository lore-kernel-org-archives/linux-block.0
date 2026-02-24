Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F5FF9C0
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 06:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915910; cv=none; b=KqIQhBikcuCd+WwZx9Z4u4oeZxCrRLo7lj9LyLtzgXcI0AcR7fG0ZwmwhgSGFntqtHOOCsXCpdGUz86FRh1XyH9VS/pv2eQlcObg3HUOl3ux3oQK7Rcr9aQJosQzxOBDeMiMV0QSMzVIbRoOOhQoxWipEXjpqFoH4yDhFIADxt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915910; c=relaxed/simple;
	bh=g6iBgRn7Zu5IdhqEoz6Ticns6br16AQn/k8I67nWTcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj7VmLMHtj4y0zK28ykAx1CzIulYbz7NGSBV70Uarg1egeFxlPM2SBvgvIJ/UCoCqsVqdeyaPJSTRzQ97tn0hCNcUWZp499sC7CtKO5tOH7kJS09hc0GwFXDhDFIi//IczYAIs7JQOCBYMoS9d06NP4OEFru/kaeceY8Q/d76QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p0HhqgO5; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p0HhqgO5"
Date: Tue, 24 Feb 2026 14:51:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771915897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wL0cOnmJMhg9IShRfsDtR2P4Agh9WQYIhyu2eoIwvjg=;
	b=p0HhqgO5dg1k9LXHplOqEs+tFh+vkPP1zGHNp6Aj4iPU5rCPKtvUfUThRlnWgFiXz0SNV3
	rhfRiNw7C9gNRKhOiNbQHtbm5W9FMfc6HdP73fpTSAvq7/lEb8le0Q0R+0CqFXR9QVU1hZ
	QmdLlmdhIwObmZMIBnz3KEAnSD3KRPs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Ming Lei <ming.lei@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <wprja2flkybpsmdpnihtxp4usbl4fdsayarg4sitnyn3leis5e@vdqas3zhqndw>
References: <aZ0SbIqaIkwoW2mB@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ0SbIqaIkwoW2mB@fedora>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 24, 2026 at 10:52:28AM +0800, Ming Lei wrote:
> Hello Vlastimil and MM guys,
> 
> The SLUB "sheaves" series merged via 815c8e35511d ("Merge branch
> 'slab/for-7.0/sheaves' into slab/for-next") introduces a severe
> performance regression for workloads with persistent cross-CPU
> alloc/free patterns. ublk null target benchmark IOPS drops
> significantly compared to v6.19: from ~36M IOPS to ~13M IOPS (~64%
> drop).

Thanks for testing.

> 
> Bisecting within the sheaves series is blocked by a kernel panic at
> 17c38c88294d ("slab: remove cpu (partial) slabs usage from allocation
> paths"),

As Harry said, this is odd. Could you post crash logs?

> so the exact first bad commit could not be identified.

Based on my earlier test results, this performance regression (more precisely, I
suspect it is an expected return to the previous baseline - see below) should have
been introduced by two patches:

slab: add optimized sheaf refill from partial list
slab: remove SLUB_CPU_PARTIAL

https://lore.kernel.org/linux-mm/imzzlzuzjmlkhxc7hszxh5ba7jksvqcieg5rzyryijkkdhai5q@l2t4ye5quozb/

> 
> Reproducer
> ==========
> 
[...]
> 
> the result is that the allocating cpu's per-cpu slab caches are
> continuously drained without being replenished by local frees. the bio
> layer's own per-cpu cache (bio_alloc_cache) suffers the same mismatch:
> freed bios go to the completion cpu's cache via bio_put_percpu_cache(),
> leaving the submitter cpus' caches empty and falling through to
> mempool_alloc() -> kmem_cache_alloc() -> slub slow path.
> 
> in v6.19, slub handled this with a 3-tier allocation hierarchy:
> 
>   Tier 1: CPU slab freelist         lock-free (cmpxchg)
>   Tier 2: CPU partial slab list     lock-free (per-CPU local_lock)
>   Tier 3: Node partial list         kmem_cache_node->list_lock
> 
> The CPU partial slab list (Tier 2) was the critical buffer. It was
> populated during __slab_free() -> put_cpu_partial() and provided a
> lock-free pool of partial slabs per CPU. Even when the CPU slab was
> exhausted, the CPU partial list could supply more slabs without
> touching any shared lock.
> 
> The sheaves architecture replaces this with a 2-tier hierarchy:
> 
>   Tier 1: Per-CPU sheaf             lock-free (local_lock)
>   Tier 2: Node partial list         kmem_cache_node->list_lock
> 
> The intermediate lock-free tier is gone. When the per-CPU sheaf is
> empty and the spare sheaf is also empty, every refill must go through
> the node partial list, requiring kmem_cache_node->list_lock. With 16
> CPUs simultaneously allocating bios and all hitting empty sheaves, this
> creates a thundering herd on the node list_lock.
> 
> When the local node's partial list is also depleted (objects freed on
> remote nodes accumulate there instead), get_from_any_partial() kicks in
> to search other NUMA nodes, compounding the contention with cross-NUMA
> list_lock acquisition — explaining the 41% in get_from_any_partial ->
> native_queued_spin_lock_slowpath seen in the profile.

The purpose of introducing sheaves was to fully replace the percpu partial slabs
mechanism with sheaves. During this process, we first added the sheaves caching
layer and only later removed the percpu partial slabs layer, so it's expected
that performance could first improve and then return to the previous level.

Would you mind also comparing against a baseline with "no sheaves at all" (e.g.
commit `9d4e6ab865c4`) versus "only the sheaves layer exists" (i.e. commit
`815c8e35511d`)? If those two results are close, then the ~64% performance
regression we're currently discussing might be better interpreted as returning
to the previous baseline (i.e. a reversion), rather than a true regression.

The link below contains my previous test results. According to will-it-scale,
the performance of "no sheaves at all" and "only the sheaves layer exists" is
close:
https://lore.kernel.org/linux-mm/pdmjsvpkl5nsntiwfwguplajq27ak3xpboq3ab77zrbu763pq7@la3hyiqigpir/


-- 
Thanks,
Hao

> 
> The mitigation in 40fd0acc45d0 ("slub: avoid list_lock contention from
> __refill_objects_any()") uses spin_trylock for cross-NUMA refill, but
> does not address the fundamental architectural issue: the missing
> lock-free intermediate caching tier that the CPU partial list provided.
> 
> Thanks,
> Ming
> 
> 
