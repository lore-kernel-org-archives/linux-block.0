Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA8A3793C5
	for <linux-block@vger.kernel.org>; Fri,  6 Mar 2026 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792578; cv=none; b=ABkB+BxkOYSO0uAdQ/X0TeDkLuKSesHRPieFn1TbScHWCxHa82RjcSbrQ32bWjjyoZyUGohiXaPCUc8G63fGCUjbTc6WkFfVqZcv3zo7uzPuVa7l8Mgz86eIV1sadrKeBoPhBQTQnZmgjuePs0B5SG1+tJ0ENTUTypsBVGluM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792578; c=relaxed/simple;
	bh=2qQ4LzEbYYQ/56bLAy3J6kSRAXAjZQGqcDGN1X7r0C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VY9G3caFzd9mibb8zoXXIHZudwpQDwnuT63ynCwl45S9NBEADwf1srb5yEU4OcaHbaARfeCRDlmW/euJrFGEvKsatU8zCMoA8/rr6gl0/Us2vM1rAGv2f1qCzYkub2Ls2PN/gzRFq6vrd0sjsEEJakiE/Xv48ytd8VirVSqJpQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U+hJSQzi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+hJSQzi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772792575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7tX/SD6EVQ4Rky93nE+4JayZQSa6Ld0wpdeMJeB4Y+k=;
	b=U+hJSQzic+koNC7bRekzR2KpltIHQ/jv7MTiPS9VytUWuZmRvWjymv43QE+aF3N/Iug0eC
	SJzUz0msJ1rRoaJM7hT29H/yVoW7RzwoLyYzpzGK4nJ95mD0FnQJ6L4DuEdsAyTDtaAfeh
	0E+GQHzPV3v27sAmBfdkGdGGMdEA5BE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-rqhmoTM9OGy0XfnfP41-7A-1; Fri,
 06 Mar 2026 05:22:54 -0500
X-MC-Unique: rqhmoTM9OGy0XfnfP41-7A-1
X-Mimecast-MFC-AGG-ID: rqhmoTM9OGy0XfnfP41-7A_1772792572
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF6011956096;
	Fri,  6 Mar 2026 10:22:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.21])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6459B1955D71;
	Fri,  6 Mar 2026 10:22:42 +0000 (UTC)
Date: Fri, 6 Mar 2026 18:22:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry.yoo@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Hao Li <hao.li@linux.dev>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <aaqq7YmUcOht3GWH@fedora>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <5cf75a95-4bb9-48e5-af94-ef8ec02dcd4d@suse.cz>
 <724310c2-46a2-4410-8a5d-c69dcc8de35d@kernel.org>
 <aZ7BbosIr2FvZFAe@fedora>
 <c6a01f7e-c6eb-454b-9b9e-734526dd659d@kernel.org>
 <aapeVb_L5zohWRRe@hyeyoo>
 <d5cd4eb4-1703-41af-9c71-842ae33edbdf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5cd4eb4-1703-41af-9c71-842ae33edbdf@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Mar 06, 2026 at 09:47:27AM +0100, Vlastimil Babka (SUSE) wrote:
