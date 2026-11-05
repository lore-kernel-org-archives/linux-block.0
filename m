Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899889;
	b=CrtSaAPMdMlhlHt4Jznd9+7ABjj0IrFrjAjG9lXOIYdDKGHsppODZTJMFaAfetAuevwN
	 KDzca7CkQxXZ45i3KQ9mNu5/VQ3ssnBgbAkoKgn5c6M+3N76AlC4s++Fc2UalEWJM0NcF
	 AGsT7Z06sRpH6y0Eip0hJSJwYNm9aR3gvJr3RdLbSseubAop+sEIeRcez0AyqJFZb8OA3
	 Kd0UirJstUF/B2HezIVmLU21rF4dTB2q+z+Voim7bi9A4TxsxM56HwXJ48va/KkrqneAz
	 mhADy+1Mc/69hR+442FF6SQnSCNYZQ17vnxOQOeQP2nphqZXzxa85qVvSbHT563S7rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899889;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TcMbrvUa/Jn6BjKU7oUBvEJq/dCe8gc8v1fptJk89gU=;
	b=N0iXWveEVfgJC2MWSfuhJZJx/s0BqCVbuBdNpPnoxG74TuwkRNEO3fvQEKDa63zS422g
	 Hw5Q6j3Ft/+m/e9cCzrClcquA6grPT29mm2NOZwvrxa2KazqtVHzTMONo8vEgle6VElbi
	 g9vEeLb7wIUZVJDe7als/KK3r52vUdZ+I7J+TwKGWaM2pXSScgz/9Jwr/+62rp3Ir7zRW
	 XGuoJgCDYpeaBgL8GLm27lRRZ6d2HPC9Qq7Ac4QkVnx5RXTuKy8fQNRKuZSSm2uqpgRXO
	 YmM1HZSAZM3jG0O4dzVKb9vS6ecUQ4TwUptiIrsElfJ76YcuScjNIetaNEE5kMmbrfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWxQCPN5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E58606A326;
	Thu,  5 Nov 2026 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWxQCPN5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D707E1F000C1;
	Thu,  5 Nov 2026 17:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793899888;
	bh=TcMbrvUa/Jn6BjKU7oUBvEJq/dCe8gc8v1fptJk89gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jWxQCPN55VFFys0nT754bQjrRCw1asZfajfVXdgWkVrrDspEBVBXI/6ArGw5i2i1I
	 oCvAeLM4QUKgS+QsnAvC44mvCYCzDfs94C0QEAbU4L2MWmUjs+QOAIPNe7ZEXDpGHg
	 eHOLgZaDHxULDAbgQf2eJb2pVK2rg+w6NYNqXden45j7vvuHcJvmEsVRY3KsswPP3f
	 pIdgDXsC0r9xESnq7WChd9U/jBCnIHTzRbSRgMcxMgYEShTdLyZPzsXbQId9fvTWLP
	 BIGOfiACG11lPr5e9CIDGnv1vEcVlMuA7YR8MTTOR5x2t6cY2Z+aSAZlkd5js2rp3m
	 rQapNtqIzirjw==
Date: Thu, 5 Nov 2026 17:31:26 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/7] zsmalloc: redesign object alloc API
Message-ID: <auy9UfB30AlYabV8@google.com>
References: <20261105044752.1997895-1-senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105044752.1997895-1-senozhatsky@chromium.org>

On Thu, Nov 05, 2026 at 01:47:30PM +0900, Sergey Senozhatsky wrote:
> Both zram and zswap already have per-entry structures that store zsmalloc
> handles, so allocating a separate handle_cachep object per stored page is
> redundant.  This series embeds struct zs_handle directly into zram and
> zswap entries and drops handle_cachep, saving 8 bytes and a slab
> alloc/free per stored object (2MB per 1GB of swapped out 4K pages).

I always hated that extra layer of indirection, thanks for doing this!

> 
> It also folds zs_malloc() and zs_obj_write() into zs_store() so we don't
> take pool->lock and look up object location again right after allocation.
> 
> A simple zram test on a 24-vCPU VM
> ==================================
> 165 fewer kernel instructions and 0.7-1.8% fewer kernel cycles per write;
> lz4 single writer +2.3% IOPS / -2.6% average latency;
> 24 writers +0.9-+1.0% IOPS; no regressions.
> Memory: 8 bytes less per stored page.
> 
> Sergey Senozhatsky (7):
>   zram: drop stale comment in write_incompressible_page()
>   zram: drop get_slot_handle() and set_slot_handle()
>   zsmalloc: switch handle type to struct zs_handle
>   zram: allocate zsmalloc object under slot lock
>   zsmalloc: embed struct zs_handle into zram and zswap entries
>   zsmalloc: fold zs_obj_write() into zs_store()
>   zsmalloc: constify struct zs_handle pointer in read-only functions
> 
>  Documentation/admin-guide/mm/slab.rst        |   2 +-
>  Documentation/core-api/memory-allocation.rst |   2 +-
>  Documentation/mm/zsmalloc.rst                |   8 +-
>  drivers/block/zram/Kconfig                   |   1 +
>  drivers/block/zram/zram_drv.c                | 130 +++++-------
>  drivers/block/zram/zram_drv.h                |  10 +-
>  include/linux/zsmalloc.h                     |  37 +++-
>  mm/Kconfig                                   |   3 +
>  mm/zsmalloc.c                                | 204 +++++++++++--------
>  mm/zswap.c                                   |  21 +-
>  10 files changed, 229 insertions(+), 189 deletions(-)
> 
> -- 
> 2.56.0.398.g882cbad275-goog
> 
> 
