Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2063101D0
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007605; cv=none; b=ftHHPMwYvYNnHIDtpgbCz7Emf1EO9CvDW6mrnt6A8K8+trPktcNFUrdNxOhjq60w/coXQgJ+2tshs8Pt6zDECPYjsMjV+/XaazAQ1cAg3nhQ3D9dpF4iyWy9hfvW4sGAxR6qR0cGlpuSKT1mkCi0n0g7gpm7f/MSwiylzhoBHyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007605; c=relaxed/simple;
	bh=RnllmbDPZOC7T/SAbQyvZvrfrH0nwu1zJE3uKq4xrAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zk9F40i392y+EC1Q4WhqfHMT00wyntf29WqdtIUSjGBfPdnCTPzQYuWd/F0bBfNHUn3DxTU/snC0nO4fIr2ZvKeO6tnFiQIkFO9axqm9ismXmIZpDLyS5TQ1dnnOo0fHlr0wXuIwnZWq/66TcGxtyMibHZCVvc82cieZc5P+Jg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sv/XUFhd; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sv/XUFhd"
Date: Wed, 25 Feb 2026 16:19:49 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772007600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CqMfuQhJe0D0dX24jwBy/Pxdi2sd3URLqvWF4bUrvgU=;
	b=Sv/XUFhdHVYdyOnP9s/ge+Ix9sVmvmrfu+qD5qxsje9QS7SbipcDGBGnpQ2rTybeNg5E1o
	4AYLh2vEQbx5pbMRusGIMIQZPwfeHtK87V9JFkd/QRo89/j4de9q0C7I5l+iHXD/awBsAj
	TyeYJebnNhJ+Kl5M/qfLQ4I2zKIVaYw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, surenb@google.com
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <jcgdv46sngpfggq26x2f7oodqxlwqtiilcgjzdcwvbt3ovelpj@mwllshvzoeoz>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <aZ0wX_QuxNTxXHMj@hyeyoo>
 <aZ1qRhIGDAR7d56r@fedora>
 <qiqptuqsiaufeasf2xukfzoumiyoau3zfpokosn2amgc6zskc6@vl6ie2h2zj4m>
 <aZ6cjpU36_EmXslf@hyeyoo>
 <zn7q75k7u2mspvmspwiao6245kmaahti3kwagablp3advcx5ga@5d36ctyi2a35>
 <aZ6ijXgDKj9D-kDm@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ6ijXgDKj9D-kDm@hyeyoo>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 25, 2026 at 04:19:41PM +0900, Harry Yoo wrote:
