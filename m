Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCD23081D9
	for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761296742; cv=none; b=GwHi9C1i76+JBtpr0PbNf07a1he0Kj268II7x5qNuCJIwySmI15rg75w2pxfdQnWsEbm+xONvx5iA/ZfQqEJaxcObNzRc7P1Q2C5QwDVATo/dmqAWXWK9ftNbs4TLnZ6HjFj/AXmuf6l5bH1UXPy0ASpk3rJLlDfDohXgwRyh7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761296742; c=relaxed/simple;
	bh=iUYPkBt1Tg0wFsAOiF61VtgBq6zfxQVqbgllsgApvLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcYsoXy/fP0qyaIyYRYR/y2/4HJifIFkTP9yUsjyxmIYmDKRt1wKongr1bCQ2iQDJUjsiduvR/19yTwQLqdbDkWK1IuAqA9YK/LZtmSFW+ygw3ebgHwV6aMIhXRos7otqsoqvGuMJP4lSbU+7KKpGQttW2Ba3N6qv5BhKPWkjYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D43BC227A8E; Fri, 24 Oct 2025 11:05:27 +0200 (CEST)
Date: Fri, 24 Oct 2025 11:05:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH 1/3] slab, block: generalize bvec_alloc_gfp
Message-ID: <20251024090527.GA27267@lst.de>
References: <20251023080919.9209-1-hch@lst.de> <20251023080919.9209-2-hch@lst.de> <50e96fd8-114b-4de3-939e-9ba606e64b06@suse.cz>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50e96fd8-114b-4de3-939e-9ba606e64b06@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 24, 2025 at 10:38:20AM +0200, Vlastimil Babka wrote:
> On 10/23/25 10:08, Christoph Hellwig wrote:
> > bvec_alloc_gfp is useful for any place that tries to kmalloc first and
> > then fall back to a mempool.  Rename it and move it to blk.h to prepare
> 
> I wonder if such fall backs are necessary because IIRC mempools try to
> allocate from the underlying provider (i.e. kmalloc caches first), and only
> give out the reserves when that fails. Is it done for less overhead or
> something?

That's the mempool behavior, yes.  But the bvec allocator only has a
mempool for the largest possible allocation, while usually trying
smaller allocations instead.

> 
> > for using it to allocate the default integrity buffer.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> That says blk.h but you move it to slab.h? Assuming you intended slab.h.

Yes.  I initially had it in blk.h, but it felt more general.

> However gfp flags are not slab only so it should be rather
> include/linux/gfp.h - added maintainers of that to Cc.

Ok.

> We do have gfp_nested_mask() there which is quite similar but not exactly.
> Maybe a canonical macro not for nested, but for opportunistic allocations
> (if a one size fits all solution can be found) would be useful too, as
> people indeed reinvent those manually in various places with subtle differences.

That's exactly what I've been trying to avoid indeed.
