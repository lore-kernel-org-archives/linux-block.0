Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822FD3C8726
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224173; cv=none; b=SHa6Y2JDMRXaWPJpARj/pCceVOSHnXmMyHsqrpXPDKu5656boVKCn2CAakhNWCVrI23Rk4OCC7spWwFKohkI+q7mcSCeTxjWevJqBXmc2bTFO/0Cp9Z3HGLZ8xNeKKseJ68Sqy6qgL9GUS1fbKFKBfFLVQmm6PifqQVdDoIfWTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224173; c=relaxed/simple;
	bh=ceOUm5oBKeVYaP52Bm023IcHCVLrOEb7eWsN/3oZX5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEBwsigZIJmBpsD0luJDDi0yXg8wQB0daZIj0dFYoeOfIX1ju5w8q51OvKf9ZfOzZUxQupEoBqY3rCDisLwQob3UEwZHUJJqf/FduXSCIbhGiOZOUZPTYz7RVSk5Wz2eGhm6sxXJ+KxJK7eQy8/gHQAnMDcyWG7KUx5raRzRlZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OraQPaZ7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OraQPaZ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773224170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ScqAB1pPNilAlzHe4XpHePGh9uVJkCnzlqRgNeOGVw8=;
	b=OraQPaZ7FRdLrieTtAOUInagI0pMKEuvm8iE2TEyEMgv0H4YUFneYvVucEZIGJnrSJ5y2U
	kdIgr5u6fjzDAVX9LMACrJA0JOBuNJc+UBU/NQBQSrzPMOY3thGhZ5ehSLrtMdN/WteNdz
	xslAv4wf1G6vUom4OLe5GLXwEMKhUGw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-nIKYXTN6MSiF-HWLli9IXg-1; Wed,
 11 Mar 2026 06:16:05 -0400
X-MC-Unique: nIKYXTN6MSiF-HWLli9IXg-1
X-Mimecast-MFC-AGG-ID: nIKYXTN6MSiF-HWLli9IXg_1773224163
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 728AB1955F39;
	Wed, 11 Mar 2026 10:16:03 +0000 (UTC)
Received: from fedora (unknown [10.72.116.147])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 056531800576;
	Wed, 11 Mar 2026 10:15:56 +0000 (UTC)
Date: Wed, 11 Mar 2026 18:15:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Hao Li <hao.li@linux.dev>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <abFA17ZmsW6RgcYI@fedora>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <5cf75a95-4bb9-48e5-af94-ef8ec02dcd4d@suse.cz>
 <724310c2-46a2-4410-8a5d-c69dcc8de35d@kernel.org>
 <aZ7BbosIr2FvZFAe@fedora>
 <c6a01f7e-c6eb-454b-9b9e-734526dd659d@kernel.org>
 <aapeVb_L5zohWRRe@hyeyoo>
 <d5cd4eb4-1703-41af-9c71-842ae33edbdf@kernel.org>
 <aaqq7YmUcOht3GWH@fedora>
 <abDA9UrJBT1wXh22@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abDA9UrJBT1wXh22@hyeyoo>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Mar 11, 2026 at 10:10:13AM +0900, Harry Yoo wrote:
