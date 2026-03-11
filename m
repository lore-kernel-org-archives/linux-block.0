Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A353310620
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260441; cv=none; b=J6vqpDuiaIe3Z1AiwwVp8vQog+GxEfoXR1XexuwVpe1O/ZReDDQ5xkedb95Jr3l7r+l5eQzb7lx2XvPKBxPHLyWRafru9F6afj7S+mSdNHXXALzwDB0pp4ZXEQ8ICQbd+RB8arijfW98DVTbzm/8VDVNykoEYYhMRt3c0Of+8HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260441; c=relaxed/simple;
	bh=OvmUYdWzF0lOI7ZgsHuDpQpSQa83TBI+cCxemeaCp6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L72vFX0lo1c0XyAtxk35WBqVzH++0hXMr5l5d6Pn7og/QiPOoWrKvrS1jzbxB+mKOwA4r4vH/qEeBoGp3imIFw0lDkPpRaDotAQvDWBqN9j6RQDtO5j3+4pbe26uPn6c8oxe1f8Gapqxre5dnV3tuA49UVMBtIVTirG2jQ55W+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJIAvcAB; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJIAvcAB"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4671cbce626so168407b6e.1
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 13:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773260439; x=1773865239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3yE0fOt9QsxeZmuU8QoQzZqCv9ze5YFahl5XE1THs8=;
        b=IJIAvcABv3XV1UIOmQLaXDeSnkcZXG8By9HWG77f0mlAbK6SET02a7VGjErLK6d2Mm
         cNj5WgGbn3tumC4rC60PP5+zI1+tVezjyK8uwFl3SHEQmKTN52UX/wu0BrhCYj+JqaJY
         zs/WKsvd96e5ZAYp8JxBg95GycSL9Fb7QB0/TOyisq+KH9Dr/8Olfg5mxtQrTBIITXpQ
         N8trPbUQLxnKEt2oxoz6pC9umaxdfLuuSdzMctAalrt3OhAUSMVbYBL+sg7BIlDbUz0B
         m6RjOmylYkfzHF3Cm34KX1wZqeMPG+NYRxoELXRo/Rx7WL2yWA08foztssoS+n0u8YMK
         nw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773260439; x=1773865239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L3yE0fOt9QsxeZmuU8QoQzZqCv9ze5YFahl5XE1THs8=;
        b=LxzpB+Qn+8QfJqVr5IXQ/HyNBWiSsWHZ9ZprdduTSUkIQZ2T+kl/JLdcGgaJ7WBTro
         lXCySYgGWWBLqb2Zah3axei2wOP7TfrCpvwLlAHGVkn7dIDXiDTe7y9NBxwZlDEPV0iI
         HsEzLZ07U19zJWNLieot2PYwwKKTav1WjT+6IZSUw2IfebTTCcU1oqPemBay3vY94Ugw
         +6Yq6OJOEvG5lzesLr+7Q4am3s/s70eh3eL1S1w7irFTJSR92dLhl+Su6Fy/xZwJBBkQ
         O5D0m3MuJZRcOUu2cZtC3gWzegpZ3A5iVeQ+ArgbC4KTA+wSDw/bGLdirqNWxnEOKiNL
         XCnA==
X-Forwarded-Encrypted: i=1; AJvYcCWjnBmJaZT9xO4YaFhVOcLBKk4V+H4xIWH4/kvHFoIlEXth7ZqJ6vXK5qn+bac8rbKkU6yfErJQkk3flw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBVxRSHYWo2ctCfuKssGQoyx/JhWwGfU77Ufi6jFbJURfQUOdz
	Wu94b1vt+4GgoR12CBkWV3q4eY2woMd95IfJ3uscz4zEIaj+UM8W230j0Xor2w==
X-Gm-Gg: ATEYQzzkNJgK7TpyXlYbHlAUCdO3uWzFrJxmo0L/L1K5rRVuw2+lSKuzjG82pDhMOiP
	Fo+MVecGRdauM86s6MXQF3F3XqG71L1hwjIjcZcd49LjOQFbeAOXF+xfsWRAmS8Dw6NytgFQudv
	nGddkQXif+LSnf4bYjqnpIxKn6F3jiIMjQbG0qKgNKPNhZqNtUFY6ULpIJlssKbPh186fpk5Lpn
	L8V7OYfLH+X+XbxbCwiStx4Dqz3+suH5YYJ8b6KqTbQU75AyVJAKGaka9yN7vJWXT/Xo0R2tMyh
	7Sp2koTEH9/LCEmfQ2B0HZXkR3+Jj03S6Wtb9pgxCH1YCIUzIs2tJ4xx7UGSMg3azQcUhtmjeou
	X8XLskQ0+31jvlJ1HRmWkQXTKmvoX5lLcNUNWZpt4mtNWTkOxMh+XXSFSEuefwnKYUk0fV30+G1
	/Etpxs/JGMCcaMksgvTmXdMg==
