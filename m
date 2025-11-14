Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ACC3D3B3;
	Fri, 14 Nov 2025 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763147678; cv=none; b=N0qBQ2QySTt2c0DXmm9Ij8tBlDHujW05v8VDScjsbZf1Fbms5u/Ap0PqsjUsKTsjQLe+ObVN91xmVDkpen9nZiv7cHSAfMgJPcacBIJnMQk28yneduXiBdd/q4QqHju1Nx//R112YnyLgHONAazrzboj5e4vKDKKCSZiMwtRR/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763147678; c=relaxed/simple;
	bh=My3Y9e3ducF2mohQ2n4aoCRXOn2E/nZUqXPJKHyG7oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLbBzd5wRDqDVj5ZdTssktJ2KslxSt+mG9hFVQqYpIaZRDFiCn8SOPunB/YtOtTSGUWxaHO/nCqI6NM5PncFO1fn3YuXnAcuYN8zGi6Oul5hUi7A9Hdc8ZomdtAB0gmP1o7Z/zzk6fvKflK8HzVau/fu7lGGU7qcIXMlDGIuiJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKERhunL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKERhunL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CB8C19421;
	Fri, 14 Nov 2025 19:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763147678;
	bh=My3Y9e3ducF2mohQ2n4aoCRXOn2E/nZUqXPJKHyG7oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKERhunLvJBf9Z+pbC7lExPnhNqVDAAUA4VZjjsu7qvwJWLy7uerCBO1ZSONctBjS
	 hWlS3AbPZi0vH4bImRuWfjtMpNAO6ahOISB1d4BDZk/qGCSzhFeZm7XfThua/Vl3fy
	 8NonjbGkjsMPPuFWPUpaz/G/jCWYNG/rosXtdp4BhO0PMoJYGiD36+8j2BJV34eHnL
	 xVNHeomBCbHCR2MId6g62VCpDXCQjRR6EmS8x8Afi8oEeDIlGw1pSVAq/r7y3a4kl3
	 cMNAswUjrj6Mw5XGfiM+B/3xXQtxpTvPVw7e06/V3cgiKg40/wckRuM0tVoSQ5QcTV
	 Vk5glnzTKWbmw==
Date: Fri, 14 Nov 2025 11:14:35 -0800
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>,
	Brian Geffon <bgeffon@google.com>, Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv2 1/4] zram: introduce writeback bio batching support
Message-ID: <aRd_m00a6AcVtDh0@google.com>
References: <20251113085402.1811522-1-senozhatsky@chromium.org>
 <20251113085402.1811522-2-senozhatsky@chromium.org>
 <aRZttTsRG1cZoovl@google.com>
 <rjowf2hdk7pkmqpslj6jaqm6y4mhvr726dxpjyz7jtcjixv3hi@jyah654foky4>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rjowf2hdk7pkmqpslj6jaqm6y4mhvr726dxpjyz7jtcjixv3hi@jyah654foky4>

On Fri, Nov 14, 2025 at 10:53:23AM +0900, Sergey Senozhatsky wrote:
> On (25/11/13 15:45), Minchan Kim wrote:
> [..]
> > > +struct zram_wb_req {
> > > +	unsigned long blk_idx;
> > > +	struct page *page;
> > >  	struct zram_pp_slot *pps;
> > >  	struct bio_vec bio_vec;
> > >  	struct bio bio;
> > > -	int ret = 0, err;
> > > +
> > > +	struct list_head entry;
> > > +};
> > 
> > How about moving structure definition to the upper part of the C file?
> > Not only readability to put together data types but also better diff
> > for reviewer to know what we changed in this patch.
> 
> This still needs to be under #ifdef CONFIG_ZRAM_WRITEBACK so readability
> is not significantly better.  Do you still prefer moving it up?

Let's move them on top of ifdef CONFIG_ZRAM_WRITEBACK, then.
IOW, above of writeback_limit_enable_store.