> On Fri, Mar 06, 2026 at 06:22:37PM +0800, Ming Lei wrote:
> > On Fri, Mar 06, 2026 at 09:47:27AM +0100, Vlastimil Babka (SUSE) wrote:
> > > On 3/6/26 05:55, Harry Yoo wrote:
> > > > On Thu, Feb 26, 2026 at 07:02:11PM +0100, Vlastimil Babka (SUSE) wrote:
> > > >> On 2/25/26 10:31, Ming Lei wrote:
> > > >> > Hi Vlastimil,
> > > >> > 
> > > >> > On Wed, Feb 25, 2026 at 09:45:03AM +0100, Vlastimil Babka (SUSE) wrote:
> > > >> >> On 2/24/26 21:27, Vlastimil Babka wrote:
> > > >> >> > 
> > > >> >> > It made sense to me not to refill sheaves when we can't reclaim, but I
> > > >> >> > didn't anticipate this interaction with mempools. We could change them
> > > >> >> > but there might be others using a similar pattern. Maybe it would be for
> > > >> >> > the best to just drop that heuristic from __pcs_replace_empty_main()
> > > >> >> > (but carefully as some deadlock avoidance depends on it, we might need
> > > >> >> > to e.g. replace it with gfpflags_allow_spinning()). I'll send a patch
> > > >> >> > tomorrow to test this theory, unless someone beats me to it (feel free to).
> > > >> >> Could you try this then, please? Thanks!
> > > >> > 
> > > >> > Thanks for working on this issue!
> > > >> > 
> > > >> > Unfortunately the patch doesn't make a difference on IOPS in the perf test,
> > > >> > follows the collected perf profile on linus tree(basically 7.0-rc1 with your patch):
> > > >> 
> > > >> what about this patch in addition to the previous one? Thanks.
> > > >> 
> > > >> ----8<----
> > > >> From d3e8118c078996d1372a9f89285179d93971fdb2 Mon Sep 17 00:00:00 2001
> > > >> From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
> > > >> Date: Thu, 26 Feb 2026 18:59:56 +0100
> > > >> Subject: [PATCH] mm/slab: put barn on every online node
> > > >> 
> > > >> Including memoryless nodes.
> > > >> 
> > > >> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > > >> ---
> > > > 
> > > > Just taking a quick grasp...
> > > > 
> > > >> @@ -6121,7 +6122,8 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
> > > >>  	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
> > > >>  		return;
> > > >>  
> > > >> -	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id())
> > > >> +	if (likely(!IS_ENABLED(CONFIG_NUMA) || (slab_nid(slab) == numa_mem_id())
> > > >> +			|| !node_isset(slab_nid(slab), slab_nodes))
> > > > 
> > > > I think you intended !node_isset(numa_mem_id(), slab_nodes)?
> > > > 
> > > > "Skip freeing to pcs if it's remote free, but memoryless nodes is
> > > >  an exception".
> > > 
> > > Indeed, thanks! Ming, could you retry with that fixed up please?
> > 
> > After applying the following change, IOPS is ~25M:
> > 
> > - delta change on the two patches
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 085fe49eec68..56fe8bd956c0 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -6142,7 +6142,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
> >                 return;
> >  
> >         if (likely(!IS_ENABLED(CONFIG_NUMA) || (slab_nid(slab) == numa_mem_id())
> > -                       || !node_isset(slab_nid(slab), slab_nodes))
> > +                       || !node_isset(numa_mem_id(), slab_nodes))
> >             && likely(!slab_test_pfmemalloc(slab))) {
> >                 if (likely(free_to_pcs(s, object, true)))
> >                         return;
> >
> 
> Hi Ming, thanks a lot for helping testing!
> 
> The stats look quite fine to me, but we're still seeing suboptimal IOPS.
> 
> > - slab stat on patched `815c8e35511d Merge branch 'slab/for-7.0/sheaves' into slab/for-next`
> 
> Does that doesn't include Vlastimil's (fb1091febd66 mm/slab: allow sheaf
> refill if blocking is not allowed)?

No, because fb1091febd66 isn't included into `815c8e35511d Merge branch
'slab/for-7.0/sheaves'.

> 
> Next time when testing it, could you please test on top of 7.0-rc3 w/
> the memoryless node patch (w/ the delta above) applied?

IOPS is same between `815c8e35511d Merge branch 'slab/for-7.0/sheaves' into slab/for-next`
and 7.0-rc3 with the two patches.

IMO, it should be more easier to compare & investigate by focusing on
815c8e35511d, given there is only 41 patches between v6.19-rc5 and
commit 815c8e35511d.

> 
> Also, let us check a few things...
> 
> 1) Does bumping up sheaf capacity change the slab stats & IOPS?
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 0c906fefc31b..5207279417e2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -7611,13 +7611,13 @@ static unsigned int calculate_sheaf_capacity(struct kmem_cache *s,
>  	 * should result in similar lock contention (barn or list_lock)
>  	 */
>  	if (s->size >= PAGE_SIZE)
> -		capacity = 4;
> +		capacity = 6;
>  	else if (s->size >= 1024)
> -		capacity = 12;
> +		capacity = 24;
>  	else if (s->size >= 256)
> -		capacity = 26;
> +		capacity = 52;
>  	else
> -		capacity = 60;
> +		capacity = 120;
>  
>  	/* Increment capacity to make sheaf exactly a kmalloc size bucket */
>  	size = struct_size_t(struct slab_sheaf, objects, capacity);

IOPS can be increased from 24M to 29M with this patch, against 7.0-rc3 with
Vlastimil's today patchset.

> 
> 2) Is there any change in NUMA locality between v6.19 vs. v7.0-rc3 (patched)?
>    (e.g., measured via
>     perf stat -e node-loads,node-load-misses,node-stores,node-store-misses)

root@tomsrv:~/temp/mm/7.0-rc3/patched# perf stat -a -e node-loads,node-load-misses,node-stores,node-store-misses
Error:
No supported events found.
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (node-loads).
"dmesg | grep -i perf" may provide additional information.

Looks the events are not supported on AMD Zen4 machine.

> 
> 3) It's quite strange that blk_mq_sched_bio_merge() completely
>    disappeared in v7.0-rc2 profile [1] . Is there any change
>    in read/write io merge rate? (/proc/diskstats) between v6.19 and
>    v7.0-rc3?

It isn't strange.

Because IOPS drops to 13M on v7.0-rc2 from 34M on v6.19-rc5, so blk_mq_sched_bio_merge
can't be shown obviously, which code path is run for each bio(IO).

It is one totally random READ IO, and IO merge shouldn't happen.

Thanks, 
Ming

