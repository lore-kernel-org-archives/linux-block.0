Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796F83A8751
	for <linux-block@vger.kernel.org>; Tue,  3 Mar 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549955; cv=none; b=pvGrRgYZuKAhwmmlAHbEe77nvOx0VJ7MBF7PtxtvvOqy9h5CCGpoEf0JaMxluYu1MYHwPYChZJpQNIqFG27pzGbDHzKJIcLQVEK4MbiqbymPlJocU33M7F0ArVQCC76108g+DfRls0RkuOxes43hDTzbNSXuCAqbo3AdkNGHSGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549955; c=relaxed/simple;
	bh=bXbsTlnyOl69D8NqlmKPurDJiOFu5wpqzkEn0HNdUP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjsG+u4hihRNXw9BMJ9sHI4CBlf2J8RHkOb/r69/oJtm7vzMysychochmryH4FgoHRhkA73ff/u9/q7+c50nZTWd6ERtFQ7EVNvoysdgDx7ou5Xskj6Rpb2JKpsxatoBurPzRwWXyRYwMQRfE0f0BeEfTFw52ckY+4uNMSLRnTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mFuZEJ40; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mFuZEJ40"
Date: Tue, 3 Mar 2026 06:59:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772549951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LzzRBFY4XpGoGT9xNiopMMRuAAFFoqywP6b/pmzvCT0=;
	b=mFuZEJ40pKY9dBp8jvbCyRxSoBDKPYlDZPoxXtHml753XhNsEB1+BHk4z/zASW7oSWSXBh
	o0ZGKNEl53FiGxD372/ksHrfRAcq3fZleJC3Jntw6vxaLZPrRHKZGvDRjmLWZNoeA4Frda
	x/lt3ZWUs6RcXWVLrqeFOM7M0CqrKGc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>, roman.gushchin@linux.dev
Subject: Re: [RFC PATCH 0/1] mm: Reduce direct reclaim stalls with RAM-backed
 swap
Message-ID: <aab0AFAgAzBi4jO6@linux.dev>
References: <20260303115358.1323188-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303115358.1323188-1-matt@readmodwrite.com>
X-Migadu-Flow: FLOW_OUT

Hi Matt,

Thanks for the report and one request I have is to avoid cover letter for a
single patch to avoid partitioning the discussion.

On Tue, Mar 03, 2026 at 11:53:57AM +0000, Matt Fleming wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> Hi,
> 
> Systems with zram-only swap can spin in direct reclaim for 20-30
> minutes without ever invoking the OOM killer. We've hit this repeatedly
> in production on machines with 377 GiB RAM and a 377 GiB zram device.
> 

Have you tried zswap and if you see similar issues with zswap?

> The problem
> -----------
> 
> should_reclaim_retry() calls zone_reclaimable_pages() to estimate how
> much memory is still reclaimable. That estimate includes anonymous
> pages, on the assumption that swapping them out frees physical pages.
> 
> With disk-backed swap, that's true -- writing a page to disk frees a
> page of RAM, and SwapFree accurately reflects how many more pages can
> be written. With zram, the free slot count is inaccurate. A 377 GiB
> zram device with 10% used reports ~340 GiB of free swap slots, but
> filling those slots requires physical RAM that the system doesn't have
> -- that's why it's in direct reclaim in the first place.
> 
> The reclaimable estimate is off by orders of magnitude.
> 

Over the time we (kernel MM community) have implicitly decided to keep the
kernel oom-killer very conservative as adding more heuristics in the reclaim/oom
path makes the kernel more unreliable and punt the aggressiveness of oom-killing
to the userspace as a policy. All major Linux deployments have started using
userspace oom-killers like systemd-oomd, Android's LMKD, fb-oomd or some
internal alternatives. That provides more flexibility to define the
aggressiveness of oom-killing based on your business needs.

Though userspace oom-killers are prone to reliability issues (oom-killer getting
stuck in reclaim or not getting enough CPU), so we (Roman) are working on adding
support for BPF based oom-killer where wen think we can do oom policies more
reliably.

Anyways, I am wondering if you have tried systemd-oomd or some userspace
alternative. If you are interested in BPF oom-killer, we can help with that as
well.

thanks,
Shakeel
