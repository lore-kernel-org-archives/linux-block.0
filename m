Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D7238D687
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260203; cv=none; b=L1dz3zyAkqgPITgzIgjOpckaVn0QrcrUBCKy2BV7HtDLeQU31lr3HSJqaiTdRJuKOURXu142gwagvhr3x3sCb5B1po8g1X2/ntO5eqNDuUUmxiNOv4a8+33oj91lUgrPhnd78jZ+cnbA06psRjizbdwjvQKRkknYpfsCwXn9TFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260203; c=relaxed/simple;
	bh=PuLwnBc+8QrXgnn/i9pHH//tTmzGBq3UlkUOmAGXElM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNy4HqmzxP1xdJrUvl12qkiv2b/22AG3kHaPATNgto9WyYUommbROKJkMQ/jImCJ1yFNBd/P04Uly208pIGvdh8RcfOaytHq6yO65+sLeQU0RFLDz0JaRlb0YiRw+zguduaaKa3jl53i7Eyiv1siYf31o6G8cklhDA4Nd3DQFjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Cqtrehr8; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="Cqtrehr8"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89a05955720so3514076d6.2
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 13:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1773260199; x=1773864999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtZj6h5RyCLZcb3faEPHDRcPqrY2sHgdB5FkBVVnG2Y=;
        b=Cqtrehr89QNFZltz5dcsMDHD/N4ccIP040MjrxLFZ3cehW0DAo1BYhdBlequD5a2CK
         t/yMPJtHU64wrl9xTcdhttyhNTDJSkwaE9hfNcjVhlgxwEylZrqIpdMYH7LSb07SL6Fx
         93UshpDza5F/C1pZLmS/TJX2jhyOuDVbYQiXXYAUbbOsEzLvJ75Q2g1vu/Ia9ekuSV/J
         t4lr6gMoSY3FMoGMwdvX0ztYl5OZDTTxJwldL3FylZu5gwIE1yYkdoFu1uRI0tAeNP5t
         VcUQwhrz8BaW2oMA636m37p1YLw03OJEQm1nUDxPAxO3PljI+7s3VcRFHkh/KNzd938f
         br9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773260199; x=1773864999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtZj6h5RyCLZcb3faEPHDRcPqrY2sHgdB5FkBVVnG2Y=;
        b=aEFw0DevRuKMSeOt0ZkrJyzcQcEWQ3TUynANdS3CaWtHM7yeOslRT3tAxmjXTWbuS3
         ZIJhar4WLsrHIL5hGHS4B1JSUQroumCe8Yt3+7ChozG3Yw+XeNoBbi7DU97uh26W57sd
         /0YDqzjH9eDxVVuHUEltpJ7BD042F9TtyzL5TYWw1+Ei0RKRTA0FSzlUBCz7Df/YIE7c
         fjd+7H7W9UmDXXGusG40rUL1voJejXEpvFU8sBVankabLzQoASY+YyfYp/XbGaCFckgL
         s+iJS2khZchn0gDol2Andt1G7RKeHxcJuJ9Ex7AWK21vd+w44YcSaG6FK5MbNTFgwmbG
         7EYg==
X-Forwarded-Encrypted: i=1; AJvYcCW7YqFhp48SZ6uPJfzVByJ5fQAD58pBxNiJ0WSWiOkfn4FtmqY2atBewDsULhimzToxdb6jfNO5IJQPPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPLGjUob+8fRmD3SCc/Shweq3ajMEGolwNAILqHzhI6xqEFXd3
	8peDUqBkV1ZnL2Wiys7ggp9v8U+3q5YGx7ZNd2W+++SLdNcPvEoCqunQiFS/L3T1oUc=
