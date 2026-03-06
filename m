Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF5031619D
	for <linux-block@vger.kernel.org>; Fri,  6 Mar 2026 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772785958; cv=none; b=QnV7ityCyJ3D9Cb9qcUo5I0gXCG0w38BhzFCVtjlU/R9w/LpVdKNCnaA1HrDh0gAncbOPwcMF1VAae6rojSnju8uQAW3QrtNDtqbL6eRyIokfgvSfIr7FurSJ/xn//ZLCX0G6jfpxAPpbC3GOnrMZpb+QsUY9zM5BmVgFRCG3fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772785958; c=relaxed/simple;
	bh=Vtjj1WM9TxjOFkXASNxocdRVkz+pKi4YcGn4mVsbmHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EG5QEQjcNebKvlYDc8ZSXWcTz5iDNk0Hh7v/ltmeeWEM/Xrk6OTrRQ9DA3xPemS7b0qIeUjQnLi6x6mUKZSnmpUEpPl6/EAF9pXFNNE42FzhroYOLr+ntoIP5O+hui0mrFTM/JmSlT5WDRd+QD+iyN6pgwZaU3HaeDGHIckTssw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f+c+/YVH; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f+c+/YVH"
Date: Fri, 6 Mar 2026 16:32:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772785944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUuJEsEmzdv4bF/ObRt5BSjkLwqw8Tv550TKHPFoo1M=;
	b=f+c+/YVHtaPhVlZINm1g+UlreDEE/PO8KOCbsTGYrcHY7eQ7LUNOhanjzzPaNAdRKsQgc3
	GciY4mex1L/z1D6HaGlO1om7aV5V5cXqxKcs+nln+15SQM9T7wJ72W4+95lshCso1bdBHC
	TmAg5o7YkP0aQiFIgbTiUVka0iyiSpo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Ming Lei <ming.lei@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <mhyjdgxppdu6bfnt2ksyltj5hqcn53ztbh4bmnwctt6phxzucb@x4qcnhjs2c2x>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <5cf75a95-4bb9-48e5-af94-ef8ec02dcd4d@suse.cz>
 <724310c2-46a2-4410-8a5d-c69dcc8de35d@kernel.org>
 <aZ7BbosIr2FvZFAe@fedora>
 <c6a01f7e-c6eb-454b-9b9e-734526dd659d@kernel.org>
 <aapeVb_L5zohWRRe@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aapeVb_L5zohWRRe@hyeyoo>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 06, 2026 at 01:55:49PM +0900, Harry Yoo wrote:
> On Thu, Feb 26, 2026 at 07:02:11PM +0100, Vlastimil Babka (SUSE) wrote:
> > On 2/25/26 10:31, Ming Lei wrote:
> > > Hi Vlastimil,
> > > 
> > > On Wed, Feb 25, 2026 at 09:45:03AM +0100, Vlastimil Babka (SUSE) wrote:
> > >> On 2/24/26 21:27, Vlastimil Babka wrote:
> > >> > 
> > >> > It made sense to me not to refill sheaves when we can't reclaim, but I
> > >> > didn't anticipate this interaction with mempools. We could change them
> > >> > but there might be others using a similar pattern. Maybe it would be for
> > >> > the best to just drop that heuristic from __pcs_replace_empty_main()
> > >> > (but carefully as some deadlock avoidance depends on it, we might need
> > >> > to e.g. replace it with gfpflags_allow_spinning()). I'll send a patch
> > >> > tomorrow to test this theory, unless someone beats me to it (feel free to).
> > >> Could you try this then, please? Thanks!
> > > 
> > > Thanks for working on this issue!
> > > 
> > > Unfortunately the patch doesn't make a difference on IOPS in the perf test,
> > > follows the collected perf profile on linus tree(basically 7.0-rc1 with your patch):
> > 
> > what about this patch in addition to the previous one? Thanks.
> > 
> > ----8<----
> > From d3e8118c078996d1372a9f89285179d93971fdb2 Mon Sep 17 00:00:00 2001
> > From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
> > Date: Thu, 26 Feb 2026 18:59:56 +0100
> > Subject: [PATCH] mm/slab: put barn on every online node
> > 
> > Including memoryless nodes.
> > 
> > Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > ---
> 
> Just taking a quick grasp...
> 
> > @@ -6121,7 +6122,8 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
> >  	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
> >  		return;
> >  
> > -	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id())
> > +	if (likely(!IS_ENABLED(CONFIG_NUMA) || (slab_nid(slab) == numa_mem_id())
> > +			|| !node_isset(slab_nid(slab), slab_nodes))
> 
> I think you intended !node_isset(numa_mem_id(), slab_nodes)?

This is a good catch! and it could explain why CPUs on memoryless nodes can have
higher barn_get_fail. They have too less sheaves in barn...

> 
> "Skip freeing to pcs if it's remote free, but memoryless nodes is
>  an exception".
> 
> >  	    && likely(!slab_test_pfmemalloc(slab))) {
> >  		if (likely(free_to_pcs(s, object, true)))
> >  			return;
> 
> -- 
> Cheers,
> Harry / Hyeonggon