> On Wed, Feb 25, 2026 at 03:06:46PM +0800, Hao Li wrote:
> > On Wed, Feb 25, 2026 at 03:54:06PM +0900, Harry Yoo wrote:
> > > On Wed, Feb 25, 2026 at 01:32:36PM +0800, Hao Li wrote:
> > > > On Tue, Feb 24, 2026 at 05:07:18PM +0800, Ming Lei wrote:
> > > > > Hi Harry,
> > > > > 
> > > > > On Tue, Feb 24, 2026 at 02:00:15PM +0900, Harry Yoo wrote:
> > > > > > On Tue, Feb 24, 2026 at 10:52:28AM +0800, Ming Lei wrote:
> > > > > > > Hello Vlastimil and MM guys,
> > > > > > 
> > > > > > Hi Ming, thanks for the report!
> > > > > > 
> > > > > > > The SLUB "sheaves" series merged via 815c8e35511d ("Merge branch
> > > > > > > 'slab/for-7.0/sheaves' into slab/for-next") introduces a severe
> > > > > > > performance regression for workloads with persistent cross-CPU
> > > > > > > alloc/free patterns. ublk null target benchmark IOPS drops
> > > > > > > significantly compared to v6.19: from ~36M IOPS to ~13M IOPS (~64%
> > > > > > > drop).
> > > > > > > 
> > > > > > > Bisecting within the sheaves series is blocked by a kernel panic at
> > > > > > > 17c38c88294d ("slab: remove cpu (partial) slabs usage from allocation
> > > > > > > paths"), so the exact first bad commit could not be identified.
> > > > > > 
> > > > > > Ouch. Why did it crash?
> > > > > 
> > > > > [   16.162422] Oops: general protection fault, probably for non-canonical address 0xdead000000000110: 0000 [#1] SMP NOPTI
> > > > > [   16.162426] CPU: 44 UID: 0 PID: 908 Comm: (udev-worker) Not tainted 6.19.0-rc5_master+ #116 PREEMPT(lazy) 
> > > > > [   16.162429] Hardware name: Giga Computing MZ73-LM2-000/MZ73-LM2-000, BIOS R19_F40 05/12/2025
> > > > > [   16.162430] RIP: 0010:__put_partials+0x2f/0x140
> > > > > [   16.162437] Code: 41 57 41 56 49 89 f6 41 55 49 89 fd 31 ff 41 54 45 31 e4 55 53 48 83 ec 18 48 c7 44 24 10 00 00 00 00 eb 03 48 89 df 4c9
> > > > > [   16.162438] RSP: 0018:ff5117c0ca2dfa60 EFLAGS: 00010086
> > > > > [   16.162441] RAX: 0000000000000001 RBX: ff1b266981200d80 RCX: 0000000000000246
> > > > > [   16.162442] RDX: ff1b266981200d90 RSI: ff1b266981200d90 RDI: ff1b266981200d80
> > > > > [   16.162442] RBP: dead000000000100 R08: 0000000000000000 R09: ffffffffa761bf5e
> > > > > [   16.162443] R10: ffb6d4b7841d5400 R11: ff1b2669800575c0 R12: 0000000000000000
> > > > > [   16.162444] R13: ff1b2669800575c0 R14: dead000000000100 R15: ffb6d4b7846be410
> > > > > [   16.162445] FS:  00007f5fdccc23c0(0000) GS:ff1b267902427000(0000) knlGS:0000000000000000
> > > > > [   16.162446] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > [   16.162446] CR2: 0000559824c6c058 CR3: 000000011fb49001 CR4: 0000000000f71ef0
> > > > > [   16.162447] PKRU: 55555554
> > > > > [   16.162448] Call Trace:
> > > > > [   16.162450]  <TASK>
> > > > > [   16.162452]  kmem_cache_free+0x410/0x490
> > > > > [   16.162454]  do_readlinkat+0x14e/0x180
> > > > > [   16.162459]  __x64_sys_readlinkat+0x1c/0x30
> > > > > [   16.162461]  do_syscall_64+0x7e/0x6b0
> > > > > [   16.162465]  ? post_alloc_hook+0xb9/0x140
> > > > > [   16.162468]  ? get_page_from_freelist+0x478/0x720
> > > > > [   16.162470]  ? path_openat+0xb3/0x2a0
> > > > > [   16.162472]  ? __alloc_frozen_pages_noprof+0x192/0x350
> > > > > [   16.162474]  ? count_memcg_events+0xd6/0x210
> > > > > [   16.162476]  ? memcg1_commit_charge+0x7a/0xa0
> > > > > [   16.162479]  ? mod_memcg_lruvec_state+0xe7/0x2d0
> > > > > [   16.162481]  ? charge_memcg+0x48/0x80
> > > > > [   16.162482]  ? lruvec_stat_mod_folio+0x85/0xd0
> > > > > [   16.162484]  ? __folio_mod_stat+0x2d/0x90
> > > > > [   16.162487]  ? set_ptes.isra.0+0x36/0x80
> > > > > [   16.162490]  ? do_anonymous_page+0x100/0x4a0
> > > > > [   16.162492]  ? __handle_mm_fault+0x45d/0x6f0
> > > > > [   16.162493]  ? count_memcg_events+0xd6/0x210
> > > > > [   16.162494]  ? handle_mm_fault+0x212/0x340
> > > > > [   16.162495]  ? do_user_addr_fault+0x2b4/0x7b0
> > > > > [   16.162500]  ? irqentry_exit+0x6d/0x540
> > > > > [   16.162502]  ? exc_page_fault+0x7e/0x1a0
> > > > > [   16.162503]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > 
> > > > For this problem, I have a hypothesis which is inspired by a comment in the
> > > > patch "slab: remove cpu (partial) slabs usage from allocation paths":
> > > > 
> > > > /*
> > > >  * get a single object from the slab. This might race against __slab_free(),
> > > >  * which however has to take the list_lock if it's about to make the slab fully
> > > >  * free.
> > > >  */
> > > > 
> > > > My understanding is that this comment is pointing out a possible race between
> > > > __slab_free() and get_from_partial_node(). Since __slab_free() takes
> > > > n->list_lock when it is about to make the slab fully free, and
> > > > get_from_partial_node() also takes the same lock, the two paths should be
> > > > mutually excluded by the lock and thus safe.
> > > > 
> > > > However, I'm wondering if there could be another race window. Suppose CPU0's
> > > > get_from_partial_node() has already finished __slab_update_freelist(), but has
> > > > not yet reached remove_partial(). In that gap, another CPU1 could free an object
> > > > to the same slab via __slab_free(). CPU1 would observe was_full == 1 (due to the
> > > > previous get_from_partial_node()->__slab_update_freelist() on CPU0), and then
> > > >
> > > > __slab_free() will call put_cpu_partial(s, slab, 1) without holding
> > > > n->list_lock, trying to add this slab to the CPU partial list.
> > > 
> > > If CPU1 observes was_full == 1, it should spin on n->list_lock and wait
> > > for CPU0 to release the lock. And CPU0 will remove the slab from the
> > > partial list before releasing the lock. Or am I missing something?
> > > 
> > > > In that case,
> > > > both paths would operate on the same union field in struct slab, which might
> > > > lead to list corruption.
> > > 
> > > Not sure how the scenario you describe could happen:
> > > 
> > > CPU 0					CPU1
> > > - get_from_partial_node()		
> > >   -> spin_lock(&n->list_lock)		
> > > 					- __slab_free()
> > >   -> __slab_update_freelist(),
> > >      slab becomes full
> > > 					-> was_full == 1
> > > 					-> spin_lock(&n->list_lock)
> > 
> > In __slab_free, if was_full == 1, then the condition
> > !(IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && was_full) becomes false, so it won't
> > enter the "if" block and therefore n->list_lock is not acquired.
> > Does that sound right.
> 
> Nah, you're right. Just slipped my mind. No need to acquire the lock
> if it was full, because that means it's not on the partial list.

Exactly.

> 
> Hmm... but the logic has been there for very long time.

Yes.

> 
> Looks like we broke a premise for the percpu slab caching layer
> to work correctly, while transitioning to sheaves.
> 
> I think the new behavior introduced during the sheaves transition is that
> SLUB can now allocate objects from slabs without freezing it. Allocating
> objects from slab without freezing it seems to confuse the free path...

I feel it's not a big issue.

I think the root cause of this issue is as follows:

Before this commit, get_partial_node would first remove the slab from the node
list and then return the slab to the upper layer for freezing and object
allocation. Therefore, when __slab_free encounters a slab marked as was_full,
that slab would no longer be on the node list, avoiding race conditions with
list operations.

However, after this commit, get_from_partial_node first allocates an object
from the slab and then removes the slab from the node list. During the
interval between these two steps, __slab_free might encounter a slab marked as
was_full and then it want to add the slab to the CPU partial list, while at
the same time, another process is trying to remove the same slab from the node
list, leading to a race condition.

> 
> But not sure if we could "fix" that because the percpu partial slab
> caching layer is gone anyway :)

Yes, this bug has already disappeared with subsequent patches...

By the way, to allow Ming Lei to continue the bisect process, maybe we should
come up with a temporary workaround, such as:

} else if (IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && was_full) {
	spin_lock_irqsave(&n->list_lock, flags);
	/*
	 * Let this empty critical section push back put_cpu_partial, ensuring
	 * its execution happens after the critical section of
	 * get_from_partial_node running in parallel.
	 */
	spin_unlock_irqrestore(&n->list_lock, flags);
	/*
	 * If we started with a full slab then put it onto the
	 * per cpu partial list.
	 */
	put_cpu_partial(s, slab, 1);
	stat(s, CPU_PARTIAL_FREE);
}

-- 
Thanks,
Hao
