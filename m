Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328623;
	b=ROXCgGM0iHRTKguOY4A2rtI+B46Z4NAfohcIM3/3MLRBFcsTLtfBB+hoFfDch1u9xpXq
	 TUSQvdAsI7BbJeGSZTpkR4mD6VFLhTq1lXxZ5eNiJJ7QOGbDoKx/xvz6XGoCZ5zf4Ujyx
	 I/NqqsiIqxuFbPsmbLDpiM024OZXTFy2vJ+rm2Yfj7oyuQsVsFcf5nAAKlpu3q2xP4dVh
	 HiJicigSZ4wITBXw7uGRf8WYwlVZE29ZLdj8f1aEpsB+yjwW/FyGpkmJMoSHrkx9xLUAu
	 pg5rbmd+5ZrcHh79NENoe0nUBRsbmnyuH+wsYP/ge3nDt6M6pdOTYcEFzSUBC5Wjsww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328623;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=oxH6nWu3xoi9MOLiEKHpTCtqocoY9P3KkSkL15dxQ2E=;
	b=5cqCJktj7+yYFws2p4bwzpsl5HBJYPUY8p+xUoVeEJlVDzRcheMaf+hxdqNQ6Wyto5zt
	 HbY1l73EOdSXt8O0liOPbau1j64Zu3M9YA0lOndgyKkzoAk2qtxEtLJl5C6SaaT3dYgrk
	 Iwva9bjtachM+Bt+kXiCwM7e7c6AHZlLxyS/Sm1AuzLJKPxSTffS3vnfRA/5NaJ7Tl0zk
	 XLAq7XQmhbOHzdOnDnq3PZ1cnsilCVEkE8FyYN10+c2IYJc4St+x3rRug5vVhtExRWbdr
	 10ahea0MepMGeYbHTt3imqmurshXWWA+eWX+SX92wfBBvbbxyOhhpo/UexlV2+7/XDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCuUCxkM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7BF606BAC1;
	Tue, 10 Nov 2026 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCuUCxkM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C401F0089F;
	Tue, 10 Nov 2026 16:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794328623;
	bh=oxH6nWu3xoi9MOLiEKHpTCtqocoY9P3KkSkL15dxQ2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mCuUCxkMSU402Oj1O0AMoMXQm08SgmKiJRj+2b6/XHGVUnUUUXvWULEFS4WoZNsLR
	 q0riXqwIPXhIfgRQQzOtH9ck1XgPYID22txx/TeeYcp8d3xHAjKkAdEV5vODmBE9rJ
	 kW0wp+vrT9yxRIU5e7kuSGyj4mVIGTC1Rk0Rh4+mntLl8ymXLwLUhuScL03XlmB3IR
	 E6MkXokc+rMzNoBDkKhYWVGuAdLQPKP3ImRQT/XnBZcHTXq3wFJ21TnQ+4Tzqg7tGf
	 CepsHdBR4s32iM9mHGZhzs5u1pXwjWJhKxGMxSGfI+8Q2TfelQPl+3nTox6JhAdRQf
	 2bGqrWSIgvdvA==
Date: Tue, 10 Nov 2026 16:37:01 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/11] zswap: do not free the entry if its pool is NULL
Message-ID: <avNIFZ0XVgOUdpDc@google.com>
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
 <20261110054836.1515030-8-senozhatsky@chromium.org>
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
In-Reply-To: <20261110054836.1515030-8-senozhatsky@chromium.org>

On Tue, Nov 10, 2026 at 02:48:12PM +0900, Sergey Senozhatsky wrote:
> zswap_entry_free() warns if the entry has no pool (which should never
> happen), skips zs_free() and then frees the entry.  A subsequent patch
> embeds zsmalloc handle into zswap_entry, so zsmalloc object will point
> to the entry, and we cannot free the entry while the object is still
> there.
> 
> Bail out early and leak the entry, its cgroup charge and stats instead.
> 
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: Yosry Ahmed <yosry@kernel.org>

> ---
>  mm/zswap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 1160bd34e289..dc0400d7e1a3 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -787,10 +787,11 @@ static void zswap_entry_free(struct zswap_entry *entry)
>  	struct zswap_pool *pool = zswap_entry_pool(entry);
>  
>  	zswap_lru_del(entry);
> -	if (!WARN_ON_ONCE(!pool)) {
> -		zs_free(pool->zs_pool, entry->handle);
> -		zswap_pool_put(pool);
> -	}
> +	if (WARN_ON_ONCE(!pool))
> +		return;
> +
> +	zs_free(pool->zs_pool, entry->handle);
> +	zswap_pool_put(pool);
>  	if (entry->objcg) {
>  		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
>  		obj_cgroup_put(entry->objcg);
> -- 
> 2.56.0.506.g506a7eabc5-goog
> 