> On 3/6/26 05:55, Harry Yoo wrote:
> > On Thu, Feb 26, 2026 at 07:02:11PM +0100, Vlastimil Babka (SUSE) wrote:
> >> On 2/25/26 10:31, Ming Lei wrote:
> >> > Hi Vlastimil,
> >> > 
> >> > On Wed, Feb 25, 2026 at 09:45:03AM +0100, Vlastimil Babka (SUSE) wrote:
> >> >> On 2/24/26 21:27, Vlastimil Babka wrote:
> >> >> > 
> >> >> > It made sense to me not to refill sheaves when we can't reclaim, but I
> >> >> > didn't anticipate this interaction with mempools. We could change them
> >> >> > but there might be others using a similar pattern. Maybe it would be for
> >> >> > the best to just drop that heuristic from __pcs_replace_empty_main()
> >> >> > (but carefully as some deadlock avoidance depends on it, we might need
> >> >> > to e.g. replace it with gfpflags_allow_spinning()). I'll send a patch
> >> >> > tomorrow to test this theory, unless someone beats me to it (feel free to).
> >> >> Could you try this then, please? Thanks!
> >> > 
> >> > Thanks for working on this issue!
> >> > 
> >> > Unfortunately the patch doesn't make a difference on IOPS in the perf test,
> >> > follows the collected perf profile on linus tree(basically 7.0-rc1 with your patch):
> >> 
> >> what about this patch in addition to the previous one? Thanks.
> >> 
> >> ----8<----
> >> From d3e8118c078996d1372a9f89285179d93971fdb2 Mon Sep 17 00:00:00 2001
> >> From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
> >> Date: Thu, 26 Feb 2026 18:59:56 +0100
> >> Subject: [PATCH] mm/slab: put barn on every online node
> >> 
> >> Including memoryless nodes.
> >> 
> >> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> >> ---
> > 
> > Just taking a quick grasp...
> > 
> >> @@ -6121,7 +6122,8 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
> >>  	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
> >>  		return;
> >>  
> >> -	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id())
> >> +	if (likely(!IS_ENABLED(CONFIG_NUMA) || (slab_nid(slab) == numa_mem_id())
> >> +			|| !node_isset(slab_nid(slab), slab_nodes))
> > 
> > I think you intended !node_isset(numa_mem_id(), slab_nodes)?
> > 
> > "Skip freeing to pcs if it's remote free, but memoryless nodes is
> >  an exception".
> 
> Indeed, thanks! Ming, could you retry with that fixed up please?

After applying the following change, IOPS is ~25M:

- delta change on the two patches

diff --git a/mm/slub.c b/mm/slub.c
index 085fe49eec68..56fe8bd956c0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6142,7 +6142,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
                return;
 
        if (likely(!IS_ENABLED(CONFIG_NUMA) || (slab_nid(slab) == numa_mem_id())
-                       || !node_isset(slab_nid(slab), slab_nodes))
+                       || !node_isset(numa_mem_id(), slab_nodes))
            && likely(!slab_test_pfmemalloc(slab))) {
                if (likely(free_to_pcs(s, object, true)))
                        return;


- slab stat on patched `815c8e35511d Merge branch 'slab/for-7.0/sheaves' into slab/for-next`

# (cd /sys/kernel/slab/bio-256/ && find . -type f -exec grep -aH . {} \;)
./remote_node_defrag_ratio:100
./total_objects:7395 N1=3876 N5=3519
./alloc_fastpath:507619662 C0=70 C1=27608632 C3=28990301 C5=35098386 C6=9 C7=35782152 C8=115 C9=31757274 C10=32 C11=30087065 C12=34 C13=31615065 C14=7 C15=31798233 C17=30695955 C18=128 C19=32204853 C20=64 C21=36842392 C23=36212376 C25=30013640 C27=29055001 C29=29990232 C30=48 C31=29867595 C36=2 C50=1
./cpu_slabs:0
./objects:7232 N1=3816 N5=3416
./sheaf_return_slow:0
./objects_partial:500 N1=195 N5=305
./sheaf_return_fast:0
./cpu_partial:0
./free_slowpath:20 C4=20
./barn_get_fail:260 C1=6 C3=26 C5=26 C7=7 C9=5 C10=2 C11=26 C12=2 C13=10 C14=1 C15=19 C17=8 C18=5 C19=19 C20=1 C21=9 C23=22 C25=11 C27=21 C29=26 C31=6 C36=1 C50=1
./sheaf_prefill_oversize:0
./skip_kfence:0
./min_partial:5
./order_fallback:0
./sheaf_capacity:28
./sheaf_flush:28 C24=28
./free_rcu_sheaf:0
./sheaf_alloc:178 C0=4 C2=9 C3=1 C4=9 C5=65 C6=4 C8=5 C10=8 C11=1 C12=4 C13=1 C14=8 C15=1 C16=5 C18=8 C19=1 C20=3 C22=10 C23=1 C24=5 C25=1 C26=7 C27=1 C28=10 C29=1 C30=2 C31=1 C36=1 C50=1
./sheaf_free:0
./sheaf_prefill_slow:0
./sheaf_prefill_fast:0
./poison:0
./red_zone:0
./free_slab:0
./slabs:145 N1=76 N5=69
./barn_get:18129029 C0=3 C1=986017 C3=1035342 C5=1253488 C6=1 C7=1277927 C8=5 C9=1134184 C11=1074513 C13=1129100 C15=1135633 C17=1096277 C19=1150155 C20=2 C21=1315791 C23=1293278 C25=1071905 C27=1037658 C29=1071054 C30=2 C31=1066694
./alloc_slowpath:0
./destroy_by_rcu:1
./free_rcu_sheaf_fail:0
./barn_put:18129105 C0=986015 C2=1035357 C4=1253502 C6=1277924 C8=1134182 C10=1074529 C12=1129101 C14=1135641 C16=1096273 C18=1150168 C20=1315792 C22=1293288 C24=1071905 C26=1037668 C28=1071069 C30=1066691
./usersize:0
./sanity_checks:0
./barn_put_fail:1 C24=1
./align:64
./alloc_node_mismatch:0
./alloc_slab:145 C1=3 C3=19 C5=6 C7=3 C9=3 C10=2 C11=18 C12=2 C13=6 C14=1 C15=12 C17=8 C18=3 C19=12 C21=2 C23=5 C25=7 C27=12 C29=15 C31=4 C36=1 C50=1
./free_remove_partial:0
./aliases:0
./store_user:0
./trace:0
./reclaim_account:0
./order:2
./sheaf_refill:7280 C1=168 C3=728 C5=728 C7=196 C9=140 C10=56 C11=728 C12=56 C13=280 C14=28 C15=532 C17=224 C18=140 C19=532 C20=28 C21=252 C23=616 C25=308 C27=588 C29=728 C31=168 C36=28 C50=28
./object_size:256
./free_fastpath:507615526 C0=27608438 C2=28990052 C4=35098103 C6=35781903 C8=31757101 C10=30086841 C12=31614841 C14=31797983 C16=30695700 C18=32204722 C19=1 C20=36842201 C22=36212117 C24=30013416 C26=29054742 C28=29989974 C30=29867383 C31=4 C39=2 C47=2
./hwcache_align:1
./cmpxchg_double_fail:0
./objs_per_slab:51
./partial:13 N1=5 N5=8
./slabs_cpu_partial:0(0)
./free_add_partial:117 C1=3 C3=7 C5=19 C7=4 C9=2 C11=8 C13=4 C15=7 C18=2 C19=7 C20=1 C21=7 C23=17 C24=3 C25=4 C27=9 C29=11 C31=2
./slab_size:320
./cache_dma:0





Thanks,
Ming

