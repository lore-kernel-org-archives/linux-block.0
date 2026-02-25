Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D628750B
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 07:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772003233; cv=none; b=kICgySLCFkM0hmDewXRciBT3YyFz8VT1MCkvYA80gLZWkrQI7Y6l+bXEwJoy0ZmEo/t0uE4z+mSJUujd1tCZsV3cWz1JuuCMmrdM3JzTLNvv/6x4dhv2ENaPu1KnTBNJ2YZuw/HA0nxLlx0gUJ93zfJ0ollNvE+w71Od4o6o+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772003233; c=relaxed/simple;
	bh=poYiLUyl9MqHdO+5KPyIdBFBuuZXhKuK4NpxmMUjLOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebmdgBUl80ljYs74Ufq5X/LbErY9rrMRitzk7CCGzhXUO2Bx6OHgukUZWc4g2km407AUedBO1q+2mjSjsR5k0GUuR7pOw4Cuic26GJqWyUSO6M/amF7PPLjEPthZ4+bbTJBnFn1TbcVzKd6KIg96sz7w5kBsl6t8W1xV6s31gsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dzQKIHxm; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dzQKIHxm"
Date: Wed, 25 Feb 2026 15:06:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772003219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2XCqGwE2JITi+kn+HyNQ55mzrR4dNxt4VlIjP1tP+zg=;
	b=dzQKIHxm7dbe1pGFIYt7fFjcQk5E1h3vzOTZygUNDAm35NZPiwaM89uQx9OF+X3qbsJx90
	v5Nq9bqlyB7pQfueQt0u+7ki47sla6afPhY4Dbq5gK0yZn8vw34aZHVQlZM1BltVofHY0W
	/35Vct7R9sC8s7Gvtf1LSukzKw5M8zg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, surenb@google.com
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <zn7q75k7u2mspvmspwiao6245kmaahti3kwagablp3advcx5ga@5d36ctyi2a35>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <aZ0wX_QuxNTxXHMj@hyeyoo>
 <aZ1qRhIGDAR7d56r@fedora>
 <qiqptuqsiaufeasf2xukfzoumiyoau3zfpokosn2amgc6zskc6@vl6ie2h2zj4m>
 <aZ6cjpU36_EmXslf@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ6cjpU36_EmXslf@hyeyoo>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 25, 2026 at 03:54:06PM +0900, Harry Yoo wrote:
