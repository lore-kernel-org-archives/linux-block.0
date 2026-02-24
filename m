Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862BB33A9DC
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918926; cv=none; b=DCYeNEFWklG3dGRDrPPDZoRX1capDpurWjZWN1H3huTLVpdlBgIoUxfmqMOQIPBDwWNNMb+NKySkmya6zhAhn84LEkJ+P06bAhgMfny+ua5JrpSgwvoWno7ujTxAPBbfvSHlY8sgkGxv2nsSBjENSWsCxBTkhalu3+z8n4RTvdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918926; c=relaxed/simple;
	bh=FfeePrbdCyua1+EaYD6qxH1EF6VZcexdrzQr+MnglnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJQtwlFtte8z/lMMavqHU324Kmv731wx0HFM+3QVhX8wsyXHAwt8mpNFw2KdluJ36qQySJ8AL2EQ5hUKVDc8L2t6zRthK1nrufy5rAAz7F6WCfeSaR4eOVRtcgzR55cSiBOUaPyBSdo2AJs64KPKbVo7sBFwjdjvW2cXuwpewD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FVIy3nip; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FVIy3nip"
Date: Tue, 24 Feb 2026 15:41:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771918922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zT9YzPCoksVoJcqmXd6fTgUCdxBZDV84wumpFiQtY6k=;
	b=FVIy3nipedxexE5diClbl4ElzKAAtZOOa1jRM+QOouuy4Ila/wvTpxKTG6+lnXW0BSIt7B
	S91FgziUudYDj92WoD7yogBCTn4fDNL/3zgUGaN7yMQV0/odGXTwmeC+czdT9arBC5ikEr
	bSWQ/jPqm4si68QkDREomezQfgFf7lE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <3efkqez23cmbwusugq34u5culryyi5emvocrxxdhxsgphqhx6y@e6kw4t3w3n5o>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <wprja2flkybpsmdpnihtxp4usbl4fdsayarg4sitnyn3leis5e@vdqas3zhqndw>
 <aZ1O82QsjwZVTvzc@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ1O82QsjwZVTvzc@hyeyoo>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 24, 2026 at 04:10:43PM +0900, Harry Yoo wrote:
> On Tue, Feb 24, 2026 at 02:51:26PM +0800, Hao Li wrote:
> > On Tue, Feb 24, 2026 at 10:52:28AM +0800, Ming Lei wrote:
> > > Reproducer
> > > ==========
> > > 
> > [...]
> > > 
> > > the result is that the allocating cpu's per-cpu slab caches are
> > > continuously drained without being replenished by local frees. the bio
> > > layer's own per-cpu cache (bio_alloc_cache) suffers the same mismatch:
> > > freed bios go to the completion cpu's cache via bio_put_percpu_cache(),
> > > leaving the submitter cpus' caches empty and falling through to
> > > mempool_alloc() -> kmem_cache_alloc() -> slub slow path.
> > > 
> > > in v6.19, slub handled this with a 3-tier allocation hierarchy:
> > > 
> > >   Tier 1: CPU slab freelist         lock-free (cmpxchg)
> > >   Tier 2: CPU partial slab list     lock-free (per-CPU local_lock)
> > >   Tier 3: Node partial list         kmem_cache_node->list_lock
> > > 
> > > The CPU partial slab list (Tier 2) was the critical buffer. It was
> > > populated during __slab_free() -> put_cpu_partial() and provided a
> > > lock-free pool of partial slabs per CPU. Even when the CPU slab was
> > > exhausted, the CPU partial list could supply more slabs without
> > > touching any shared lock.
> > > 
> > > The sheaves architecture replaces this with a 2-tier hierarchy:
> > > 
> > >   Tier 1: Per-CPU sheaf             lock-free (local_lock)
> > >   Tier 2: Node partial list         kmem_cache_node->list_lock
> > > 
> > > The intermediate lock-free tier is gone. When the per-CPU sheaf is
> > > empty and the spare sheaf is also empty, every refill must go through
> > > the node partial list, requiring kmem_cache_node->list_lock. With 16
> > > CPUs simultaneously allocating bios and all hitting empty sheaves, this
> > > creates a thundering herd on the node list_lock.
> > > 
> > > When the local node's partial list is also depleted (objects freed on
> > > remote nodes accumulate there instead), get_from_any_partial() kicks in
> > > to search other NUMA nodes, compounding the contention with cross-NUMA
> > > list_lock acquisition — explaining the 41% in get_from_any_partial ->
> > > native_queued_spin_lock_slowpath seen in the profile.
> > 
> > The purpose of introducing sheaves was to fully replace the percpu partial slabs
> > mechanism with sheaves. During this process, we first added the sheaves caching
> > layer and only later removed the percpu partial slabs layer, so it's expected
> > that performance could first improve and then return to the previous level.
> 
> There's one difference here; you used will-it-scale mmap2 test case that
> involves maple tree node and vm_area_struct cache that already has
> sheaves enabled in v6.19.
> 
> And Ming's benchmark stresses bio-<size> caches.
> 
> Since other caches don't have sheaves in v6.19, they're not supposed to
> have performance gain by having additional sheaves layer on top of cpu
> slab + percpu partial slab list.

Oh, yes-you're right. That distinction is important!
I think I've gotten a bit stuck in a fixed way of thinking...
Thanks for pointing it out!

> 
> > Would you mind also comparing against a baseline with "no sheaves at all" (e.g.
> > commit `9d4e6ab865c4`) versus "only the sheaves layer exists" (i.e. commit
> > `815c8e35511d`)? If those two results are close, then the ~64% performance
> > regression we're currently discussing might be better interpreted as returning
> > to the previous baseline (i.e. a reversion), rather than a true regression.
> >
> > The link below contains my previous test results. According to will-it-scale,
> > the performance of "no sheaves at all" and "only the sheaves layer exists" is
> > close:
> > https://lore.kernel.org/linux-mm/pdmjsvpkl5nsntiwfwguplajq27ak3xpboq3ab77zrbu763pq7@la3hyiqigpir/
> 
> -- 
> Cheers,
> Harry / Hyeonggon
