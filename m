Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1990928D83E
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924056; cv=none; b=lWVeKMx2bv/WPQ0c9jP6f5nwTkVuQDyvIGKFl7taqj0e6awhT9Lf+3TT5gQYaxP0DYaLRcQ4XTd4WX4TtfMyFWoxuK+JPyHObOgfmFGY5kAc/sdE69JCHZQx5xIrOD7p9mWGoRfEbhBj8pwpZlia+10Vuq4bGCH1fflvMgDX27o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924056; c=relaxed/simple;
	bh=lKXbwMZicouIm05NXrO3ScRA9RqWZkN5yIxawIhQtYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScuSvmKGOmmK+A/NLgp4nxH+AElOqJQgMdbIqcqfJJJP522bIrlfBvZkKeFBnzO2ucVAfpGzQr+5sBldY5gO4XKmIg9iUDU7pLWhfI5/3E59oVAoqaa/agMOWoQgCHChIlggqYoqiUZGvtVtjPidUSIZA1Zexr1FirjZlLLk3ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLGXY67c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLGXY67c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771924054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lowuVS/ej1pF2SSlwwOVmOlogLmaS7K21b81ed6QGS4=;
	b=gLGXY67c08sX1QAgadseRaRWT9+TUn6XfbqlOleE1Qg3ZUVQZ+kzDPNVPrvLBEiM+C+aOH
	y0LbADEVyMEhoPxQPBcOM0E3H+1qyrSUWHCvQJ2sgSScyXQVf3We1cTUsL882BiF0R2AZG
	HHIECq94VFJG0O2R8lg3t9mXDNdFmqY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-KckwD23dM7eWUExHWcnG1g-1; Tue,
 24 Feb 2026 04:07:30 -0500
X-MC-Unique: KckwD23dM7eWUExHWcnG1g-1
X-Mimecast-MFC-AGG-ID: KckwD23dM7eWUExHWcnG1g_1771924048
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1990180025E;
	Tue, 24 Feb 2026 09:07:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6EBBF1955F43;
	Tue, 24 Feb 2026 09:07:22 +0000 (UTC)
Date: Tue, 24 Feb 2026 17:07:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Hao Li <hao.li@linux.dev>, surenb@google.com
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <aZ1qRhIGDAR7d56r@fedora>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <aZ0wX_QuxNTxXHMj@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ0wX_QuxNTxXHMj@hyeyoo>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Harry,

