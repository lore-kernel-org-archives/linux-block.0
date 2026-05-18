Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4F539023C
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131948; cv=none; b=MmG75r5TAGon7+q8PbIh3dnvN5qmUJQ9BFNcstdlUVO10ezV3s6k0VF007tfWeOnoWkrirzfJFtI2wUtAZOxAHtM1RFRApeb+PTAAtx1fC/DGeNzPg6yaE4PfycKE40X6FE0rZB/HTCsitBnTwwmry4FFVOBhPD0X44mDmeNvz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131948; c=relaxed/simple;
	bh=YFhY9Oja0xAhwcMRPAQXvqvD2wPgo6bs4N5pZzlzYnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMWKkKeqgEVVpEEOUTTZNKB1CoNu2iVcQNmg74T1/zF7MaPFN5dSVtuBPYCcKAlpPHUMXps8AiO+trPY2QK76NPUTUyXbCyAOAORJNyBmZ7IKsxvHEdtRgJ6DQksxmBBUieB6b8bz+z6HWldlyhjnquBOozFfxe/dcgqmefUWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S80F7c+m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S80F7c+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08D7C2BCB7;
	Mon, 18 May 2026 19:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779131948;
	bh=YFhY9Oja0xAhwcMRPAQXvqvD2wPgo6bs4N5pZzlzYnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S80F7c+mti1+IVcR9v3yZYou2ZJvA0m+0kKFqoVk8SDHhFz/elHqlNuUsiuwy6DlG
	 F4x9ocvUIaxR8lHaGHZnN1/bVH3D9EjIhiuo8K95LlDJh4afT1GNgSKR7LkghVEo7F
	 gkudFyrL0XcFKDfmVVOY7uiGUMQridM7p8gswxczGozH9wFPw2DOm9OuDa+xyth37q
	 gO5BscQHsgRO5y2dbNPasEjnWT3FWbi5FTnsQIeoJrEOZzzXhja/HKEno8LjpZha64
	 lhQsYbK2mMyrnyATgq3gS7W4v1tQi69lhcNnViK6e7PMYQBQ3tlyxbMmUz/w7V1gnK
	 FUy9hehynJ2qw==
Date: Mon, 18 May 2026 09:19:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cuitao@kylinos.cn>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup-rwstat: add missing DISCARD counter in
 blkg_rwstat_total()
Message-ID: <agtmKyx4GqRQrftf@slm.duckdns.org>
References: <20260516044752.446995-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516044752.446995-1-cuitao@kylinos.cn>

On Sat, May 16, 2026 at 12:47:52PM +0800, Tao Cui wrote:
> Since commit 636620b66d5d ("blkcg: Track DISCARD statistics and output
> them in cgroup io.stat"), blkg_rwstat_add() routes discard IOs into
> BLKG_RWSTAT_DISCARD, but blkg_rwstat_total() still only sums READ and
> WRITE.  This makes the total inconsistent with the per-type counters
> whenever discard IOs are present.
> 
> On mixed read/write/discard workloads, the total undercounts the
> actual IO activity.  If only discard requests are queued, the total
> returns 0 outright.  In BFQ this causes avg_queue_size to be
> underestimated and the group to be incorrectly marked empty.
> 
> The affected BFQ code paths are all gated by CONFIG_BFQ_CGROUP_DEBUG
> and used only for statistics display (bfq.sectors, bfq.avg_queue_size,
> bfq.empty_time).  No scheduling decisions depend on these values.

I don't think including discard in total io amount is an improvement. This
will throw off a lot of people.

Thanks.

-- 
tejun
