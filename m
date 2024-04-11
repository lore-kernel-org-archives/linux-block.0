Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A91E487
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712799767; cv=none; b=Ay1046bIs1bh4RlniQOEyE1LiQh9MHGhWcKTy8MrZAvgpDqK8kBI19vYJcAx1l2zu8qbZB4B0xqe+GhVtMrQNcEvUYS/JfT8cTcH9oLto5LLgyVQUD8mm5ml+hexGBn/UKwMCjtrl7i6E6cV7AtUBJ5zx4wE/KN1rUlEYstckkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712799767; c=relaxed/simple;
	bh=b46EKHeN62VzvcIHKL/PslQeg4RSRT3w3KCPqZGtsKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQUbAxboA83hFNVo41MmaW+A+XpAG/RhWJsFiqtgBswNWOcLvzC7IWn4sH2tYs75CxaAE0jdz3WGM3Iz+P+kRJaRfyL6an2+tiDIhpwscPsotWBcL/plE7Ywzh8GQ6ZrxBjp02UR0d1+RmHGLuxa2bNY+tIp/onT7LxecGooFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jUHTSiKW; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jUHTSiKW"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so4577108a12.0
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2024 18:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712799765; x=1713404565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Wjsjcbxj0gvh46svZ/4TV2vWh7wPtzVX00GOKp+juw=;
        b=jUHTSiKWLcBfp++L7GwG/oMBj0bSyQvhxGOv84u4XjOiOrmjGbxzhIszyK0FpkFqL9
         NVXggK17NYof1Xrjjzz5fQ4z/Lugy7zfjb9jmivd7zW8GCz9k43tTtywawCHx7Znxnmd
         bc+JTn5ntU4GAtTRLbaI/tpGwXD1FEfOtv/XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712799765; x=1713404565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Wjsjcbxj0gvh46svZ/4TV2vWh7wPtzVX00GOKp+juw=;
        b=FrtcEUBvKpqnkiy4kvlDxUJG+SnPJ2QL1T7sv3Df6e+GGLbAd1fbFfqGdNiq+bODqE
         M7UyIkACnFdVeUGHqsC1Mis7xzGg6cSDrHB8jUtZs+eE00MOcA3WaB9YYTG27iAwkabK
         HlbYnAkQUSoDMm/fkXk6/jA5aX7aIJVLJMNUwzJgf+MsCDO189J3gXY+Jjy+oO+jwJ0N
         5Tdv4cz2aijFoRAblfv4bAZpTXonQ75PTSocxqHXDfa9UoMfNOvfiQLZYR3mWTpQNNcq
         qUJoZzlJwlGhHDVrT4wb39UxPn/kwPievwbqMND12ArkF5+PGmTBiynDrD7SIWBQ8mER
         fYFw==
X-Forwarded-Encrypted: i=1; AJvYcCWchwEfUwgY1MUm3LtO7bNzbIZ9x3CTbibBbzSW8aeliUF3Gl9aEVKe69oHJCymwfE9DUp51qMuiFYz1nG/HJnGmTJfsIxt/YedCx0=
X-Gm-Message-State: AOJu0Yx5wF8AB7+XVHhqLY4iZJdcl3H0tzA5CM8kfZA96mn/v2QBCMGb
	YimkERtdY5/9WkZ46HUblpgcYEcXmxirK5MuiSIMjq4FOAX7AaVQMHCwaLdxKw==
X-Google-Smtp-Source: AGHT+IGAQHOTuAOm/KqDp30urLcwa5fjz1YvZoSRFiNIBEbRtud1u29qA2P6s8jCeMAYkw13KFUilw==
X-Received: by 2002:a05:6300:8086:b0:1a7:175:2cac with SMTP id ap6-20020a056300808600b001a701752cacmr4551833pzc.13.1712799764699;
        Wed, 10 Apr 2024 18:42:44 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f30d:f29e:acb:4140])
        by smtp.gmail.com with ESMTPSA id fr14-20020a17090ae2ce00b002a54222e694sm272647pjb.51.2024.04.10.18.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 18:42:44 -0700 (PDT)
Date: Thu, 11 Apr 2024 10:42:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, senozhatsky@chromium.org,
	linux-block@vger.kernel.org, axboe@kernel.dk, linux-mm@kvack.org,
	terrelln@fb.com, chrisl@kernel.org, david@redhat.com,
	kasong@tencent.com, yuzhao@google.com, yosryahmed@google.com,
	nphamcs@gmail.com, willy@infradead.org, hannes@cmpxchg.org,
	ying.huang@intel.com, surenb@google.com, wajdi.k.feghali@intel.com,
	kanchana.p.sridhar@intel.com, corbet@lwn.net,
	zhouchengming@bytedance.com,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH RFC 2/2] zram: support compression at the granularity of
 multi-pages
Message-ID: <20240411014237.GB8743@google.com>
References: <20240327214816.31191-1-21cnbao@gmail.com>
 <20240327214816.31191-3-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327214816.31191-3-21cnbao@gmail.com>

On (24/03/28 10:48), Barry Song wrote:
[..]
> +/*
> + * Use a temporary buffer to decompress the page, as the decompressor
> + * always expects a full page for the output.
> + */
> +static int zram_bvec_read_multi_pages_partial(struct zram *zram, struct bio_vec *bvec,
> +				  u32 index, int offset)
> +{
> +	struct page *page = alloc_pages(GFP_NOIO | __GFP_COMP, ZCOMP_MULTI_PAGES_ORDER);
> +	int ret;
> +
> +	if (!page)
> +		return -ENOMEM;
> +	ret = zram_read_multi_pages(zram, page, index, NULL);
> +	if (likely(!ret)) {
> +		atomic64_inc(&zram->stats.zram_bio_read_multi_pages_partial_count);
> +		void *dst = kmap_local_page(bvec->bv_page);
> +		void *src = kmap_local_page(page);
> +
> +		memcpy(dst + bvec->bv_offset, src + offset, bvec->bv_len);
> +		kunmap_local(src);
> +		kunmap_local(dst);
> +	}
> +	__free_pages(page, ZCOMP_MULTI_PAGES_ORDER);
> +	return ret;
> +}

[..]

> +static int zram_bvec_write_multi_pages_partial(struct zram *zram, struct bio_vec *bvec,
> +				   u32 index, int offset, struct bio *bio)
> +{
> +	struct page *page = alloc_pages(GFP_NOIO | __GFP_COMP, ZCOMP_MULTI_PAGES_ORDER);
> +	int ret;
> +	void *src, *dst;
> +
> +	if (!page)
> +		return -ENOMEM;
> +
> +	ret = zram_read_multi_pages(zram, page, index, bio);
> +	if (!ret) {
> +		src = kmap_local_page(bvec->bv_page);
> +		dst = kmap_local_page(page);
> +		memcpy(dst + offset, src + bvec->bv_offset, bvec->bv_len);
> +		kunmap_local(dst);
> +		kunmap_local(src);
> +
> +		atomic64_inc(&zram->stats.zram_bio_write_multi_pages_partial_count);
> +		ret = zram_write_page(zram, page, index);
> +	}
> +	__free_pages(page, ZCOMP_MULTI_PAGES_ORDER);
> +	return ret;
> +}

What type of testing you run on it? How often do you see partial
reads and writes? Because this looks concerning - zsmalloc memory
usage reduction is one metrics, but this also can be achieved via
recompression, writeback, or even a different compression algorithm,
but higher CPU/power usage/higher requirements for physically contig
pages cannot be offset easily. (Another corner case, assume we have
partial read requests on every CPU simultaneously.)