On Tue, Feb 24, 2026 at 02:00:15PM +0900, Harry Yoo wrote:
> On Tue, Feb 24, 2026 at 10:52:28AM +0800, Ming Lei wrote:
> > Hello Vlastimil and MM guys,
> 
> Hi Ming, thanks for the report!
> 
> > The SLUB "sheaves" series merged via 815c8e35511d ("Merge branch
> > 'slab/for-7.0/sheaves' into slab/for-next") introduces a severe
> > performance regression for workloads with persistent cross-CPU
> > alloc/free patterns. ublk null target benchmark IOPS drops
> > significantly compared to v6.19: from ~36M IOPS to ~13M IOPS (~64%
> > drop).
> > 
> > Bisecting within the sheaves series is blocked by a kernel panic at
> > 17c38c88294d ("slab: remove cpu (partial) slabs usage from allocation
> > paths"), so the exact first bad commit could not be identified.
> 
> Ouch. Why did it crash?

[   16.162422] Oops: general protection fault, probably for non-canonical address 0xdead000000000110: 0000 [#1] SMP NOPTI
[   16.162426] CPU: 44 UID: 0 PID: 908 Comm: (udev-worker) Not tainted 6.19.0-rc5_master+ #116 PREEMPT(lazy) 
[   16.162429] Hardware name: Giga Computing MZ73-LM2-000/MZ73-LM2-000, BIOS R19_F40 05/12/2025
[   16.162430] RIP: 0010:__put_partials+0x2f/0x140
[   16.162437] Code: 41 57 41 56 49 89 f6 41 55 49 89 fd 31 ff 41 54 45 31 e4 55 53 48 83 ec 18 48 c7 44 24 10 00 00 00 00 eb 03 48 89 df 4c9
[   16.162438] RSP: 0018:ff5117c0ca2dfa60 EFLAGS: 00010086
[   16.162441] RAX: 0000000000000001 RBX: ff1b266981200d80 RCX: 0000000000000246
[   16.162442] RDX: ff1b266981200d90 RSI: ff1b266981200d90 RDI: ff1b266981200d80
[   16.162442] RBP: dead000000000100 R08: 0000000000000000 R09: ffffffffa761bf5e
[   16.162443] R10: ffb6d4b7841d5400 R11: ff1b2669800575c0 R12: 0000000000000000
[   16.162444] R13: ff1b2669800575c0 R14: dead000000000100 R15: ffb6d4b7846be410
[   16.162445] FS:  00007f5fdccc23c0(0000) GS:ff1b267902427000(0000) knlGS:0000000000000000
[   16.162446] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.162446] CR2: 0000559824c6c058 CR3: 000000011fb49001 CR4: 0000000000f71ef0
[   16.162447] PKRU: 55555554
[   16.162448] Call Trace:
[   16.162450]  <TASK>
[   16.162452]  kmem_cache_free+0x410/0x490
[   16.162454]  do_readlinkat+0x14e/0x180
[   16.162459]  __x64_sys_readlinkat+0x1c/0x30
[   16.162461]  do_syscall_64+0x7e/0x6b0
[   16.162465]  ? post_alloc_hook+0xb9/0x140
[   16.162468]  ? get_page_from_freelist+0x478/0x720
[   16.162470]  ? path_openat+0xb3/0x2a0
[   16.162472]  ? __alloc_frozen_pages_noprof+0x192/0x350
[   16.162474]  ? count_memcg_events+0xd6/0x210
[   16.162476]  ? memcg1_commit_charge+0x7a/0xa0
[   16.162479]  ? mod_memcg_lruvec_state+0xe7/0x2d0
[   16.162481]  ? charge_memcg+0x48/0x80
[   16.162482]  ? lruvec_stat_mod_folio+0x85/0xd0
[   16.162484]  ? __folio_mod_stat+0x2d/0x90
[   16.162487]  ? set_ptes.isra.0+0x36/0x80
[   16.162490]  ? do_anonymous_page+0x100/0x4a0
[   16.162492]  ? __handle_mm_fault+0x45d/0x6f0
[   16.162493]  ? count_memcg_events+0xd6/0x210
[   16.162494]  ? handle_mm_fault+0x212/0x340
[   16.162495]  ? do_user_addr_fault+0x2b4/0x7b0
[   16.162500]  ? irqentry_exit+0x6d/0x540
[   16.162502]  ? exc_page_fault+0x7e/0x1a0
[   16.162503]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

> 
> > Reproducer
> > ==========
> > 
> > Hardware: NUMA machine with >= 32 CPUs
> > Kernel:   v7.0-rc (with slab/for-7.0/sheaves merged)
> > 
> >     # build kublk selftest
> >     make -C tools/testing/selftests/ublk/
> > 
> >     # create ublk null target device with 16 queues
> >     tools/testing/selftests/ublk/kublk add -t null -q 16
> > 
> >     # run fio/t/io_uring benchmark: 16 jobs, 20 seconds, non-polled
> >     taskset -c 0-31 fio/t/io_uring -p0 -n 16 -r 20 /dev/ublkb0
> > 
> >     # cleanup
> >     tools/testing/selftests/ublk/kublk del -n 0
> > 
> > Good: v6.19 (and 41f1a08645ab, the mainline parent of the slab merge)
> > Bad:  815c8e35511d (Merge branch 'slab/for-7.0/sheaves' into slab/for-next)
> 
> Thanks for such a detailed steps to reproduce :)
> 
> > perf profile (bad kernel)
> > =========================
> > 
> > ~47% of CPU time is spent in bio allocation hitting the SLUB slow path,
> > with massive spinlock contention on the node partial list lock:
> > 
> > +   47.65%     1.21%  io_uring  [k] bio_alloc_bioset
> > -   44.87%     0.45%  io_uring  [k] kmem_cache_alloc_noprof
> >    - 44.41% kmem_cache_alloc_noprof
> >       - 43.89% ___slab_alloc
> >          + 41.16% get_from_any_partial
> >            0.91% get_from_partial_node
> >          + 0.87% alloc_from_new_slab
> >          + 0.65% allocate_slab
> > -   44.70%     0.21%  io_uring  [k] mempool_alloc_noprof
> >    - 44.49% mempool_alloc_noprof
> >       - 44.43% kmem_cache_alloc_noprof
> >          - 43.90% ___slab_alloc
> >             + 41.18% get_from_any_partial
> >               0.90% get_from_partial_node
> >             + 0.87% alloc_from_new_slab
> >             + 0.65% allocate_slab
> > +   41.23%     0.10%  io_uring  [k] get_from_any_partial
> > +   40.82%     0.48%  io_uring  [k] __raw_spin_lock_irqsave
> > -   40.75%     0.20%  io_uring  [k] get_from_partial_node
> >    - 40.56% get_from_partial_node
> >       - 38.83% __raw_spin_lock_irqsave
> >            38.65% native_queued_spin_lock_slowpath
> 
> That's pretty severe contention. Interestingly, the profile shows
> a severe contention on the alloc path, but I don't see free path here.
> wondering why only the alloc path is suffering, hmm...

free path looks fine.

+    2.84%     0.16%  kublk            [kernel.kallsyms]       [k] mempool_free
+    2.66%     0.17%  kublk            [kernel.kallsyms]       [k] security_uring_cmd
+    2.57%     0.36%  kublk            [kernel.kallsyms]       [k] __slab_free

> 
> Anyway, I think there may be two pieces contributing to this contention:
> 
> Part 1) We probably made the portion of slowpath bigger,
>         by caching a smaller number of objects per CPU
> 	after transitioning to sheaves.
> 
> Part 2) We probably made the slowpath much slower.
> 
> We need to investigate those parts separately.
> 
> Regarding Part 1:
> 
> # Point 1. The CPU slab was not considered in the sheaf capacity calculation
> 
> calculate_sheaf_capacity() does not take into account that the CPU slab
> was also cached per CPU. Shouldn't we add oo_objects(s->oo) to the existing
> calculation to cache a number of objects similar to the CPU slab + percpu
> partial slab list layers that SLUB previously had?
> 
> # Point 2. SLUB no longer relies on "Slabs are half-full" assumption,
> # and that probably means we're caching less objects per CPU.
> 
> Because SLUB previously assumed "slabs are half-full" when calculating
> the number of slabs to cache per CPU, that could actually cache as twice
> as many objects than intended when slabs are mostly empty.
> 
> Because sheaves track the number of objects precisely, that inaccuracy
> is gone. If the workload was previously benefiting from the inaccuracy,
> sheaves can make CPUs cache a smaller number of objects per CPU compared
> to the percpu slab caching layer.
> 
> Anyway, I guess we need to check how many objects are actually
> cached per CPU w/ and w/o sheaves, during the benchmark.

In the workload `fio/t/io_uring -p0 -n 16 -r 20 /dev/ublkb0`, queue depth
is 128, so there should be 128 inflight bios on these 16 tasks/cpus.

> 
> After making sure the number of objects cached per CPU is the same as
> before, we could further investigate how much Part 2 plays into it.
> 
> Slightly off-topic, by the way, slab currently doesn't let system admins
> set custom sheaf_capacity. Instead, calculate_sheaf_capacity() sets
> the default capacity. I think we need to allow sys admins to set a custom
> sheaf_capacity in the very near future.
> 
> > Analysis
> > ========
> > 
> > The ublk null target workload exposes a cross-CPU slab allocation
> > pattern: bios are allocated on the io_uring submitter CPU during block
> > layer submission, but freed on a different CPU — the ublk daemon thread
> > that runs the completion via io_uring_cmd_complete_in_task() task work.
> > And the completion CPU stays in same LLC or numa node with submission CPU.
> 
> Ok, so a submitter CPU keeps allocating objects, while a completion CPU
> keeps freeing objects.

Yes.


Thanks, 
Ming