> On Wed, Feb 25, 2026 at 01:32:36PM +0800, Hao Li wrote:
> > On Tue, Feb 24, 2026 at 05:07:18PM +0800, Ming Lei wrote:
> > > Hi Harry,
> > > 
> > > On Tue, Feb 24, 2026 at 02:00:15PM +0900, Harry Yoo wrote:
> > > > On Tue, Feb 24, 2026 at 10:52:28AM +0800, Ming Lei wrote:
> > > > > Hello Vlastimil and MM guys,
> > > > 
> > > > Hi Ming, thanks for the report!
> > > > 
> > > > > The SLUB "sheaves" series merged via 815c8e35511d ("Merge branch
> > > > > 'slab/for-7.0/sheaves' into slab/for-next") introduces a severe
> > > > > performance regression for workloads with persistent cross-CPU
> > > > > alloc/free patterns. ublk null target benchmark IOPS drops
> > > > > significantly compared to v6.19: from ~36M IOPS to ~13M IOPS (~64%
> > > > > drop).
> > > > > 
> > > > > Bisecting within the sheaves series is blocked by a kernel panic at
> > > > > 17c38c88294d ("slab: remove cpu (partial) slabs usage from allocation
> > > > > paths"), so the exact first bad commit could not be identified.
> > > > 
> > > > Ouch. Why did it crash?
> > > 
> > > [   16.162422] Oops: general protection fault, probably for non-canonical address 0xdead000000000110: 0000 [#1] SMP NOPTI
> > > [   16.162426] CPU: 44 UID: 0 PID: 908 Comm: (udev-worker) Not tainted 6.19.0-rc5_master+ #116 PREEMPT(lazy) 
> > > [   16.162429] Hardware name: Giga Computing MZ73-LM2-000/MZ73-LM2-000, BIOS R19_F40 05/12/2025
> > > [   16.162430] RIP: 0010:__put_partials+0x2f/0x140
> > > [   16.162437] Code: 41 57 41 56 49 89 f6 41 55 49 89 fd 31 ff 41 54 45 31 e4 55 53 48 83 ec 18 48 c7 44 24 10 00 00 00 00 eb 03 48 89 df 4c9
> > > [   16.162438] RSP: 0018:ff5117c0ca2dfa60 EFLAGS: 00010086
> > > [   16.162441] RAX: 0000000000000001 RBX: ff1b266981200d80 RCX: 0000000000000246
> > > [   16.162442] RDX: ff1b266981200d90 RSI: ff1b266981200d90 RDI: ff1b266981200d80
> > > [   16.162442] RBP: dead000000000100 R08: 0000000000000000 R09: ffffffffa761bf5e
> > > [   16.162443] R10: ffb6d4b7841d5400 R11: ff1b2669800575c0 R12: 0000000000000000
> > > [   16.162444] R13: ff1b2669800575c0 R14: dead000000000100 R15: ffb6d4b7846be410
> > > [   16.162445] FS:  00007f5fdccc23c0(0000) GS:ff1b267902427000(0000) knlGS:0000000000000000
> > > [   16.162446] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   16.162446] CR2: 0000559824c6c058 CR3: 000000011fb49001 CR4: 0000000000f71ef0
> > > [   16.162447] PKRU: 55555554
> > > [   16.162448] Call Trace:
> > > [   16.162450]  <TASK>
> > > [   16.162452]  kmem_cache_free+0x410/0x490
> > > [   16.162454]  do_readlinkat+0x14e/0x180
> > > [   16.162459]  __x64_sys_readlinkat+0x1c/0x30
> > > [   16.162461]  do_syscall_64+0x7e/0x6b0
> > > [   16.162465]  ? post_alloc_hook+0xb9/0x140
> > > [   16.162468]  ? get_page_from_freelist+0x478/0x720
> > > [   16.162470]  ? path_openat+0xb3/0x2a0
> > > [   16.162472]  ? __alloc_frozen_pages_noprof+0x192/0x350
> > > [   16.162474]  ? count_memcg_events+0xd6/0x210
> > > [   16.162476]  ? memcg1_commit_charge+0x7a/0xa0
> > > [   16.162479]  ? mod_memcg_lruvec_state+0xe7/0x2d0
> > > [   16.162481]  ? charge_memcg+0x48/0x80
> > > [   16.162482]  ? lruvec_stat_mod_folio+0x85/0xd0
> > > [   16.162484]  ? __folio_mod_stat+0x2d/0x90
> > > [   16.162487]  ? set_ptes.isra.0+0x36/0x80
> > > [   16.162490]  ? do_anonymous_page+0x100/0x4a0
> > > [   16.162492]  ? __handle_mm_fault+0x45d/0x6f0
> > > [   16.162493]  ? count_memcg_events+0xd6/0x210
> > > [   16.162494]  ? handle_mm_fault+0x212/0x340
> > > [   16.162495]  ? do_user_addr_fault+0x2b4/0x7b0
> > > [   16.162500]  ? irqentry_exit+0x6d/0x540
> > > [   16.162502]  ? exc_page_fault+0x7e/0x1a0
> > > [   16.162503]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > 
> > For this problem, I have a hypothesis which is inspired by a comment in the
> > patch "slab: remove cpu (partial) slabs usage from allocation paths":
> > 
> > /*
> >  * get a single object from the slab. This might race against __slab_free(),
> >  * which however has to take the list_lock if it's about to make the slab fully
> >  * free.
> >  */
> > 
> > My understanding is that this comment is pointing out a possible race between
> > __slab_free() and get_from_partial_node(). Since __slab_free() takes
> > n->list_lock when it is about to make the slab fully free, and
> > get_from_partial_node() also takes the same lock, the two paths should be
> > mutually excluded by the lock and thus safe.
> > 
> > However, I'm wondering if there could be another race window. Suppose CPU0's
> > get_from_partial_node() has already finished __slab_update_freelist(), but has
> > not yet reached remove_partial(). In that gap, another CPU1 could free an object
> > to the same slab via __slab_free(). CPU1 would observe was_full == 1 (due to the
> > previous get_from_partial_node()->__slab_update_freelist() on CPU0), and then
> >
> > __slab_free() will call put_cpu_partial(s, slab, 1) without holding
> > n->list_lock, trying to add this slab to the CPU partial list.
> 
> If CPU1 observes was_full == 1, it should spin on n->list_lock and wait
> for CPU0 to release the lock. And CPU0 will remove the slab from the
> partial list before releasing the lock. Or am I missing something?
> 
> > In that case,
> > both paths would operate on the same union field in struct slab, which might
> > lead to list corruption.
> 
> Not sure how the scenario you describe could happen:
> 
> CPU 0					CPU1
> - get_from_partial_node()		
>   -> spin_lock(&n->list_lock)		
> 					- __slab_free()
>   -> __slab_update_freelist(),
>      slab becomes full
> 					-> was_full == 1
> 					-> spin_lock(&n->list_lock)

In __slab_free, if was_full == 1, then the condition
!(IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && was_full) becomes false, so it won't
enter the "if" block and therefore n->list_lock is not acquired.
Does that sound right.

-- 
Thanks,
Hao

> 					// starts spining
>   -> if (!new.freelist)
>   ->   remove_partial()
>   -> spin_unlock()
> 					-> spin_lock(&n->list_lock)
> 					   // acquired!
> 					-> slab_update_freelist()
> 					-> spin_unlock(&n->list_lock)
> 
> -- 
> Cheers,
> Harry / Hyeonggon