X-Gm-Gg: ATEYQzz2b/0WHDn1kouR07pQ/AwR9HJRBzgE6zmff/0FgSM4vUnF6t3sve2HOruzJ3q
	1Fdz+vHr7HJYBeqFMPG+Sf0XUlc+03b3U1Jb708XZ61ds0afHwN4VlJJWyRc376US35Y2rf0RTF
	vgjLwJYfzVhKN1eypOraxQ+4tz5OOidyjsflAZkLTwHE/9nR5v9p0GmvlCzoTVVSTlbyXK8i/7Z
	P/Z0Twz+LQxcpLlD0YfkvPD4Xea4jp7oRrIVdE+qGW7SKnqEu6OPXrvIfoBhFuJRt6RFmtVDC3y
	iD/IlsCU2tsAZe3QLpIA7btcQwXWYO07bX2ubjhFEBPIa3W0lIDOUiQtMqrhGpki0TNpyOheqz0
	6ALczJqADgtj0ExuScO1CEBRXdj2pL5tbAYCE7CImeOf1XsZiYCPvSRl2knEO5TTP/tvcWHcJC0
	YkIZB8eMXXRxYpDY5YyvV5lg==
X-Received: by 2002:a05:6214:3003:b0:89a:110f:894a with SMTP id 6a1803df08f44-89a669c4812mr51524686d6.12.1773260198806;
        Wed, 11 Mar 2026 13:16:38 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65cd5fa8sm19798006d6.30.2026.03.11.13.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 13:16:37 -0700 (PDT)
Date: Wed, 11 Mar 2026 16:16:34 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 03/11] mm/zsmalloc: Introduce conditional memcg awareness
 to zs_pool
Message-ID: <abHNog8CV0mWummY@cmpxchg.org>
References: <20260311195153.4013476-1-joshua.hahnjy@gmail.com>
 <20260311195153.4013476-4-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311195153.4013476-4-joshua.hahnjy@gmail.com>

On Wed, Mar 11, 2026 at 12:51:40PM -0700, Joshua Hahn wrote:
> Introduce 3 new fields to struct zs_pool to allow individual zpools to
> be "memcg-aware": memcg_aware, compressed_stat, and uncompressed_stat.
> 
> memcg_aware is used in later patches to determine whether memory
> should be allocated to keep track of per-compresed object objgs.
> compressed_stat and uncompressed_stat are enum indices that point into
> memcg (node) stats that zsmalloc will account towards.
> 
> In reality, these fields help distinguish between the two users of
> zsmalloc, zswap and zram. The enum indices compressed_stat and
> uncompressed_stat are parametrized to minimize zswap-specific hardcoding
> in zsmalloc.
> 
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>  drivers/block/zram/zram_drv.c |  3 ++-
>  include/linux/zsmalloc.h      |  5 ++++-
>  mm/zsmalloc.c                 | 13 ++++++++++++-
>  mm/zswap.c                    |  3 ++-
>  4 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index bca33403fc8b..d1eae5c20df7 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1980,7 +1980,8 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
>  	if (!zram->table)
>  		return false;
>  
> -	zram->mem_pool = zs_create_pool(zram->disk->disk_name);
> +	/* zram does not support memcg accounting */
> +	zram->mem_pool = zs_create_pool(zram->disk->disk_name, false, 0, 0);

It's a bit awkward that 0 is valid (MEMCG_SWAP). Plus you store these
values in every pool, even though they're always the same for all
zswap pools.

How about:

/* zsmalloc.h */
struct zs_memcg_params {
	enum memcg_stat_item compressed;
	enum memcg_stat_item uncompressed;
};
struct zs_pool *zs_create_pool(const char *name, struct zs_memcg_params *memcg_params);

/* zswap.c */
static struct zs_memcg_params zswap_memcg_params = {
	.compressed = MEMCG_ZSWAP_B,
	.uncompressed = MEMCG_ZSWAPPED,
};

then pass &zswap_memcg_params from zswap and NULL from zram.

> @@ -2071,6 +2079,9 @@ struct zs_pool *zs_create_pool(const char *name)
>  	rwlock_init(&pool->lock);
>  	atomic_set(&pool->compaction_in_progress, 0);
>  
> +	pool->memcg_aware = memcg_aware;
> +	pool->compressed_stat = compressed_stat;
> +	pool->uncompressed_stat = uncompressed_stat;

	pool->memcg_params = memcg_params;

And then use if (pool->memcg_params) to gate in zsmalloc.c.