> 
> [..]
> 
> > > +/* XXX: should be a per-device sysfs attr */
> > > +#define ZRAM_WB_REQ_CNT 1
> > 
> > Understand you will create the knob for the tune but at least,
> > let's introduce default number for that here.
> > 
> > How about 32 since it's general queue depth for modern storage?
> 
> So this is tricky.  I don't know what number is a good default for
> all, given the variety of devices out there, variety of specs and
> hardware, on both sides of price range.  I don't know if 32 is safe
> wrt to performance/throughput (I may be wrong and 32 is safe for
> everyone).  On the other hand, 1 was our baseline for ages, so I
> wanted to minimize the risks and just keep the baseline behavior.
> 
> Do you still prefer 32 as default?  (here and in the next patch)

Yes, we couldn't get the perfect number everyone would be happpy
since we don't know their configuration but the value is the
typical UFS 3.1(even, it's little old sice UFS has higher queue depth)'s
queue depth. More good thing with the 32 is aligned with SWAP_CLUSTER_MAX
which is the unit of batching in the traditional split LRU reclaim.

Assuming we don't encounter any significant regressions, I'd like to
move forward with a queue depth of 32 so that all users can benefit from
this speedup.

> 
> [..]
> > > +	for (i = 0; i < ZRAM_WB_REQ_CNT; i++) {
> > > +		struct zram_wb_req *req;
> > > +
> > > +		/*
> > > +		 * This is fatal condition only if we couldn't allocate
> > > +		 * any requests at all.  Otherwise we just work with the
> > > +		 * requests that we have successfully allocated, so that
> > > +		 * writeback can still proceed, even if there is only one
> > > +		 * request on the idle list.
> > > +		 */
> > > +		req = kzalloc(sizeof(*req), GFP_NOIO | __GFP_NOWARN);
> > 
> > Why GFP_NOIO?
> > 
> > > +		if (!req)
> > > +			break;
> > > +
> > > +		req->page = alloc_page(GFP_NOIO | __GFP_NOWARN);
> > 
> > Ditto
> 
> So we do this for post-processing, which allocates a bunch of memory
> for post-processing (not only requests lists with physical pages, but
> also candidate slots buckets).  The thing is that post-processing can
> be called under memory pressure and we don't really want to block and
> reclaim memory from the path that is called to relive memory pressure
> (by doing writeback or recompression).

Sorry, I didn't understand what's the post-processing means.

First, this writeback_store path is not critical path. Typical usecase
is trigger the writeback store on system idle time to save zram memory.

Second, If you used the flag to relieve memory pressure, that's not
the right flag. GFP_NOIO aimed to prevent deadlock with IO context
but the writeback_store is just process context so no reason to use
the GFP_NOIO. (If we really want to releieve memory presure, we
should use __GFP_NORETRY with ~__GFP_RECLAIM but I doubt)


> 
> > > +		if (!req->page) {
> > > +			kfree(req);
> > > +			break;
> > > +		}
> > > +
> > > +		INIT_LIST_HEAD(&req->entry);
> > 
> > Do we need this reset?
> 
> Let me take a look.
> 
> > > +static void zram_account_writeback_rollback(struct zram *zram)
> > > +{
> > > +	spin_lock(&zram->wb_limit_lock);
> > > +	if (zram->wb_limit_enable)
> > > +		zram->bd_wb_limit +=  1UL << (PAGE_SHIFT - 12);
> > > +	spin_unlock(&zram->wb_limit_lock);
> > > +}
> > > +
> > > +static void zram_account_writeback_submit(struct zram *zram)
> > > +{
> > > +	spin_lock(&zram->wb_limit_lock);
> > > +	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
> > > +		zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
> > > +	spin_unlock(&zram->wb_limit_lock);
> > > +}
> > 
> > I didn't think about much about this that we really need to be
> > accurate like this. Maybe, next time after coffee.
> 
> Sorry, not sure I understand this comment.

I meant I didn't took close look the part, yet. :)
