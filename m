Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1D838E5D8
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011908; cv=none; b=DKnktbULquXPl4NSPp2w3LeiXqPT4nol9IFFB5CScUn2i179pqLWzAWbZZnlvQtETQ4XNXaNfgqJgnpn9Ro1I4SE2G7R0dW/62lOjGJ9t/tK7lwB69Ao4TiaLRBi4cn89pEVOOdiFD0NQAzbzY/98DzonB5oa1fGpocHDB9wR58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011908; c=relaxed/simple;
	bh=128L0tf7bk1XB7auGcc2eBBTEozaf+vPJ2wOgbsqp5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndKbptBKGoVCLBZG8Wk6Uy3PNnLXSxG2OcMPe/+72goguvtjdS1U7AzBmIlOBy1Z7BEsM2hDbw/9NZMOhQpoit3Hw8oVUqFeOKhJAt7TmF2TtygC8H0GW4kGURhVhbM5bBP74yt1CUZAX04C3c1vIx04g4rxuIhPO++sfuqeTEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZh1JsHI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZh1JsHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772011906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GZZSjVez67bmnK2NRSU6UxlSzwwe3Q6UiGHwSsR6W2A=;
	b=gZh1JsHICy2j+rsBgpwliJ+lT1QCq2ZSLOmccQP7rVOcBmJWsn4YJjeoSzIcgMMmV8zBf0
	VrGtbQFEYxxKYtYa+62mdxvl5rq4+CmjRHe3B9SN8wFNdmEab5Y5OYqUZ8kxOEqdbeNbmP
	ctk58L3mZqkQEyAxK/0t5g3QrFxPokM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-WT7Mkpl-O2ya_WKqO2WGQw-1; Wed,
 25 Feb 2026 04:31:41 -0500
X-MC-Unique: WT7Mkpl-O2ya_WKqO2WGQw-1
X-Mimecast-MFC-AGG-ID: WT7Mkpl-O2ya_WKqO2WGQw_1772011899
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 567DF195605F;
	Wed, 25 Feb 2026 09:31:39 +0000 (UTC)
Received: from fedora (unknown [10.72.116.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB2921955F43;
	Wed, 25 Feb 2026 09:31:31 +0000 (UTC)
Date: Wed, 25 Feb 2026 17:31:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Harry Yoo <harry.yoo@oracle.com>, Hao Li <hao.li@linux.dev>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <aZ7BbosIr2FvZFAe@fedora>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <5cf75a95-4bb9-48e5-af94-ef8ec02dcd4d@suse.cz>
 <724310c2-46a2-4410-8a5d-c69dcc8de35d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <724310c2-46a2-4410-8a5d-c69dcc8de35d@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Vlastimil,

On Wed, Feb 25, 2026 at 09:45:03AM +0100, Vlastimil Babka (SUSE) wrote:
> On 2/24/26 21:27, Vlastimil Babka wrote:
> > 
> > It made sense to me not to refill sheaves when we can't reclaim, but I
> > didn't anticipate this interaction with mempools. We could change them
> > but there might be others using a similar pattern. Maybe it would be for
> > the best to just drop that heuristic from __pcs_replace_empty_main()
> > (but carefully as some deadlock avoidance depends on it, we might need
> > to e.g. replace it with gfpflags_allow_spinning()). I'll send a patch
> > tomorrow to test this theory, unless someone beats me to it (feel free to).
> Could you try this then, please? Thanks!

Thanks for working on this issue!

Unfortunately the patch doesn't make a difference on IOPS in the perf test,
follows the collected perf profile on linus tree(basically 7.0-rc1 with your patch):

```
04cb971e2d28 (HEAD -> master) mm:slab/sheaves: severe performance regression in cross-CPU slab allocation
a5a9cf3f020f mm: fix NULL NODE_DATA dereference for memoryless nodes on boot
7dff99b35460 (origin/master) Remove WARN_ALL_UNSEEDED_RANDOM kernel config option
551d44200152 default_gfp(): avoid using the "newfangled" __VA_OPT__ trick
6de23f81a5e0 (tag: v7.0-rc1) Linux 7.0-rc1
```

+   49.03%     2.00%  io_uring         [kernel.kallsyms]       [k] __blkdev_direct_IO_async
-   38.66%     1.16%  io_uring         [kernel.kallsyms]       [k] bio_alloc_bioset
   - 37.51% bio_alloc_bioset
      - 34.98% mempool_alloc_noprof
         - 34.87% kmem_cache_alloc_noprof
            - 33.82% ___slab_alloc
               - 30.25% get_from_any_partial
                  - 29.59% get_from_partial_node
                     - 28.42% __raw_spin_lock_irqsave
                          native_queued_spin_lock_slowpath
               + 2.16% allocate_slab
               + 0.60% alloc_from_new_slab
              0.51% __pcs_replace_empty_main
        1.58% bio_associate_blkg
   + 1.16% submitter_uring_fn
+   35.16%     0.30%  io_uring         [kernel.kallsyms]       [k] kmem_cache_alloc_noprof
+   35.13%     0.12%  io_uring         [kernel.kallsyms]       [k] mempool_alloc_noprof


Thanks,
Ming