X-Received: by 2002:a05:6808:4f6b:b0:459:b569:702f with SMTP id 5614622812f47-46733431a6emr1950640b6e.15.1773260439503;
        Wed, 11 Mar 2026 13:20:39 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342c0382sm1914583b6e.10.2026.03.11.13.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 13:20:38 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 03/11] mm/zsmalloc: Introduce conditional memcg awareness to zs_pool
Date: Wed, 11 Mar 2026 13:20:37 -0700
Message-ID: <20260311202037.265101-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <abHNog8CV0mWummY@cmpxchg.org>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 11 Mar 2026 16:16:34 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Wed, Mar 11, 2026 at 12:51:40PM -0700, Joshua Hahn wrote:
> > Introduce 3 new fields to struct zs_pool to allow individual zpools to
> > be "memcg-aware": memcg_aware, compressed_stat, and uncompressed_stat.
> > 
> > memcg_aware is used in later patches to determine whether memory
> > should be allocated to keep track of per-compresed object objgs.
> > compressed_stat and uncompressed_stat are enum indices that point into
> > memcg (node) stats that zsmalloc will account towards.
> > 
> > In reality, these fields help distinguish between the two users of
> > zsmalloc, zswap and zram. The enum indices compressed_stat and
> > uncompressed_stat are parametrized to minimize zswap-specific hardcoding
> > in zsmalloc.
> > 
> > Suggested-by: Yosry Ahmed <yosry@kernel.org>
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > ---
> >  drivers/block/zram/zram_drv.c |  3 ++-
> >  include/linux/zsmalloc.h      |  5 ++++-
> >  mm/zsmalloc.c                 | 13 ++++++++++++-
> >  mm/zswap.c                    |  3 ++-
> >  4 files changed, 20 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index bca33403fc8b..d1eae5c20df7 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -1980,7 +1980,8 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
> >  	if (!zram->table)
> >  		return false;
> >  
> > -	zram->mem_pool = zs_create_pool(zram->disk->disk_name);
> > +	/* zram does not support memcg accounting */
> > +	zram->mem_pool = zs_create_pool(zram->disk->disk_name, false, 0, 0);

Hello Johannes,

Thank you for your review! I hope you are doing well : -)

> It's a bit awkward that 0 is valid (MEMCG_SWAP). Plus you store these
> values in every pool, even though they're always the same for all
> zswap pools.

Agreed. Originally I thought of removing memcg_aware and doing a bitwise
OR check of the two stats, but thought this was also a bit strange
(also because 0 is not a valid enum state for memcg_stat_item anyways)

> How about:
> 
> /* zsmalloc.h */
> struct zs_memcg_params {
> 	enum memcg_stat_item compressed;
> 	enum memcg_stat_item uncompressed;
> };
> struct zs_pool *zs_create_pool(const char *name, struct zs_memcg_params *memcg_params);
> 
> /* zswap.c */
> static struct zs_memcg_params zswap_memcg_params = {
> 	.compressed = MEMCG_ZSWAP_B,
> 	.uncompressed = MEMCG_ZSWAPPED,
> };
> 
> then pass &zswap_memcg_params from zswap and NULL from zram.
> 
> > @@ -2071,6 +2079,9 @@ struct zs_pool *zs_create_pool(const char *name)
> >  	rwlock_init(&pool->lock);
> >  	atomic_set(&pool->compaction_in_progress, 0);
> >  
> > +	pool->memcg_aware = memcg_aware;
> > +	pool->compressed_stat = compressed_stat;
> > +	pool->uncompressed_stat = uncompressed_stat;
> 
> 	pool->memcg_params = memcg_params;
> 
> And then use if (pool->memcg_params) to gate in zsmalloc.c.

These definitely look a lot cleaner. Will make these changes in v3!

Thanks again. I hope you have a great day!
Joshua
